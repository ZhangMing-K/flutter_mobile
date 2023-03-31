import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../../../profile/controllers/profile_controller.dart';

class FollowersController extends GetxController with StateMixin<List<User>> {
  FollowersController(
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

  getUser() async {
    onLoadFollowers().getResponse(rebuildOnChange);
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

  Repository<List<User>> onLoadFollowers() {
    return repository.searchFollowers(
        entityKey: profileUserKey,
        name: searchValue,
        offset: offset,
        searchFollowing: SEARCH_QUERY.FOLLOWERS);
  }

  Future<void> loadMore() async {
    offset += 10;
    final data = await onLoadFollowers().remote;
    final List<User> newState = state!;
    newState.addAll(data);
    if (data.isNotEmpty) {
      change(newState, status: RxStatus.success());
    }
  }

  Future<void> pullRefresh() async {
    offset = 0;
    final data = await onLoadFollowers().remote;
    rebuildOnChange(data);
  }

  Future<void> onFollowerRemove(int userKey, int newFollowerNum) async {
    profileUser.value = profileUser.value?.copyWith(
        followStats: profileUser.value?.followStats
            ?.copyWith(numberOfFollowers: newFollowerNum));
    rebuildOnChange(
        state!..removeWhere((element) => element.userKey == userKey));
  }
}
