part of charts;

/// This class has the properties of the numeric axis.
///
/// Numeric axis uses a numerical scale and displays numbers as labels. By default, [NumericAxis] is set to both
/// horizontal axis and vertical axis.
///
/// Provides the options of [name], axis line, label rotation, label format, alignment and label position are
/// used to customize the appearance.
///
class NumericAxis extends ChartAxis {
  /// Creating an argument constructor of NumericAxis class.
  NumericAxis({
    String? name,
    bool? isVisible,
    bool? anchorRangeToVisiblePoints,
    AxisTitle? title,
    AxisLine? axisLine,
    ChartRangePadding? rangePadding,
    AxisLabelIntersectAction? labelIntersectAction,
    int? labelRotation,
    this.labelFormat,
    this.numberFormat,
    LabelAlignment? labelAlignment,
    ChartDataLabelPosition? labelPosition,
    TickPosition? tickPosition,
    bool? isInversed,
    bool? opposedPosition,
    int? minorTicksPerInterval,
    int? maximumLabels,
    MajorTickLines? majorTickLines,
    MinorTickLines? minorTickLines,
    MajorGridLines? majorGridLines,
    MinorGridLines? minorGridLines,
    EdgeLabelPlacement? edgeLabelPlacement,
    TextStyle? labelStyle,
    double? plotOffset,
    double? zoomFactor,
    double? zoomPosition,
    InteractiveTooltip? interactiveTooltip,
    this.minimum,
    this.maximum,
    double? interval,
    this.visibleMinimum,
    this.visibleMaximum,
    dynamic crossesAt,
    String? associatedAxisName,
    bool? placeLabelsNearAxisLine,
    List<PlotBand>? plotBands,
    int? decimalPlaces,
    int? desiredIntervals,
    RangeController? rangeController,
  })  : decimalPlaces = decimalPlaces ?? 3,
        super(
          name: name,
          isVisible: isVisible,
          anchorRangeToVisiblePoints: anchorRangeToVisiblePoints,
          isInversed: isInversed,
          opposedPosition: opposedPosition,
          rangePadding: rangePadding,
          labelRotation: labelRotation,
          labelIntersectAction: labelIntersectAction,
          labelPosition: labelPosition,
          tickPosition: tickPosition,
          minorTicksPerInterval: minorTicksPerInterval,
          maximumLabels: maximumLabels,
          labelStyle: labelStyle,
          title: title,
          labelAlignment: labelAlignment,
          axisLine: axisLine,
          edgeLabelPlacement: edgeLabelPlacement,
          majorTickLines: majorTickLines,
          minorTickLines: minorTickLines,
          majorGridLines: majorGridLines,
          minorGridLines: minorGridLines,
          plotOffset: plotOffset,
          zoomFactor: zoomFactor,
          zoomPosition: zoomPosition,
          interactiveTooltip: interactiveTooltip,
          interval: interval,
          crossesAt: crossesAt,
          associatedAxisName: associatedAxisName,
          placeLabelsNearAxisLine: placeLabelsNearAxisLine,
          plotBands: plotBands,
          desiredIntervals: desiredIntervals,
          rangeController: rangeController,
        );

  ///Formats the numeric axis labels.
  ///
  ///The labels can be customized by adding desired text as prefix or suffix.
  ///
  ///Defaults to `null`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(labelFormat: '{value}M'),
  ///        ));
  ///}
  ///```
  final String? labelFormat;

  ///Formats the numeric axis labels with globalized label formats.
  ///
  ///Defaults to `null`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(numberFormat: NumberFormat.currencyCompact()),
  ///        ));
  ///}
  ///```
  final NumberFormat? numberFormat;

  ///The minimum value of the axis.
  ///
  /// The axis will start from this value.
  ///
  ///Defaults to `null`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(minimum: 0),
  ///        ));
  ///}
  ///```
  final double? minimum;

  ///The maximum value of the axis.
  ///
  ///The axis will end at this value.
  ///
  ///Defaults to `null`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(maximum: 200),
  ///        ));
  ///}
  ///```
  final double? maximum;

  ///The minimum visible value of the axis.
  ///
  ///The axis will be rendered from this value initially.
  ///
  ///Defaults to `null`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(visibleMinimum: 0),
  ///        ));
  ///}
  ///```
  final double? visibleMinimum;

  ///The maximum visible value of the axis.
  ///
  /// The axis will be rendered till this value initially.
  ///
  ///Defaults to `null`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(visibleMaximum: 200),
  ///        ));
  ///}
  ///```
  final double? visibleMaximum;

  ///The rounding decimal value of the label.
  ///
  ///Defaults to `3`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(decimalPlaces: 3),
  ///        ));
  ///}
  ///```
  final int decimalPlaces;
}

/// Creates an axis renderer for Numeric axis.
class NumericAxisRenderer extends ChartAxisRenderer {
  /// Creating an argument constructor of NumericAxisRenderer class.
  NumericAxisRenderer(this._numericAxis) : super(_numericAxis);
  // ignore:unused_field
  final int _axisPadding = 5;
  // ignore:unused_field
  final int _innerPadding = 5;

  @override
  Size? _axisSize;

  final NumericAxis _numericAxis;

  /// Find the series min and max values of an series
  void _findAxisMinMaxValues(CartesianSeriesRenderer seriesRenderer,
      CartesianChartPoint<dynamic> point, int pointIndex, int dataLength,
      [bool isXVisibleRange = false, bool isYVisibleRange = false]) {
    final bool _anchorRangeToVisiblePoints =
        seriesRenderer._yAxisRenderer!._axis.anchorRangeToVisiblePoints;
    final String? seriesType = seriesRenderer._seriesType;
    point.xValue = point.x;
    point.yValue = point.y;
    if (isYVisibleRange) {
      seriesRenderer._minimumX ??= point.xValue;
      seriesRenderer._maximumX ??= point.xValue;
    }
    if ((isXVisibleRange || !_anchorRangeToVisiblePoints) &&
        !seriesType!.contains('range') &&
        !seriesType.contains('hilo') &&
        !seriesType.contains('candle') &&
        !seriesType.contains('boxandwhisker') &&
        !seriesType.contains('waterfall')) {
      seriesRenderer._minimumY ??= point.yValue;
      seriesRenderer._maximumY ??= point.yValue;
    }

    if (isYVisibleRange && point.xValue != null) {
      seriesRenderer._minimumX =
          math.min(seriesRenderer._minimumX!, point.xValue);
      seriesRenderer._maximumX =
          math.max(seriesRenderer._maximumX!, point.xValue);
    }
    if (isXVisibleRange || !_anchorRangeToVisiblePoints) {
      if (point.yValue != null &&
          (!seriesType!.contains('range') &&
              !seriesType.contains('hilo') &&
              !seriesType.contains('candle') &&
              !seriesType.contains('boxandwhisker') &&
              !seriesType.contains('waterfall'))) {
        seriesRenderer._minimumY =
            math.min(seriesRenderer._minimumY!, point.yValue);
        seriesRenderer._maximumY =
            math.max(seriesRenderer._maximumY!, point.yValue);
      }
      if (point.high != null) {
        _highMin = _findMinValue(_highMin ?? point.high, point.high);
        _highMax = _findMaxValue(_highMax ?? point.high, point.high);
      }
      if (point.low != null) {
        _lowMin = _findMinValue(_lowMin ?? point.low, point.low);
        _lowMax = _findMaxValue(_lowMax ?? point.low, point.low);
      }
      if (point.maximum != null) {
        _highMin = _findMinValue(_highMin ?? point.maximum!, point.maximum!);
        _highMax = _findMaxValue(_highMax ?? point.maximum!, point.maximum!);
      }
      if (point.minimum != null) {
        _lowMin = _findMinValue(_lowMin ?? point.minimum!, point.minimum!);
        _lowMax = _findMaxValue(_lowMax ?? point.minimum!, point.minimum!);
      }
      if (seriesType!.contains('waterfall')) {
        /// Empty point is not applicable for Waterfall series.
        point.yValue ??= 0;
        seriesRenderer._minimumY = _findMinValue(
            seriesRenderer._minimumY ?? point.yValue, point.yValue);
        seriesRenderer._maximumY = _findMaxValue(
            seriesRenderer._maximumY ?? point.maxYValue!, point.maxYValue!);
      }
    }
    if (pointIndex >= dataLength - 1) {
      if (seriesType!.contains('range') ||
          seriesType.contains('hilo') ||
          seriesType.contains('candle') ||
          seriesType.contains('boxandwhisker')) {
        _lowMin ??= 0;
        _lowMax ??= 5;
        _highMin ??= 0;
        _highMax ??= 5;
        seriesRenderer._minimumY = math.min(_lowMin!, _highMin!);
        seriesRenderer._maximumY = math.max(_lowMax!, _highMax!);
      }

      seriesRenderer._minimumX ??= 0;
      seriesRenderer._minimumY ??= 0;
      seriesRenderer._maximumX ??= 5;
      seriesRenderer._maximumY ??= 5;
    }
  }

  /// Listener for range controller
  void _controlListener() {
    if (_axis.rangeController != null && !_chartState!._rangeChangedByChart) {
      _updateRangeControllerValues(this);
      _chartState!._redrawByRangeChange();
    }
  }

  /// Calculate the range and interval
  void _calculateRangeAndInterval(SfCartesianChartState chartState,
      [String? type]) {
    _chartState = chartState;
    _chart = chartState._chart;
    if (_axis.rangeController != null) {
      _chartState!._rangeChangeBySlider = true;
      _axis.rangeController!.addListener(_controlListener);
    }
    final Rect containerRect = _chartState!._containerRect!;
    final Rect rect = Rect.fromLTWH(containerRect.left, containerRect.top,
        containerRect.width, containerRect.height);
    _axisSize = Size(rect.width, rect.height);
    calculateRange(this);
    _calculateActualRange();
    if (_actualRange != null) {
      applyRangePadding(_actualRange, _actualRange!.interval);
      if (type == null && type != 'AxisCross') {
        generateVisibleLabels();
      }
    }
  }

  /// Calculate the required values of the actual range for numeric axis
  void _calculateActualRange() {
    _min ??= 0;
    _max ??= 5;
    _actualRange = _VisibleRange(
        _chartState!._rangeChangeBySlider &&
                _numericAxis.rangeController != null
            ? _rangeMinimum ?? _numericAxis.rangeController!.start
            : _numericAxis.minimum ?? _min,
        _chartState!._rangeChangeBySlider &&
                _numericAxis.rangeController != null
            ? _rangeMaximum ?? _numericAxis.rangeController!.end
            : _numericAxis.maximum ?? _max);
    if (_axis.anchorRangeToVisiblePoints &&
        _needCalculateYrange(_numericAxis.minimum, _numericAxis.maximum,
            _chartState!, _orientation)) {
      _actualRange = _calculateYRangeOnZoomX(_actualRange, this);
    }

    ///Below condition is for checking the min, max value is equal
    if (_actualRange!.minimum == _actualRange!.maximum) {
      _actualRange!.maximum += 1;
    }

    ///Below condition is for checking the axis min value is greater than max value, then swapping min max values
    else if (_actualRange!.minimum > _actualRange!.maximum) {
      _actualRange!.minimum = _actualRange!.minimum + _actualRange!.maximum;
      _actualRange!.maximum = _actualRange!.minimum - _actualRange!.maximum;
      _actualRange!.minimum = _actualRange!.minimum - _actualRange!.maximum;
    }
    _actualRange!.delta = _actualRange!.maximum - _actualRange!.minimum;

    _actualRange!.interval = _numericAxis.interval ??
        _calculateNumericNiceInterval(this, _actualRange!.delta!, _axisSize);
  }

  /// Applies range padding to auto, normal, additional, round, and none types.
  @override
  void applyRangePadding(_VisibleRange? range, num? interval) {
    ActualRangeChangedArgs rangeChangedArgs;
    if (!(_numericAxis.minimum != null && _numericAxis.maximum != null)) {
      ///Calculating range padding
      _applyRangePadding(this, _chartState, range!, interval);
    }

    calculateVisibleRange(_axisSize);

    /// Setting range as visible zoomRange
    if ((_numericAxis.visibleMinimum != null ||
            _numericAxis.visibleMaximum != null) &&
        (_numericAxis.visibleMinimum != _numericAxis.visibleMaximum) &&
        _chartState!._zoomedAxisRendererStates != null &&
        _chartState!._zoomedAxisRendererStates!.isEmpty) {
      _visibleRange!.minimum =
          _numericAxis.visibleMinimum ?? _visibleRange!.minimum;
      _visibleRange!.maximum =
          _numericAxis.visibleMaximum ?? _visibleRange!.maximum;
      _visibleRange!.delta = _visibleRange!.maximum - _visibleRange!.minimum;
      _visibleRange!.interval = interval == null
          ? _calculateNumericNiceInterval(
              this, _visibleRange!.maximum - _visibleRange!.minimum, _axisSize)
          : _visibleRange!.interval;
      _zoomFactor = _visibleRange!.delta! / range!.delta!;
      _zoomPosition =
          (_visibleRange!.minimum - _actualRange!.minimum) / range.delta;
    }
    if (_chart!.onActualRangeChanged != null) {
      rangeChangedArgs = ActualRangeChangedArgs(_name, _numericAxis,
          range!.minimum, range.maximum, range.interval, _orientation);
      rangeChangedArgs.visibleMin = _visibleRange!.minimum;
      rangeChangedArgs.visibleMax = _visibleRange!.maximum;
      rangeChangedArgs.visibleInterval = _visibleRange!.interval;
      _chart!.onActualRangeChanged!(rangeChangedArgs);
      _visibleRange!.minimum = rangeChangedArgs.visibleMin;
      _visibleRange!.maximum = rangeChangedArgs.visibleMax;
      _visibleRange!.interval = rangeChangedArgs.visibleInterval;
    }
  }

  /// Generates the visible axis labels.
  @override
  void generateVisibleLabels() {
    num tempInterval = _visibleRange!.minimum;
    String text;
    final String minimum = tempInterval.toString();
    final num maximumVisibleRange = _visibleRange!.maximum;
    num? interval = _visibleRange!.interval;
    interval = interval.toString().split('.').length >= 2
        ? interval.toString().split('.')[1].length == 1 &&
                interval.toString().split('.')[1] == '0'
            ? interval!.floor()
            : interval
        : interval;
    _visibleLabels = <AxisLabel>[];
    for (; tempInterval <= maximumVisibleRange; tempInterval += interval!) {
      num minimumVisibleRange = tempInterval;
      if (minimumVisibleRange <= maximumVisibleRange &&
          minimumVisibleRange >= _visibleRange!.minimum) {
        final int fractionDigits = (minimum.split('.').length >= 2)
            ? minimum.split('.')[1].toString().length
            : (minimumVisibleRange.toString().split('.').length >= 2)
                ? minimumVisibleRange.toString().split('.')[1].toString().length
                : 0;
        final int fractionDigitValue =
            fractionDigits > 20 ? 20 : fractionDigits;
        minimumVisibleRange = minimumVisibleRange.toString().contains('e')
            ? minimumVisibleRange
            : num.tryParse(
                minimumVisibleRange.toStringAsFixed(fractionDigitValue))!;
        if (minimumVisibleRange.toString().split('.').length > 1) {
          final String str = minimumVisibleRange.toString();
          final List<dynamic> list = str.split('.');
          minimumVisibleRange = double.parse(
              minimumVisibleRange.toStringAsFixed(_numericAxis.decimalPlaces));
          if (list.length > 1 &&
              (list[1] == '0' ||
                  list[1] == '00' ||
                  list[1] == '000' ||
                  list[1] == '0000' ||
                  list[1] == '00000')) {
            minimumVisibleRange = minimumVisibleRange.round();
          }
        }
        text = minimumVisibleRange.toString();
        if (_numericAxis.numberFormat != null) {
          text = _numericAxis.numberFormat!.format(minimumVisibleRange);
        }
        if (_numericAxis.labelFormat != null &&
            _numericAxis.labelFormat != '') {
          text = _numericAxis.labelFormat!.replaceAll(RegExp('{value}'), text);
        }
        text = _chartState!._chartAxis!._primaryYAxisRenderer!._isStack100 ==
                    true &&
                _name == _chartState!._chartAxis!._primaryYAxisRenderer!._name
            ? (text + '%')
            : text;
        _triggerLabelRenderEvent(text, tempInterval);
      }
    }

    /// Get the maximum label of width and height in axis.
    _calculateMaximumLabelSize(this, _chartState!);
  }

  /// Calculates the visible range for an axis in chart.
  @override
  void calculateVisibleRange(Size? availableSize) {
    _visibleRange = _VisibleRange(_actualRange!.minimum, _actualRange!.maximum);
    _visibleRange!.delta = _actualRange!.delta;
    _visibleRange!.interval = _actualRange!.interval;
    _checkWithZoomState(this, _chartState!._zoomedAxisRendererStates!);
    if (_zoomFactor! < 1 || _zoomPosition! > 0) {
      _chartState!._zoomProgress = true;
      _calculateZoomRange(this, availableSize);
      _visibleRange!.interval =
          _axis.enableAutoIntervalOnZooming && _chartState!._zoomProgress
              ? calculateInterval(_visibleRange!, _axisSize)
              : _visibleRange!.interval;
      if (_axis.rangeController != null) {
        _chartState!._rangeChangedByChart = true;
        _setRangeControllerValues(this);
      }
    }
  }

  /// Finds the interval of an axis.
  @override
  num calculateInterval(_VisibleRange range, Size? availableSize) =>
      _calculateNumericNiceInterval(
          this, range.maximum - range.minimum, _axisSize);
}
