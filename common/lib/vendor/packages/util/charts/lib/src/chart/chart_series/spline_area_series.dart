part of charts;

/// Renders the spline series.
///
/// To render a spline area chart, create an instance of SplineAreaSeries, and add it to the series collection property of [SfCartesianChart].
///  Properties such as [color], [opacity], [width] are used to customize the appearance of spline area chart.
class SplineAreaSeries<T, D> extends XyDataSeries<T, D> {
  /// Creating an argument constructor of SplineAreaSeries class.
  SplineAreaSeries(
      {ValueKey<String>? key,
      ChartSeriesRendererFactory<T, D>? onCreateRenderer,
      required List<T> dataSource,
      required ChartValueMapper<T, D> xValueMapper,
      required ChartValueMapper<T, num> yValueMapper,
      ChartValueMapper<T, dynamic>? sortFieldValueMapper,
      ChartValueMapper<T, String>? dataLabelMapper,
      SortingOrder? sortingOrder,
      String? xAxisName,
      String? yAxisName,
      String? name,
      Color? color,
      MarkerSettings? markerSettings,
      this.splineType,
      List<Trendline>? trendlines,
      double? cardinalSplineTension,
      EmptyPointSettings? emptyPointSettings,
      DataLabelSettings? dataLabelSettings,
      bool? isVisible,
      bool? enableTooltip,
      List<double>? dashArray,
      double? animationDuration,
      Color? borderColor,
      double? borderWidth,
      LinearGradient? gradient,
      LinearGradient? borderGradient,
      // ignore: deprecated_member_use_from_same_package
      SelectionSettings? selectionSettings,
      SelectionBehavior? selectionBehavior,
      bool? isVisibleInLegend,
      LegendIconType? legendIconType,
      String? legendItemText,
      double? opacity,
      SeriesRendererCreatedCallback? onRendererCreated,
      BorderDrawMode? borderDrawMode})
      : borderDrawMode = borderDrawMode ?? BorderDrawMode.top,
        cardinalSplineTension = cardinalSplineTension ?? 0.5,
        super(
            key: key,
            onCreateRenderer: onCreateRenderer,
            xValueMapper: xValueMapper,
            yValueMapper: yValueMapper,
            sortFieldValueMapper: sortFieldValueMapper,
            dataLabelMapper: dataLabelMapper,
            dataSource: dataSource,
            xAxisName: xAxisName,
            yAxisName: yAxisName,
            name: name,
            color: color,
            trendlines: trendlines,
            markerSettings: markerSettings,
            dataLabelSettings: dataLabelSettings,
            isVisible: isVisible,
            emptyPointSettings: emptyPointSettings,
            enableTooltip: enableTooltip,
            dashArray: dashArray,
            animationDuration: animationDuration,
            borderColor: borderColor,
            borderWidth: borderWidth,
            gradient: gradient,
            borderGradient: borderGradient,
            selectionSettings: selectionSettings,
            selectionBehavior: selectionBehavior,
            legendItemText: legendItemText,
            isVisibleInLegend: isVisibleInLegend,
            legendIconType: legendIconType,
            sortingOrder: sortingOrder,
            onRendererCreated: onRendererCreated,
            opacity: opacity);

  ///Border type of area series.
  ///
  ///Defaults to `BorderDrawMode.top`
  ///
  ///Also refer [BorderDrawMode]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <AreaSeries<SalesData, num>>[
  ///                AreaSeries<SalesData, num>(
  ///                  borderDrawMode: BorderDrawMode.all,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final BorderDrawMode borderDrawMode;

  ///Type of the spline curve. Various type of curves such as clamped, cardinal,
  ///monotonic, and natural can be rendered between the data points.
  ///
  ///Defaults to `splineType.natural`
  ///
  ///Also refer [SplineType]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineAreaSeries<SalesData, num>>[
  ///                SplineAreaSeries<SalesData, num>(
  ///                  splineType: SplineType.monotonic,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final SplineType? splineType;

  ///Line tension of the cardinal spline. The value ranges from 0 to 1.
  ///
  ///Defaults to `0.5`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineAreaSeries<SalesData, num>>[
  ///                SplineAreaSeries<SalesData, num>(
  ///                  splineType: SplineType.natural,
  ///                  cardinalSplineTension: 0.4,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double cardinalSplineTension;

  /// Create the spline area series renderer.
  SplineAreaSeriesRenderer createRenderer(ChartSeries<T, D> series) {
    SplineAreaSeriesRenderer seriesRenderer;
    if (onCreateRenderer != null) {
      seriesRenderer = onCreateRenderer!(series) as SplineAreaSeriesRenderer;
      return seriesRenderer;
    }
    return SplineAreaSeriesRenderer();
  }
}

/// Creates series renderer for Spline area series
class SplineAreaSeriesRenderer extends XyDataSeriesRenderer {
  /// Calling the default constructor of SplineAreaSeriesRenderer class.
  SplineAreaSeriesRenderer();

  //ignore: prefer_final_fields
  List<_ControlPoints>? _drawPoints;

  /// SplineArea segment is created here
  ChartSegment _createSegments(int? seriesIndex, SfCartesianChart chart,
      num animateFactor, Path path, Path strokePath,
      [List<Offset>? _points]) {
    final SplineAreaSegment segment = createSegment() as SplineAreaSegment;
    _isRectSeries = false;
    segment._seriesIndex = seriesIndex;
    segment.animationFactor = animateFactor as double?;
    segment._series = _series as XyDataSeries<dynamic, dynamic>?;
    segment._seriesRenderer = this;
    segment.points = _points;
    segment._path = path;
    segment._strokePath = strokePath;
    segment._chart = chart;
    customizeSegment(segment);
    segment.strokePaint = segment.getStrokePaint();
    segment.fillPaint = segment.getFillPaint();
    _segments.add(segment);
    return segment;
  }

  /// To render spline area series segments
  //ignore: unused_element
  void _drawSegment(Canvas canvas, ChartSegment segment) {
    if (segment._seriesRenderer!._isSelectionEnable) {
      final SelectionBehaviorRenderer selectionBehaviorRenderer =
          segment._seriesRenderer!._selectionBehaviorRenderer!;
      selectionBehaviorRenderer._selectionRenderer!
          ._checkWithSelectionState(_segments[0], _chart);
    }
    segment.onPaint(canvas);
  }

  /// Creates a segment for a data point in the series.
  @override
  ChartSegment createSegment() => SplineAreaSegment();

  /// Changes the series color, border color, and border width.
  @override
  void customizeSegment(ChartSegment segment) {
    segment._color = segment._seriesRenderer!._seriesColor;
    segment._strokeColor = segment._seriesRenderer!._seriesColor;
    segment._strokeWidth = segment._series!.width;
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
