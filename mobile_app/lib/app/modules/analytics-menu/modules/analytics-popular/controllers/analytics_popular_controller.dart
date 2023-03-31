import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-popular/views/table/constants.dart';
import 'package:iris_mobile/app/routes/pages.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class AnalyticsPopularController extends GetxController {
  IAnalyticsPopularRepository repository;

  final scrollController = ScrollController();

  final IAuthUserService authUserStore;

  Rx<OVERVIEW_ORDER_BY> selectedOrderBy$ = Rx(OVERVIEW_ORDER_BY.ALL);
  List<String> spans = ['This Week', 'Last Week', 'This Month', 'Last Month'];
  Rx<SENTIMENT_TYPE> currentSentimentType$ = Rx(SENTIMENT_TYPE.BULLISH);
  RxList<AssetOverviewItem> currentSentimentData$ = <AssetOverviewItem>[].obs;
  Rx<String?> currentSelectedSpan$ = Rx('This Week');
  Rx<API_STATUS> currentApiStatus$ = Rx<API_STATUS>(API_STATUS.PENDING);
  Rx<SortColumns> sortColumns$ =
      Rx(SortColumns(sortBy: SORT_BY.PINVESTORS, orderByAsc: false));

  Rx<bool> appliedIsGold = false.obs;
  int offset = 0;

  int limit = 20;
  bool canLoadMore = false;
  bool isLoadingMore = false;

  final LinkedScrollControllerGroup linkedScrollControllerGroup =
      LinkedScrollControllerGroup();

  late ScrollController headController;
  late ScrollController bodyController;
  AnalyticsPopularController(
      {required this.repository, required this.authUserStore});

  bool get getIsGoldApplied {
    return appliedIsGold.value == true;
  }

  bool get isCrown {
    return selectedOrderBy$.value == OVERVIEW_ORDER_BY.TOP;
  }

  bool get isGoldMember =>
      authUserStore.loggedUser?.goldConnection?.isGoldMember == true;

  changeToTopView() async {
    if (selectedOrderBy$.value == OVERVIEW_ORDER_BY.ALL) {
      selectedOrderBy$.value = OVERVIEW_ORDER_BY.TOP;
    } else {
      selectedOrderBy$.value = OVERVIEW_ORDER_BY.ALL;
    }
    currentApiStatus$.value = API_STATUS.PENDING;
    offset = 0;
    getAssetAnalysis();
  }

  String formatDateTime(DateTime time) {
    return DateFormat('yyyy-MM-dd').format(time);
  }

  String formatDateTimeDisplay(DateTime time) {
    return DateFormat('MM/dd/yy').format(time);
  }

  Future<void> getAssetAnalysis() async {
    OverviewBetweenInput? betweenRange;
    String? betweenString;
    betweenRange = getDatesBySpan(currentSelectedSpan$.value);
    betweenString = currentSelectedSpan$.value;
    await repository.getTradeOverview(
        callback: onSuccessGetOverview,
        sentimentType: currentSentimentType$.value,
        onError: onError,
        between: betweenRange,
        betweenString: betweenString,
        orderBy:
            appliedIsGold.value ? OVERVIEW_ORDER_BY.TOP : OVERVIEW_ORDER_BY.ALL,
        offset: offset,
        limit: limit);
  }

  OverviewBetweenInput? getDatesBySpan(String? span) {
    final now = DateTime.now();
    final end = DateTime(now.year, now.month, now.day);
    switch (span) {
      case 'This Week':
        return OverviewBetweenInput(
            start: DateTime.now().subtract(const Duration(days: 7)), end: end);
      case 'Last Week':
        return OverviewBetweenInput(
            start: DateTime.now().subtract(const Duration(days: 14)),
            end: DateTime.now().subtract(const Duration(days: 7)));
      case 'This Month':
        return OverviewBetweenInput(
            start: DateTime.now().subtract(const Duration(days: 30)), end: end);
      case 'Last Month':
        return OverviewBetweenInput(
            start: DateTime.now().subtract(const Duration(days: 30 * 2)),
            end: DateTime.now().subtract(const Duration(days: 30)));
      default:
        return null;
    }
  }

  Future<void> loadMore() async {
    if (canLoadMore && !isLoadingMore) {
      isLoadingMore = true;
      OverviewBetweenInput? betweenRange;
      String? betweenString;
      betweenRange = getDatesBySpan(currentSelectedSpan$.value);
      betweenString = currentSelectedSpan$.value;
      await repository.getTradeOverview(
          callback: onSuccessGetOverviewMore,
          sentimentType: currentSentimentType$.value,
          queryType: QueryType.loadMore,
          onError: onError,
          between: betweenRange,
          betweenString: betweenString,
          orderBy: appliedIsGold.value
              ? OVERVIEW_ORDER_BY.TOP
              : OVERVIEW_ORDER_BY.ALL,
          offset: offset,
          limit: limit);
      isLoadingMore = false;
    }
  }

  void onError(err) {
    currentApiStatus$.value = API_STATUS.FINISHED;
  }

  onFilterApplied(bool isGold) {
    Get.back();
    // if (isGoldMember) {
    offset = 0;
    appliedIsGold.value = isGold;
    currentApiStatus$.value = API_STATUS.PENDING;
    currentSentimentData$.value = <AssetOverviewItem>[];
    getAssetAnalysis();
    // } else {
    //   HapticFeedback.heavyImpact();
    //   routeToGoldSignUp();
    // }
  }

  @override
  onInit() async {
    headController = linkedScrollControllerGroup.addAndGet();
    bodyController = linkedScrollControllerGroup.addAndGet();
    getAssetAnalysis();
    super.onInit();
  }

  onPressSelector(SENTIMENT_TYPE sentimentType) async {
    currentSentimentType$.value = sentimentType;
    currentApiStatus$.value = API_STATUS.PENDING;
    currentSentimentData$.value = <AssetOverviewItem>[];
    offset = 0;
    await getAssetAnalysis();
  }

  Future<void> onRefresh() async {
    offset = 0;
    // currentApiStatus$.value = API_STATUS.PENDING;
    await getAssetAnalysis();
  }

  void onSuccessGetOverview(AnalyticsPopularData<AssetOverviewItem> data) {
    if (shouldShowResult(data.filterFields)) {
      if (data.list!.length == limit) {
        offset += limit;
        canLoadMore = true;
      } else {
        canLoadMore = false;
      }
      currentSentimentData$.assignAll(data.list!);
      if (data.list!.isNotEmpty) {
        currentApiStatus$.value = API_STATUS.FINISHED;
      } else {
        currentApiStatus$.value = API_STATUS.EMPTY;
      }
    }
  }

  void onSuccessGetOverviewMore(AnalyticsPopularData<AssetOverviewItem> data) {
    if (shouldShowResult(data.filterFields)) {
      if (data.list!.length == limit) {
        offset += limit;
        canLoadMore = true;
      } else {
        canLoadMore = false;
      }
      currentApiStatus$.value = API_STATUS.FINISHED;
      currentSentimentData$.addAll(data.list!);
    }
  }

  refreshBySpan(String span) async {
    currentSelectedSpan$.value = span;
    currentApiStatus$.value = API_STATUS.PENDING;
    currentSentimentData$.value = <AssetOverviewItem>[];
    offset = 0;
    await getAssetAnalysis();
  }

  // routeToGoldSignUp() async {
  //   await Get.toNamed(Paths.IrisGoldSettingsPreview);
  // }

  bool shouldShowResult(AnalyticsPopularFilterFields filterFields) {
    if (filterFields.sentimentType != currentSentimentType$.value) {
      return false;
    }
    final currentOrderBy =
        appliedIsGold.value ? OVERVIEW_ORDER_BY.TOP : OVERVIEW_ORDER_BY.ALL;
    if (filterFields.orderBy != currentOrderBy) {
      return false;
    }
    final currentBetweenRange = getDatesBySpan(currentSelectedSpan$.value);
    if (filterFields.between.start != currentBetweenRange!.start) {
      return false;
    }
    if (filterFields.between.end != currentBetweenRange.end) {
      return false;
    }
    return true;
  }

  sortTradeAnalysisData(
      {SORT_BY? sortBy, SENTIMENT_TYPE? sentimentType}) async {
    sortColumns$.value.sortBy = sortBy;
    sortColumns$.value.orderByAsc = !sortColumns$.value.orderByAsc!;
    List<AssetOverviewItem> tempData;
    tempData = currentSentimentData$.value;
    currentSentimentData$.value = [];
    final bool? asc = sortColumns$.value.orderByAsc;
    switch (sortBy) {
      case SORT_BY.PINVESTORS:
        tempData.sort((a, b) {
          final double val1 = (sentimentType == SENTIMENT_TYPE.BULLISH
                  ? !isCrown
                      ? a.pctInvestorsTotalBull
                      : a.pctInvestorsTotalBullTop
                  : !isCrown
                      ? a.pctInvestorsTotalBear
                      : a.pctInvestorsTotalBearTop) ??
              0;
          final double val2 = (sentimentType == SENTIMENT_TYPE.BULLISH
                  ? !isCrown
                      ? b.pctInvestorsTotalBull
                      : b.pctInvestorsTotalBullTop
                  : !isCrown
                      ? b.pctInvestorsTotalBear
                      : b.pctInvestorsTotalBearTop) ??
              0;
          if (asc!) {
            return val1.compareTo(val2);
          } else {
            return val2.compareTo(val1);
          }
        });
        break;
      case SORT_BY.DINVESTED:
        tempData.sort((a, b) {
          final double val1 = (sentimentType == SENTIMENT_TYPE.BULLISH
                  ? !isCrown
                      ? a.amtInvestedBull
                      : a.amtInvestedBullTop
                  : !isCrown
                      ? a.amtInvestedBear
                      : a.amtInvestedBearTop) ??
              0;
          final double val2 = (sentimentType == SENTIMENT_TYPE.BULLISH
                  ? !isCrown
                      ? b.amtInvestedBull
                      : b.amtInvestedBullTop
                  : !isCrown
                      ? b.amtInvestedBear
                      : b.amtInvestedBearTop) ??
              0;
          if (asc!) {
            return val1.compareTo(val2);
          } else {
            return val2.compareTo(val1);
          }
        });
        break;
      case SORT_BY.BULLISHORBEARISH:
        tempData.sort((a, b) {
          final double val1 = (sentimentType == SENTIMENT_TYPE.BULLISH
                  ? !isCrown
                      ? a.pctInvestorsBull
                      : a.pctInvestorsBullTop
                  : !isCrown
                      ? a.pctInvestorsBear
                      : a.pctInvestorsBearTop) ??
              0;
          final double val2 = (sentimentType == SENTIMENT_TYPE.BULLISH
                  ? !isCrown
                      ? b.pctInvestorsBull
                      : b.pctInvestorsBullTop
                  : !isCrown
                      ? b.pctInvestorsBear
                      : b.pctInvestorsBearTop) ??
              0;
          if (asc!) {
            return val1.compareTo(val2);
          } else {
            return val2.compareTo(val1);
          }
        });
        break;
      // case SORT_BY.BEAR_TRADES:
      //   tempData.sort((a, b) {
      //     if (asc!) {
      //       return a.bearishTransactionCount!
      //           .compareTo(b.bearishPositionsOpenedCount!);
      //     } else {
      //       return b.bearishTransactionCount!
      //           .compareTo(a.bearishPositionsOpenedCount!);
      //     }
      //   });
      //   break;
      // case SORT_BY.BEAR_AMOUNT:
      //   tempData.sort((a, b) {
      //     if (asc!) {
      //       return a.bearishAmountOpen!.compareTo(b.bearishAmountOpen!);
      //     } else {
      //       return b.bearishAmountOpen!.compareTo(a.bearishAmountOpen!);
      //     }
      //   });
      //   break;
      default:
        tempData.sort((a, b) {
          final double val1 = (sentimentType == SENTIMENT_TYPE.BULLISH
                  ? !isCrown
                      ? a.pctInvestorsTotalBull
                      : a.pctInvestorsTotalBullTop
                  : !isCrown
                      ? a.pctInvestorsTotalBear
                      : a.pctInvestorsTotalBearTop) ??
              0;
          final double val2 = (sentimentType == SENTIMENT_TYPE.BULLISH
                  ? !isCrown
                      ? b.pctInvestorsTotalBull
                      : b.pctInvestorsTotalBullTop
                  : !isCrown
                      ? b.pctInvestorsTotalBear
                      : b.pctInvestorsTotalBearTop) ??
              0;
          if (asc!) {
            return val1.compareTo(val2);
          } else {
            return val2.compareTo(val1);
          }
        });
        break;
    }
    currentSentimentData$.value = tempData;
  }
}
