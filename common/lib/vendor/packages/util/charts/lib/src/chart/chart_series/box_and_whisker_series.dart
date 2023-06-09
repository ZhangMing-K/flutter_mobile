part of charts;

/// This class holds the properties of the Box and Whisker series.
///
/// To render a Box and Whisker chart, create an instance of [BoxAndWhiskerSeries], and add it to the [series] collection property of [SfCartesianChart].
/// The Box and Whisker chart represents the hollow rectangle with the lower quartile, upper quartile, maximum and minimum value in the given data.
///
/// Provides options for color, opacity, border color, and border width
/// to customize the appearance.
///
class BoxAndWhiskerSeries<T, D> extends XyDataSeries<T, D> {
  /// Creating an argument constructor of BoxAndWhiskerSeries class.
  BoxAndWhiskerSeries(
      {ValueKey<String>? key,
      ChartSeriesRendererFactory<T, D>? onCreateRenderer,
      required List<T> dataSource,
      required ChartValueMapper<T, D> xValueMapper,
      required ChartValueMapper<T, dynamic> yValueMapper,
      ChartValueMapper<T, dynamic>? sortFieldValueMapper,
      ChartValueMapper<T, Color>? pointColorMapper,
      ChartValueMapper<T, String>? dataLabelMapper,
      SortingOrder? sortingOrder,
      String? xAxisName,
      String? yAxisName,
      String? name,
      Color? color,
      double? width,
      double? spacing,
      MarkerSettings? markerSettings,
      DataLabelSettings? dataLabelSettings,
      bool? isVisible,
      bool? enableTooltip,
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
      List<double>? dashArray,
      double? opacity,
      SeriesRendererCreatedCallback? onRendererCreated,
      List<Trendline>? trendlines,
      BoxPlotMode? boxPlotMode,
      bool? showMean})
      : spacing = spacing ?? 0,
        boxPlotMode = boxPlotMode ?? BoxPlotMode.normal,
        showMean = showMean ?? true,
        super(
            key: key,
            onCreateRenderer: onCreateRenderer,
            name: name,
            onRendererCreated: onRendererCreated,
            dashArray: dashArray,
            xValueMapper: xValueMapper,
            yValueMapper: yValueMapper,
            sortFieldValueMapper: sortFieldValueMapper,
            pointColorMapper: pointColorMapper,
            dataLabelMapper: dataLabelMapper,
            dataSource: dataSource,
            xAxisName: xAxisName,
            yAxisName: yAxisName,
            color: color,
            width: width ?? 0.7,
            markerSettings: markerSettings,
            dataLabelSettings: dataLabelSettings,
            isVisible: isVisible,
            enableTooltip: enableTooltip,
            animationDuration: animationDuration,
            borderColor: borderColor ?? Colors.black,
            borderWidth: borderWidth ?? 1,
            gradient: gradient,
            borderGradient: borderGradient,
            selectionSettings: selectionSettings,
            selectionBehavior: selectionBehavior,
            legendItemText: legendItemText,
            isVisibleInLegend: isVisibleInLegend,
            legendIconType: legendIconType,
            sortingOrder: sortingOrder,
            opacity: opacity,
            trendlines: trendlines);

  ///To change the box plot rendering mode.
  ///
  ///The box plot series rendering mode can be changed by
  ///using [BoxPlotMode] property. The below values are applicable for this:
  ///
  ///* `normal` - The quartile values are calculated by splitting the list and
  /// by getting the median values.
  ///* `exclusive` - The quartile values are calculated by using the formula
  /// (N+1) * P (N count, P percentile), and their index value starts
  /// from 1 in the list.
  /// * `inclusive` - The quartile values are calculated by using the formula
  /// (N−1) * P (N count, P percentile), and their index value starts
  /// from 0 in the list.
  ///
  ///Also refer [BoxPlotMode].
  ///
  ///Defaults to `BoxPlotMode.normal`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <BoxAndWhiskerSeries<SalesData, num>>[
  ///                BoxAndWhiskerSeries<SalesData, num>(
  ///                  boxPlotMode: BoxPlotMode.normal
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final BoxPlotMode boxPlotMode;

  ///Indication for mean value in box plot.
  ///
  ///If [showMean] property value is set to true, a cross symbol will be
  ///displayed at the mean value, for each data point in box plot. Else,
  ///it will not be displayed.
  ///
  ///Defaults to `true`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <BoxAndWhiskerSeries<SalesData, num>>[
  ///                BoxAndWhiskerSeries<SalesData, num>(
  ///                  showMean: true
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final bool showMean;

  ///Spacing between the box plots.
  ///
  ///The value ranges from 0 to 1, where 1 represents 100% and 0 represents 0%
  ///of the available space.
  ///
  ///Spacing affects the width of the box plots. For example, setting 20%
  ///spacing and 100% width renders the box plots with 80% of total width.
  ///
  ///Also refer [CartesianSeries.width].
  ///
  ///Defaults to `0`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <BoxAndWhiskerSeries<SalesData, num>>[
  ///                BoxAndWhiskerSeries<SalesData, num>(
  ///                  spacing: 0,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double spacing;

  /// Create the Box and Whisker series renderer.
  BoxAndWhiskerSeriesRenderer createRenderer(ChartSeries<T, D> series) {
    BoxAndWhiskerSeriesRenderer seriesRenderer;
    if (onCreateRenderer != null) {
      seriesRenderer = onCreateRenderer!(series) as BoxAndWhiskerSeriesRenderer;
      return seriesRenderer;
    }
    return BoxAndWhiskerSeriesRenderer();
  }
}

class _BoxPlotQuartileValues {
  _BoxPlotQuartileValues(
      {this.minimum,
      this.maximum,
      //ignore: unused_element
      List<num>? outliers,
      this.upperQuartile,
      this.lowerQuartile,
      this.average,
      this.median,
      this.mean});
  num? minimum;
  num? maximum;
  List<num> outliers = <num>[];
  num? upperQuartile;
  num? lowerQuartile;
  num? average;
  num? median;
  num? mean;
}

/// Creates series renderer for Box and Whisker series
class BoxAndWhiskerSeriesRenderer extends XyDataSeriesRenderer {
  /// Calling the default constructor of BoxAndWhiskerSeriesRenderer class.
  BoxAndWhiskerSeriesRenderer();

  num? _rectPosition;

  num? _rectCount;

  BoxAndWhiskerSegment? _segment;

  List<CartesianSeriesRenderer?>? _oldSeriesRenderers;

  _BoxPlotQuartileValues? _boxPlotQuartileValues;

  /// To find the minimum, maximum, quartile and median value
  /// of a box plot series.
  void _findBoxPlotValues(
      List<num> yValues, CartesianChartPoint<dynamic> point, BoxPlotMode mode) {
    final num yCount = yValues.length;
    _boxPlotQuartileValues = _BoxPlotQuartileValues();
    _boxPlotQuartileValues!.average =
        (yValues.fold(0, (dynamic x, y) => x + y)) / yCount;
    if (mode == BoxPlotMode.exclusive) {
      _boxPlotQuartileValues!.lowerQuartile =
          _getExclusiveQuartileValue(yValues, yCount, 0.25);
      _boxPlotQuartileValues!.upperQuartile =
          _getExclusiveQuartileValue(yValues, yCount, 0.75);
      _boxPlotQuartileValues!.median =
          _getExclusiveQuartileValue(yValues, yCount, 0.5);
    } else if (mode == BoxPlotMode.inclusive) {
      _boxPlotQuartileValues!.lowerQuartile =
          _getInclusiveQuartileValue(yValues, yCount, 0.25);
      _boxPlotQuartileValues!.upperQuartile =
          _getInclusiveQuartileValue(yValues, yCount, 0.75);
      _boxPlotQuartileValues!.median =
          _getInclusiveQuartileValue(yValues, yCount, 0.5);
    } else {
      _boxPlotQuartileValues!.median = _getMedian(yValues);
      _getQuartileValues(yValues, yCount, _boxPlotQuartileValues);
    }
    _getMinMaxOutlier(yValues, yCount, _boxPlotQuartileValues!);
    point.minimum = _boxPlotQuartileValues!.minimum;
    point.maximum = _boxPlotQuartileValues!.maximum;
    point.lowerQuartile = _boxPlotQuartileValues!.lowerQuartile;
    point.upperQuartile = _boxPlotQuartileValues!.upperQuartile;
    point.median = _boxPlotQuartileValues!.median;
    point.outliers = _boxPlotQuartileValues!.outliers;
    point.mean = _boxPlotQuartileValues!.average;
  }

  /// To find exclusive quartile values.
  num _getExclusiveQuartileValue(List<num> yValues, num count, num percentile) {
    if (count == 0) {
      return 0;
    } else if (count == 1) {
      return yValues[0];
    }
    num value = 0;
    final num rank = percentile * (count + 1);
    final num integerRank = (rank.abs()).floor();
    final num fractionRank = rank - integerRank;
    if (integerRank == 0) {
      value = yValues[0];
    } else if (integerRank > count - 1) {
      value = yValues[count - 1 as int];
    } else {
      value = fractionRank *
              (yValues[integerRank as int] - yValues[integerRank - 1]) +
          yValues[integerRank - 1];
    }
    return value;
  }

  /// To find inclusive quartile values.
  num _getInclusiveQuartileValue(List<num> yValues, num count, num percentile) {
    if (count == 0) {
      return 0;
    } else if (count == 1) {
      return yValues[0];
    }
    num value = 0;
    final num rank = percentile * (count - 1);
    final num integerRank = (rank.abs()).floor();
    final num fractionRank = rank - integerRank;
    value = fractionRank *
            (yValues[integerRank + 1 as int] - yValues[integerRank as int]) +
        yValues[integerRank];
    return value;
  }

  /// To find a midian value of each box plot point.
  num _getMedian(List<num> values) {
    final num half = (values.length / 2).floor();
    return values.length % 2 != 0
        ? values[half as int]
        : ((values[half - 1 as int] + values[half as int]) / 2.0);
  }

  /// To get the quartile values.
  void _getQuartileValues(dynamic yValues, num count,
      _BoxPlotQuartileValues? _boxPlotQuartileValues) {
    if (count == 1) {
      _boxPlotQuartileValues!.lowerQuartile = yValues[0];
      _boxPlotQuartileValues.upperQuartile = yValues[0];
      return;
    }
    final bool isEvenList = count % 2 == 0;
    final num halfLength = count ~/ 2;
    final List<num> lowerQuartileArray = yValues.sublist(0, halfLength);
    final List<num> upperQuartileArray =
        yValues.sublist(isEvenList ? halfLength : halfLength + 1, count);
    _boxPlotQuartileValues!.lowerQuartile = _getMedian(lowerQuartileArray);
    _boxPlotQuartileValues.upperQuartile = _getMedian(upperQuartileArray);
  }

  /// To get the outliers values of box plot series.
  void _getMinMaxOutlier(List<num> yValues, num count,
      _BoxPlotQuartileValues _boxPlotQuartileValues) {
    final num interquartile = _boxPlotQuartileValues.upperQuartile! -
        _boxPlotQuartileValues.lowerQuartile!;
    final num rangeIQR = 1.5 * interquartile;
    for (int i = 0; i < count; i++) {
      if (yValues[i] < _boxPlotQuartileValues.lowerQuartile! - rangeIQR) {
        _boxPlotQuartileValues.outliers.add(yValues[i]);
      } else {
        _boxPlotQuartileValues.minimum = yValues[i];
        break;
      }
    }
    for (int i = count - 1 as int; i >= 0; i--) {
      if (yValues[i] > _boxPlotQuartileValues.upperQuartile! + rangeIQR) {
        _boxPlotQuartileValues.outliers.add(yValues[i]);
      } else {
        _boxPlotQuartileValues.maximum = yValues[i];
        break;
      }
    }
  }

  /// Range box plot _segment is created here
  ChartSegment? _createSegments(CartesianChartPoint<dynamic>? currentPoint,
      int pointIndex, int? seriesIndex, num animateFactor) {
    _segment = createSegment() as BoxAndWhiskerSegment?;
    _oldSeriesRenderers = _chartState!._oldSeriesRenderers;
    _isRectSeries = false;
    if (_segment != null) {
      _segment!._seriesIndex = seriesIndex;
      _segment!.currentSegmentIndex = pointIndex;
      _segment!._seriesRenderer = this;
      _segment!._series = _series as XyDataSeries<dynamic, dynamic>?;
      _segment!.animationFactor = animateFactor as double?;
      _segment!._pointColorMapper = currentPoint!.pointColorMapper;
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
      }
      _segment!.calculateSegmentPoints();
      //stores the points for rendering box and whisker - high, low and rect points
      _segment!.points!
        ..add(Offset(currentPoint.markerPoint!.x as double,
            _segment!._maxPoint!.y as double))
        ..add(Offset(currentPoint.markerPoint!.x as double,
            _segment!._minPoint!.y as double))
        ..add(
            Offset(_segment!._lowerX as double, _segment!._topRectY as double))
        ..add(
            Offset(_segment!._upperX as double, _segment!._topRectY as double))
        ..add(Offset(
            _segment!._upperX as double, _segment!._bottomRectY as double))
        ..add(Offset(
            _segment!._lowerX as double, _segment!._bottomRectY as double));
      customizeSegment(_segment!);
      _segment!.strokePaint = _segment!.getStrokePaint();
      _segment!.fillPaint = _segment!.getFillPaint();
      _segments.add(_segment);
    }
    return _segment;
  }

  @override
  ChartSegment createSegment() => BoxAndWhiskerSegment();

  /// Changes the series color, border color, and border width.
  @override
  void customizeSegment(ChartSegment _segment) {
    final BoxAndWhiskerSegment boxSegment = _segment as BoxAndWhiskerSegment;
    boxSegment._color = boxSegment._currentPoint!.pointColorMapper ??
        _segment._seriesRenderer!._seriesColor;
    boxSegment._strokeColor = _segment._series!.borderColor;
    boxSegment._strokeWidth = _segment._series!.borderWidth;
    boxSegment.strokePaint = boxSegment.getStrokePaint();
    boxSegment.fillPaint = boxSegment.getFillPaint();
  }

  /// To draw box plot series segments
  //ignore: unused_element
  void _drawSegment(Canvas canvas, ChartSegment _segment) {
    if (_segment._seriesRenderer!._isSelectionEnable) {
      final SelectionBehaviorRenderer selectionBehaviorRenderer =
          _segment._seriesRenderer!._selectionBehaviorRenderer!;
      selectionBehaviorRenderer._selectionRenderer!._checkWithSelectionState(
          _segments[_segment.currentSegmentIndex!], _chart);
    }
    _segment.onPaint(canvas);
  }

  ///Draws outlier with different shape and color of the appropriate
  ///data point in the series.
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
