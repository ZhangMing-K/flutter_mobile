import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../../../profile/controllers/profile_controller.dart';

class PortfoliosFollowingController extends GetxController
    with StateMixin<List<Portfolio>> {
  PortfoliosFollowingController(
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

  ///The [getResponse] method receives a callback that is called whenever it has new data.
  ///It first searches the internal storage, and only then searches the server.
  ///If the result is exactly the same, it will only call the callback the first time (from the cache).
  @override
  void onInit() {
    selectedTab = int.parse(Get.parameters['selectedTab']!);
    getUser();
    super.onInit();
  }

  getUser() {
    onLoadPortfoliosFollowing().getResponse(rebuildOnChange);
  }

  forceUpdate({newProfileKey}) {
    offset = 0;
    change([], status: RxStatus.loading());
    getUser();
  }

  /// If the items is empty, return empty status so the view renders onEmtpy() widget
  RxStatus getStatus(items) {
    var status = RxStatus.success();
    if (items.isEmpty) {
      status = RxStatus.empty();
    }
    return status;
  }

  /// This method checks if the value of the added data is different from the value of the current state.
  /// It serves functions that do not use [getResponse] from a [Repository], but only data from the local cache,
  /// or just from the internet.
  void rebuildOnChange(List<Portfolio> data) {
    change(data, status: getStatus(data));
  }

  Repository<List<Portfolio>> onLoadPortfoliosFollowing() {
    return repository.searchPortfoliosFollowing(
        entityKey: profileUserKey,
        name: searchValue,
        offset: offset,
        searchFollowing: SEARCH_QUERY.PORTFOLIOS_FOLLOWING);
  }

  Future<void> loadMore() async {
    offset += 10;
    final data = await onLoadPortfoliosFollowing().remote;
    change(state!..addAll(data), status: RxStatus.success());
  }

  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> pullRefresh() async {
    offset = 0;
    final data = await onLoadPortfoliosFollowing().remote;
    rebuildOnChange(data);
  }

  Future<void> onRemovePortfolio(int portfolioKey, int newFollowingNum) async {
    profileUser.value = profileUser.value?.copyWith(
        followStats: profileUser.value?.followStats
            ?.copyWith(numberOfPortfoliosFollowing: newFollowingNum));
    rebuildOnChange(
        state!..removeWhere((element) => element.portfolioKey == portfolioKey));
    // watchlistStore.delete(key: portfolioKey);
  }
}
