part of charts;

/// This class has the properties of the crosshair behavior.
///
/// crosshair behavior has the activation mode and line type property to set the behavior of the crosshair.
/// It also has the property to customize the appearance.
///
/// Provide options for activation mode, line type, line color, line width, hide delay for customizing the
/// behavior of the crosshair.
///
class CrosshairBehavior {
  /// Creating an argument constructor of CrosshairBehavior class.
  CrosshairBehavior({
    ActivationMode? activationMode,
    CrosshairLineType? lineType,
    this.lineDashArray,
    this.enable = false,
    this.lineColor,
    this.lineWidth = 1,
    this.shouldAlwaysShow = false,
    double? hideDelay,
  })  : activationMode = activationMode ?? ActivationMode.longPress,
        hideDelay = hideDelay ?? 0,
        lineType = lineType ?? CrosshairLineType.both;

  /// Toggles the visibility of the crosshair.
  ///
  ///Defaults to `false`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           crosshairBehavior: CrosshairBehavior(enable: true),
  ///        ));
  ///}
  ///```
  final bool enable;

  /// Width of the crosshair line.
  ///
  /// Defaults to `1`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           crosshairBehavior: CrosshairBehavior(
  ///                   enable: true, lineWidth: 5),
  ///        ));
  ///}
  ///```
  final double lineWidth;

  ///Color of the crosshair line.
  ///
  /// Color will be applied based on the brightness
  ///property of the app.
  ///
  ///Defaults to `1`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           crosshairBehavior: CrosshairBehavior(
  ///                   enable: true, lineColor: Colors.red),
  ///        ));
  ///}
  ///```
  final Color? lineColor;

  /// Dashes of the crosshair line.
  ///
  /// Any number of values can be provided in the list.
  /// Odd value is considered as rendering size and even value is considered as gap.
  ///
  /// Dafaults to `[0,0]`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           crosshairBehavior: CrosshairBehavior(
  ///                   enable: true, lineDashArray: [10,10]),
  ///        ));
  ///}
  ///```
  final List<double>? lineDashArray;

  /// Gesture for activating the crosshair.
  ///
  /// Crosshair can be activated in tap, double tap
  /// and long press.
  ///
  /// Defaults to `ActivationMode.longPress`
  ///
  /// Also refer ActivationMode
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           crosshairBehavior: CrosshairBehavior(
  ///               enable: true, activationMode: ActivationMode.doubleTap),
  ///        ));
  ///}
  ///```
  final ActivationMode activationMode;

  /// Type of crosshair line.
  ///
  /// By default, both vertical and horizontal lines will be
  /// displayed. You can change this by specifying values to this property.
  ///
  /// Defaults to `CrosshairLineType.both`
  ///
  /// Also refer CrosshairLineType
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           crosshairBehavior: CrosshairBehavior(
  ///                 enable: true, lineType: CrosshairLineType.horizontal),
  ///        ));
  ///}
  ///```
  final CrosshairLineType lineType;

  /// Enables or disables the crosshair.
  ///
  /// By default, the crosshair will be hidden on touch.
  /// To avoid this, set this property to true.
  ///
  /// Defaults to `false`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           crosshairBehavior: CrosshairBehavior(enable: true, shouldAlwaysShow: true),
  ///        ));
  ///}
  ///```
  final bool shouldAlwaysShow;

  ///Giving disapper delay for crosshair
  ///
  /// Defaults to `0`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           crosshairBehavior: CrosshairBehavior(enable: true, duration: 3000),
  ///        ));
  ///}
  ///```
  final double hideDelay;

  SfCartesianChartState? _chartState;

  /// Displays the crosshair at the specified x and y-positions.
  ///
  ///
  /// x & y - x and y values/pixel where the crosshair needs to be shown.
  ///
  /// coordinateUnit - specify the type of x and y values given.'pixel' or 'point' for logica pixel and chart data point respectively.
  /// Defaults to `'point'`.
  void show(dynamic x, double? y, [String? coordinateUnit]) {
    final SfCartesianChartState chartState = _chartState!;
    final CrosshairBehaviorRenderer crosshairBehaviorRenderer =
        chartState._crosshairBehaviorRenderer;
    firstY ??= y;
    if (coordinateUnit != 'pixel') {
      crosshairBehaviorRenderer
          ._crosshairPainter!.chartState._crosshairWithoutTouch = false;
      final CartesianSeriesRenderer seriesRenderer = crosshairBehaviorRenderer
          ._crosshairPainter!
          .chartState
          ._chartSeries!
          .visibleSeriesRenderers[0]!;
      final _ChartLocation location = _calculatePoint(
          x is DateTime ? x.millisecondsSinceEpoch : x,
          y,
          seriesRenderer._xAxisRenderer!,
          seriesRenderer._yAxisRenderer!,
          seriesRenderer._chartState!._requireInvertedAxis!,
          seriesRenderer._series,
          seriesRenderer._chartState!._chartAxis!._axisClipRect!);
      x = location.x;
      y = location.y as double?;
    }

    if (crosshairBehaviorRenderer._crosshairPainter != null &&
        activationMode != ActivationMode.none &&
        x != null &&
        y != null) {
      crosshairBehaviorRenderer._crosshairPainter!
          ._generateAllPoints(Offset(x.toDouble(), y));
      crosshairBehaviorRenderer._crosshairPainter!.canResetPath = false;
      if (crosshairBehaviorRenderer
          ._crosshairPainter!.chartState._crosshairWithoutTouch) {
        crosshairBehaviorRenderer
            ._crosshairPainter!.chartState._crosshairRepaintNotifier!.value++;
      }
    }
  }

  double? firstY;

  /// Displays the crosshair at the specified point index.
  ///
  ///
  /// pointIndex - index of point at which the crosshair needs to be shown.
  void showByIndex(int pointIndex) {
    final SfCartesianChartState chartState = _chartState!;
    final CrosshairBehaviorRenderer crosshairBehaviorRenderer =
        chartState._crosshairBehaviorRenderer;
    if (_validIndex(
        pointIndex, 0, crosshairBehaviorRenderer._crosshairPainter!.chart)) {
      if (crosshairBehaviorRenderer._crosshairPainter != null &&
          activationMode != ActivationMode.none) {
        final List<CartesianSeriesRenderer?> visibleSeriesRenderer =
            crosshairBehaviorRenderer._crosshairPainter!.chartState
                ._chartSeries!.visibleSeriesRenderers;
        final CartesianSeriesRenderer seriesRenderer =
            visibleSeriesRenderer[0]!;
        crosshairBehaviorRenderer._crosshairPainter!._generateAllPoints(Offset(
            seriesRenderer._dataPoints![pointIndex]!.markerPoint!.x as double,
            seriesRenderer._dataPoints![pointIndex]!.markerPoint!.y as double));
        crosshairBehaviorRenderer._crosshairPainter!.canResetPath = false;
      }
    }
  }

  /// Hides the crosshair if it is displayed.
  void hide() {
    final SfCartesianChartState chartState = _chartState!;
    final CrosshairBehaviorRenderer crosshairBehaviorRenderer =
        chartState._crosshairBehaviorRenderer;
    if (crosshairBehaviorRenderer._crosshairPainter != null) {
      crosshairBehaviorRenderer._crosshairPainter!.canResetPath = false;
      ValueNotifier<int>(crosshairBehaviorRenderer
          ._crosshairPainter!.chartState._crosshairRepaintNotifier!.value++);
      if (crosshairBehaviorRenderer._crosshairPainter!.timer != null) {
        crosshairBehaviorRenderer._crosshairPainter!.timer!.cancel();
      }
      if (!shouldAlwaysShow) {
        final double duration = (hideDelay == 0 &&
                crosshairBehaviorRenderer
                    ._crosshairPainter!.chartState._enableDoubleTap)
            ? 200
            : hideDelay;
        crosshairBehaviorRenderer._crosshairPainter!.timer =
            Timer(Duration(milliseconds: duration.toInt()), () {
          crosshairBehaviorRenderer
              ._crosshairPainter!.chartState._crosshairRepaintNotifier!.value++;
          crosshairBehaviorRenderer._crosshairPainter!.canResetPath = true;
        });
      }
    }
  }
}

/// Cross hair renderer class for mutable fields and methods
class CrosshairBehaviorRenderer with ChartBehavior {
  /// Creates an argument constructor for Crosshair renderer class
  CrosshairBehaviorRenderer(this._chartState);

  dynamic get _chart => _chartState._chart;

  final dynamic _chartState;

  CrosshairBehavior? get _crosshairBehavior => _chart.crosshairBehavior;

  /// Touch position
  Offset? _position;

  /// Holds the instance of CrosshairPainter
  _CrosshairPainter? _crosshairPainter;

  /// Check whether long press activated or not.
  //ignore: prefer_final_fields
  bool _isLongPressActivated = false;

  /// Enables the crosshair on double tap.
  @override
  void onDoubleTap(double xPos, double yPos) =>
      _crosshairBehavior!.show(xPos, yPos, 'pixel');

  /// Enables the crosshair on long press.
  @override
  void onLongPress(double xPos, double yPos) =>
      _crosshairBehavior!.show(xPos, yPos, 'pixel');

  /// Enables the crosshair on touch down.
  @override
  void onTouchDown(double xPos, double yPos) =>
      _crosshairBehavior!.show(xPos, yPos, 'pixel');

  /// Enables the crosshair on touch move.
  @override
  void onTouchMove(double xPos, double yPos) =>
      _crosshairBehavior!.show(xPos, yPos, 'pixel');

  /// Enables the crosshair on touch up.
  @override
  void onTouchUp(double? xPos, double? yPos) => _crosshairBehavior!.hide();

  /// Enables the crosshair on mouse hover.
  @override
  void onEnter(double xPos, double yPos) =>
      _crosshairBehavior!.show(xPos, yPos, 'pixel');

  /// Disables the crosshair on mouse exit.
  @override
  void onExit(double xPos, double yPos) => _crosshairBehavior!.hide();

  /// Draws the crosshair.
  @override
  void onPaint(Canvas canvas) {
    if (_crosshairPainter != null) {
      _crosshairPainter!._drawCrosshair(canvas);
    }
  }

  /// To draw cross hair line
  void _drawLine(Canvas canvas, Paint? paint, int? seriesIndex) {
    if (_crosshairPainter != null) {
      _crosshairPainter!._drawCrosshairLine(canvas, paint, seriesIndex);
    }
  }

  Paint? _linePainter(Paint paint) => _crosshairPainter?._getLinePainter(paint);
}
