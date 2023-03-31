import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iris_common/iris_common.dart';

class ChartController extends GetxController {
  Rx<LOADING_STATUS> loadingStatus$ = Rx(LOADING_STATUS.NOT_LOADING);
  HISTORICAL_SPAN selectedSpan = HISTORICAL_SPAN.DAY;
  ChartData chartData;
  Historical? selectedHistorical;
  Y_AXIS_TYPE yAxisType;
  Function? historicalFunction;
  double? minY;
  double? maxY;
  double? previousCloseAmount;
  DateTimeIntervalType? xAxisIntervalType = DateTimeIntervalType.hours;
  double? yInterval;

  double? xInterval;
  double minVolumeY = 0;

  double maxVolumeY = 100;
  String spanSubText = 'day';
  double? maxPointVolume;
  bool showChart = true;

  Rx<SelectedPointData> selectedPointData$ = SelectedPointData().obs;
  Rx<SelectedPointData> secondSelectedPointData$ = SelectedPointData().obs;
  Rx<double> percentageDifference = 0.0.obs;
  Rx<double> priceDifference = 0.0.obs;
  Rx<String> dateRange = ''.obs;
  Rx<SelectedPointData> laterPointData$ = SelectedPointData().obs;
  ChartController(
      {required this.chartData,
      this.yAxisType = Y_AXIS_TYPE.AMOUNT,
      this.historicalFunction}) {
    init();
  }

  NumberFormat get yAxisNumberFormat {
    if (yAxisType == Y_AXIS_TYPE.PERCENT) {
      return NumberFormat.percentPattern();
    } else if (yAxisType == Y_AXIS_TYPE.AMOUNT) {
      return NumberFormat.compactSimpleCurrency();
    }
    return NumberFormat.compactSimpleCurrency();
  }

  void addHistoricalData({HISTORICAL_SPAN? span, Historical? historical}) {
    if (selectedSpan == HISTORICAL_SPAN.DAY) {
      chartData.dayHistorical = historical;
    } else if (selectedSpan == HISTORICAL_SPAN.WEEK) {
      chartData.weekHistorical = historical;
    } else if (selectedSpan == HISTORICAL_SPAN.MONTH) {
      chartData.monthHistorical = historical;
    } else if (selectedSpan == HISTORICAL_SPAN.THREE_MONTH) {
      chartData.threeMonthHistorical = historical;
    } else if (selectedSpan == HISTORICAL_SPAN.YEAR) {
      chartData.yearHistorical = historical;
    } else if (selectedSpan == HISTORICAL_SPAN.ALL) {
      chartData.allHistorical = historical;
    }
  }

  void comparePercentChange() {
    if (selectedPointData$.value.date != null &&
        secondSelectedPointData$.value.date != null) {
      final fDate = selectedPointData$.value.date;
      final sDate = secondSelectedPointData$.value.date;
      final fPrimary = sDate!.compareTo(fDate!) >= 0
          ? secondSelectedPointData$.value
          : selectedPointData$.value;
      final sPrimary = sDate.compareTo(fDate) >= 0
          ? selectedPointData$.value
          : secondSelectedPointData$.value;
      final firstDate = sDate.compareTo(fDate) >= 0 ? sDate : fDate;
      final secondDate = sDate.compareTo(fDate) >= 0 ? fDate : sDate;
      laterPointData$.value = fPrimary;
      if (fPrimary.primaryVal != null && sPrimary.primaryVal != null) {
        if (yAxisType == Y_AXIS_TYPE.AMOUNT) {
          final priceDifferences =
              fPrimary.priceChange! - sPrimary.priceChange!;
          priceDifference.value = priceDifferences;
          percentageDifference.value = sPrimary.closeAmount != null
              ? priceDifferences / sPrimary.closeAmount!
              : 0;
          dateRange.value = getFormartXAxis().format(secondDate) +
              ' - ' +
              getFormartXAxis().format(firstDate);
        } else if (yAxisType == Y_AXIS_TYPE.PERCENT) {
          final differences = fPrimary.primaryVal! - sPrimary.primaryVal!;
          percentageDifference.value = differences;
          dateRange.value = getFormartXAxis().format(secondDate) +
              ' - ' +
              getFormartXAxis().format(firstDate);
        }
      }
    }
  }

  void getChartData() {
    final List<HistoricalPoint>? points = selectedHistorical?.points;
    if (points == null) {
      return;
    }
    final List<HistoricalPoint> newPoints = [];
    resetValues();
    HistoricalPoint firstPoint = HistoricalPoint(
      closeAmount: selectedHistorical!.closeAmount,
      openAmount: selectedHistorical!.openAmount,
      spanReturnAmount: selectedHistorical!.returnAmount,
      spanReturnPercentage: selectedHistorical!.returnPercentage,
    );
    for (int i = 0; i < points.length; i++) {
      HistoricalPoint point = points[i];
      double? checkY;
      final double? checkVolume = getVolumeFromPoint(point);
      if (yAxisType == Y_AXIS_TYPE.PERCENT) {
        checkY = point.spanReturnPercentage;
      } else if (yAxisType == Y_AXIS_TYPE.AMOUNT) {
        checkY = point.closeAmount;
      }
      if (checkY != null) {
        firstPoint = point;
        if (maxY == null) {
          maxY = checkY;
          minY = checkY;
        }
        if (checkY > maxY!) {
          maxY = checkY;
        } else if (checkY < minY!) {
          minY = checkY;
        }
      } else {
        int index = i - 1;
        if (index < 0) {
          index = 0;
        }
        final prevVal = points[index].closeAmount;
        if (prevVal != null) {
          firstPoint = points[index];
        }
        point = point.copyWith(
            closeAmount: firstPoint.closeAmount,
            spanReturnPercentage: firstPoint.spanReturnPercentage,
            spanReturnAmount: firstPoint.spanReturnAmount);
      }
      if (checkVolume != null) {
        maxPointVolume ??= checkVolume;
        if (checkVolume > maxPointVolume!) {
          maxPointVolume = checkVolume;
        }
      }
      newPoints.add(point);
    }
    selectedHistorical = selectedHistorical!.copyWith(points: newPoints);
    maxY ??= 0.0;
    minY ??= 0.0;
    final double difference = maxY! - minY!;

    // DRAFT: logic for previousCloseAmount axis line
    previousCloseAmount = yAxisType == Y_AXIS_TYPE.AMOUNT
        ? selectedHistorical!.closeAmount
        : selectedHistorical!.returnPercentage ?? 0;
    if (newPoints.isNotEmpty) {
      if (yAxisType == Y_AXIS_TYPE.PERCENT) {
        previousCloseAmount = newPoints[0].spanReturnPercentage ?? 0.0;
      } else {
        previousCloseAmount = newPoints[0].closeAmount ?? 0.0;
      }
    }

    minY = minY! - (difference * .01);
    maxY = maxY! + (difference * .01);
    if (difference == 0) {
      yInterval = maxY!.abs() / 2;
      minY = minY! - (minY!.abs() * .5);
      maxY = maxY! + (maxY!.abs() * .5);
      // yInterval = 1;
    } else {
      yInterval = difference;
    }
  }

  DateFormat getFormartXAxis() {
    if (selectedSpan == HISTORICAL_SPAN.DAY) {
      return DateFormat.jm();
    } else if (selectedSpan == HISTORICAL_SPAN.ALL) {
      return DateFormat('M/d/yy');
    } else {
      return DateFormat('M/d');
    }
  }

  Color getLineColor() {
    Color color;
    if (selectedHistorical!.returnPercentage != null) {
      if (selectedHistorical!.returnPercentage! >= 0) {
        color = IrisColor.positiveChange;
      } else {
        color = IrisColor.negativeChange;
      }
      return color;
    }
    return IrisColor.negativeChange;
  }

  num getPointVolumeY(HistoricalPoint point) {
    if (maxPointVolume == null || maxPointVolume == 0) {
      return 0;
    }
    final volume = getVolumeFromPoint(point);
    const maxHeight = 7;
    final f = (maxHeight * volume) / maxPointVolume!;
    return f;
  }

  double getVolumeFromPoint(HistoricalPoint point) {
    if (point.buyVolume != null && point.sellVolume != null) {
      return point.buyVolume! + point.sellVolume!;
    } else {
      return point.volume ?? 0;
    }
  }

  void init() {
    setHistorical();
    getChartData();
    setSelectedPointData();
    if (selectedHistorical?.points == null) {
      showChart = false;
    }
  }

  void onPointChange(HistoricalPoint? point) {
    final SelectedPointData s = SelectedPointData();
    double? colorValueTest;
    if (point != null) {
      if (yAxisType == Y_AXIS_TYPE.AMOUNT) {
        s.primaryText = point.closeAmount.formatCurrency();
        s.secondaryText = point.spanReturnPercentage.formatPercentage();
        s.primaryVal = point.spanReturnPercentage;
        s.priceChange = point.spanReturnAmount ?? 0.0;
        colorValueTest = point.spanReturnPercentage;
        s.closeAmount = point.closeAmount;
      } else if (yAxisType == Y_AXIS_TYPE.PERCENT) {
        s.primaryText = point.spanReturnPercentage.formatPercentage();
        s.primaryVal = point.spanReturnPercentage;
        s.priceChange = point.spanReturnAmount ?? 0.0;
        colorValueTest = point.spanReturnPercentage;
      }
      if (colorValueTest != null) {
        if (colorValueTest >= 0) {
          s.primaryColor = IrisColor.positiveChange;
          s.secondaryColor = IrisColor.positiveChange;
        } else {
          s.primaryColor = IrisColor.negativeChange;
          s.secondaryColor = IrisColor.negativeChange;
        }
      } else {
        s.primaryColor = IrisColor.negativeChange;
        s.secondaryColor = IrisColor.negativeChange;
      }

      final DateTime d = point.beginsAt!.subtract(const Duration(hours: 3));
      s.subText = getFormartXAxis().format(d);
      s.date = d;
    }
    selectedPointData$.value = s;
    comparePercentChange();
  }

  void onSecondPointChange(HistoricalPoint? point) {
    final SelectedPointData s = SelectedPointData();
    double? colorValueTest;
    if (point != null) {
      if (yAxisType == Y_AXIS_TYPE.AMOUNT) {
        s.primaryText = point.closeAmount.formatCurrency();
        s.primaryVal = point.spanReturnPercentage;
        s.secondaryText = point.spanReturnPercentage.formatPercentage();
        s.priceChange = point.spanReturnAmount ?? 0.0;
        colorValueTest = point.spanReturnPercentage;
        s.closeAmount = point.closeAmount;
      } else if (yAxisType == Y_AXIS_TYPE.PERCENT) {
        s.primaryText = point.spanReturnPercentage.formatPercentage();
        s.primaryVal = point.spanReturnPercentage;
        s.priceChange = point.spanReturnAmount ?? 0.0;
        colorValueTest = point.spanReturnPercentage;
      }
      if (colorValueTest! >= 0) {
        s.primaryColor = IrisColor.positiveChange;
        s.secondaryColor = IrisColor.positiveChange;
      } else {
        s.primaryColor = IrisColor.negativeChange;
        s.secondaryColor = IrisColor.negativeChange;
      }

      final DateTime d = point.beginsAt!.subtract(const Duration(hours: 3));
      s.subText = getFormartXAxis().format(d);
      s.date = d;
    }
    secondSelectedPointData$.value = s;
    laterPointData$.value = s;
    comparePercentChange();
  }

  void resetValues() {
    minY = null;
    maxY = null;
    yInterval = null;
    xInterval = null;
    maxPointVolume = null;
    xAxisIntervalType = null;
  }

  Historical? setHistorical() {
    if (selectedSpan == HISTORICAL_SPAN.DAY) {
      selectedHistorical = chartData.dayHistorical;
      xAxisIntervalType = DateTimeIntervalType.hours;
      spanSubText = yAxisType == Y_AXIS_TYPE.AMOUNT ? 'Today' : 'Day';
    } else if (selectedSpan == HISTORICAL_SPAN.WEEK) {
      selectedHistorical = chartData.weekHistorical;
      spanSubText = 'Week';
      xAxisIntervalType = DateTimeIntervalType.hours;
    } else if (selectedSpan == HISTORICAL_SPAN.MONTH) {
      selectedHistorical = chartData.monthHistorical;
      xAxisIntervalType = DateTimeIntervalType.days;
      spanSubText = 'Month';
    } else if (selectedSpan == HISTORICAL_SPAN.THREE_MONTH) {
      selectedHistorical = chartData.threeMonthHistorical;
      xAxisIntervalType = DateTimeIntervalType.days;
      spanSubText = '3 Months';
    } else if (selectedSpan == HISTORICAL_SPAN.YEAR) {
      selectedHistorical = chartData.yearHistorical;
      xAxisIntervalType = DateTimeIntervalType.days;
      spanSubText = 'Year';
    } else if (selectedSpan == HISTORICAL_SPAN.ALL) {
      selectedHistorical = chartData.allHistorical;
      xAxisIntervalType = DateTimeIntervalType.days;
      spanSubText = 'All';
    } else {
      selectedHistorical = chartData.dayHistorical;
      xAxisIntervalType = DateTimeIntervalType.hours;
      spanSubText = yAxisType == Y_AXIS_TYPE.AMOUNT ? 'Today' : 'Day';
    }
    return selectedHistorical;
  }

  void setSelectedPointData() {
    if (selectedHistorical == null) {
      return;
    }
    final SelectedPointData s = SelectedPointData();
    double? colorValueTest;
    if (yAxisType == Y_AXIS_TYPE.AMOUNT) {
      s.primaryText = selectedHistorical!.closeAmount.formatCurrency();
      s.secondaryText = selectedHistorical!.returnPercentage.formatPercentage();
      s.priceChange = selectedHistorical!.returnAmount ?? 0.0;
      colorValueTest = selectedHistorical!.returnPercentage;
      s.closeAmount = selectedHistorical!.closeAmount;
    } else if (yAxisType == Y_AXIS_TYPE.PERCENT) {
      s.primaryText = selectedHistorical!.returnPercentage.formatPercentage();
      s.primaryVal = selectedHistorical!.returnPercentage;
      s.priceChange = selectedHistorical!.returnAmount ?? 0.0;
      colorValueTest = selectedHistorical!.returnPercentage;
    }

    if (colorValueTest == null) {
    } else if (colorValueTest >= 0) {
      s.primaryColor = IrisColor.positiveChange;
      s.secondaryColor = IrisColor.positiveChange;
    } else {
      s.primaryColor = IrisColor.negativeChange;
      s.secondaryColor = IrisColor.negativeChange;
    }
    s.subText = spanSubText;
    s.date = DateTime.now();
    selectedPointData$.value = s;
    secondSelectedPointData$.value =
        SelectedPointData(); // initialize second selected point
    laterPointData$.value = SelectedPointData();
    comparePercentChange();
  }

  Future<void> timeSpanButtonClick(HISTORICAL_SPAN span) async {
    if (historicalFunction == null) {
      return;
    }
    loadingStatus$.value = LOADING_STATUS.LOADING;
    selectedSpan = span;
    setHistorical();
    if (selectedHistorical == null) {
      final data = await historicalFunction!(span: span);
      addHistoricalData(span: span, historical: data);
    }
    selectedSpan = span;
    init();
    loadingStatus$.value = LOADING_STATUS.NOT_LOADING;
  }
}

class SelectedPointData {
  String? primaryText;
  double? primaryVal;
  Color? primaryColor;
  String? secondaryText;
  Color? secondaryColor;
  String? subText;
  DateTime? date;
  double? priceChange;
  double? closeAmount;
  SelectedPointData(
      {this.primaryText,
      this.primaryVal,
      this.primaryColor,
      this.secondaryColor,
      this.secondaryText,
      this.priceChange,
      this.subText,
      this.date,
      this.closeAmount});
}

enum Y_AXIS_TYPE { PERCENT, AMOUNT }
