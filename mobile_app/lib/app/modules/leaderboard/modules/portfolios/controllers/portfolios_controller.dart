import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class PortfoliosLeaderboardController extends GetxController
    with StateMixin<List<Rx<Portfolio>>> {
  final ILeaderboardRepository repository;
  final scrollController = ScrollController();
  RxBool isLocalLeadeboard = true.obs;
  int offset = 0;

  bool saved = false;
  HISTORICAL_SPAN currentPortfolioSelection = HISTORICAL_SPAN.DAY;

  List<HISTORICAL_SPAN> feedSelection = [
    HISTORICAL_SPAN.DAY,
    HISTORICAL_SPAN.WEEK,
    HISTORICAL_SPAN.THREE_MONTH,
    HISTORICAL_SPAN.YEAR,
  ];
  PortfoliosLeaderboardController({required this.repository});

  Future fetchGlobalPortfolios(
      {QueryType queryType = QueryType.loadCache, orderBy}) async {
    return await repository.getGlobalLeaderboard(
      span: orderBy ?? currentPortfolioSelection,
      queryType: queryType,
      mostRecent: true,
      limit: 10,
      callback: (isLocal, span, data) => onSuccessGlobal(isLocal, span, data),
      onError: onError,
    );
  }

  Future fetchLocalPortfolios(
      {QueryType queryType = QueryType.loadCache, orderBy}) async {
    return await repository.getPortfolios(
      offset: offset,
      orderBy: orderBy ?? currentPortfolioSelection,
      queryType: queryType,
      callback: (isLocal, span, data) => onSuccessLocal(isLocal, span, data,
          isLoadMore: queryType == QueryType.loadMore),
      onError: onError,
    );
  }

  RxStatus getStatus(items) {
    var status = RxStatus.success();
    if (items.isEmpty) {
      status = RxStatus.empty();
    }
    return status;
  }

  Future<void> loadMore() async {
    if (isLocalLeadeboard.value && state!.length >= 10) {
      offset += 10;
      await fetchLocalPortfolios(queryType: QueryType.loadMore);
    }
  }

  void onError(err) {
    debugPrint('err: $err');
  }

  void onLoadingWidget() {
    change(state, status: RxStatus.loading());
  }

  onSuccessGlobal(bool isLocal, HISTORICAL_SPAN span, List<Portfolio> data) {
    if (isLocalLeadeboard.value != isLocal) return;
    if (data.isEmpty) {
      change(state, status: RxStatus.empty());
    }
    if (span == currentPortfolioSelection) {
      rebuildOnChange(
        data.map((item) => item.obs).toList(),
      );
    }
  }

  onSuccessLocal(bool isLocal, HISTORICAL_SPAN span, List<Portfolio> data,
      {required bool isLoadMore}) {
    if (isLocalLeadeboard.value != isLocal) return;
    if (data.isEmpty) {
      rebuildOnChange([]);
    }
    if (isLoadMore) {
      if (span == currentPortfolioSelection) {
        rebuildOnChange(state!..addAll(data.map((portfolio) => portfolio.obs)));
      }
    } else {
      if (span == currentPortfolioSelection) {
        rebuildOnChange(
          data.map((item) => item.obs).toList(),
        );
      }
    }
  }

  Future<void> pullRefresh() async {
    offset = 0;
    if (isLocalLeadeboard.value) {
      await fetchLocalPortfolios(queryType: QueryType.loadRemote);
    } else {
      await fetchGlobalPortfolios(queryType: QueryType.loadRemote);
    }
  }

  void rebuildOnChange(List<Rx<Portfolio>> data) {
    change(data, status: getStatus(data));
  }
}
