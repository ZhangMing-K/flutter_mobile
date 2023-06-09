part of charts;

/// This class Renders the area series.
///
/// To render an area chart, create an instance of AreaSeries, and add it to the series collection property of SfCartesianChart.
/// The area chart shows the filled area to represent the data, but when there are more than a series, this may hide the other series.
/// To get rid of this, increase or decrease the transparency of the series.
///
/// It provides options for color, opacity, border color, and border width to customize the appearance.
///
class AreaSeries<T, D> extends XyDataSeries<T, D> {
  /// Creating an argument constructor of AreaSeries class.
  AreaSeries(
      {ValueKey<String>? key,
      ChartSeriesRendererFactory<T, D>? onCreateRenderer,
      required List<T> dataSource,
      required ChartValueMapper<T, D> xValueMapper,
      required ChartValueMapper<T, num> yValueMapper,
      ChartValueMapper<T, dynamic>? sortFieldValueMapper,
      ChartValueMapper<T, Color>? pointColorMapper,
      ChartValueMapper<T, String>? dataLabelMapper,
      SortingOrder? sortingOrder,
      String? xAxisName,
      String? yAxisName,
      String? name,
      Color? color,
      MarkerSettings? markerSettings,
      EmptyPointSettings? emptyPointSettings,
      DataLabelSettings? dataLabelSettings,
      List<Trendline>? trendlines,
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
      BorderDrawMode? borderDrawMode,
      SeriesRendererCreatedCallback? onRendererCreated})
      : borderDrawMode = borderDrawMode ?? BorderDrawMode.top,
        super(
            key: key,
            onRendererCreated: onRendererCreated,
            onCreateRenderer: onCreateRenderer,
            xValueMapper: xValueMapper,
            yValueMapper: yValueMapper,
            sortFieldValueMapper: sortFieldValueMapper,
            pointColorMapper: pointColorMapper,
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
            opacity: opacity);

  ///Border type of area series.
  ///
  ///It have the three types of [BorderDrawMode],
  ///
  ///* [BorderDrawMode.all] renders border for all the sides of area.
  ///
  ///* [BorderDrawMode.top] renders border only for top side.
  ///
  ///* [BorderDrawMode.excludeBottom] renders border except bottom side.
  ///
  ///
  ///Defaults to `BorderDrawMode.top`.
  ///
  ///Also refer [BorderDrawMode].
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

  /// Create the Area series renderer.
  AreaSeriesRenderer createRenderer(ChartSeries<T, D> series) {
    AreaSeriesRenderer seriesRenderer;
    if (onCreateRenderer != null) {
      seriesRenderer = onCreateRenderer!(series) as AreaSeriesRenderer;
      return seriesRenderer;
    }
    return AreaSeriesRenderer();
  }
}

/// Creates series renderer for Area series
class AreaSeriesRenderer extends XyDataSeriesRenderer {
  /// Calling the default constructor of AreaSeriesRenderer class.
  AreaSeriesRenderer();

  /// Creates a segment for a data point in the series.
  ChartSegment _createSegments(
      Path path, Path strokePath, int? seriesIndex, num animateFactor,
      [List<Offset>? _points]) {
    final AreaSegment segment = createSegment() as AreaSegment;
    final List<CartesianSeriesRenderer?>? oldSeriesRenderers =
        _chartState!._oldSeriesRenderers;
    segment._series = _series as XyDataSeries<dynamic, dynamic>?;
    segment.currentSegmentIndex = 0;
    segment.points = _points;
    segment._seriesRenderer = this;
    segment._seriesIndex = seriesIndex;
    segment.animationFactor = animateFactor as double?;
    segment._path = path;
    segment._strokePath = strokePath;
    if (_chartState!._widgetNeedUpdate &&
        oldSeriesRenderers != null &&
        oldSeriesRenderers.isNotEmpty &&
        oldSeriesRenderers.length - 1 >= segment._seriesIndex! &&
        oldSeriesRenderers[segment._seriesIndex!]!._seriesName ==
            segment._seriesRenderer!._seriesName) {
      segment._oldSeriesRenderer = oldSeriesRenderers[segment._seriesIndex!];
    }
    customizeSegment(segment);
    segment._chart = _chart;
    segment._chartState = _chartState;
    _segments.add(segment);
    return segment;
  }

  /// To draw area segments
  //ignore: unused_element
  void _drawSegment(Canvas canvas, ChartSegment segment) {
    if (segment._seriesRenderer!._isSelectionEnable) {
      final SelectionBehaviorRenderer selectionBehaviorRenderer =
          segment._seriesRenderer!._selectionBehaviorRenderer!;
      selectionBehaviorRenderer._selectionRenderer!._checkWithSelectionState(
          _segments[segment.currentSegmentIndex!], _chart);
    }
    segment.onPaint(canvas);
  }

  /// To create area series segments
  @override
  ChartSegment createSegment() => AreaSegment();

  /// Changes the series color, border color, and border width.
  @override
  void customizeSegment(ChartSegment segment) {
    final AreaSegment areaSegment = segment as AreaSegment;
    areaSegment._color = areaSegment._seriesRenderer!._seriesColor;
    areaSegment._strokeColor = areaSegment._seriesRenderer!._seriesColor;
    areaSegment._strokeWidth = areaSegment._series!.width;
    areaSegment.strokePaint = areaSegment.getStrokePaint();
    areaSegment.fillPaint = areaSegment.getFillPaint();
  }

  /// Draws marker with different shape and color of the appropriate data point in the series.
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
