import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:iris_common/iris_common.dart';

import '../asset_analysis_shimmer.dart';

const double columnWidth = 120;
const double staticWidth = 58;

class AnalyticsPopularTable extends StatelessWidget {
  final List<AssetOverviewItem> dataSource;
  final String? selectedSpan;
  final OVERVIEW_ORDER_BY? selectedOrder;
  final Function({SORT_BY? sortBy, SENTIMENT_TYPE? sentimentType})?
      handleSortData;
  final SortColumns? sortedColumn;
  final API_STATUS? apiStatus;
  final SENTIMENT_TYPE? sentimentType;
  final bool? loadFinished;
  final bool? isTop;
  final bool? isBottom;
  final bool? reset;
  final Function? loadMore;

  const AnalyticsPopularTable({
    Key? key,
    required this.dataSource,
    this.handleSortData,
    this.sortedColumn,
    this.selectedSpan,
    this.sentimentType = SENTIMENT_TYPE.BULLISH,
    this.selectedOrder = OVERVIEW_ORDER_BY.ALL,
    this.apiStatus,
    this.loadMore,
    this.loadFinished = false,
    this.isTop,
    this.isBottom,
    this.reset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularTableController>(
        init: PopularTableController(),
        global: false,
        builder: (controller) {
          return Column(children: [
            Divider(
              color: context.theme.colorScheme.secondary.withOpacity(0.4),
              height: 0.5,
            ),
            Divider(
              color: context.theme.colorScheme.secondary.withOpacity(0.4),
              height: 0.5,
            ),
            if (apiStatus == null || apiStatus == API_STATUS.PENDING)
              const AnalyticsShimmer(tableDataLoading: true),
            if (dataSource.isEmpty && apiStatus == API_STATUS.FINISHED)
              Container(
                height: context.height / 3,
                alignment: Alignment.center,
                child: const Text('No Data :('),
              ),
            Obx(() {
              return SizedBox(
                  height: dataSource.isEmpty ? 0 : Get.height - 100,
                  child: HorizontalDataTable(
                    leftHandSideColumnWidth: columnWidth,
                    rightHandSideColumnWidth: columnWidth * 4,
                    verticalScrollController: controller.controller,
                    scrollPhysics:
                        controller.getScrollPhysics(isTop!, isBottom!, reset!),
                    isFixedHeader: true,
                    headerWidgets: dataSource.isEmpty
                        ? [const Text('')]
                        : headerWidgets(context),
                    itemCount: dataSource.length + 1,
                    leftSideItemBuilder: (BuildContext context, int index) {
                      if (index < dataSource.length) {
                        return tradeAnalysisFixedItem(dataSource[index], index);
                      } else {
                        if (loadFinished!) return Container();
                        if (loadMore != null) {
                          loadMore!();
                        }
                        return Container(
                            height: 40,
                            color: context.theme.backgroundColor,
                            child: Row(children: const [
                              ShimmerRow(
                                height: 20,
                                width: columnWidth,
                                borderRadius: 10,
                              )
                            ]));
                      }
                    },
                    rightSideItemBuilder: (BuildContext context, int index) {
                      if (index < dataSource.length) {
                        return tradeAnalysisItem(dataSource[index], index);
                      } else {
                        if (loadFinished!) return Container();
                        return Container(
                            height: 40,
                            color: context.theme.backgroundColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                ShimmerRow(
                                  borderRadius: 10,
                                  width: columnWidth,
                                  height: 20,
                                ),
                                ShimmerRow(
                                  borderRadius: 10,
                                  width: columnWidth,
                                  height: 20,
                                ),
                                ShimmerRow(
                                  borderRadius: 10,
                                  width: columnWidth,
                                  height: 20,
                                ),
                                ShimmerRow(
                                  borderRadius: 10,
                                  width: columnWidth,
                                  height: 20,
                                ),
                              ],
                            ));
                      }
                    },
                    rowSeparatorWidget: const Divider(
                      color: Colors.black54,
                      height: 0.0,
                      thickness: 0.0,
                    ),
                    leftHandSideColBackgroundColor:
                        context.theme.backgroundColor,
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
          ]);
        });
  }

  Widget cell(
      {Widget? contents,
      double? width,
      Alignment alignment = Alignment.center}) {
    return Container(
      width: width ?? columnWidth,
      alignment: alignment,
      child: contents,
    );
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
      double? width = 120,
      SORT_BY? sortBy,
      Alignment alignment = Alignment.center}) {
    return Builder(builder: (context) {
      return InkWell(
          onTap: () {
            handleSortData!(sortBy: sortBy, sentimentType: sentimentType);
          },
          child: Container(
              width: width,
              alignment: alignment,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(text!,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: sortedColumn!.sortBy == sortBy
                            ? context.theme.colorScheme.secondary
                                .withOpacity(0.75)
                            : context.theme.colorScheme.secondary
                                .withOpacity(0.4),
                      )),
                  if (sortedColumn!.sortBy == sortBy)
                    Icon(
                      sortedColumn!.orderByAsc!
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 10,
                    )
                ],
              )));
    });
  }

  headerWidgets(BuildContext context) {
    return [
      Container(
          color: context.theme.backgroundColor,
          height: 44,
          child: headerItem(
              text: 'Ticker',
              sortBy: SORT_BY.TICKER,
              width: columnWidth,
              alignment: Alignment.centerRight)),
      Container(
          color: context.theme.backgroundColor,
          height: 44,
          child: headerItem(
              text: '% of investors',
              width: columnWidth,
              sortBy: SORT_BY.PINVESTORS,
              alignment: Alignment.center)),
      Container(
        color: context.theme.backgroundColor,
        height: 44,
        child: headerItem(
            text: '\$ invested', width: columnWidth, sortBy: SORT_BY.DINVESTED),
      ),
      Container(
        color: context.theme.backgroundColor,
        height: 44,
        child: headerItem(
            text: 'Bulllish / Bearish',
            width: columnWidth,
            sortBy: SORT_BY.BULLISHORBEARISH),
      ),
      Container(
        color: context.theme.backgroundColor,
        height: 44,
        child: headerItem(
            text: 'Streaks', width: columnWidth, sortBy: SORT_BY.STREAK),
      ),
    ];
  }

  Widget tradeAnalysisFixedItem(AssetOverviewItem ta, int index) {
    return Builder(builder: (context) {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          color: index % 2 == 0
              ? context.theme.backgroundColor
              : context.theme.dialogBackgroundColor,
          height: 44,
          width: columnWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppAssetImage(
                asset: ta.asset,
                height: 35,
              ),
              cell(
                  contents: Text(ta.asset?.symbol ?? '',
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold)),
                  width: 40,
                  alignment: Alignment.centerLeft),
            ],
          ));
    });
  }

  Widget tradeAnalysisItem(AssetOverviewItem ta, int index) {
    return Builder(builder: (context) {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          color: index % 2 == 0
              ? context.theme.backgroundColor
              : context.theme.dialogBackgroundColor,
          height: 44,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cell(
                contents: Text(sentimentType == SENTIMENT_TYPE.BULLISH
                    ? selectedOrder == OVERVIEW_ORDER_BY.ALL
                        ? ta.pctInvestorsTotalBull.formatPercentage()
                        : ta.pctInvestorsTotalBullTop.formatPercentage()
                    : selectedOrder == OVERVIEW_ORDER_BY.ALL
                        ? ta.pctInvestorsTotalBear.formatPercentage()
                        : ta.pctInvestorsTotalBearTop.formatPercentage()),
              ),
              cell(
                  contents: Text(
                      '\$${sentimentType == SENTIMENT_TYPE.BULLISH ? selectedOrder == OVERVIEW_ORDER_BY.ALL ? ta.amtInvestedBull.formatCompact() : ta.amtInvestedBullTop.formatCompact() : selectedOrder == OVERVIEW_ORDER_BY.ALL ? ta.amtInvestedBear.formatCompact() : ta.amtInvestedBearTop.formatCompact()}')),
              cell(
                contents: Text(
                  sentimentType == SENTIMENT_TYPE.BULLISH
                      ? selectedOrder == OVERVIEW_ORDER_BY.ALL
                          ? ta.pctInvestorsBull.formatPercentage()
                          : ta.pctInvestorsBullTop.formatPercentage() +
                              ' Bullish'
                      : selectedOrder == OVERVIEW_ORDER_BY.ALL
                          ? ta.pctInvestorsBear.formatPercentage()
                          : ta.pctInvestorsBearTop.formatPercentage() +
                              ' Bearish',
                ),
              ),
              cell(contents: const Text('Streaks')
                  // Text('${ta.bearishPositionsOpenedCount!.toInt()}')
                  ),
            ],
          ));
    });
  }

  Widget tradeAnalysisRow(AssetOverviewItem tradeAnalysis, int index) {
    return InkWell(
        onTap: () {},
        child: Column(
          children: [
            tradeAnalysisItem(tradeAnalysis, index),
            Divider(
              color: Colors.black.withOpacity(0.4),
              height: 0.5,
            ),
          ],
        ));
  }

  Widget tradeAnalysisRowFixed(AssetOverviewItem tradeAnalysis, int index) {
    return InkWell(
        onTap: () {},
        child: Column(
          children: [
            tradeAnalysisFixedItem(tradeAnalysis, index),
            Divider(
              color: Colors.black.withOpacity(0.4),
              height: 0.5,
            ),
          ],
        ));
  }
}

class PopularTableController extends BouncingNestedScrollController {}

enum SORT_BY { TICKER, PINVESTORS, DINVESTED, BULLISHORBEARISH, STREAK }

class SortColumns {
  SORT_BY? sortBy;
  bool? orderByAsc;
  SortColumns({this.sortBy, this.orderByAsc});
}
