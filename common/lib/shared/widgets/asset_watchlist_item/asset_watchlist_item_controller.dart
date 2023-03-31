// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:iris_mobile/widgets_v2/charts/historical_chart/app_chart.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// import '../../../data/models/index.dart';
// import '../../../shared/themes/colors.dart';
// import '../../../shared/types/index.dart';
// import '../../extensions/double.dart';

// class AssetWatchlistItemController extends GetxController {
//   Rx<LOADING_STATUS> loadingStatus$ = Rx(LOADING_STATUS.NOT_LOADING);
//   HISTORICAL_SPAN selectedSpan = HISTORICAL_SPAN.DAY;
//   ChartData chartData;
//   Historical? selectedHistorical;
//   Y_AXIS_TYPE yAxisType;
//   double? minY;
//   double? maxY;
//   DateTimeIntervalType? xAxisIntervalType = DateTimeIntervalType.hours;
//   double? yInterval;

//   double? xInterval;
//   double minVolumeY = 0;

//   double maxVolumeY = 100;
//   String spanSubText = 'Day';
//   double? maxPointVolume;
//   bool showChart = true;

//   Rx<SelectedPointData> selectedPointData$ = SelectedPointData().obs;
//   Rx<SelectedPointData> secondSelectedPointData$ = SelectedPointData().obs;
//   Rx<double> percentageDifference = 0.0.obs;
//   Rx<String> dateRange = ''.obs;
//   RxBool showPercent = true.obs;
//   Rx<SelectedPointData> laterPointData$ = SelectedPointData().obs;
//   AssetWatchlistItemController({
//     required this.chartData,
//     this.yAxisType = Y_AXIS_TYPE.AMOUNT,
//   }) {
//     init();
//   }

//   NumberFormat get yAxisNumberFormat {
//     if (yAxisType == Y_AXIS_TYPE.PERCENT) {
//       return NumberFormat.percentPattern();
//     } else if (yAxisType == Y_AXIS_TYPE.AMOUNT) {
//       return NumberFormat.compactSimpleCurrency();
//     }
//     return NumberFormat.compactSimpleCurrency();
//   }

//   addHistoricalData({HISTORICAL_SPAN? span, Historical? historical}) {
//     if (selectedSpan == HISTORICAL_SPAN.DAY) {
//       chartData.dayHistorical = historical;
//     } else if (selectedSpan == HISTORICAL_SPAN.WEEK) {
//       chartData.weekHistorical = historical;
//     } else if (selectedSpan == HISTORICAL_SPAN.MONTH) {
//       chartData.monthHistorical = historical;
//     } else if (selectedSpan == HISTORICAL_SPAN.THREE_MONTH) {
//       chartData.threeMonthHistorical = historical;
//     } else if (selectedSpan == HISTORICAL_SPAN.YEAR) {
//       chartData.yearHistorical = historical;
//     } else if (selectedSpan == HISTORICAL_SPAN.ALL) {
//       chartData.allHistorical = historical;
//     }
//   }

//   getChartData() {
//     final List<Point>? points = selectedHistorical?.points;
//     if (points == null) {
//       return;
//     }
//     final List<Point> newPoints = [];
//     resetValues();
//     for (int i = 0; i < points.length; i++) {
//       Point point = points[i];
//       double? checkY;
//       final double? checkVolume = getVolumeFromPoint(point);
//       if (yAxisType == Y_AXIS_TYPE.PERCENT) {
//         checkY = point.spanReturnPercentage;
//       } else if (yAxisType == Y_AXIS_TYPE.AMOUNT) {
//         checkY = point.closeAmount;
//       }
//       if (checkY != null) {
//         if (maxY == null) {
//           maxY = checkY;
//           minY = checkY;
//         }
//         if (checkY > maxY!) {
//           maxY = checkY;
//         } else if (checkY < minY!) {
//           minY = checkY;
//         }
//       } else {
//         int index = i - 1;
//         if (index < 0) {
//           index = 0;
//         }
//         for (int o = index; o < points.length; o++) {
//           final Point tempP = points[o];
//           point = tempP.copyWith(beginsAt: point.beginsAt);
//         }
//       }
//       if (checkVolume != null) {
//         maxPointVolume ??= checkVolume;
//         if (checkVolume > maxPointVolume!) {
//           maxPointVolume = checkVolume;
//         }
//       }
//       newPoints.add(point);
//     }
//     selectedHistorical = selectedHistorical!.copyWith(points: newPoints);
//     maxY ??= 0.0;
//     minY ??= 0.0;
//     final double difference = maxY! - minY!;
//     minY = minY! - (difference * .1);
//     maxY = maxY! + (difference * .1);
//     if (difference == 0) {
//       yInterval = maxY!.abs() / 2;
//       minY = minY! - (minY!.abs() * .5);
//       maxY = maxY! + (maxY!.abs() * .5);
//       // yInterval = 1;
//     } else {
//       yInterval = difference / 3;
//     }
//   }

//   DateFormat getFormartXAxis() {
//     if (selectedSpan == HISTORICAL_SPAN.DAY) {
//       return DateFormat.jm();
//     } else if (selectedSpan == HISTORICAL_SPAN.ALL) {
//       return DateFormat('M/d/yy');
//     } else {
//       return DateFormat('M/d');
//     }
//   }

//   Color getLineColor(BuildContext context) {
//     Color color;
//     if (selectedHistorical!.returnPercentage != null) {
//       if (selectedHistorical!.returnPercentage! >= 0) {
//         color = IrisColor.positiveChange;
//       } else {
//         color = IrisColor.negativeChange;
//       }
//       return color;
//     }
//     return IrisColor.negativeChange;
//   }

//   getPointVolumeY(Point point) {
//     if (maxPointVolume == null || maxPointVolume == 0) {
//       return 0;
//     }
//     final double volume = getVolumeFromPoint(point);
//     const double maxHeight = 7;
//     final double f = (maxHeight * volume) / maxPointVolume!;
//     return f;
//   }

//   getVolumeFromPoint(Point point) {
//     if (point.buyVolume != null && point.sellVolume != null) {
//       return point.buyVolume! + point.sellVolume!;
//     } else {
//       return point.volume;
//     }
//   }

//   init() {
//     setHistorical();
//     getChartData();
//     setSelectedPointData();
//     if (selectedHistorical?.points == null) {
//       showChart = false;
//     }
//   }

//   resetValues() {
//     minY = null;
//     maxY = null;
//     yInterval = null;
//     xInterval = null;
//     maxPointVolume = null;
//     xAxisIntervalType = null;
//   }

//   setHistorical() {
//     if (selectedSpan == HISTORICAL_SPAN.DAY) {
//       selectedHistorical = chartData.dayHistorical;
//       xAxisIntervalType = DateTimeIntervalType.hours;
//       spanSubText = 'Day';
//     } else if (selectedSpan == HISTORICAL_SPAN.WEEK) {
//       selectedHistorical = chartData.weekHistorical;
//       spanSubText = 'Week';
//       xAxisIntervalType = DateTimeIntervalType.hours;
//     } else if (selectedSpan == HISTORICAL_SPAN.MONTH) {
//       selectedHistorical = chartData.monthHistorical;
//       xAxisIntervalType = DateTimeIntervalType.days;
//       spanSubText = 'Month';
//     } else if (selectedSpan == HISTORICAL_SPAN.THREE_MONTH) {
//       selectedHistorical = chartData.threeMonthHistorical;
//       xAxisIntervalType = DateTimeIntervalType.days;
//       spanSubText = '3 Months';
//     } else if (selectedSpan == HISTORICAL_SPAN.YEAR) {
//       selectedHistorical = chartData.yearHistorical;
//       xAxisIntervalType = DateTimeIntervalType.days;
//       spanSubText = 'Year';
//     } else if (selectedSpan == HISTORICAL_SPAN.ALL) {
//       selectedHistorical = chartData.allHistorical;
//       xAxisIntervalType = DateTimeIntervalType.days;
//       spanSubText = 'All';
//     } else {
//       selectedHistorical = chartData.dayHistorical;
//       xAxisIntervalType = DateTimeIntervalType.hours;
//       spanSubText = 'Day';
//     }
//     return selectedHistorical;
//   }

//   setSelectedPointData() {
//     if (selectedHistorical == null) {
//       return;
//     }
//     final SelectedPointData s = SelectedPointData();
//     double? colorValueTest;
//     if (yAxisType == Y_AXIS_TYPE.AMOUNT) {
//       s.primaryText = selectedHistorical!.closeAmount?.formatCurrency();
//       s.secondaryText =
//           selectedHistorical!.returnPercentage?.formatAssetPrice();
//       colorValueTest = selectedHistorical!.returnPercentage;
//     } else if (yAxisType == Y_AXIS_TYPE.PERCENT) {
//       s.primaryText = selectedHistorical!.returnPercentage?.formatPercentage();
//       s.primaryVal = selectedHistorical!.returnPercentage;
//       colorValueTest = selectedHistorical!.returnPercentage;
//     }
//     if (colorValueTest == null) {
//     } else if (colorValueTest >= 0) {
//       s.primaryColor = IrisColor.positiveChange;
//       s.secondaryColor = IrisColor.positiveChange;
//     } else {
//       s.primaryColor = IrisColor.negativeChange;
//       s.secondaryColor = IrisColor.negativeChange;
//     }
//     s.subText = spanSubText;
//     s.date = DateTime.now();
//     selectedPointData$.value = s;
//     secondSelectedPointData$.value =
//         SelectedPointData(); // initialize second selected point
//     laterPointData$.value = SelectedPointData();
//   }
// }

// class SelectedPointData {
//   String? primaryText;
//   double? primaryVal;
//   Color? primaryColor;
//   String? secondaryText;
//   Color? secondaryColor;
//   String? subText;
//   DateTime? date;
//   SelectedPointData(
//       {this.primaryText,
//       this.primaryVal,
//       this.primaryColor,
//       this.secondaryColor,
//       this.secondaryText,
//       this.subText,
//       this.date});
// }

// enum Y_AXIS_TYPE { PERCENT, AMOUNT }
