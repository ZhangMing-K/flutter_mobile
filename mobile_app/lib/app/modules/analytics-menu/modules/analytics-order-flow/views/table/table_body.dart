import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iris_mobile/app/modules/analytics-menu/shared/gold_gradient_wrapper/gold_gradient_wrapper.dart';
import 'package:iris_mobile/app/routes/pages.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import 'constants.dart';

class TableBody extends StatelessWidget {
  final List<OrderFlow>? dataSource;
  final ScrollController? scrollController;
  final POSITION_TYPE positionType;
  const TableBody({
    Key? key,
    this.dataSource,
    this.scrollController,
    required this.positionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rowWidths = positionType == POSITION_TYPE.OPTION
        ? optionTableWidth
        : equityTableWidth;
    final scaleFactor = context.textScaleFactor;

    return GetBuilder<TableBodyController>(
        init: TableBodyController(),
        global: false,
        builder: (controller) {
          return Row(
            children: [
              SizedBox(
                width: staticWidth * scaleFactor,
                child: ListView(
                  controller: controller._headController,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  children: List.generate(dataSource!.length, (index) {
                    final ta = dataSource![index];
                    return positionType == POSITION_TYPE.OPTION
                        ? orderFlowsOptionsStaticItem(ta, index)
                        : orderFlowsEquityStaticItem(ta, index);
                  }),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: ClampingScrollPhysics()),
                  child: SizedBox(
                    width: rowWidths.fold(0, (p, c) => p! + c * scaleFactor),
                    child: ListView(
                      controller: controller._bodyController,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      children: List.generate(dataSource!.length, (y) {
                        final OrderFlow item = dataSource![y];
                        return Row(children: [
                          positionType == POSITION_TYPE.OPTION
                              ? orderFlowsOptionsItem(
                                  item,
                                  y,
                                  controller.isOrderToday(
                                      item.order!.fullfilledAt!.toLocal()))
                              : orderFlowsEquityItem(
                                  item,
                                  y,
                                  controller.isOrderToday(
                                      item.order!.fullfilledAt!.toLocal()))
                        ]);
                      }),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
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

  Widget orderFlowsEquityItem(OrderFlow ta, int index, bool isOrderToday) {
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
                        if (!isOrderToday)
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

  Widget orderFlowsEquityStaticItem(OrderFlow ta, int index) {
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
            width: staticWidth,
            child: ta.isTopTrader!
                ? IrisGoldGradientRapper(
                    child: cell(
                        contents: Row(
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
                                  style: TextStyle(
                                      color:
                                          context.theme.colorScheme.secondary,
                                      fontWeight: FontWeight.bold))
                            ]),
                        width: staticWidth,
                        alignment: Alignment.center),
                  )
                : cell(
                    contents: Row(
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
                              style: TextStyle(
                                  color: context.theme.colorScheme.secondary,
                                  fontWeight: FontWeight.bold))
                        ]),
                    width: staticWidth,
                    alignment: Alignment.center),
          ));
    });
  }

  Widget orderFlowsOptionsItem(OrderFlow ta, int index, bool isOrderToday) {
    final double gainLossValue = ta.order!.profitLossPercentValue ?? 0;
    final String gainLossInd = gainLossValue > 0 ? '+' : '';
    final String expirationDate = ta.order!.expirationDate != null
        ? ta.order!.expirationDate!.toLocal().formatMonthDayYear()
        : '';
    return Builder(builder: (context) {
      final scaleFactor = context.textScaleFactor;
      return Container(
          color: index % 2 == 0
              ? context.theme.backgroundColor
              : context.theme.dialogBackgroundColor,
          height: 50 * scaleFactor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cell(
                  width: optionTableWidth[0],
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
                        if (!isOrderToday)
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
                  width: optionTableWidth[1],
                  color: ta.order!.sentimentType == SENTIMENT_TYPE.BULLISH
                      ? IrisColor.positiveChange
                      : IrisColor.negativeChange,
                  contents: Text(
                    ta.order!.optionType != null
                        ? describeEnum(ta.order!.optionType!)
                        : '',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
              ta.isTopTrader!
                  ? IrisGoldGradientRapper(
                      child: cell(
                          width: optionTableWidth[2],
                          contents: Text(ta.percentile.formatPercentage(),
                              style: TextStyle(
                                  color: context.theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w500))))
                  : cell(
                      width: optionTableWidth[2],
                      contents: Text(ta.percentile.formatPercentage(),
                          style: TextStyle(
                              color: context.theme.colorScheme.secondary,
                              fontWeight: FontWeight.w500))),
              ta.isTopTrader!
                  ? IrisGoldGradientRapper(
                      child: cell(
                          width: optionTableWidth[3],
                          contents: Text(ta.transactionAmount.formatCurrency(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500))),
                    )
                  : cell(
                      width: optionTableWidth[3],
                      contents: Text(ta.transactionAmount.formatCurrency(),
                          style: const TextStyle(fontWeight: FontWeight.w500))),
              ta.isTopTrader!
                  ? IrisGoldGradientRapper(
                      child: cell(
                          width: optionTableWidth[4],
                          contents: Text(ta.tradeAccuracy.formatPercentage(),
                              style: TextStyle(
                                  color: context.theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w500))))
                  : cell(
                      width: optionTableWidth[4],
                      contents: Text(ta.tradeAccuracy.formatPercentage(),
                          style: TextStyle(
                              color: context.theme.colorScheme.secondary,
                              fontWeight: FontWeight.w500))),
              ta.isTopTrader!
                  ? IrisGoldGradientRapper(
                      child: cell(
                          width: optionTableWidth[5],
                          contents: Text(
                              ta.order!.portfolioAllocation.formatPercentage(),
                              style: TextStyle(
                                  color: context.theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w500))))
                  : cell(
                      width: optionTableWidth[5],
                      contents: Text(
                          ta.order!.portfolioAllocation.formatPercentage(),
                          style: TextStyle(
                              color: context.theme.colorScheme.secondary,
                              fontWeight: FontWeight.w500))),
              ta.isTopTrader!
                  ? IrisGoldGradientRapper(
                      child: cell(
                          width: optionTableWidth[6],
                          contents: Text(expirationDate,
                              style: TextStyle(
                                  color: context.theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w500))))
                  : cell(
                      width: optionTableWidth[6],
                      contents: Text(expirationDate,
                          style: TextStyle(
                              color: context.theme.colorScheme.secondary,
                              fontWeight: FontWeight.w500))),
              ta.isTopTrader!
                  ? IrisGoldGradientRapper(
                      child: cell(
                          width: optionTableWidth[7],
                          contents: Text(
                              '\$${ta.order!.strikePrice.formatCompact()}',
                              style: TextStyle(
                                  color: context.theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w500))))
                  : cell(
                      width: optionTableWidth[7],
                      contents: Text(
                          '\$${ta.order!.strikePrice.formatCompact()}',
                          style: TextStyle(
                              color: context.theme.colorScheme.secondary,
                              fontWeight: FontWeight.w500))),
              ta.isTopTrader!
                  ? IrisGoldGradientRapper(
                      child: cell(
                          width: optionTableWidth[8],
                          contents: Text(
                              ta.order!.asset?.currentPrice.formatCurrency() ??
                                  '-',
                              style: TextStyle(
                                  color: context.theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w500))))
                  : cell(
                      width: optionTableWidth[8],
                      contents: Text(
                          ta.order!.asset?.currentPrice.formatCurrency() ?? '-',
                          style: TextStyle(
                              color: context.theme.colorScheme.secondary,
                              fontWeight: FontWeight.w500))),
              ta.isTopTrader!
                  ? IrisGoldGradientRapper(
                      child: cell(
                          width: optionTableWidth[9],
                          contents: Text(ta.order!.orderSideDisplayAction,
                              style: TextStyle(
                                  color: context.theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w500))))
                  : cell(
                      width: optionTableWidth[9],
                      contents: Text(ta.order!.orderSideDisplayAction,
                          style: TextStyle(
                              color: context.theme.colorScheme.secondary,
                              fontWeight: FontWeight.w500))),
              ta.isTopTrader!
                  ? IrisGoldGradientRapper(
                      child: cell(
                          width: optionTableWidth[10],
                          contents: Text(ta.order!.positionEffectDisplay,
                              style: TextStyle(
                                  color: context.theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w500))))
                  : cell(
                      width: optionTableWidth[10],
                      contents: Text(ta.order!.positionEffectDisplay,
                          style: TextStyle(
                              color: context.theme.colorScheme.secondary,
                              fontWeight: FontWeight.w500))),
              cell(
                  width: optionTableWidth[11],
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
            ],
          ));
    });
  }

  Widget orderFlowsOptionsStaticItem(OrderFlow ta, int index) {
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
}

class TableBodyController extends GetxController {
  late LinkedScrollControllerGroup _controllers;
  ScrollController? _headController;
  ScrollController? _bodyController;
  TableBodyController();

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

  @override
  void onInit() {
    _controllers = LinkedScrollControllerGroup();
    _headController = _controllers.addAndGet();
    _bodyController = _controllers.addAndGet();
    super.onInit();
  }
}
