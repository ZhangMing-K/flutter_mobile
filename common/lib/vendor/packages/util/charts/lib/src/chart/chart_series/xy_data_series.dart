part of charts;

/// Renders the xy series.
///
/// Cartesian charts uses two axis namely x and y, to render.
abstract class XyDataSeries<T, D> extends CartesianSeries<T, D> {
  /// Creating an argument constructor of XyDataSeries class.
  XyDataSeries(
      {ValueKey<String>? key,
      ChartSeriesRendererFactory<T, D>? onCreateRenderer,
      SeriesRendererCreatedCallback? onRendererCreated,
      ChartValueMapper<T, D>? xValueMapper,
      ChartValueMapper<T, dynamic>? yValueMapper,
      ChartValueMapper<T, String>? dataLabelMapper,
      String? name,
      required List<T>? dataSource,
      String? xAxisName,
      String? yAxisName,
      ChartValueMapper<T, Color>? pointColorMapper,
      String? legendItemText,
      ChartValueMapper<T, dynamic>? sortFieldValueMapper,
      LinearGradient? gradient,
      LinearGradient? borderGradient,
      ChartValueMapper<T, num>? sizeValueMapper,
      ChartValueMapper<T, num>? highValueMapper,
      ChartValueMapper<T, num>? lowValueMapper,
      ChartValueMapper<T, bool>? intermediateSumPredicate,
      ChartValueMapper<T, bool>? totalSumPredicate,
      List<Trendline>? trendlines,
      double? width,
      MarkerSettings? markerSettings,
      bool? isVisible,
      bool? enableTooltip,
      EmptyPointSettings? emptyPointSettings,
      DataLabelSettings? dataLabelSettings,
      double? animationDuration,
      List<double>? dashArray,
      Color? borderColor,
      double? borderWidth,
      // ignore: deprecated_member_use_from_same_package
      SelectionSettings? selectionSettings,
      SelectionBehavior? selectionBehavior,
      bool? isVisibleInLegend,
      LegendIconType? legendIconType,
      double? opacity,
      Color? color,
      List<int>? initialSelectedDataIndexes,
      SortingOrder? sortingOrder})
      : super(
            key: key,
            onRendererCreated: onRendererCreated,
            onCreateRenderer: onCreateRenderer,
            isVisible: isVisible,
            legendItemText: legendItemText,
            xAxisName: xAxisName,
            dashArray: dashArray,
            isVisibleInLegend: isVisibleInLegend,
            borderColor: borderColor,
            trendlines: trendlines,
            borderWidth: borderWidth,
            yAxisName: yAxisName,
            color: color,
            name: name,
            width: width,
            xValueMapper: (int index) =>
                xValueMapper!(dataSource![index], index),
            yValueMapper: (int index) =>
                yValueMapper!(dataSource![index], index),
            sortFieldValueMapper: sortFieldValueMapper != null
                ? (int index) => sortFieldValueMapper(dataSource![index], index)
                : null,
            pointColorMapper: pointColorMapper != null
                ? (int index) => pointColorMapper(dataSource![index], index)
                : null,
            dataLabelMapper: dataLabelMapper != null
                ? (int index) => dataLabelMapper(dataSource![index], index)
                : null,
            sizeValueMapper: sizeValueMapper != null
                ? (int index) => sizeValueMapper(dataSource![index], index)
                : null,
            highValueMapper: highValueMapper != null
                ? (int index) => highValueMapper(dataSource![index], index)
                : null,
            lowValueMapper: lowValueMapper != null
                ? (int index) => lowValueMapper(dataSource![index], index)
                : null,
            intermediateSumPredicate: intermediateSumPredicate != null
                ? (int index) =>
                    intermediateSumPredicate(dataSource![index], index)
                : null,
            totalSumPredicate: totalSumPredicate != null
                ? (int index) => totalSumPredicate(dataSource![index], index)
                : null,
            dataSource: dataSource,
            emptyPointSettings: emptyPointSettings,
            dataLabelSettings: dataLabelSettings,
            enableTooltip: enableTooltip,
            animationDuration: animationDuration,
            selectionSettings: selectionSettings,
            selectionBehavior: selectionBehavior,
            legendIconType: legendIconType,
            sortingOrder: sortingOrder,
            opacity: opacity,
            gradient: gradient,
            borderGradient: borderGradient,
            markerSettings: markerSettings,
            initialSelectedDataIndexes: initialSelectedDataIndexes);
}

/// Returns the widget.
typedef ChartDataLabelTemplateBuilder<T> = Widget Function(
    T data, CartesianChartPoint<dynamic> point, int pointIndex,
    {int? seriesIndex, CartesianSeries<dynamic, dynamic>? series});

/// This class has the properties of CartesianChartPoint.
///
/// Chart point is a class that is used to store the current x and y values from the datasource.
/// Contains x and y coordinates which are converted from the x and y values.
///
class CartesianChartPoint<D> {
  /// Creating an argument constructor of CartesianChartPoint class.
  CartesianChartPoint(
      [this.x,
      this.y,
      this.dataLabelMapper,
      this.pointColorMapper,
      this.bubbleSize,
      this.high,
      this.low,
      this.open,
      this.close,
      this.volume,
      this.sortValue,
      this.minimum,
      this.maximum,
      this.isIntermediateSum,
      this.isTotalSum,
      this.maxYValue,
      this.outliers,
      this.upperQuartile,
      this.lowerQuartile,
      this.mean,
      this.median,
      this.originValue,
      this.endValue]) {
    x = x;
    y = y;
    sortValue = sortValue;
    markerPoint = markerPoint;
    isEmpty = isEmpty;
    isGap = isGap;
    isVisible = isVisible;
    bubbleSize = bubbleSize;
    pointColorMapper = pointColorMapper;
    dataLabelMapper = dataLabelMapper;
    high = high;
    low = low;
    open = open;
    close = close;
    markerPoint2 = markerPoint2;
    volume = volume;
    minimum = minimum;
    maximum = maximum;
    outliers = outliers;
    upperQuartile = upperQuartile;
    lowerQuartile = lowerQuartile;
    mean = mean;
    median = median;
    isIntermediateSum = isIntermediateSum;
    isTotalSum = isTotalSum;
    originValue = originValue;
    endValue = endValue;
    maxYValue = maxYValue;
  }

  /// X value of the point.
  D? x;

  /// Y value of the point
  D? y;

  /// Stores the xValues of the point
  D? xValue;

  /// Stores the yValues of the Point
  D? yValue;

  /// Sort value of the point.
  D? sortValue;

  /// High value of the point.
  D? high;

  /// Low value of the point.
  D? low;

  /// Open value of the point.
  D? open;

  /// Close value of the point
  D? close;

  /// Volume value of the point
  num? volume;

  /// Marker point location.
  _ChartLocation? markerPoint;

  /// second Marker point location.
  _ChartLocation? markerPoint2;

  /// Size of the bubble.
  num? bubbleSize;

  /// To set empty value
  bool? isEmpty;

  /// To set gap value
  bool isGap = false;

  /// To set the drop value
  bool isDrop = false;

  /// Set the visibility of the series.
  bool isVisible = true;

  /// Used to map the color value from data point.
  Color? pointColorMapper;

  /// Map the datalabel value from data point.
  String? dataLabelMapper;

  /// Store the region.
  Rect? region;

  /// Store the region for box series rect.
  Rect? boxRectRegion;

  /// Store the outliers region.
  List<Rect>? outlierRegion;

  /// Store the outliers region.
  List<dynamic>? outlierRegionPosition;

  /// Minimum value of box plot series.
  num? minimum;

  /// Maximum value of box plot series.
  num? maximum;

  /// Outlier values of box plot series.
  List<num>? outliers = <num>[];

  /// Upper quartile values of box plot series.
  num? upperQuartile;

  /// Lower quartile values of box plot series.
  num? lowerQuartile;

  /// Average value of the given data source in box plot series.
  num? mean;

  /// Median value of the given data source in box plot series.
  num? median;

  /// The intermediate sum value of the waterfall series.
  bool? isIntermediateSum;

  /// The total sum value of the waterfall series.
  bool? isTotalSum;

  /// The end value of each data point in the waterfall series.
  num? endValue;

  /// The Origin value of each data point in waterfall series.
  num? originValue;

  /// To find the maximum Y value in the waterfall series.
  num? maxYValue = 0;

  /// To execute OnDataLabelRender event or not.
  // ignore: prefer_final_fields
  bool labelRenderEvent = false;

  /// To execute onTooltipRender event or not.
  // ignore: prefer_final_fields
  bool isTooltipRenderEvent = false;

  /// Stores the chart location.
  _ChartLocation? openPoint,
      closePoint,
      centerOpenPoint,
      centerClosePoint,
      lowPoint,
      highPoint,
      centerLowPoint,
      centerHighPoint,
      currentPoint,
      _nextPoint,
      _midPoint,
      startControl,
      endControl,
      highStartControl,
      highEndControl,
      lowStartControl,
      lowEndControl,
      minimumPoint,
      maximumPoint,
      lowerQuartilePoint,
      upperQuartilePoint,
      centerMinimumPoint,
      centerMaximumPoint,
      medianPoint,
      centerMedianPoint,
      centerMeanPoint,
      originValueLeftPoint,
      originValueRightPoint,
      endValueLeftPoint,
      endValueRightPoint;

  /// Stores the outliers location.
  List<_ChartLocation> outliersPoint = <_ChartLocation>[];

  /// control points for spline series.
  List<_ControlPoints>? controlPoint;

  /// control points for spline range area series.
  List<_ControlPoints>? controlPointshigh;

  /// control points for spline range area series.
  List<_ControlPoints>? controlPointslow;

  /// Store the visible range.
  _VisibleRange? sideBySideInfo;

  /// Store the List of region.
  List<Rect>? regions;

  /// store the cumulative value.
  double? cumulativeValue;

  /// Stores the tracker rect region
  late Rect trackerRectRegion;

  /// Stores the forth data label text
  String? label;

  /// Stores the forth data label text
  String? label2;

  /// Stores the forth data label text
  String? label3;

  /// Stores the forth data label text
  String? label4;

  /// Stores the median data label text
  String? label5;

  /// Stores the outliers data label text
  List<String?> outliersLabel = <String?>[];

  /// Stores the forth data label Rect
  RRect? labelFillRect;

  /// Stores the forth data label Rect
  RRect? labelFillRect2;

  /// Stores the forth data label Rect
  RRect? labelFillRect3;

  /// Stores the forth data label Rect
  RRect? labelFillRect4;

  /// Stores the median data label Rect
  RRect? labelFillRect5;

  /// Stores the outliers data label Rect
  List<RRect> outliersFillRect = <RRect>[];

  /// Stores the data label location
  late _ChartLocation labelLocation;

  /// Stores the second data label location
  late _ChartLocation labelLocation2;

  /// Stores the third data label location
  late _ChartLocation labelLocation3;

  /// Stores the forth data label location
  late _ChartLocation labelLocation4;

  /// Stores the median data label location
  _ChartLocation? labelLocation5;

  /// Stores the outliers data label location
  List<_ChartLocation> outliersLocation = <_ChartLocation>[];

  /// Data label region saturation.
  bool dataLabelSaturationRegionInside = false;

  /// Stores the data label region
  late Rect dataLabelRegion;

  /// Stores the second data label region
  Rect? dataLabelRegion2;

  /// Stores the third data label region
  Rect? dataLabelRegion3;

  /// Stores the forth data label region
  Rect? dataLabelRegion4;

  /// Stores the median data label region
  Rect? dataLabelRegion5;

  /// Stores the outliers data label region
  List<Rect> outliersDataLabelRegion = <Rect>[];

  /// Stores the data point index
  int? index;

  /// Stores the data index
  int? overallDataPointIndex;

  /// Store the region data of the data point.
  List<String?>? regionData;
}

class _ChartLocation {
  _ChartLocation(this.x, this.y);
  num? x;
  num? y;
}

/// To calculate dash array path for series
Path? _dashPath(
  Path? source, {
  required _CircularIntervalList<double> dashArray,
}) {
  if (source == null) {
    return null;
  }
  const double intialValue = 0.0;
  final Path path = Path();
  for (final PathMetric measurePath in source.computeMetrics()) {
    double distance = intialValue;
    bool draw = true;
    while (distance < measurePath.length) {
      final double length = dashArray.next;
      if (draw) {
        path.addPath(
            measurePath.extractPath(distance, distance + length), Offset.zero);
      }
      distance += length;
      draw = !draw;
    }
  }
  return path;
}

/// A circular array for dash offsets and lengths.
class _CircularIntervalList<T> {
  _CircularIntervalList(this._values);
  final List<T>? _values;
  int _index = 0;
  T get next {
    if (_index >= _values!.length) {
      _index = 0;
    }
    return _values![_index++];
  }
}

/// Creates series renderer for Xy data series
abstract class XyDataSeriesRenderer extends CartesianSeriesRenderer {
  /// To calculate empty point value for the specific mode
  @override
  void calculateEmptyPointValue(
      int pointIndex, CartesianChartPoint<dynamic>? currentPoint,
      [CartesianSeriesRenderer? seriesRenderer]) {
    final int pointLength = seriesRenderer!._dataPoints!.length - 1;
    final String _seriesType = seriesRenderer._seriesType!;
    final CartesianChartPoint<dynamic>? prevPoint = seriesRenderer._dataPoints![
        seriesRenderer._dataPoints!.length >= 2
            ? pointLength - 1
            : pointLength];
    if (_seriesType.contains('range') ||
            _seriesType.contains('hilo') ||
            _seriesType == 'candle'
        ? _seriesType == 'hiloopenclose' || _seriesType == 'candle'
            ? (currentPoint!.low == null ||
                currentPoint.high == null ||
                currentPoint.open == null ||
                currentPoint.close == null)
            : (currentPoint!.low == null || currentPoint.high == null)
        : currentPoint!.y == null) {
      switch (seriesRenderer._series!.emptyPointSettings.mode) {
        case EmptyPointMode.zero:
          currentPoint.isEmpty = true;
          if (_seriesType.contains('range') ||
              _seriesType.contains('hilo') ||
              _seriesType.contains('candle')) {
            currentPoint.high = 0;
            currentPoint.low = 0;
            if (_seriesType == 'hiloopenclose' || _seriesType == 'candle') {
              currentPoint.open = 0;
              currentPoint.close = 0;
            }
          } else {
            currentPoint.y = 0;
          }
          break;

        case EmptyPointMode.average:
          if (seriesRenderer is XyDataSeriesRenderer) {
            _calculateAverageModeValue(
                pointIndex, pointLength, currentPoint, prevPoint);
          }
          currentPoint.isEmpty = true;
          break;

        case EmptyPointMode.gap:
          if (_seriesType == 'scatter' ||
              _seriesType == 'column' ||
              _seriesType == 'bar' ||
              _seriesType == 'bubble' ||
              _seriesType == 'splinearea' ||
              _seriesType == 'rangecolumn' ||
              _seriesType.contains('hilo') ||
              _seriesType.contains('candle') ||
              _seriesType == 'rangearea' ||
              _seriesType.contains('stacked')) {
            currentPoint.y = pointIndex != 0 &&
                    (!_seriesType.contains('stackedcolumn') &&
                        !_seriesType.contains('stackedbar'))
                ? prevPoint!.y
                : 0;
            currentPoint.open = 0;
            currentPoint.close = 0;
            currentPoint.isVisible = false;
          } else if (_seriesType.contains('line') ||
              _seriesType == 'area' ||
              _seriesType == 'steparea') {
            if (_seriesType == 'splinerangearea') {
              // ignore: prefer_if_null_operators
              currentPoint.low = currentPoint.low == null
                  ? pointIndex != 0
                      ? prevPoint!.low ?? 0
                      : 0
                  : currentPoint.low;
              // ignore: prefer_if_null_operators
              currentPoint.high = currentPoint.high == null
                  ? pointIndex != 0
                      ? prevPoint!.high ?? 0
                      : 0
                  : currentPoint.high;
            } else {
              currentPoint.y = pointIndex != 0 ? prevPoint!.y : 0;
            }
          }
          currentPoint.isGap = true;
          break;
        case EmptyPointMode.drop:
          if (_seriesType == 'splinerangearea') {
            // ignore: prefer_if_null_operators
            currentPoint.low = currentPoint.low == null
                ? pointIndex != 0
                    ? prevPoint!.low ?? 0
                    : 0
                : currentPoint.low;
            // ignore: prefer_if_null_operators
            currentPoint.high = currentPoint.high == null
                ? pointIndex != 0
                    ? prevPoint!.high ?? 0
                    : 0
                : currentPoint.high;
          }
          currentPoint.y = pointIndex != 0 &&
                  (_seriesType != 'area' &&
                      _seriesType != 'splinearea' &&
                      _seriesType != 'splinerangearea' &&
                      _seriesType != 'steparea' &&
                      !_seriesType.contains('stackedcolumn') &&
                      !_seriesType.contains('stackedbar'))
              ? prevPoint!.y
              : 0;
          currentPoint.isDrop = true;
          currentPoint.isVisible = false;
          break;
        default:
          currentPoint.y = 0;
          break;
      }
    }
  }

  /// To render a series of elements for all series
  void _renderSeriesElements(SfCartesianChart chart, Canvas canvas,
      Animation<double>? animationController) {
    _markerShapes = <Path>[];
    _markerShapes2 = <Path>[];
    assert(
        _series!.markerSettings.height != null
            ? _series!.markerSettings.height >= 0
            : true,
        'The height of the marker should be greater than or equal to 0.');
    assert(
        _series!.markerSettings.width != null
            ? _series!.markerSettings.width >= 0
            : true,
        'The width of the marker must be greater than or equal to 0.');
    for (int pointIndex = 0; pointIndex < _dataPoints!.length; pointIndex++) {
      final CartesianChartPoint<dynamic>? point = _dataPoints![pointIndex];
      if ((_series!.markerSettings.isVisible &&
              this is! BoxAndWhiskerSeriesRenderer) ||
          this is ScatterSeriesRenderer) {
        final MarkerSettingsRenderer? markerSettingsRenderer =
            _markerSettingsRenderer;
        markerSettingsRenderer?.renderMarker(
            this, point, animationController, canvas, pointIndex);
      }
    }
  }

  void _repaintSeriesElement() {
    _repaintNotifier!.value++;
  }

  void _animationStatusListener(AnimationStatus status) {
    if (_chartState != null && status == AnimationStatus.completed) {
      _reAnimate = false;
      _chartState!._animationCompleteCount =
          _chartState!._animationCompleteCount! + 1;
      _setAnimationStatus(_chartState);
    } else if (_chartState != null && status == AnimationStatus.forward) {
      _chartState?._animateCompleted = false;
    }
  }

  /// To store the series properties
  void _storeSeriesProperties(SfCartesianChartState chartState, int? index) {
    _chartState = chartState;
    _chart = chartState._chart;
    _isRectSeries = _seriesType!.contains('column') ||
        _seriesType!.contains('bar') ||
        _seriesType == 'histogram';
    _regionalData = <dynamic, dynamic>{};
    _segmentPath = Path();
    _segments = <ChartSegment?>[];
    _seriesColor =
        _series!.color ?? _chart!.palette[index! % _chart!.palette.length];

    // calculates the tooltip region for trenlines in this series
    final List<Trendline>? trendlines = _series!.trendlines;
    if (trendlines != null && _chart!.tooltipBehavior.enable) {
      for (int j = 0; j < trendlines.length; j++) {
        if (_trendlineRenderer[j]._isNeedRender) {
          if (_trendlineRenderer[j]._pointsData != null) {
            for (int k = 0;
                k < _trendlineRenderer[j]._pointsData!.length;
                k++) {
              final CartesianChartPoint<dynamic>? trendlinePoint =
                  _trendlineRenderer[j]._pointsData![k];
              _calculateTooltipRegion(trendlinePoint, index, this, _chartState!,
                  trendlines[j], _trendlineRenderer[j], j);
            }
          }
        }
      }
    }
  }

  /// To find the region data of a series
  void _calculateRegionData(
      SfCartesianChartState _chartState,
      CartesianSeriesRenderer? seriesRenderer,
      int? seriesIndex,
      CartesianChartPoint<dynamic>? point,
      int pointIndex,
      [_VisibleRange? sideBySideInfo,
      CartesianChartPoint<dynamic>? _nextPoint,
      num? midX,
      num? midY]) {
    _chart = _chartState._chart;
    final ChartAxis xAxis = _xAxisRenderer!._axis;
    final ChartAxis yAxis = _yAxisRenderer!._axis;
    final Rect rect = _calculatePlotOffset(
        _chartState._chartAxis!._axisClipRect!,
        Offset(xAxis.plotOffset, yAxis.plotOffset));
    _isRectSeries = _seriesType == 'column' ||
        _seriesType == 'bar' ||
        _seriesType!.contains('stackedcolumn') ||
        _seriesType!.contains('stackedbar') ||
        _seriesType == 'rangecolumn' ||
        _seriesType == 'histogram' ||
        _seriesType == 'waterfall';
    CartesianChartPoint<dynamic>? point;
    final num markerHeight = _series!.markerSettings.height,
        markerWidth = _series!.markerSettings.width;
    final bool isPointSeries =
        _seriesType == 'scatter' || _seriesType == 'bubble';
    final bool isFastLine = _seriesType == 'fastline';
    if ((!isFastLine ||
            (isFastLine &&
                (_series!.markerSettings.isVisible ||
                    _series!.dataLabelSettings.isVisible ||
                    _series!.enableTooltip))) &&
        _visible!) {
      point = _dataPoints![pointIndex];
      if (point!.region == null ||
          _seriesType!.contains('stackedcolumn') ||
          _seriesType!.contains('stackedbar')) {
        if (_isRectSeries) {
          _calculateRectSeriesRegion(point, pointIndex, this, _chartState);
        } else if (isPointSeries) {
          _calculatePointSeriesRegion(
              point, pointIndex, this, _chartState, rect);
        } else {
          _calculatePathSeriesRegion(
              point,
              pointIndex,
              this,
              _chartState,
              rect,
              markerHeight,
              markerWidth,
              sideBySideInfo,
              _nextPoint,
              midX,
              midY);
        }
      }
      if (_chart!.tooltipBehavior.enable && _seriesType != 'boxandwhisker') {
        _calculateTooltipRegion(point, seriesIndex, this, _chartState);
      }
    }
  }

  /// To find the region data of chart tooltip
  void calculateTooltipRegion(SfCartesianChart chart, int seriesIndex,
      CartesianChartPoint<dynamic> point, int pointIndex) {
    /// For tooltip implementation
    if (_series!.enableTooltip && !point.isGap && !point.isDrop) {
      final List<String> regionData = <String>[];
      String? date;
      final List<dynamic> regionRect = <dynamic>[];
      final dynamic primaryAxisRenderer = _xAxisRenderer;
      if (primaryAxisRenderer is DateTimeAxisRenderer) {
        final DateTimeAxis _axis = primaryAxisRenderer._axis as DateTimeAxis;
        final DateFormat dateFormat = _axis.dateFormat ??
            primaryAxisRenderer
                ._getLabelFormat(_xAxisRenderer as DateTimeAxisRenderer)!;
        date = dateFormat
            .format(DateTime.fromMillisecondsSinceEpoch(point.xValue));
      }
      _xAxisRenderer is CategoryAxisRenderer
          ? regionData.add(point.x.toString())
          : _xAxisRenderer is DateTimeAxisRenderer
              ? regionData.add(date.toString())
              : regionData.add(_getLabelValue(
                      point.xValue,
                      _xAxisRenderer!._axis,
                      chart.tooltipBehavior.decimalPlaces)
                  .toString());
      if (_seriesType!.contains('range')) {
        regionData.add(_getLabelValue(point.high, _yAxisRenderer!._axis,
                chart.tooltipBehavior.decimalPlaces)
            .toString());
        regionData.add(_getLabelValue(point.low, _yAxisRenderer!._axis,
                chart.tooltipBehavior.decimalPlaces)
            .toString());
      } else {
        regionData.add(_getLabelValue(point.yValue, _yAxisRenderer!._axis,
                chart.tooltipBehavior.decimalPlaces)
            .toString());
      }
      regionData.add(_series!.name ?? 'series $seriesIndex');
      regionRect.add(point.region);
      regionRect.add(_isRectSeries
          ? _seriesType == 'column' || _seriesType!.contains('stackedcolumn')
              ? point.yValue > 0
                  ? point.region!.topCenter
                  : point.region!.bottomCenter
              : point.region!.topCenter
          : (_seriesType == 'rangearea'
              ? Offset(point.markerPoint!.x as double,
                  (point.markerPoint!.y! + point.markerPoint2!.y!) / 2)
              : point.region!.center));
      regionRect.add(point.pointColorMapper);
      regionRect.add(point.bubbleSize);
      if (_seriesType!.contains('stacked')) {
        regionData.add((point.cumulativeValue).toString());
      }
      _regionalData![regionRect] = regionData;
    }
  }

  /// To calculate the empty point average mode value
  void _calculateAverageModeValue(
      int pointIndex,
      int pointLength,
      CartesianChartPoint<dynamic>? currentPoint,
      CartesianChartPoint<dynamic>? prevPoint) {
    final List<dynamic> dataSource = _series!.dataSource!;
    final CartesianChartPoint<dynamic> _nextPoint = _getPointFromData(
        this,
        pointLength < dataSource.length - 1
            ? dataSource.indexOf(dataSource[pointLength + 1])
            : dataSource.indexOf(dataSource[pointLength]));
    if (_seriesType!.contains('range') ||
        _seriesType!.contains('hilo') ||
        _seriesType!.contains('candle')) {
      final CartesianSeries<dynamic, dynamic>? _cartesianSeries = _series;
      if (_cartesianSeries is _FinancialSeriesBase &&
          _cartesianSeries.showIndicationForSameValues) {
        if (currentPoint!.low != null || currentPoint.high != null) {
          currentPoint.low = currentPoint.low ?? currentPoint.high;
          currentPoint.high = currentPoint.high ?? currentPoint.low;
        } else {
          currentPoint.low = 0;
          currentPoint.high = 0;
          currentPoint.open = 0;
          currentPoint.close = 0;
          currentPoint.isGap = true;
        }
        if (_seriesType == 'hiloopenclose' || _seriesType == 'candle') {
          if (currentPoint.open != null || currentPoint.close != null) {
            currentPoint.open = currentPoint.open ?? currentPoint.close;
            currentPoint.close = currentPoint.close ?? currentPoint.open;
          } else {
            currentPoint.low = 0;
            currentPoint.high = 0;
            currentPoint.open = 0;
            currentPoint.close = 0;
            currentPoint.isGap = true;
          }
        }
      } else {
        if (pointIndex == 0) {
          if (currentPoint!.low == null) {
            pointIndex == dataSource.length - 1
                ? currentPoint.low = 0
                : currentPoint.low = ((_nextPoint.low) ?? 0) / 2;
          }
          if (currentPoint.high == null) {
            pointIndex == dataSource.length - 1
                ? currentPoint.high = 0
                : currentPoint.high = ((_nextPoint.high) ?? 0) / 2;
          }
          if (_seriesType == 'hiloopenclose' || _seriesType == 'candle') {
            if (currentPoint.open == null) {
              pointIndex == dataSource.length - 1
                  ? currentPoint.open = 0
                  : currentPoint.open = ((_nextPoint.open) ?? 0) / 2;
            }
            if (currentPoint.close == null) {
              pointIndex == dataSource.length - 1
                  ? currentPoint.close = 0
                  : currentPoint.close = ((_nextPoint.close) ?? 0) / 2;
            }
          }
        } else if (pointIndex == dataSource.length - 1) {
          currentPoint!.low = currentPoint.low ?? ((prevPoint!.low) ?? 0) / 2;
          currentPoint.high = currentPoint.high ?? ((prevPoint!.high) ?? 0) / 2;

          if (_seriesType == 'hiloopenclose' || _seriesType == 'candle') {
            currentPoint.open =
                currentPoint.open ?? ((prevPoint!.open) ?? 0) / 2;
            currentPoint.close =
                currentPoint.close ?? ((prevPoint!.close) ?? 0) / 2;
          }
        } else {
          currentPoint!.low = currentPoint.low ??
              (((prevPoint!.low) ?? 0) + ((_nextPoint.low) ?? 0)) / 2;
          currentPoint.high = currentPoint.high ??
              (((prevPoint!.high) ?? 0) + ((_nextPoint.high) ?? 0)) / 2;

          if (_seriesType == 'hiloopenclose' || _seriesType == 'candle') {
            currentPoint.open = currentPoint.open ??
                (((prevPoint!.open) ?? 0) + ((_nextPoint.open) ?? 0)) / 2;
            currentPoint.close = currentPoint.close ??
                (((prevPoint!.close) ?? 0) + ((_nextPoint.close) ?? 0)) / 2;
          }
        }
      }
    } else {
      if (pointIndex == 0) {
        ///Check the first point is null
        pointIndex == dataSource.length - 1
            ?

            ///Check the series contains single point with null value
            currentPoint!.y = 0
            : currentPoint!.y = ((_nextPoint.y) ?? 0) / 2;
      } else if (pointIndex == dataSource.length - 1) {
        ///Check the last point is null
        currentPoint!.y = ((prevPoint!.y) ?? 0) / 2;
      } else {
        currentPoint!.y = (((prevPoint!.y) ?? 0) + ((_nextPoint.y) ?? 0)) / 2;
      }
    }
  }
}
