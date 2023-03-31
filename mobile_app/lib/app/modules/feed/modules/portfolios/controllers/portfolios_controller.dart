import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../../shared/mixins/scroll_controller_mixin.dart';

class PortfoliosController extends GetxController
    with StateMixin<List<Rx<Portfolio>>>, ScrollControllerMixin {
  PortfoliosController({required this.repository});
  final IFeedRepository repository;

  final listviewController = GlobalKey<IrisListViewState>();

  int offset = 0;
  bool saved = false;

  List<PORTFOLIO_ORDER_BY> feedSelection = [
    PORTFOLIO_ORDER_BY.DAY,
    PORTFOLIO_ORDER_BY.WEEK,
    PORTFOLIO_ORDER_BY.THREE_MONTH,
    PORTFOLIO_ORDER_BY.YEAR,
  ];

  String feedSelectionToString(PORTFOLIO_ORDER_BY selection) {
    switch (selection) {
      case PORTFOLIO_ORDER_BY.DAY:
        return 'Day';
      case PORTFOLIO_ORDER_BY.WEEK:
        return 'Week';
      case PORTFOLIO_ORDER_BY.THREE_MONTH:
        return '3 Month';
      case PORTFOLIO_ORDER_BY.YEAR:
        return 'Year';
      default:
        return 'Day';
    }
  }

  PORTFOLIO_ORDER_BY getCurrentCategory() {
    return _currentPortfolioSelection;
  }

  String getCurrentSelectionString() {
    return feedSelectionToString(_currentPortfolioSelection);
  }

  int getCurrentCategoryIndex() {
    return feedSelection.indexOf(_currentPortfolioSelection);
  }

  Future<void> changeCategory(String? index) async {
    change(state, status: RxStatus.loading());
    final newCategory = feedSelection
        .firstWhere((value) => feedSelectionToString(value) == index);

    _currentPortfolioSelection = newCategory;
    offset = 0;
    final data = await fetchPortfolios().remote;

    rebuildOnChange(data.map((e) => e.obs).toList());
  }

  Future<void> toggleSaved() async {
    change(state, status: RxStatus.loading());
    saved = !saved;
    offset = 0;
    final data = await fetchPortfolios().remote;
    rebuildOnChange(data.map((e) => e.obs).toList());
  }

  /// Current feed category. It receives the default value
  PORTFOLIO_ORDER_BY _currentPortfolioSelection = PORTFOLIO_ORDER_BY.DAY;

  ///The [getResponse] method receives a callback that is called whenever it has new data.
  ///It first searches the internal storage, and only then searches the server.
  ///If the result is exactly the same, it will only call the callback the first time (from the cache).
  @override
  void onInit() {
    fetchPortfolios().getResponse((data) {
      rebuildOnChange(
        data.map((item) => item.obs).toList(),
      );
    });
    super.onInit();
  }

  void rebuildOnChange(List<Rx<Portfolio>> data) {
    change(data, status: RxStatus.success());
  }

  Repository<List<Portfolio>> fetchPortfolios() {
    return repository.getPortfolios(
        offset: offset, saved: saved, orderBy: _currentPortfolioSelection);
  }

  Future<void> loadMore() async {
    offset += 10;
    final data = await fetchPortfolios().remote;
    change(state!..addAll(data.map((portfolio) => portfolio.obs)),
        status: RxStatus.success());
  }

  Future<void> pullRefresh() async {
    offset = 0;
    final data = await fetchPortfolios().remote;
    rebuildOnChange(data.map((portfolio) => portfolio.obs).toList());
  }
}
