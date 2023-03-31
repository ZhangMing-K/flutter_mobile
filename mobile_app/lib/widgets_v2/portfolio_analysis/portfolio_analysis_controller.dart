import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'widgets/portfolio_analysis_table.dart';
import 'widgets/trade_analysis_chart.dart';

class PortfolioAnalysisController extends GetxController {
  int? portfolioKey;
  int? userKey;
  String? symbol;
  DISPLAY_UNIT? displayUnit;
  bool? isAuthUser;
  TradeAnalysisService tradeAnalysisService = Get.find();

  Rx<String?> selectedSpan$ = Rx('Year');
  Rx<OPTION_TYPE?> selectedOptionType$ = Rx<OPTION_TYPE?>(null);
  Rx<POSITION_TYPE?> selectedPositionType$ = Rx<POSITION_TYPE?>(null);
  Rx<String?> selectedSpecificPositionType$ = Rx('All');
  List<String> spans = ['Week', '1M', '3M', '6M', 'Year', 'All'];
  List<String> positionTypes = ['All', 'Equity', 'Options', 'Calls', 'Puts'];
  RxList<TradeAnalysis> dataSource$ = <TradeAnalysis>[].obs;
  // Rx<PortfolioAnalysisDGSource> dataSource$ = Rx();
  Rx<double?> totalProfitLoss$ = Rx<double?>(null);
  Rx<double?> totalInvested$ = Rx<double?>(null);
  Rx<double?> totalPercentProfitLoss$ = Rx<double?>(null);
  Rx<double?> chartSize$ = Rx<double?>(null);
  RxList<TradeAnalysisChartData> positionTypeAnalysis$ =
      <TradeAnalysisChartData>[].obs;
  Rx<bool> realized$ = Rx(false);
  Rx<DISPLAY_UNIT> displayUnitToggle$ = Rx(DISPLAY_UNIT.DOLLAR);
  Rx<bool> displayUnitToggleBool$ = Rx(true);
  late ChartSeriesController tradeAnalysisChartController;
  Rx<SortColumns> sortColumns$ =
      Rx(SortColumns(sortBy: SORT_BY.GAIN, orderByAsc: false));
  PortfolioAnalysisController(
      {this.userKey,
      this.portfolioKey,
      this.symbol,
      this.displayUnit,
      this.isAuthUser});

  DateRangeInput? getDatesBySpan(String? span) {
    switch (span) {
      case 'All':
        return null;
      case 'Week':
        return DateRangeInput(
            start: DateTime.now().subtract(const Duration(days: 7)),
            end: DateTime.now());
      case '1M':
        return DateRangeInput(
            start: DateTime.now().subtract(const Duration(days: 31)),
            end: DateTime.now());
      case '3M':
        return DateRangeInput(
            start: DateTime.now().subtract(const Duration(days: 92)),
            end: DateTime.now());
      case '6M':
        return DateRangeInput(
            start: DateTime.now().subtract(const Duration(days: 180)),
            end: DateTime.now());
      case 'Year':
        return DateRangeInput(
            start: DateTime.now().subtract(const Duration(days: 365)),
            end: DateTime.now());
      default:
        return null;
    }
  }

  getPositionTypeAnalysis() async {
    final betweenRange = getDatesBySpan(selectedSpan$.value);
    final res = await tradeAnalysisService.positionTypeAnalysisGet(
        locator: portfolioKey != null ? LOCATOR.PORTFOLIO : LOCATOR.USER,
        locatorKeys: [portfolioKey ?? userKey],
        positionStatus: realized$.value
            ? POSITION_STATUS.REALIZED
            : POSITION_STATUS.ALL_GAINS,
        between: betweenRange);
    final List<TradeAnalysisChartData> taList = [
      TradeAnalysisChartData(profitLoss: 0.00001, tradeType: 'Equity'),
      TradeAnalysisChartData(profitLoss: 0.00002, tradeType: 'Call'),
      TradeAnalysisChartData(profitLoss: 0.00003, tradeType: 'Put'),
      TradeAnalysisChartData(profitLoss: 0.00004, tradeType: 'Crypto'),
    ];
    for (var ta in res) {
      final double? profitLoss = displayUnitToggle$.value == DISPLAY_UNIT.DOLLAR
          ? ta.profitLossTotal
          : ta.profitLossPercentRelative;
      final int index = taList.indexWhere((t) =>
          t.tradeType ==
          describeEnum(ta.optionType ?? ta.positionType!).capitalize);
      if (index >= 0) {
        taList[index].profitLoss = profitLoss;
      }
    }
    positionTypeAnalysis$.value = taList;
    totalProfitLoss$.value =
        res.fold(0, (sum, item) => sum! + item.profitLossTotal!);
    totalPercentProfitLoss$.value =
        res.fold(0, (sum, item) => sum! + item.profitLossPercentRelative!);
  }

  getTradeAnalysis() async {
    final List<TradeAnalysis>? res = await getTradeAnalysisByOffset();
    if (res != null) {
      dataSource$.value = res;
      chartSize$.value = res.length * 60 + 80.toDouble();
    }
  }

  Future<List<TradeAnalysis>?> getTradeAnalysisByOffset(
      {int offset = 0}) async {
    final betweenRange = getDatesBySpan(selectedSpan$.value);
    return await tradeAnalysisService.tradeAnalysisGet(
        locator: portfolioKey != null ? LOCATOR.PORTFOLIO : LOCATOR.USER,
        locatorKeys: [portfolioKey ?? userKey],
        positionTypes: selectedPositionType$.value == null
            ? null
            : [selectedPositionType$.value],
        optionTypes: selectedOptionType$.value == null
            ? null
            : [selectedOptionType$.value],
        orderGroupBy: ORDER_GROUP_BY.SYMBOL,
        positionStatus: realized$.value
            ? POSITION_STATUS.REALIZED
            : POSITION_STATUS.ALL_GAINS,
        unit: DECIDING_UNIT.TOTAL_GAIN,
        between: betweenRange,
        offset: offset);
  }

  @override
  onReady() async {
    if (displayUnit == null) if (isAuthUser!) {
      displayUnitToggle$.value = DISPLAY_UNIT.DOLLAR;
    } else {
      displayUnitToggle$.value = DISPLAY_UNIT.PERCENT;
    }
    getPositionTypeAnalysis();
    getTradeAnalysis();
    super.onReady();
  }

  onTradeAnalysisChartRender(ChartSeriesController controller) {
    tradeAnalysisChartController = controller;
  }

  refreshByPositionType(String? positionType) async {
    selectedSpecificPositionType$.value = positionType;
    switch (positionType) {
      case 'All':
        selectedPositionType$.value = null;
        selectedOptionType$.value = null;
        break;
      case 'Equity':
        selectedPositionType$.value = POSITION_TYPE.EQUITY;
        selectedOptionType$.value = null;
        break;
      case 'Options':
        selectedPositionType$.value = POSITION_TYPE.OPTION;
        selectedOptionType$.value = null;
        break;
      case 'Calls':
        selectedPositionType$.value = null;
        selectedOptionType$.value = OPTION_TYPE.CALL;
        break;
      case 'Puts':
        selectedPositionType$.value = null;
        selectedOptionType$.value = OPTION_TYPE.PUT;
        break;
    }
    await getTradeAnalysis();
  }

  refreshByRealized(bool realized) async {
    realized$.value = realized;
    await getPositionTypeAnalysis();
    tradeAnalysisChartController.animate();
    await getTradeAnalysis();
  }

  refreshBySpan(span) async {
    selectedSpan$.value = span;
    await getPositionTypeAnalysis();
    tradeAnalysisChartController.animate();
    await getTradeAnalysis();
  }

  refresheByDisplayUnit(bool displayBool) async {
    displayUnitToggleBool$.value = displayBool;
    displayUnitToggle$.value =
        displayBool ? DISPLAY_UNIT.DOLLAR : DISPLAY_UNIT.PERCENT;
    await getPositionTypeAnalysis();
    tradeAnalysisChartController.animate();
  }

  sortTradeAnalysisData({SORT_BY? sortBy}) async {
    sortColumns$.value.sortBy = sortBy;
    sortColumns$.value.orderByAsc = !sortColumns$.value.orderByAsc!;
    final tempData = dataSource$.value;
    dataSource$.value = [];
    final bool? asc = sortColumns$.value.orderByAsc;
    switch (sortBy) {
      case SORT_BY.GAIN:
        tempData.sort((a, b) {
          final double val1 = a.profitLossTotal ?? 0;
          final double val2 = b.profitLossTotal ?? 0;
          final double val3 = a.profitLossPercentPortfolio ?? 0;
          final double val4 = b.profitLossPercentPortfolio ?? 0;
          if (asc!) {
            if (displayUnitToggle$.value == DISPLAY_UNIT.DOLLAR) {
              return val1.compareTo(val2);
            } else {
              return val3.compareTo(val4);
            }
          } else {
            if (displayUnitToggle$.value == DISPLAY_UNIT.DOLLAR) {
              return val2.compareTo(val1);
            } else {
              return val4.compareTo(val3);
            }
          }
        });
        break;
      case SORT_BY.PERCENT_GAIN:
        tempData.sort((a, b) {
          final double val1 = a.gainPercentAverageInvestment ?? 0;
          final double val2 = b.gainPercentAverageInvestment ?? 0;
          if (asc!) {
            return val1.compareTo(val2);
          } else {
            return val2.compareTo(val1);
          }
        });
        break;
      case SORT_BY.SYMBOL:
        tempData.sort((a, b) {
          if (asc!) {
            return b.symbol!.compareTo(a.symbol!);
          } else {
            return a.symbol!.compareTo(b.symbol!);
          }
        });
        break;
      case SORT_BY.TRADE_COUNT:
        tempData.sort((a, b) {
          if (asc!) {
            return a.transactionCount!.compareTo(b.transactionCount!);
          } else {
            return b.transactionCount!.compareTo(a.transactionCount!);
          }
        });
        break;
      default:
        tempData.sort((a, b) {
          final double val1 = a.profitLossTotal ?? 0;
          final double val2 = b.profitLossTotal ?? 0;
          final double val3 = a.profitLossPercentPortfolio ?? 0;
          final double val4 = b.profitLossPercentPortfolio ?? 0;
          if (asc!) {
            if (displayUnitToggle$.value == DISPLAY_UNIT.DOLLAR) {
              return val1.compareTo(val2);
            } else {
              return val3.compareTo(val4);
            }
          } else {
            if (displayUnitToggle$.value == DISPLAY_UNIT.DOLLAR) {
              return val2.compareTo(val1);
            } else {
              return val4.compareTo(val3);
            }
          }
        });
        break;
    }
    dataSource$.value = tempData;
  }
}
