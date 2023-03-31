import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../../../profile/controllers/profile_controller.dart';

class FollowingController extends GetxController with StateMixin<List<User>> {
  FollowingController(
      {required this.repository, required this.profileUserKey, this.events});
  final IProfileSearchRepository repository;
  final Events? events;

  final scrollController = ScrollController();

  int offset = 0;
  String searchValue = '';
  final int profileUserKey;
  Rx<User?> profileUser = Rx<User?>(null);
  int selectedTab = 0;
  late ProfileController profileController;

  @override
  void onInit() {
    selectedTab = int.parse(Get.parameters['selectedTab']!);
    getUser();
    super.onInit();
  }

  forceUpdate({newProfileKey}) {
    offset = 0;
    change([], status: RxStatus.loading());
    getUser();
  }

  getUser() {
    onLoadFollowing().getResponse(rebuildOnChange);
  }

  /// If the items is empty, return empty status so the view renders onEmtpy() widget
  RxStatus getStatus(items) {
    var status = RxStatus.success();
    if (items.isEmpty) {
      status = RxStatus.empty();
    }
    return status;
  }

  void rebuildOnChange(List<User> data) {
    change(data, status: getStatus(data));
  }

  Repository<List<User>> onLoadFollowing() {
    return repository.searchFollowing(
        entityKey: profileUserKey,
        name: searchValue,
        offset: offset,
        searchFollowing: SEARCH_QUERY.FOLLOWING);
  }

  Future<void> loadMore() async {
    offset += 10;
    final data = await onLoadFollowing().remote;
    change(state!..addAll(data), status: RxStatus.success());
  }

  Future<void> pullRefresh() async {
    offset = 0;
    final data = await onLoadFollowing().remote;
    rebuildOnChange(data);
  }

  Future<void> onRemoveFollowing(int userKey, int newFollowingNum) async {
    profileUser.value = profileUser.value?.copyWith(
        followStats: profileUser.value?.followStats
            ?.copyWith(numberFollowing: newFollowingNum));
    rebuildOnChange(
        state!..removeWhere((element) => element.userKey == userKey));
  }
}
