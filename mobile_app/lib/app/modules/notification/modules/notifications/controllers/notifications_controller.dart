import 'dart:async';

import 'package:flutter/material.dart' hide Notification;
import 'package:get/get.dart';

import '../../../../../routes/pages.dart';
import '../../../../feed/controllers/feed_controller.dart';

class NotificationsController extends GetxController
    with StateMixin<List<Rx<NotificationModel?>>> {
  final INotificationRepository repository;
  final IAuthUserService authUserStore;
  final FeedController feedController;
  final scrollController = ScrollController();

  String? cursor = '';

  bool isLoading = false;
  bool canLoadMore = true;
  late StreamSubscription _routeListener;
  NotificationsController({
    required this.repository,
    required this.authUserStore,
    required this.feedController,
  });

  clearNotificationBadge() async {
    authUserStore.clearUserNotifications();

    await repository.makeAllSeen();
    await updateUnreadMessageCountForAuthUser();
    // if (await FlutterAppBadger.isAppBadgeSupported()) {//replace this with an auth user store one that does this prioritizes messages
    //   FlutterAppBadger.removeBadge();
    // }
  }

  Future<void> fetchAuthNotifications(
      {QueryType queryType = QueryType.loadCache}) {
    final String cursorToApply = cursor ??= '';
    return repository.getNotifications(
      cursor: cursorToApply,
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
    if (canLoadMore) {
      await fetchAuthNotifications(queryType: QueryType.loadMore);
    }
  }

  void onAction(int followRequestKey) {
    onReactNotifications(followRequestKey);
  }

  @override
  void onClose() {
    _routeListener.cancel();
  }

  void onDismiss(int? notification) {
    state!.removeWhere((n) => n.value?.notificationKey == notification);
    change(state, status: getStatus(state));
  }

  void onError(exception) {
    debugPrint(exception.toString());
    Get.snackbar('Error', 'Issue loading your notifications');
  }

  @override
  void onInit() {
    _routeListener = IrisStackObserver.stackChange.listen((stackChange) {
      if (stackChange.newRoute?.settings.name ==
              Paths.Feed + Paths.Notifications &&
          stackChange.oldRoute is GetPageRoute) {
        notifyReading();
      }
    });
    super.onInit();
  }

  void notifyReading() {
    pullRefresh();
    clearNotificationBadge();
  }

  void onLoadMore(serverResponse) {
    if (serverResponse is DataList<NotificationModel>) {
      canLoadMore = serverResponse.list.length == 10;
      if (serverResponse.cursor.isNotEmpty) {
        cursor = serverResponse.cursor;
      }

      rebuildOnChange(
        state!
          ..addAll(serverResponse.list
              .map((notification) => notification.obs)
              .toList()),
      );
    }
  }

  void onNotificationFollow(int notificationKey) {
    final Rx<NotificationModel?> actionItem = state!.firstWhere(
        (element) => element.value?.notificationKey == notificationKey,
        orElse: () => const NotificationModel().obs);
    if (actionItem.value!.notificationKey != null) {
      final index = state!.indexWhere(
          (element) => element.value?.notificationKey == notificationKey);
      final AuthUserFollowInfo? authUserFollowInfo = actionItem
          .value?.actionUser!.authUserFollowInfo!
          .copyWith(followStatus: FOLLOW_STATUS.APPROVED);
      final NotificationModel? copied = actionItem.value?.copyWith(
          actionUser: actionItem.value?.actionUser
              ?.copyWith(authUserFollowInfo: authUserFollowInfo));
      state![index].value = copied;
    }
    rebuildOnChange(state!);
  }

  void onReactNotifications(int followRequestKey) {
    //code doesnt work after migration to null safety
    final Rx<NotificationModel?> actionItem = state!.firstWhere(
        (element) =>
            element.value?.followRequest?.followRequestKey == followRequestKey,
        orElse: () => const NotificationModel().obs);
    if (actionItem.value!.followRequest != null) {
      final index = state!.indexWhere((element) =>
          element.value?.followRequest?.followRequestKey == followRequestKey);
      final NotificationModel? copied = actionItem.value?.copyWith(
          followRequest: actionItem.value?.followRequest
              ?.copyWith(status: FOLLOW_REQUEST_STATUS.DENIED));
      state![index].value = copied;
    }
  }

  ///The [getResponse] method receives a callback that is called whenever it has new data.
  ///It first searches the internal storage, and only then searches the server.
  ///If the result is exactly the same, it will only call the callback the first time (from the cache).

  @override
  void onReady() {
    notifyReading();
    fetchAuthNotifications();
    clearNotificationBadge();

    super.onReady();
  }

  void onRequestFollow(int followRequestKey) {
    final Rx<NotificationModel?> actionItem = state!.firstWhere(
        (element) =>
            element.value?.followRequest?.followRequestKey == followRequestKey,
        orElse: () => const NotificationModel().obs);
    if (actionItem.value!.followRequest != null) {
      final index = state!.indexWhere((element) =>
          element.value?.followRequest?.followRequestKey == followRequestKey);
      final AuthUserFollowInfo? authUserFollowInfo = actionItem
          .value?.actionUser?.authUserFollowInfo
          ?.copyWith(followStatus: FOLLOW_STATUS.APPROVED);

      final NotificationModel? copied = actionItem.value?.copyWith(
          actionUser: actionItem.value?.actionUser
              ?.copyWith(authUserFollowInfo: authUserFollowInfo));
      state![index].value = copied;
    }
    rebuildOnChange(state!);
  }

  void onSuccess(serverResponse) {
    if (serverResponse is DataList<NotificationModel>) {
      cursor = serverResponse.cursor;

      canLoadMore = serverResponse.list.length == 10;
      rebuildOnChange(
        serverResponse.list.map((notification) => notification.obs).toList(),
      );
    }
  }

  Future<void> pullRefresh() async {
    cursor = '';
    await fetchAuthNotifications(queryType: QueryType.loadRemote);
  }

  /// This method checks if the value of the added data is different from the value of the current state.
  /// or just from the internet.
  Future<void> rebuildOnChange(List<Rx<NotificationModel?>> data) async {
    change(data, status: getStatus(data));
  }

  Future<void> updateUnreadMessageCountForAuthUser() async {
    return feedController.updateAppBadges();
  }
}
