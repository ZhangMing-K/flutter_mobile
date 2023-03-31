import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class StocksController extends GetxController {
  ITagAnalysisRepository repository;

  ITradeAnalysisRepository tradeRepository;
  final IStorage storage = Get.find();
  Rx<String?> selectedSpan$ = Rx('Week');

  RxList<TagAnalysis> topMentions$ = <TagAnalysis>[].obs;
  RxList<TradeAnalysis> mostBearish$ = <TradeAnalysis>[].obs;
  RxList<TradeAnalysis> mostBullish$ = <TradeAnalysis>[].obs;
  Rx<HISTORICAL_SPAN> historicalSpan$ = Rx(HISTORICAL_SPAN.WEEK);
  final recentList = <Asset>[].obs;

  StocksController({required this.repository, required this.tradeRepository});

  Future<void> getMostBearish() async {
    final now = DateTime.now().toUtc();
    final betweenRange = DateRangeInput(
        start: DateTime(now.year, now.month, now.day)); // by today
    const orderBy = ORDER_BY.TOTAL_AMOUNT;
    await tradeRepository.getMostBearishorBullish(
        orderBy:
            const AssetAnalysisOrderBy(orderBy: orderBy, outlook: OUTLOOK.BEARISH),
        between: betweenRange,
        limit: 3,
        callback: onSuccessMostBearish,
        onError: onError);
  }

  Future<void> getMostBullish() async {
    final now = DateTime.now().toUtc();
    final betweenRange = DateRangeInput(
        start: DateTime(now.year, now.month, now.day)); // by today
    const orderBy = ORDER_BY.TOTAL_AMOUNT;
    await tradeRepository.getMostBearishorBullish(
        orderBy:
            const AssetAnalysisOrderBy(orderBy: orderBy, outlook: OUTLOOK.BULLISH),
        between: betweenRange,
        limit: 3,
        callback: onSuccessBullish,
        onError: onError);
  }

  Future<void> getTagAnalysis() async {
    final betweenRange =
        DateRangeInput(start: DateTime.now().subtract(const Duration(days: 7)));
    const orderBy = TAG_ANALYSIS_ORDER_BY.TOTAL_TAGS;
    await repository.getTopMentions(
        orderBy: orderBy,
        between: betweenRange,
        assetSpan: historicalSpan$.value,
        limit: 10,
        callback: (data) => onSuccessTopMentions(data),
        onError: onError);
  }

  void loadRecentList() {
    final assetsFromStorage = storage.read('savedAssets');
    if (assetsFromStorage != null) {
      final List<Asset> userList = List<Asset>.from(assetsFromStorage.map((i) {
        if (i is Asset) return i;
        return Asset.fromJson(i);
      }));
      recentList.assignAll(userList);
    }
  }

  void onError(err) {
    debugPrint('error on getting top mentions');
  }

  @override
  onInit() async {
    onLoadData();
    loadRecentList();
    super.onInit();
  }

  onLoadData() {
    getTagAnalysis();
    getMostBearish();
    getMostBullish();
  }

  void onSuccessBullish(dynamic data) {
    mostBullish$.assignAll(data);
  }

  void onSuccessMostBearish(dynamic data) {
    mostBearish$.assignAll(data);
  }

  void onSuccessTopMentions(dynamic data) {
    topMentions$.assignAll(data);
  }

  void saveAssetToRecent(Asset asset) {
    final assetKey = asset.assetKey;
    recentList.removeWhere((element) => element.assetKey == assetKey);
    recentList.insert(0, asset);
    storage.write(
        key: 'savedAssets',
        value: recentList.map((element) => element.toJson()).toList());
  }
}
