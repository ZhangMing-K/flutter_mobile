part of charts;

/// Renders the 100% stacked column series.
///
/// A stackedcolumn100 is an  chart series type meant to show the relative
/// percentage of multiple data series in stacked columns, where the total (cumulative) of stacked columns always equals 100%.
///
/// To render a 100% stacked column chart, create an instance of StackedColumn100Series,
///  and add it to the series collection property of [SfCartesianChart].
///
///Provides options to customize properties such as [color], [opacity],
///[borderWidth], [borderColor], [borderRadius] of the StackedColumn100 segemnts.
class StackedColumn100Series<T, D> extends _StackedSeriesBase<T, D> {
  /// Creating an argument constructor of StackedColumn100Series class.
  StackedColumn100Series(
      {ValueKey<String>? key,
      ChartSeriesRendererFactory<T, D>? onCreateRenderer,
      required List<T> dataSource,
      required ChartValueMapper<T, D> xValueMapper,
      required ChartValueMapper<T, num> yValueMapper,
      ChartValueMapper<T, dynamic>? sortFieldValueMapper,
      ChartValueMapper<T, Color>? pointColorMapper,
      ChartValueMapper<T, String>? dataLabelMapper,
      SortingOrder? sortingOrder,
      String? groupName,
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
      Color? borderColor,
      double? borderWidth,
      // ignore: deprecated_member_use_from_same_package
      SelectionSettings? selectionSettings,
      SelectionBehavior? selectionBehavior,
      bool? isVisibleInLegend,
      LegendIconType? legendIconType,
      String? legendItemText,
      List<double>? dashArray,
      double? opacity,
      SeriesRendererCreatedCallback? onRendererCreated,
      List<int>? initialSelectedDataIndexes})
      : super(
            key: key,
            onCreateRenderer: onCreateRenderer,
            name: name,
            dashArray: dashArray,
            groupName: groupName,
            spacing: spacing,
            xValueMapper: xValueMapper,
            yValueMapper: yValueMapper,
            sortFieldValueMapper: sortFieldValueMapper,
            pointColorMapper: pointColorMapper,
            dataLabelMapper: dataLabelMapper,
            dataSource: dataSource,
            trendlines: trendlines,
            xAxisName: xAxisName,
            yAxisName: yAxisName,
            color: color,
            width: width ?? 0.7,
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
            borderRadius: borderRadius,
            selectionSettings: selectionSettings,
            selectionBehavior: selectionBehavior,
            legendItemText: legendItemText,
            isVisibleInLegend: isVisibleInLegend,
            legendIconType: legendIconType,
            sortingOrder: sortingOrder,
            opacity: opacity,
            onRendererCreated: onRendererCreated,
            initialSelectedDataIndexes: initialSelectedDataIndexes);

  /// Create the stacked area series renderer.
  StackedColumn100SeriesRenderer createRenderer(ChartSeries<T, D> series) {
    StackedColumn100SeriesRenderer stackedAreaSeriesRenderer;
    if (onCreateRenderer != null) {
      stackedAreaSeriesRenderer =
          onCreateRenderer!(series) as StackedColumn100SeriesRenderer;
      return stackedAreaSeriesRenderer;
    }
    return StackedColumn100SeriesRenderer();
  }
}

/// Creates series renderer for Stacked column 100 series
class StackedColumn100SeriesRenderer extends _StackedSeriesRenderer {
  /// Calling the default constructor of StackedColumn100SeriesRenderer class.
  StackedColumn100SeriesRenderer();

  @override
  num? _rectPosition;
  @override
  num? _rectCount;

  /// Stacked Column 100 segment is created here
  // ignore: unused_element
  ChartSegment _createSegments(CartesianChartPoint<dynamic> currentPoint,
      int pointIndex, int seriesIndex, num animateFactor) {
    final StackedColumn100Segment segment =
        createSegment() as StackedColumn100Segment;
    final StackedColumn100Series<dynamic, dynamic>? _stackedColumn100Series =
        _series as StackedColumn100Series<dynamic, dynamic>?;
    _isRectSeries = true;
    segment._seriesIndex = seriesIndex;
    segment.currentSegmentIndex = pointIndex;
    segment.points!.add(Offset(currentPoint.markerPoint!.x as double,
        currentPoint.markerPoint!.y as double));
    segment._seriesRenderer = this;
    segment._series = _stackedColumn100Series;
    segment._currentPoint = currentPoint;
    segment.animationFactor = animateFactor as double?;
    segment._path = _findingRectSeriesDashedBorder(
        currentPoint, _stackedColumn100Series!.borderWidth);
    segment.segmentRect = _getRRectFromRect(
        currentPoint.region!, _stackedColumn100Series.borderRadius);
    segment._segmentRect = segment.segmentRect;
    customizeSegment(segment);
    segment.strokePaint = segment.getStrokePaint();
    segment.fillPaint = segment.getFillPaint();
    _segments.add(segment);
    return segment;
  }

  /// To render stacked column 100 series segments
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

  /// Creates a segment for a data point in the series.
  @override
  ChartSegment createSegment() => StackedColumn100Segment();

  /// Changes the series color, border color, and border width.
  @override
  void customizeSegment(ChartSegment segment) {
    final StackedColumn100Segment column100Segment =
        segment as StackedColumn100Segment;
    column100Segment._color =
        column100Segment._currentPoint!.pointColorMapper ??
            column100Segment._seriesRenderer!._seriesColor;
    column100Segment._strokeColor = column100Segment._series!.borderColor;
    column100Segment._strokeWidth = column100Segment._series!.borderWidth;
  }

  /// Draws data label text of the appropriate data point in a series.
  @override
  void drawDataLabel(int index, Canvas canvas, String? dataLabel, double pointX,
          double pointY, int? angle, TextStyle style) =>
      _drawText(canvas, dataLabel, Offset(pointX, pointY), style, angle);

  /// Draws marker with different shape and color of the appropriate data point in the series.
  @override
  void drawDataMarker(int? index, Canvas canvas, Paint? fillPaint,
      Paint? strokePaint, double? pointX, double? pointY,
      [CartesianSeriesRenderer? seriesRenderer]) {
    canvas.drawPath(seriesRenderer!._markerShapes[index!], fillPaint!);
    canvas.drawPath(seriesRenderer._markerShapes[index], strokePaint!);
  }
}
