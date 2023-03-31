import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-order-flow/views/table/constants.dart';
import 'package:iris_mobile/app/modules/analytics-menu/shared/gold_gradient_wrapper/gold_gradient_wrapper.dart';

class OrderEquityTable extends StatelessWidget {
  final List<OrderFlow> dataSource;
  final Function({SORT_BY? sortBy})? handleSortData;
  final SortColumns? sortedColumn;
  final API_STATUS? apiStatus;
  final bool? loadFinished;
  final Function? loadMore;
  final bool? isTop;
  final bool? isBottom;
  final bool? reset;

  const OrderEquityTable(
      {Key? key,
      required this.dataSource,
      this.handleSortData,
      this.sortedColumn,
      this.loadMore,
      this.loadFinished = false,
      this.isTop,
      this.isBottom,
      this.reset,
      this.apiStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaleFactor = context.textScaleFactor;
    return Column(
      children: [
        if (apiStatus == null || apiStatus == API_STATUS.PENDING)
          const IrisLoading(),
        if (dataSource.isEmpty && apiStatus == API_STATUS.FINISHED)
          Container(
            height: Get.height / 3,
            alignment: Alignment.center,
            child: const Text('No trade data :( Check back later'),
          ),
        if (apiStatus == API_STATUS.FINISHED && dataSource.isNotEmpty)
          Obx(() {
            return SizedBox(
                height: 300 * scaleFactor,
                child: HorizontalDataTable(
                  leftHandSideColumnWidth: staticWidth * scaleFactor,
                  rightHandSideColumnWidth:
                      equityTableWidth.fold(0, (p, c) => p + c * scaleFactor),
                  isFixedHeader: true,
                  headerWidgets: dataSource.isEmpty
                      ? [const Text('')]
                      : [
                          Container(
                              color: context.theme.backgroundColor,
                              height: 50 * scaleFactor,
                              child: headerItem(
                                  text: 'Ticker',
                                  sortBy: SORT_BY.TICKER,
                                  width: staticWidth,
                                  alignment: Alignment.center)),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              color: context.theme.backgroundColor,
                              height: 50 * scaleFactor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  headerItem(
                                      text: equityTableHeader[0],
                                      width: equityTableWidth[0],
                                      sortBy: SORT_BY.TIME,
                                      alignment: Alignment.center),
                                  headerItem(
                                      text: equityTableHeader[1],
                                      width: equityTableWidth[1],
                                      sortBy: SORT_BY.STRATEGY),
                                  headerItem(
                                      text: equityTableHeader[2],
                                      width: equityTableWidth[2],
                                      sortBy: SORT_BY.TRADER_PERCENTILE),
                                  headerItem(
                                      text: equityTableHeader[3],
                                      width: equityTableWidth[3],
                                      sortBy: SORT_BY.INVESTED),
                                  headerItem(
                                      text: equityTableHeader[4],
                                      width: equityTableWidth[4],
                                      sortBy: SORT_BY.TRADER_ACCURACY),
                                  headerItem(
                                      text: equityTableHeader[5],
                                      width: equityTableWidth[5],
                                      sortBy: SORT_BY.TRADER_ACCURACY),
                                  headerItem(
                                      text: equityTableHeader[6],
                                      width: equityTableWidth[6],
                                      sortBy: SORT_BY.TRADER_ACCURACY),
                                  headerItem(
                                      text: equityTableHeader[7],
                                      width: equityTableWidth[7],
                                      sortBy: SORT_BY.TRADER_ACCURACY),
                                  headerItem(
                                      text: equityTableHeader[8],
                                      width: equityTableWidth[8],
                                      sortBy: SORT_BY.TRADER_ACCURACY),
                                  headerItem(
                                      text: equityTableHeader[9],
                                      width: equityTableWidth[9],
                                      sortBy: SORT_BY.TRADER_ACCURACY),
                                ],
                              )),
                        ],
                  itemCount: dataSource.length,
                  leftSideItemBuilder: (BuildContext context, int index) {
                    return orderFlowsFixedItem(dataSource[index], index);
                  },
                  rightSideItemBuilder: (BuildContext context, int index) {
                    return orderFlowsItem(dataSource[index], index);
                  },
                  rowSeparatorWidget: const Divider(
                    color: Colors.black54,
                    height: 0.0,
                    thickness: 0.0,
                  ),
                  leftHandSideColBackgroundColor: context.theme.backgroundColor,
                  rightHandSideColBackgroundColor:
                      context.theme.backgroundColor,
                  verticalScrollbarStyle: const ScrollbarStyle(
                    isAlwaysShown: false,
                    thickness: 0.0,
                    radius: Radius.circular(0.0),
                  ),
                  horizontalScrollbarStyle: const ScrollbarStyle(
                    isAlwaysShown: false,
                    thickness: 0.0,
                    radius: Radius.circular(0.0),
                  ),
                ));
          })
      ],
    );
  }

  Widget cell(
      {Widget? contents,
      double? width,
      Color color = Colors.transparent,
      Alignment alignment = Alignment.center}) {
    return Builder(builder: (context) {
      final scaleFactor = context.textScaleFactor;
      return Container(
        width: (width ?? 80) * scaleFactor,
        height: 50 * scaleFactor,
        alignment: alignment,
        color: color,
        child: contents,
      );
    });
  }

  Color getColor(bool positive) {
    if (positive) {
      return IrisColor.positiveChange;
    } else {
      return IrisColor.negativeChange;
    }
  }

  Widget headerItem(
      {String? text,
      double? width = 80,
      SORT_BY? sortBy,
      Color? color,
      Alignment alignment = Alignment.center}) {
    return Builder(builder: (context) {
      final scaleFactor = context.textScaleFactor;
      return InkWell(
          onTap: () {
            // handleSortData!(sortBy: sortBy);
          },
          child: Container(
              width: width! * scaleFactor,
              alignment: alignment,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: SizedBox(
                        width: (width - 10) * scaleFactor,
                        child: Text(text!,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: IrisScreenUtil.dFontSize(12),
                              fontWeight: FontWeight.w500,
                              color: sortedColumn!.sortBy == sortBy
                                  ? color ??
                                      context.theme.colorScheme.secondary
                                          .withOpacity(0.75)
                                  : color ??
                                      context.theme.colorScheme.secondary
                                          .withOpacity(0.4),
                            ))),
                  ),
                  if (sortedColumn!.sortBy == sortBy)
                    Icon(
                      sortedColumn!.orderByAsc!
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 10 * scaleFactor,
                    )
                ],
              )));
    });
  }

  bool isOrderToday(DateTime orderFulFilledAt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final orderDate = DateTime(
        orderFulFilledAt.year, orderFulFilledAt.month, orderFulFilledAt.day);
    if (orderDate == today) {
      return true;
    }
    return false;
  }

  Widget orderFlowsFixedItem(OrderFlow ta, int index) {
    return Builder(builder: (context) {
      final scaleFactor = context.textScaleFactor;
      return GestureDetector(
          onTap: () {
            final int assetKey = ta.order!.asset?.assetKey ?? 0;
            if (assetKey > 0) {
              // Get.toNamed(
              //   Paths.Asset,
              //   parameters: {'assetKey': assetKey.toString()},
              // );
            }
          },
          child: Container(
            color: index % 2 == 0
                ? context.theme.backgroundColor
                : context.theme.dialogBackgroundColor,
            height: 50 * scaleFactor,
            child: ta.isTopTrader!
                ? IrisGoldGradientRapper(
                    child: cell(
                        contents: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 4 * scaleFactor,
                              color: ta.order!.sentimentType ==
                                      SENTIMENT_TYPE.BULLISH
                                  ? IrisColor.positiveChange
                                  : IrisColor.negativeChange,
                            ),
                            SizedBox(width: 6 * scaleFactor),
                            Text(ta.order!.symbol!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        width: staticWidth,
                        alignment: Alignment.center),
                  )
                : cell(
                    contents: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 4 * scaleFactor,
                          color:
                              ta.order!.sentimentType == SENTIMENT_TYPE.BULLISH
                                  ? IrisColor.positiveChange
                                  : IrisColor.negativeChange,
                        ),
                        SizedBox(width: 6 * scaleFactor),
                        Text(ta.order!.symbol!,
                            style: const TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                    width: staticWidth,
                    alignment: Alignment.center),
          ));
    });
  }

  Widget orderFlowsItem(OrderFlow ta, int index) {
    final double gainLossValue = ta.order?.profitLossPercentValue ?? 0;
    final String gainLossInd = gainLossValue > 0 ? '+' : '';
    final String currentPrice =
        ta.order?.asset?.currentPrice.formatCurrency() ?? '-';
    return Builder(builder: (context) {
      final scaleFactor = context.textScaleFactor;
      return Container(
          color: index % 2 == 0
              ? context.theme.backgroundColor
              : context.theme.dialogBackgroundColor,
          height: 50 * scaleFactor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              cell(
                  width: equityTableWidth[0],
                  contents: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            DateFormat('h:mm aa')
                                .format(ta.order!.fullfilledAt!.toLocal()),
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.normal,
                                color: context.theme.colorScheme.secondary
                                    .withOpacity(0.5))),
                        if (!isOrderToday(ta.order!.fullfilledAt!.toLocal()))
                          Text(
                              DateFormat('M/d/yy')
                                  .format(ta.order!.fullfilledAt!.toLocal()),
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.normal,
                                  color: context.theme.colorScheme.secondary
                                      .withOpacity(0.5))),
                      ])),
              cell(
                  width: equityTableWidth[1],
                  color: ta.order!.sentimentType == SENTIMENT_TYPE.BULLISH
                      ? IrisColor.positiveChange
                      : IrisColor.negativeChange,
                  contents: Text(
                    ta.order!.orderSideDisplayAction,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
              ta.isTopTrader!
                  ? IrisGoldGradientRapper(
                      child: cell(
                          width: equityTableWidth[2],
                          contents: Text(ta.percentile.formatPercentage(),
                              style: TextStyle(
                                  color: context.theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w500))))
                  : cell(
                      width: equityTableWidth[2],
                      contents: Text(ta.percentile.formatPercentage(),
                          style: TextStyle(
                              color: context.theme.colorScheme.secondary,
                              fontWeight: FontWeight.w500))),
              ta.isTopTrader!
                  ? IrisGoldGradientRapper(
                      child: cell(
                          width: equityTableWidth[3],
                          contents: Text(
                              '\$${ta.transactionAmount.formatCompact()}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500))),
                    )
                  : cell(
                      width: equityTableWidth[3],
                      contents: Text(
                          '\$${ta.transactionAmount.formatCompact()}',
                          style: const TextStyle(fontWeight: FontWeight.w500))),
              ta.isTopTrader!
                  ? IrisGoldGradientRapper(
                      child: cell(
                          width: equityTableWidth[4],
                          contents: Text(ta.tradeAccuracy.formatPercentage(),
                              style: TextStyle(
                                  color: context.theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w500))))
                  : cell(
                      width: equityTableWidth[4],
                      contents: Text(ta.tradeAccuracy.formatPercentage(),
                          style: TextStyle(
                              color: context.theme.colorScheme.secondary,
                              fontWeight: FontWeight.w500))),
              ta.isTopTrader!
                  ? IrisGoldGradientRapper(
                      child: cell(
                          width: equityTableWidth[5],
                          contents: Text(
                              ta.order!.portfolioAllocation.formatPercentage(),
                              style: TextStyle(
                                  color: context.theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w500))))
                  : cell(
                      width: equityTableWidth[5],
                      contents: Text(
                          ta.order!.portfolioAllocation.formatPercentage(),
                          style: TextStyle(
                              color: context.theme.colorScheme.secondary,
                              fontWeight: FontWeight.w500))),
              ta.isTopTrader!
                  ? IrisGoldGradientRapper(
                      child: cell(
                          width: equityTableWidth[6],
                          contents: Text(
                              '\$${ta.order!.averageBuyPrice.formatCompact()}',
                              style: TextStyle(
                                  color: context.theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w500))))
                  : cell(
                      width: equityTableWidth[6],
                      contents: Text(
                          '\$${ta.order!.averageBuyPrice.formatCompact()}',
                          style: TextStyle(
                              color: context.theme.colorScheme.secondary,
                              fontWeight: FontWeight.w500))),
              ta.isTopTrader!
                  ? IrisGoldGradientRapper(
                      child: cell(
                          width: equityTableWidth[7],
                          contents: Text(currentPrice,
                              style: TextStyle(
                                  color: context.theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w500))))
                  : cell(
                      width: equityTableWidth[7],
                      contents: Text(currentPrice,
                          style: TextStyle(
                              color: context.theme.colorScheme.secondary,
                              fontWeight: FontWeight.w500))),
              cell(
                  width: equityTableWidth[8],
                  contents: Text(
                      gainLossInd +
                          ta.order!.profitLossPercentValue.formatPercentage(),
                      style: TextStyle(
                          color: gainLossValue > 0
                              ? IrisColor.positiveChange
                              : gainLossValue == 0
                                  ? context.theme.colorScheme.secondary
                                      .withOpacity(0.5)
                                  : IrisColor.negativeChange,
                          fontWeight: FontWeight.w500))),
              ta.isTopTrader!
                  ? IrisGoldGradientRapper(
                      child: cell(
                          width: equityTableWidth[9],
                          contents: Text(ta.order!.positionEffectDisplay,
                              style: TextStyle(
                                  color: context.theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w500))))
                  : cell(
                      width: equityTableWidth[9],
                      contents: Text(ta.order!.positionEffectDisplay,
                          style: TextStyle(
                              color: context.theme.colorScheme.secondary,
                              fontWeight: FontWeight.w500))),
            ],
          ));
    });
  }

  Widget orderFlowsRow(OrderFlow orderFlow, int index) {
    return InkWell(
        onTap: () {},
        child: Column(
          children: [
            orderFlowsItem(orderFlow, index),
          ],
        ));
  }

  Widget orderFlowsRowFixed(
    OrderFlow orderFlow,
    int index,
  ) {
    return InkWell(
        onTap: () {},
        child: Column(
          children: [
            orderFlowsFixedItem(orderFlow, index),
          ],
        ));
  }

  List<Widget> tableData() {
    List<Widget> widgets = [];
    dataSource.asMap().forEach((int key, OrderFlow value) {
      widgets.add(orderFlowsRow(value, key));
    });
    return widgets;
  }

  List<Widget> tableHeaderData() {
    List<Widget> widgets = [];
    dataSource.asMap().forEach((int key, OrderFlow value) {
      widgets.add(orderFlowsRowFixed(value, key));
    });
    return widgets;
  }

  Widget valueCell(String value, {required bool positive}) {
    return Text(value,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 12,
            color: getColor(positive),
            fontWeight: FontWeight.bold));
  }
}
