import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../notifications/controllers/notifications_controller.dart';

///This class has the sole responsibility to control the status of the posts tab in the feed.
///We use StateMixin because it makes our code more secure. If an error is not caught,
///it is displayed automatically. The loading status is also displayed when there is no data.
///We can change the state of the controller through the change method, and attach a status to it
class FollowRequestsController extends GetxController
    with StateMixin<List<Rx<FollowRequest?>>> {
  final INotificationRepository repository;
  final NotificationsController? notificationsController;
  final Events? events;
  final scrollController = ScrollController();

  String? cursor = '';

  bool isLoading = false;
  bool canLoadMore = false;
  FollowRequestsController(
      {required this.repository, this.events, this.notificationsController});

  Future<void> fetchFollowRequestsData({
    QueryType queryType = QueryType.loadCache,
  }) {
    return repository.getFollowRequests(
      cursor: cursor,
      queryType: queryType,
      callback: () {
        if (queryType == QueryType.loadMore) {
          return onLoadMore;
        } else {
          return onSuccess;
        }
      }(),
      onError: onError,
    );
  }

  /// If the items is empty, return empty status so the view renders onEmtpy() widget
  RxStatus getStatus(items) {
    var status = RxStatus.success();
    if (items.isEmpty) {
      status = RxStatus.empty();
    }
    return status;
  }

  Future<void> loadMore() async {
    if (!isLoading && cursor != '' && canLoadMore) {
      isLoading = true;
      await fetchFollowRequestsData(queryType: QueryType.loadMore);
    }
  }

  void onAction(int followRequestKey) {
    onReactToFollowRequestAction(followRequestKey);
  }

  void onError(err) {
    Get.snackbar('Error', 'Can not get follow requests');
  }

  void onFollow(int followRequestKey) {
    final Rx<FollowRequest?> actionItem = state!.firstWhere(
        (element) => element.value?.followRequestKey == followRequestKey,
        orElse: () => const FollowRequest().obs);
    if (actionItem.value!.followRequestKey != null) {
      final index = state!.indexWhere(
          (element) => element.value?.followRequestKey == followRequestKey);
      final itemActionUser = actionItem.value?.followerUser!;
      final itemAuthUserFollowInfo = itemActionUser!.authUserFollowInfo!;
      final FollowRequest? copied = actionItem.value?.copyWith(
          followerUser: itemActionUser.copyWith(
              authUserFollowInfo: itemAuthUserFollowInfo.copyWith(
                  followStatus: FOLLOW_STATUS.APPROVED)));
      state![index].value = copied;
      rebuildOnChange(state);
    }
  }

  ///The [getResponse] method receives a callback that is called whenever it has new data.
  ///It first searches the internal storage, and only then searches the server.
  ///If the result is exactly the same, it will only call the callback the first time (from the cache).
  @override
  void onInit() {
    fetchFollowRequestsData();
    super.onInit();
  }

  void onLoadMore(data) {
    final List<FollowRequest> list = data['list'];
    if (data['cursor'] != '') {
      cursor = data['cursor'];
    }
    if (list.isNotEmpty) {
      canLoadMore = true;
      change(state!..addAll(list.map((l) => l.obs).toList()),
          status: RxStatus.success());
    } else {
      canLoadMore = false;
    }
    isLoading = false;
  }

  void onReactToFollowRequestAction(int followRequestKey) {
    state!.removeWhere((fr) => fr.value!.followRequestKey == followRequestKey);
    change(state, status: getStatus(state));
    if (state!.length < 4) {
      loadMore();
    }
  }

  void onSuccess(data) {
    final List<FollowRequest?>? list = data['list'];
    if (data['cursor'] != '') {
      cursor = data['cursor'];
    }
    if (list == null) {
      return;
    }
    if (list.length == 10) {
      canLoadMore = true;
    } else {
      canLoadMore = false;
    }
    rebuildOnChange(list.map((l) => l.obs).toList());
  }

  Future<void> pullRefresh() async {
    cursor = '';
    await fetchFollowRequestsData(queryType: QueryType.loadRemote);
  }

  void rebuildOnChange(List<Rx<FollowRequest?>>? data) {
    if (data != state) {
      change(data, status: getStatus(data));
    }
  }
}
