import 'package:flutter/material.dart' hide MenuItem;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

Map<HISTORICAL_SPAN, String> displayHistoricalButton = {
  HISTORICAL_SPAN.DAY: '1D',
  HISTORICAL_SPAN.WEEK: '1W',
  HISTORICAL_SPAN.MONTH: '1M',
  HISTORICAL_SPAN.THREE_MONTH: '3M',
  HISTORICAL_SPAN.YEAR: '1Y',
  HISTORICAL_SPAN.ALL: 'ALL',
};

//TODO: Refactor:
// Change all propertys to final, e chance "c" to controller
class AppChart extends StatelessWidget {
  late ChartController c;
  ChartData chartData;
  Y_AXIS_TYPE yAxisType;
  List<HISTORICAL_SPAN>? spanButtons;
  Widget? leading;
  Widget? title;
  Widget? subtitle;
  bool? showTile;
  int? assetKey;
  final IrisEvent irisEvent = Get.find();
  Function({required HISTORICAL_SPAN span})? historicalFunction;

  String tag;

  AppChart(
      {Key? key,
      required this.chartData,
      this.yAxisType = Y_AXIS_TYPE.AMOUNT,
      this.leading,
      this.title,
      this.subtitle,
      this.spanButtons,
      this.historicalFunction,
      this.showTile = true,
      this.assetKey,
      this.tag = '1'})
      : super(key: key) {
    //figure out why tag is at 1?? should we delete remove
    if (spanButtons == null || spanButtons!.isEmpty) {
      spanButtons = [
        HISTORICAL_SPAN.DAY,
        HISTORICAL_SPAN.WEEK,
        HISTORICAL_SPAN.MONTH,
        HISTORICAL_SPAN.THREE_MONTH,
        HISTORICAL_SPAN.YEAR,
        HISTORICAL_SPAN.ALL
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    c = Get.put(
        ChartController(
            chartData: chartData,
            yAxisType: yAxisType,
            historicalFunction: historicalFunction),
        tag: tag);
    return main(context);
  }

  chart(BuildContext context) {
    return Obx(() {
      final LOADING_STATUS loadingStatus = c.loadingStatus$.value;
      if (loadingStatus == LOADING_STATUS.LOADING) {
        return shimmerChart();
      }
      if (c.selectedHistorical == null || c.yInterval! <= 0) {
        return Container(
          color: context.theme.scaffoldBackgroundColor,
          child: const Text('No data'),
          height: 100,
        );
      }
      return SfCartesianChart(
          enableMultiSelection: true,
          plotAreaBorderColor: Colors.red,
          //unknown
          margin: const EdgeInsets.all(0),
          borderColor: Colors.transparent,
          borderWidth: 0,
          plotAreaBorderWidth: 0,
          selectionGesture: ActivationMode.singleTap,
          onChartTouchInteractionDown: (args) {
            HapticFeedback.lightImpact();
          },
          onChartTouchInteractionUp: (args) {
            HapticFeedback.lightImpact();
            c.setSelectedPointData();
          },
          onAxisLabelRender: (args) {
            if (args.axisName == 'primaryXAxis') {
              final int index = (args.value! + .5).round();
              if (index == 0) {
                args.text = '';
                return;
              }
              if (index > c.selectedHistorical!.points!.length - 1) {
                return;
              }
              final point = c.selectedHistorical!.points![index];
              final DateTime d =
                  point.beginsAt!.subtract(const Duration(hours: 3));
              args.text = c.getFormartXAxis().format(d);
            }
          },
          onTrackballPositionChanging: (args) {
            final dataPoint = args.chartPointInfo;
            final dataPointIndex = dataPoint.dataPointIndex;
            if (dataPointIndex == null) {
              c.onPointChange(null);
            } else {
              final point = c.selectedHistorical!.points![dataPointIndex];
              c.onPointChange(point);
            }
          },
          onSecondTrackballPositionChanging: (args) {
            final dataPoint = args.chartPointInfo;
            final dataPointIndex = dataPoint.dataPointIndex;
            if (dataPointIndex == null) {
              c.onSecondPointChange(null);
            } else {
              final point = c.selectedHistorical!.points![dataPointIndex];
              c.onSecondPointChange(point);
            }
          },
          trackballBehavior: TrackballBehavior(
            // hideDelay: 1000,
            enable: true,
            activationMode: ActivationMode.singleTap,
            tooltipSettings: const InteractiveTooltip(enable: false),
            // tooltipSettings: InteractiveTooltip(),
            // tooltipDisplayMode: TrackballDisplayMode.none,
          ),
          primaryXAxis: NumericAxis(
              // dateFormat: DateFormat.jm(),
              labelFormat: '{value}',
              // interval: 1,
              isVisible: false,
              // intervalType: DateTimeIntervalType.auto,
              // minimum: DateTime.now(),
              // minimum: DateTime(2016, 01, 01),
              // maximum: DateTime(2020, 10, 01),
              // plotBands: [PlotBand()],//maybe this will solve the weekly graph etc.//update this actualy does not
              majorGridLines: const MajorGridLines(width: 0)),
          primaryYAxis: NumericAxis(
              anchorRangeToVisiblePoints: false,
              opposedPosition: true,
              majorTickLines: const MajorTickLines(width: 0),
              // minorTickLines: MinorTickLines(width: 0),
              // isVisible: false,
              visibleStarting: c.previousCloseAmount!,
              visibleStartingText: yAxisType == Y_AXIS_TYPE.AMOUNT
                  ? c.previousCloseAmount!.formatCurrency()
                  : c.previousCloseAmount!.formatPercentage(roundedNumber: 0),
              minimum: c.minY,
              maximum: c.maxY,
              interval: c.yInterval,
              plotOffset: 15,
              // placeLabelsNearAxisLine: true,
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              numberFormat: c.yAxisNumberFormat,
              // labelFormat: NumberFormat.currencyCompact(),
              // label
              // majorTickLines: ,
              interactiveTooltip: const InteractiveTooltip(enable: true),
              axisLine: const AxisLine(width: 0)),
          axes: <ChartAxis>[
            NumericAxis(
              // opposedPosition: true,
              isVisible: false,
              name: 'yAxis1',
              // majorGridLines: MajorGridLines(width: 0),
              labelFormat: '{value}',
              minimum: c.minVolumeY,
              maximum: c.maxVolumeY,
            )
          ],
          series: <ChartSeries<HistoricalPoint, num>>[
            ColumnSeries<HistoricalPoint, num>(
              pointColorMapper: (HistoricalPoint point, _) {
                return Colors.grey.shade400;
              },
              dataSource: c.selectedHistorical!.points!,
              xValueMapper: (HistoricalPoint point, _) {
                return _;
              },
              yValueMapper: (HistoricalPoint point, _) {
                final v = c.getPointVolumeY(point);
                return v;
              },
              yAxisName: 'yAxis1',
            ),
            LineSeries<HistoricalPoint, num>(
                pointColorMapper: (HistoricalPoint point, _) {
                  return c.getLineColor();
                },
                emptyPointSettings:
                    EmptyPointSettings(mode: EmptyPointMode.drop),
                dataSource: c.selectedHistorical!.points!,
                xValueMapper: (HistoricalPoint point, _) {
                  return _;
                },
                yValueMapper: (HistoricalPoint point, _) {
                  if (yAxisType == Y_AXIS_TYPE.PERCENT) {
                    return point.spanReturnPercentage;
                  } else if (yAxisType == Y_AXIS_TYPE.AMOUNT) {
                    return point.closeAmount;
                  } else {
                    return point.spanReturnPercentage;
                  }
                }),
          ]);
    });
  }

  main(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            top(),
            if (yAxisType == Y_AXIS_TYPE.AMOUNT) trailing(),
            // menu(),
            totalChart(context)
          ],
        ));
  }

  Widget menu() {
    final List<MenuItem<HISTORICAL_SPAN>> items = [];
    for (var span in spanButtons!) {
      final String? buttonText = displayHistoricalButton[span];
      items.add(MenuItem<HISTORICAL_SPAN>(name: buttonText, id: span));
    }
    Color indicatorColor = c.getLineColor();
    if (c.selectedHistorical == null || c.yInterval! <= 0) {
      indicatorColor = IrisColor.positiveChange;
    }
    return AppMenu<HISTORICAL_SPAN>(
      activeTabId: HISTORICAL_SPAN.DAY,
      indicatorColor: indicatorColor,
      haptic: true,
      onChange: (MenuItem item) {
        if (assetKey != null) {
          ASSET_EVENT_TYPE type = ASSET_EVENT_TYPE.HISTORICAL_1D;
          switch (item.id) {
            case HISTORICAL_SPAN.DAY:
              type = ASSET_EVENT_TYPE.HISTORICAL_1D;
              break;
            case HISTORICAL_SPAN.WEEK:
              type = ASSET_EVENT_TYPE.HISTORICAL_1W;
              break;
            case HISTORICAL_SPAN.MONTH:
              type = ASSET_EVENT_TYPE.HISTORICAL_1M;
              break;
            case HISTORICAL_SPAN.THREE_MONTH:
              type = ASSET_EVENT_TYPE.HISTORICAL_3M;
              break;
            case HISTORICAL_SPAN.YEAR:
              type = ASSET_EVENT_TYPE.HISTORICAL_1Y;
              break;
            case HISTORICAL_SPAN.ALL:
              type = ASSET_EVENT_TYPE.HISTORICAL_ALL;
              break;
            default:
              break;
          }
          irisEvent.registerAssetEvent(
              assetKey: assetKey!, assetEventType: type);
        }
        c.timeSpanButtonClick(item.id);
      },
      style: APP_MENU_STYLE.BUTTON,
      items: items,
    );
  }

  portfolioTrailing() {
    return Obx(() {
      final s = c.secondSelectedPointData$.value.primaryVal != null
          ? c.secondSelectedPointData$.value
          : c.selectedPointData$.value;
      if (s.primaryText == null) {
        return Container(
          width: 10,
        );
      }
      final difference = c.percentageDifference.value;
      final showDifference = c.selectedPointData$.value.primaryVal != null &&
          c.secondSelectedPointData$.value.primaryVal != null;
      final portfolioPrimaryText =
          showDifference ? difference.formatPercentage() : s.primaryText!;

      final assetPrimary = c.laterPointData$.value.primaryVal != null
          ? c.laterPointData$.value
          : s;
      final primaryColor = showDifference
          ? difference >= 0.0
              ? IrisColor.positiveChange
              : IrisColor.negativeChange
          : yAxisType == Y_AXIS_TYPE.AMOUNT
              ? c.laterPointData$.value.primaryColor
              : s.primaryColor;
      final subText = showDifference ? c.dateRange.value : s.subText!;
      final assetSecondaryText = yAxisType == Y_AXIS_TYPE.AMOUNT
          ? showDifference
              ? difference.formatPercentage()
              : s.secondaryText!
          : '';
      return SizedBox(
        width: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  yAxisType == Y_AXIS_TYPE.AMOUNT
                      ? assetPrimary.primaryText!
                      : portfolioPrimaryText,
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (s.secondaryText != null)
                  Text(
                    assetSecondaryText,
                    style: TextStyle(
                      color: showDifference
                          ? difference >= 0.0
                              ? IrisColor.positiveChange
                              : IrisColor.negativeChange
                          : assetPrimary.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  subText,
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                )
              ],
            )
          ],
        ),
      );
    });
  }

  Widget shimmerChart() {
    return const SizedBox(
        height: 250,
        child: Center(
          child: ShimmerCircleLoader(),
        ));
  }

  top() {
    if (yAxisType == Y_AXIS_TYPE.AMOUNT) {
      return showTile!
          ? Container(
              margin: const EdgeInsets.only(left: 10, top: 5),
              child: Row(
                children: [leading!, const SizedBox(width: 8), title!],
              ))
          : Container();
    } else if (yAxisType == Y_AXIS_TYPE.PERCENT) {
      return ListTile(
          leading: leading,
          title: title,
          subtitle: subtitle,
          trailing: portfolioTrailing());
    }
  }

  totalChart(BuildContext context) {
    if (!c.showChart) {
      return Container();
    }

    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(maxHeight: 250),
          child: chart(context),
        ),
        menu(),
      ],
    );
  }

  trailing() {
    return Obx(() {
      final s = c.secondSelectedPointData$.value.primaryVal != null
          ? c.secondSelectedPointData$.value
          : c.selectedPointData$.value;
      if (s.primaryText == null) {
        return Container(
          width: 10,
        );
      }
      final difference = c.percentageDifference.value;
      final showDifference = c.selectedPointData$.value.primaryVal != null &&
          c.secondSelectedPointData$.value.primaryVal != null;
      final portfolioPrimaryText =
          showDifference ? difference.formatPercentage() : s.primaryText!;

      final assetPrimary = c.laterPointData$.value.primaryVal != null
          ? c.laterPointData$.value
          : s;
      final primaryColor = showDifference
          ? difference >= 0.0
              ? IrisColor.positiveChange
              : IrisColor.negativeChange
          : yAxisType == Y_AXIS_TYPE.AMOUNT
              ? c.laterPointData$.value.primaryColor
              : s.primaryColor;
      final subText = showDifference ? c.dateRange.value : s.subText!;
      final assetSecondaryText = yAxisType == Y_AXIS_TYPE.AMOUNT
          ? showDifference
              ? difference.formatPercentage()
              : s.secondaryText!
          : '';
      final priceChange =
          showDifference ? c.priceDifference.value : s.priceChange;
      return Container(
        margin: const EdgeInsets.only(left: 10, bottom: 20, top: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  yAxisType == Y_AXIS_TYPE.AMOUNT
                      ? assetPrimary.primaryText!
                      : portfolioPrimaryText,
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    (priceChange! >= 0.0 ? '+' : '') +
                        priceChange.formatCurrency(),
                    style: TextStyle(
                      color: showDifference
                          ? difference >= 0.0
                              ? IrisColor.positiveChange
                              : IrisColor.negativeChange
                          : assetPrimary.primaryColor,
                      fontSize: 16,
                    )),
                const SizedBox(width: 4),
                if (s.secondaryText != null)
                  Text(
                    '(' + assetSecondaryText + ')',
                    style: TextStyle(
                      color: showDifference
                          ? difference >= 0.0
                              ? IrisColor.positiveChange
                              : IrisColor.negativeChange
                          : assetPrimary.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  subText,
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                )
              ],
            )
          ],
        ),
      );
    });
  }
}

class ChartData {
  Historical? dayHistorical;
  Historical? weekHistorical;
  Historical? monthHistorical;
  Historical? threeMonthHistorical;
  Historical? yearHistorical;
  Historical? allHistorical;

  ChartData({
    required this.dayHistorical,
    this.weekHistorical,
    this.monthHistorical,
    this.threeMonthHistorical,
    this.yearHistorical,
    this.allHistorical,
  });
}
