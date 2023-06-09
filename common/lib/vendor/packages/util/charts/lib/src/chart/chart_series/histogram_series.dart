part of charts;

/// This class has the properties of the column series.
///
/// To render a column chart, create an instance of [HistogramSeries], and add it to the series collection property of [SfCartesianChart].
/// The column series is a rectangular column with heights or lengths proportional to the values that they represent. it has the spacing
/// property to separate the column.
///
/// Provide the options of color, opacity, border color, and border width to customize the appearance.
///
class HistogramSeries<T, D> extends XyDataSeries<T, D> {
  /// Creating an argument constructor of HistogramSeries class.
  HistogramSeries(
      {ValueKey<String>? key,
      ChartSeriesRendererFactory<T, D>? onCreateRenderer,
      required List<T> dataSource,
      required ChartValueMapper<T, num> yValueMapper,
      ChartValueMapper<T, dynamic>? sortFieldValueMapper,
      ChartValueMapper<T, Color>? pointColorMapper,
      ChartValueMapper<T, String>? dataLabelMapper,
      SortingOrder? sortingOrder,
      this.isTrackVisible = false,
      String? xAxisName,
      String? yAxisName,
      String? name,
      Color? color,
      double? width,
      double? spacing,
      MarkerSettings? markerSettings,
      List<Trendline>? trendlines,
      EmptyPointSettings? emptyPointSettings,
      DataLabelSettings? dataLabelSettings,
      bool? isVisible,
      LinearGradient? gradient,
      LinearGradient? borderGradient,
      BorderRadius? borderRadius,
      bool? enableTooltip,
      double? animationDuration,
      Color? trackColor,
      Color? trackBorderColor,
      double? trackBorderWidth,
      double? trackPadding,
      Color? borderColor,
      double? borderWidth,
      // ignore: deprecated_member_use_from_same_package
      SelectionSettings? selectionSettings,
      SelectionBehavior? selectionBehavior,
      bool? isVisibleInLegend,
      LegendIconType? legendIconType,
      String? legendItemText,
      double? opacity,
      List<double>? dashArray,
      this.binInterval,
      bool? showNormalDistributionCurve,
      this.curveColor = Colors.blue,
      double? curveWidth,
      this.curveDashArray,
      SeriesRendererCreatedCallback? onRendererCreated})
      : trackColor = trackColor ?? Colors.grey,
        trackBorderColor = trackBorderColor ?? Colors.transparent,
        trackBorderWidth = trackBorderWidth ?? 1,
        trackPadding = trackPadding ?? 0,
        spacing = spacing ?? 0,
        borderRadius = borderRadius ?? const BorderRadius.all(Radius.zero),
        showNormalDistributionCurve = showNormalDistributionCurve ?? false,
        curveWidth = curveWidth ?? 2,
        super(
            key: key,
            onCreateRenderer: onCreateRenderer,
            name: name,
            yValueMapper: yValueMapper,
            sortFieldValueMapper: sortFieldValueMapper,
            pointColorMapper: pointColorMapper,
            dataLabelMapper: dataLabelMapper,
            dataSource: dataSource,
            xAxisName: xAxisName,
            yAxisName: yAxisName,
            trendlines: trendlines,
            color: color,
            width: width ?? 0.95,
            markerSettings: markerSettings,
            dataLabelSettings: dataLabelSettings,
            isVisible: isVisible,
            gradient: gradient,
            borderGradient: borderGradient,
            emptyPointSettings: emptyPointSettings,
            enableTooltip: enableTooltip,
            animationDuration: animationDuration,
            borderColor: borderColor,
            borderWidth: borderWidth,
            selectionSettings: selectionSettings,
            selectionBehavior: selectionBehavior,
            legendItemText: legendItemText,
            isVisibleInLegend: isVisibleInLegend,
            legendIconType: legendIconType,
            sortingOrder: sortingOrder,
            onRendererCreated: onRendererCreated,
            opacity: opacity,
            dashArray: dashArray);

  ///Interval value by which the data points are grouped and rendered as bars, in histogram series.
  ///
  ///For example, if the [binInterval] is set to 20, the x-axis will split with 20 as the interval.
  /// The first bar in the histogram represents the count of values lying between 0 to 20
  ///  in the provided data and the second bar will represent 20 to 40.
  ///
  ///If no value is specified for this property, then the interval will be calculated
  /// automatically based on the data points count and value.
  ///
  ///Defaults to `null`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <HistogramSeries<SalesData, num>>[
  ///                HistogramSeries<SalesData, num>(
  ///                   binInterval: 4
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final int? binInterval;

  ///Renders a spline curve for the normal distribution, calculated based on the series data points.
  ///
  ///This spline curve type can be changed using the [splineType] property.
  ///
  ///Defaults to `false`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <HistogramSeries<SalesData, num>>[
  ///                HistogramSeries<SalesData, num>(
  ///                   showNormalDistributionCurve: true
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final bool showNormalDistributionCurve;

  ///Color of the normal distribution spline curve.
  ///
  ///Defaults to `Colors.blue`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <HistogramSeries<SalesData, num>>[
  ///                HistogramSeries<SalesData, num>(
  ///                   curveColor: Colors.red
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final Color curveColor;

  ///Width of the normal distribution spline curve.
  ///
  ///Defaults to `2`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <HistogramSeries<SalesData, num>>[
  ///                HistogramSeries<SalesData, num>(
  ///                   curveWidth: 4
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double curveWidth;

  ///Dash array of the normal distribution spline curve.
  ///
  ///Defaults to `null`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <HistogramSeries<SalesData, num>>[
  ///                HistogramSeries<SalesData, num>(
  ///                   curveDashArray: [2, 3]
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final List<double>? curveDashArray;

  ///Color of the track.
  ///
  ///Defaults to `Colors.grey`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <HistogramSeries<SalesData, num>>[
  ///                HistogramSeries<SalesData, num>(
  ///                  isTrackVisible: true,
  ///                  trackColor: Colors.red
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final Color trackColor;

  ///Color of the track border.
  ///
  ///Defaults to `Colors.transparent`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <HistogramSeries<SalesData, num>>[
  ///                HistogramSeries<SalesData, num>(
  ///                  isTrackVisible: true,
  ///                  trackBorderColor: Colors.red
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final Color trackBorderColor;

  ///Width of the track border.
  ///
  ///Defaults to `1`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <HistogramSeries<SalesData, num>>[
  ///                HistogramSeries<SalesData, num>(
  ///                  isTrackVisible: true,
  ///                  trackBorderColor: Colors.red ,
  ///                  trackBorderWidth: 2
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double trackBorderWidth;

  ///Padding of the track.
  ///
  ///By default, track will be rendered based on the bar’s available width and spacing.
  /// If you wish to change the track width, you can use this property.
  ///
  ///Defaults to `0`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <HistogramSeries<SalesData, num>>[
  ///                HistogramSeries<SalesData, num>(
  ///                  isTrackVisible: true,
  ///                  trackPadding: 2
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double trackPadding;

  ///Spacing between the bars in histogram series.
  ///
  ///The value ranges from 0 to 1. 1 represents 100% and 0 represents 0% of the available space.
  ///
  ///Spacing also affects the width of the bar. For example, setting 20% spacing
  ///and 100% width renders the bar with 80% of total width.
  ///
  ///Defaults to `0`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <HistogramSeries<SalesData, num>>[
  ///                HistogramSeries<SalesData, num>(
  ///                  spacing: 0,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double spacing;

  ///Renders the bar in histogram series with track.
  ///
  ///Track is a rectangular bar rendered from the start to the end of the axis.
  /// Bars in the histogram will be rendered above the track.
  ///
  ///Defaults to `false`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <HistogramSeries<SalesData, num>>[
  ///                HistogramSeries<SalesData, num>(
  ///                  isTrackVisible: true,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final bool isTrackVisible;

  ///Customizes the corners of the bars in histogram series.
  ///
  ///Each corner can be customized individually or can be customized together, by specifying a single value.
  ///
  ///Defaults to `Radius.zero`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <HistogramSeries<SalesData, num>>[
  ///                HistogramSeries<SalesData, num>(
  ///                  borderRadius: BorderRadius.circular(5),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final BorderRadius borderRadius;

  /// Create the Histogram series renderer.
  HistogramSeriesRenderer createRenderer(ChartSeries<T, D> series) {
    HistogramSeriesRenderer seriesRenderer;
    if (onCreateRenderer != null) {
      seriesRenderer = onCreateRenderer!(series) as HistogramSeriesRenderer;
      return seriesRenderer;
    }
    return HistogramSeriesRenderer();
  }
}

class _HistogramValues {
  _HistogramValues(
      {this.sDValue, this.mean, this.binWidth, this.yValues, this.minValue});
  num? sDValue;
  num? mean;
  num? binWidth;
  num? minValue;
  List<num>? yValues = <num>[];
}

/// Creates series renderer for Histogram series
class HistogramSeriesRenderer extends XyDataSeriesRenderer {
  num? _rectPosition;
  num? _rectCount;
  late _HistogramValues _histogramValues;
  HistogramSegment? _segment;
  List<CartesianSeriesRenderer?>? _oldSeriesRenderers;
  HistogramSeries<dynamic, dynamic>? _histogramSeries;
  BorderRadius? _borderRadius;

  /// To get the proper data for histogram series
  void _processData(HistogramSeries<dynamic, dynamic> series, List<num> yValues,
      num yValuesCount) {
    _histogramValues = _HistogramValues();
    _histogramValues.yValues = yValues;
    final num mean = yValuesCount / _histogramValues.yValues!.length;
    _histogramValues.mean = mean;
    num sumValue = 0;
    num sDValue;
    for (int value = 0; value < _histogramValues.yValues!.length; value++) {
      sumValue += (_histogramValues.yValues![value] - _histogramValues.mean!) *
          (_histogramValues.yValues![value] - _histogramValues.mean!);
    }
    sDValue = math.sqrt(sumValue / _histogramValues.yValues!.length - 1).isNaN
        ? 0
        : (math.sqrt(sumValue / _histogramValues.yValues!.length - 1)).round();
    _histogramValues.sDValue = sDValue;
  }

  /// Find the path for distribution line in the histogram
  Path _findNormalDistributionPath(
      HistogramSeries<dynamic, dynamic> series, SfCartesianChart chart) {
    final num min = _xAxisRenderer!._visibleRange!.minimum;
    final num max = _xAxisRenderer!._visibleRange!.maximum;
    num xValue, yValue;
    final Path path = Path();
    _ChartLocation pointLocation;
    const num pointsCount = 500;
    final num del = (max - min) / (pointsCount - 1);
    for (int i = 0; i < pointsCount; i++) {
      xValue = min + i * del;
      yValue = math.exp(-(xValue - _histogramValues.mean!) *
              (xValue - _histogramValues.mean!) /
              (2 * _histogramValues.sDValue! * _histogramValues.sDValue!)) /
          (_histogramValues.sDValue! * math.sqrt(2 * math.pi));
      pointLocation = _calculatePoint(
          xValue,
          yValue *
              _histogramValues.binWidth! *
              _histogramValues.yValues!.length,
          _xAxisRenderer!,
          _yAxisRenderer!,
          _chartState!._requireInvertedAxis!,
          series,
          _chartState!._chartAxis!._axisClipRect!);
      i == 0
          ? path.moveTo(pointLocation.x as double, pointLocation.y as double)
          : path.lineTo(pointLocation.x as double, pointLocation.y as double);
    }
    return path;
  }

  /// To add histogram segments to segments list
  ChartSegment? _createSegments(
      CartesianChartPoint<dynamic> currentPoint,
      int pointIndex,
      _VisibleRange sideBySideInfo,
      int? seriesIndex,
      num animateFactor) {
    _segment = createSegment() as HistogramSegment?;
    _oldSeriesRenderers = _chartState!._oldSeriesRenderers;
    _histogramSeries = _series as HistogramSeries<dynamic, dynamic>?;
    _borderRadius = _histogramSeries!.borderRadius;
    _segment!._seriesRenderer = this;
    _segment!._series = _histogramSeries;
    _segment!._chart = _chart;
    _segment!._chartState = _chartState;
    _segment!._seriesIndex = seriesIndex;
    _segment!.currentSegmentIndex = pointIndex;
    _segment!.points!.add(Offset(currentPoint.markerPoint!.x as double,
        currentPoint.markerPoint!.y as double));
    _segment!.animationFactor = animateFactor as double?;
    final num origin = math.max(_yAxisRenderer!._visibleRange!.minimum, 0);
    currentPoint.region = _calculateRectangle(
        currentPoint.xValue + sideBySideInfo.minimum,
        currentPoint.yValue,
        currentPoint.xValue + sideBySideInfo.maximum,
        math.max(_yAxisRenderer!._visibleRange!.minimum, 0),
        this,
        _chartState!);
    _segment!._currentPoint = currentPoint;
    if (_chartState!._widgetNeedUpdate &&
        !_chartState!._isLegendToggled! &&
        _oldSeriesRenderers != null &&
        _oldSeriesRenderers!.isNotEmpty &&
        _oldSeriesRenderers!.length - 1 >= _segment!._seriesIndex! &&
        _oldSeriesRenderers![_segment!._seriesIndex!]!._seriesName ==
            _segment!._seriesRenderer!._seriesName) {
      _segment!._oldSeriesRenderer =
          _oldSeriesRenderers![_segment!._seriesIndex!];
      _segment!._oldPoint = (_segment!
                  ._oldSeriesRenderer!._segments.isNotEmpty &&
              _segment!._oldSeriesRenderer!._segments[0] is HistogramSegment &&
              _segment!._oldSeriesRenderer!._dataPoints!.length - 1 >=
                  pointIndex)
          ? _segment!._oldSeriesRenderer!._dataPoints![pointIndex]
          : null;
    } else if (_chartState!._isLegendToggled! &&
        _chartState!._segments != null &&
        _chartState!._segments!.isNotEmpty) {
      _segment!._oldSeriesVisible =
          _chartState!._oldSeriesVisible[_segment!._seriesIndex!];
      for (int i = 0; i < _chartState!._segments!.length; i++) {
        final HistogramSegment oldSegment =
            _chartState!._segments![i] as HistogramSegment;
        if (oldSegment.currentSegmentIndex == _segment!.currentSegmentIndex &&
            oldSegment._seriesIndex == _segment!._seriesIndex) {
          _segment!._oldRegion = oldSegment.segmentRect!.outerRect;
        }
      }
    }
    _segment!._path = _findingRectSeriesDashedBorder(
        currentPoint, _histogramSeries!.borderWidth);
    if (_borderRadius != null) {
      _segment!.segmentRect =
          _getRRectFromRect(currentPoint.region!, _borderRadius!);
    }
    //Tracker rect
    if (_histogramSeries!.isTrackVisible) {
      currentPoint.trackerRectRegion = _calculateShadowRectangle(
          currentPoint.xValue + sideBySideInfo.minimum,
          currentPoint.yValue,
          currentPoint.xValue + sideBySideInfo.maximum,
          origin,
          this,
          _chartState!,
          Offset(_segment!._seriesRenderer!._xAxisRenderer!._axis.plotOffset,
              _segment!._seriesRenderer!._yAxisRenderer!._axis.plotOffset));
      if (_borderRadius != null) {
        _segment!._trackRect =
            _getRRectFromRect(currentPoint.trackerRectRegion, _borderRadius!);
      }
    }
    _segment!._segmentRect = _segment!.segmentRect;
    customizeSegment(_segment!);
    _segments.add(_segment);
    return _segment;
  }

  /// To render histogram series segments
  //ignore: unused_element
  void _drawSegment(Canvas canvas, ChartSegment segment) {
    if (_segment!._seriesRenderer!._isSelectionEnable) {
      final SelectionBehaviorRenderer selectionBehaviorRenderer =
          _segment!._seriesRenderer!._selectionBehaviorRenderer!;
      selectionBehaviorRenderer._selectionRenderer!._checkWithSelectionState(
          _segments[segment.currentSegmentIndex!], _chart);
    }
    segment.onPaint(canvas);
  }

  /// Creates a segment for a data point in the series.
  @override
  ChartSegment createSegment() => HistogramSegment();

  /// Changes the series color, border color, and border width.
  @override
  void customizeSegment(ChartSegment segment) {
    final HistogramSegment histogramSegment = segment as HistogramSegment;
    histogramSegment._color =
        histogramSegment._currentPoint!.pointColorMapper ??
            segment._seriesRenderer!._seriesColor;
    histogramSegment._strokeColor = segment._series!.borderColor;
    histogramSegment._strokeWidth = segment._series!.borderWidth;
    histogramSegment.strokePaint = histogramSegment.getStrokePaint();
    histogramSegment.fillPaint = histogramSegment.getFillPaint();
    histogramSegment._trackerFillPaint =
        histogramSegment._getTrackerFillPaint();
    histogramSegment._trackerStrokePaint =
        histogramSegment._getTrackerStrokePaint();
  }

  ///Draws marker with different shape and color of the appropriate data point in the series.
  @override
  void drawDataMarker(int? index, Canvas canvas, Paint? fillPaint,
      Paint? strokePaint, double? pointX, double? pointY,
      [CartesianSeriesRenderer? seriesRenderer]) {
    canvas.drawPath(seriesRenderer!._markerShapes[index!], fillPaint!);
    canvas.drawPath(seriesRenderer._markerShapes[index], strokePaint!);
  }

  /// Draws data label text of the appropriate data point in a series.
  @override
  void drawDataLabel(int index, Canvas canvas, String? dataLabel, double pointX,
          double pointY, int? angle, TextStyle style) =>
      _drawText(canvas, dataLabel, Offset(pointX, pointY), style, angle);
}
