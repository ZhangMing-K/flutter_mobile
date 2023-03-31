import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class PortfolioUsersController extends GetxController
    with StateMixin<List<User>> {
  PortfolioUsersController({required this.repository, this.events});
  final IPortfolioSearchRepository repository;
  final Events? events;

  final scrollController = ScrollController();
  final listviewController = GlobalKey<IrisListViewState>();

  int offset = 0;
  String searchValue = '';
  int? portfolioKey;

  @override
  void onInit() {
    final int routeKey = int.parse(Get.parameters['portfolioKey']!);
    if (portfolioKey != routeKey) {
      portfolioKey = routeKey;
      onLoadUsers().getResponse(rebuildOnChange);
    }
    super.onInit();
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
    if (data != state) {
      change(data, status: getStatus(data));
    }
  }

  Repository<List<User>> onLoadUsers() {
    return repository.loadUsers(
        offset: offset,
        name: searchValue,
        entityKey: portfolioKey!,
        entityType: SEARCH_QUERY.PORTFOLIO,
        searchFollowing: SEARCH_QUERY.FOLLOWERS);
  }

  Future<void> loadMore() async {
    offset += 10;
    final data = await onLoadUsers().remote;
    change(state!..addAll(data), status: RxStatus.success());
  }

  Future<void> pullRefresh() async {
    offset = 0;
    final data = await onLoadUsers().remote;
    rebuildOnChange(data);
  }
}
