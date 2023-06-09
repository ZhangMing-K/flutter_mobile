part of charts;

/// Render plot band.
///
/// Plot bands are also known as strip lines, which are used to shade the different ranges in plot
/// area with different colors to improve the readability of the chart.
///
/// Plot bands are drawn based on the
/// axis, you have to add plot bands using the plotBands property of the respective axis. You can also add
/// multiple plot bands to an axis.
///
/// Provides the property of visible, opacity, start, end, color, border color, and border width to
/// customize the appearance.
///
class PlotBand {
  /// Creating an argument constructor of PlotBand class.
  PlotBand(
      {bool? isVisible,
      this.start,
      this.end,
      Color? color,
      double? opacity,
      Color? borderColor,
      double? borderWidth,
      this.text,
      TextStyle? textStyle,
      bool? isRepeatable,
      dynamic repeatEvery,
      this.verticalTextPadding,
      this.horizontalTextPadding,
      this.repeatUntil,
      this.textAngle,
      bool? shouldRenderAboveSeries,
      DateTimeIntervalType? sizeType,
      List<double>? dashArray,
      this.size,
      this.associatedAxisStart,
      this.associatedAxisEnd,
      TextAnchor? verticalTextAlignment,
      TextAnchor? horizontalTextAlignment,
      this.gradient})
      : isVisible = isVisible ?? true,
        opacity = opacity ?? 1.0,
        color = color ?? Colors.grey,
        borderColor = borderColor ?? Colors.transparent,
        borderWidth = borderWidth ?? 0,
        textStyle = textStyle ??
            const TextStyle(
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal,
                fontSize: 12),
        isRepeatable = isRepeatable ?? false,
        repeatEvery = repeatEvery ?? 1,
        shouldRenderAboveSeries = shouldRenderAboveSeries ?? false,
        dashArray = dashArray ?? <double>[0, 0],
        sizeType = sizeType ?? DateTimeIntervalType.auto,
        verticalTextAlignment = verticalTextAlignment ?? TextAnchor.middle,
        horizontalTextAlignment = horizontalTextAlignment ?? TextAnchor.middle;

  ///Toggles the visibility of the plot band.
  ///
  ///Defaults to `true`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final bool isVisible;

  ///Specifies the start value of plot band.
  ///
  ///Defaults to `true`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                     start: 1,
  ///                     end: 5
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final dynamic start;

  ///Specifies the end value of plot band.
  ///
  ///Defaults to `true`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                     start: 1,
  ///                     end: 5
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final dynamic end;

  ///Text to be displayed in the plot band segment.
  ///
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    text:'Winter'
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final String? text;

  ///Customizes the text style of plot band.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    textStyle: const TextStyle(color:Colors.red)
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final TextStyle textStyle;

  ///Color of the plot band.
  ///
  ///Defaults to `Colors.grey`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    color: Colors.red
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final Color color;

  ///Color of the plot band border.
  ///
  ///Defaults to `Colors.transparent`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    borderColor: Colors.red
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final Color borderColor;

  ///Width of the plot band border.
  ///
  ///Defaults to `0`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    borderWidth: 2
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final double borderWidth;

  ///Opacity of the plot band. The value ranges from 0 to 1.
  ///
  ///Defaults to `1`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    opacity: 0.5
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final double opacity;

  ///Specifies the plot band need to be repeated in specified interval.
  ///
  ///Defaults to `false`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    isRepeatable: true
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final bool isRepeatable;

  ///Interval of the plot band need to be repeated.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    repeatEvery: 200
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final dynamic repeatEvery;

  ///End of the plot band need to be repeated.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    repeatUntil: 600
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final dynamic repeatUntil;

  ///Angle of the plot band text.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    textAngle: 90
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final double? textAngle;

  ///Specifies the whether plot band need to be rendered above the series.
  ///
  ///Defaults to `false`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    shouldRenderAboveSeries: true
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final bool shouldRenderAboveSeries;

  ///Date time interval type of the plot band.
  ///
  ///Defaults to `false`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    sizeType: DateTimeIntervalType.years
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final DateTimeIntervalType sizeType;

  ///Dashes of the series. Any number of values can be provided in the list. Odd value
  ///is considered as rendering size and even value is considered as gap.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    dashArray: <double>[10, 10]
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final List<double> dashArray;

  ///Size of the plot band
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    size: 20
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final dynamic size;

  ///Perpendicular axis start value.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    associatedAxisStart: 2
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final dynamic associatedAxisStart;

  ///Perpendicular axis end value.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    associatedAxisStart: 2
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final dynamic associatedAxisEnd;

  ///Vertical text alignment of the plot band text
  ///
  ///Defaults to `TextAnchor.middle`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    verticalTextAlignment: TextAnchor.start
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final TextAnchor verticalTextAlignment;

  ///Horizontal text alignment of the plot band text
  ///
  ///Defaults to `TextAnchor.middle`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    horizontalTextAlignment: TextAnchor.end
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final TextAnchor horizontalTextAlignment;

  ///Fills the plot band with gradient color.
  ///
  ///```dart
  ///final List <Color> color = <Color>[];
  ///    color.add(Colors.pink[50]);
  ///    color.add(Colors.pink[200]);
  ///    color.add(Colors.pink);
  ///
  ///final List<double> stops = <double>[];
  ///    stops.add(0.0);
  ///    stops.add(0.5);
  ///    stops.add(1.0);
  ///
  ///final LinearGradient gradients = LinearGradient(colors: color, stops: stops);
  ///
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    gradient: gradients
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final LinearGradient? gradient;

  ///To move the plot band text vertically.
  ///
  ///Takes pixel or percentage value. For pixel, input should be like `10px` and for percentage
  /// input should be like `10%`. If no suffix is specified (`10`), it will be considered as pixel value.
  /// Percentage value referes to the overall height of the chart. i.e. 100% is equal to the height
  /// of the chart.
  ///
  ///This is applicable for both vertical and horizontal axis. Positive value for this property
  /// moves the text upwards and negative value moves downwards.
  ///
  ///If [verticalTextAlignment] or [horizontalTextAlignment] is specified, text padding will be calculated
  /// from that modified position.
  ///
  ///Defaults to `null`
  ///
  ///
  ///```dart
  ///
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    verticalTextPadding:'30%',
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  final String? verticalTextPadding;

  ///To move the plot band text horizontally.
  ///
  ///Takes pixel or percentage value. For pixel, input should be like `10px` and for percentage
  /// input should be like `10%`. If no suffix is specified (`10`), it will be considered as pixel value.
  /// Percentage value referes to the overall width of the chart. i.e. 100% is equal to the width
  /// of the chart.
  ///
  ///This is applicable for both vertical and horizontal axis. Positive value for this property
  /// moves the text to right and negative value moves to left.
  ///
  ///If [verticalTextAlignment] or [horizontalTextAlignment] is specified, text padding will be calculated
  /// from that modified position.
  ///
  ///Defaults to `null`
  ///```dart
  ///
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    horizontalTextPadding:'30%',
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  final String? horizontalTextPadding;
}

class _PlotBandPainter extends CustomPainter {
  _PlotBandPainter({required this.chartState, this.shouldRenderAboveSeries})
      : chart = chartState._chart;

  final SfCartesianChartState chartState;

  final SfCartesianChart chart;

  final bool? shouldRenderAboveSeries;

  /// To paint plotbands
  @override
  void paint(Canvas canvas, Size size) {
    Rect clipRect;
    for (int axisIndex = 0;
        axisIndex < chartState._chartAxis!._axisRenderersCollection.length;
        axisIndex++) {
      final ChartAxisRenderer axisRenderer =
          chartState._chartAxis!._axisRenderersCollection[axisIndex]!;
      final ChartAxis axis = axisRenderer._axis;
      for (int j = 0; j < axis.plotBands.length; j++) {
        final PlotBand plotBand = axis.plotBands[j];
        if (plotBand.isVisible &&
            shouldRenderAboveSeries != plotBand.shouldRenderAboveSeries) {
          clipRect = _calculatePlotOffset(
              Rect.fromLTRB(
                  chartState._chartAxis!._axisClipRect!.left,
                  chartState._chartAxis!._axisClipRect!.top,
                  chartState._chartAxis!._axisClipRect!.right,
                  chartState._chartAxis!._axisClipRect!.bottom),
              Offset(axis.plotOffset, axis.plotOffset));
          canvas.clipRect(clipRect);
          _renderPlotBand(canvas, axisRenderer, plotBand);
        }
      }
    }
  }

  /// To find the start and end location for plotband
  _ChartLocation _getStartAndEndValues(ChartAxisRenderer? axisRenderer,
      dynamic start, dynamic end, PlotBand plotBand, bool isNeedRepeat) {
    dynamic startValue = start is String && num.tryParse(start) != null
        ? num.tryParse(start)
        : start;

    dynamic endValue =
        end is String && num.tryParse(end) != null ? num.tryParse(end) : end;
    if (axisRenderer is DateTimeAxisRenderer) {
      startValue = startValue is DateTime
          ? startValue.millisecondsSinceEpoch
          : startValue;
      endValue = isNeedRepeat
          ? plotBand.repeatUntil is DateTime
              ? plotBand.repeatUntil.millisecondsSinceEpoch
              : plotBand.repeatUntil
          : endValue is DateTime
              ? endValue.millisecondsSinceEpoch
              : endValue;
    } else if (axisRenderer is CategoryAxisRenderer) {
      startValue = startValue is num
          ? startValue
          : axisRenderer._labels.indexOf(startValue);
      endValue = isNeedRepeat
          ? plotBand.repeatUntil is num
              ? plotBand.repeatUntil.floor()
              : axisRenderer._labels.indexOf(plotBand.repeatUntil)
          : endValue is num
              ? endValue
              : axisRenderer._labels.indexOf(endValue);
    } else if (axisRenderer is LogarithmicAxisRenderer ||
        axisRenderer is NumericAxisRenderer) {
      endValue = isNeedRepeat ? plotBand.repeatUntil : endValue;
    }
    return _ChartLocation(startValue, endValue);
  }

  /// Render a method for plotband
  void _renderPlotBand(
      Canvas canvas, ChartAxisRenderer axisRenderer, PlotBand plotBand) {
    num? startValue, endValue;

    final bool isNeedRepeat = plotBand.isRepeatable &&
        plotBand.repeatUntil != null &&
        plotBand.repeatEvery != null;

    final _ChartLocation startAndEndValues = _getStartAndEndValues(
        axisRenderer,
        plotBand.start ?? axisRenderer._visibleRange!.minimum,
        plotBand.end ?? axisRenderer._visibleRange!.maximum,
        plotBand,
        isNeedRepeat);
    startValue = startAndEndValues.x;
    endValue = startAndEndValues.y;
    if (isNeedRepeat) {
      num? repeatStart = startValue, repeatEnd;
      while (repeatStart! < endValue!) {
        repeatEnd = _getPlotBandValue(axisRenderer, plotBand, repeatStart,
            plotBand.size ?? plotBand.repeatEvery);
        repeatEnd = repeatEnd > endValue ? endValue : repeatEnd;
        _renderPlotBandElement(
            axisRenderer, repeatStart, repeatEnd, plotBand, canvas);
        repeatStart = plotBand.size != null
            ? _getPlotBandValue(
                axisRenderer, plotBand, repeatStart, plotBand.repeatEvery)
            : repeatEnd;
      }
    } else {
      _renderPlotBandElement(
          axisRenderer, startValue, endValue, plotBand, canvas);
    }
  }

  /// To get and return value for date time axis
  num _getPlotBandValue(ChartAxisRenderer axisRenderer, PlotBand plotBand,
      num? value, num addValue) {
    DateTimeIntervalType? intervalType;
    if (axisRenderer is DateTimeAxisRenderer) {
      intervalType = (plotBand.sizeType == DateTimeIntervalType.auto)
          ? axisRenderer._actualIntervalType
          : plotBand.sizeType;
      DateTime date = DateTime.fromMillisecondsSinceEpoch(value as int);
      switch (intervalType!) {
        case DateTimeIntervalType.years:
          date = DateTime(date.year + (addValue as int), date.month, date.day,
              date.hour, date.minute, date.second);
          break;
        case DateTimeIntervalType.months:
          date = DateTime(date.year, date.month + (addValue as int), date.day,
              date.hour, date.minute, date.second);
          break;
        case DateTimeIntervalType.days:
          date = DateTime(date.year, date.month, date.day + (addValue as int),
              date.hour, date.minute, date.second);
          break;
        case DateTimeIntervalType.hours:
          date = DateTime(date.year, date.month, date.day,
              date.hour + (addValue as int), date.minute, date.second);
          break;
        case DateTimeIntervalType.minutes:
          date = DateTime(date.year, date.month, date.day, date.hour,
              date.minute + (addValue as int), date.second);
          break;
        case DateTimeIntervalType.seconds:
          date = DateTime(date.year, date.month, date.day, date.hour,
              date.minute, date.second + (addValue as int));
          break;
        case DateTimeIntervalType.auto:
          break;
      }
      value = date.millisecondsSinceEpoch;
    } else {
      value = value! + addValue;
    }
    return value!;
  }

  /// Render plotband element
  void _renderPlotBandElement(ChartAxisRenderer axisRenderer, num? startValue,
      num? endValue, PlotBand plotBand, Canvas canvas) {
    _ChartLocation startPoint, endPoint, segmentStartPoint, segmentEndPoint;
    final Rect axisRect = chartState._chartAxis!._axisClipRect!;
    Rect plotBandRect;
    int textAngle;
    num? left, top, bottom, right;
    final ChartAxis axis = axisRenderer._axis;

    startValue = axis is LogarithmicAxis
        ? _calculateLogBaseValue(startValue!, axis.logBase)
        : startValue;
    endValue = axis is LogarithmicAxis
        ? _calculateLogBaseValue(endValue!, axis.logBase)
        : endValue;

    endValue! < 0
        ? endValue <= axisRenderer._visibleRange!.minimum
            ? endValue = axisRenderer._visibleRange!.minimum
            : endValue = endValue
        : endValue >= axisRenderer._visibleRange!.maximum
            ? endValue = axisRenderer._visibleRange!.maximum
            : endValue = endValue;

    startValue! < 0
        ? startValue <= axisRenderer._visibleRange!.minimum
            ? startValue = axisRenderer._visibleRange!.minimum
            : startValue = startValue
        : startValue >= axisRenderer._visibleRange!.maximum
            ? startValue = axisRenderer._visibleRange!.maximum
            : startValue = startValue;

    startPoint = _calculatePoint(startValue, startValue, axisRenderer,
        axisRenderer, chartState._requireInvertedAxis!, null, axisRect);
    endPoint = _calculatePoint(endValue, endValue, axisRenderer, axisRenderer,
        chartState._requireInvertedAxis!, null, axisRect);

    ChartAxisRenderer? segmentAxisRenderer;
    if (plotBand.associatedAxisStart != null ||
        plotBand.associatedAxisEnd != null) {
      if (axis.associatedAxisName == null) {
        segmentAxisRenderer =
            (axisRenderer._orientation == AxisOrientation.horizontal)
                ? chartState._chartAxis!._primaryYAxisRenderer
                : chartState._chartAxis!._primaryXAxisRenderer;
      } else {
        for (int axisIndex = 0;
            axisIndex < chartState._chartAxis!._axisRenderersCollection.length;
            axisIndex++) {
          final ChartAxisRenderer targetAxisRenderer =
              chartState._chartAxis!._axisRenderersCollection[axisIndex]!;
          if (axis.associatedAxisName == targetAxisRenderer._name) {
            segmentAxisRenderer = axisRenderer;
          }
        }
      }
      final _ChartLocation startAndEndValues = _getStartAndEndValues(
          segmentAxisRenderer,
          plotBand.associatedAxisStart ?? startValue,
          plotBand.associatedAxisEnd ?? endValue,
          plotBand,
          false);

      if (segmentAxisRenderer!._orientation == AxisOrientation.horizontal) {
        segmentStartPoint = _calculatePoint(
            startAndEndValues.x,
            startValue,
            segmentAxisRenderer,
            axisRenderer,
            chartState._requireInvertedAxis!,
            null,
            axisRect);
        segmentEndPoint = _calculatePoint(
            startAndEndValues.y,
            endValue,
            segmentAxisRenderer,
            axisRenderer,
            chartState._requireInvertedAxis!,
            null,
            axisRect);
        left = plotBand.associatedAxisStart != null
            ? segmentStartPoint.x
            : axisRect.left;
        right = plotBand.associatedAxisEnd != null
            ? segmentEndPoint.x
            : axisRect.right;
      } else {
        segmentStartPoint = _calculatePoint(
            startValue,
            startAndEndValues.x,
            axisRenderer,
            segmentAxisRenderer,
            chartState._requireInvertedAxis!,
            null,
            axisRect);
        segmentEndPoint = _calculatePoint(
            endValue,
            startAndEndValues.y,
            axisRenderer,
            segmentAxisRenderer,
            chartState._requireInvertedAxis!,
            null,
            axisRect);
        top = plotBand.associatedAxisStart != null
            ? segmentStartPoint.y
            : axisRect.bottom;
        bottom = plotBand.associatedAxisEnd != null
            ? segmentEndPoint.y
            : axisRect.top;
      }
    }

    if (axisRenderer._orientation == AxisOrientation.horizontal) {
      textAngle =
          plotBand.textAngle != null ? plotBand.textAngle!.toInt() : 270;
      plotBandRect = Rect.fromLTRB(
          left as double? ?? startPoint.x as double,
          top as double? ?? axisRect.top,
          right as double? ?? endPoint.x as double,
          bottom as double? ?? axisRect.bottom);
    } else {
      textAngle = plotBand.textAngle != null ? plotBand.textAngle!.toInt() : 0;
      plotBandRect = Rect.fromLTRB(
          left as double? ?? axisRect.left,
          top as double? ?? endPoint.y as double,
          right as double? ?? axisRect.right,
          bottom as double? ?? startPoint.y as double);
    }
    _drawPlotBand(plotBand, plotBandRect, textAngle, canvas, axis);
  }

  /// To draw the plotband
  void _drawPlotBand(PlotBand plotBand, Rect plotBandRect, int textAngle,
      Canvas canvas, ChartAxis axis) {
    final List<double> dashArray = plotBand.dashArray;
    bool needDashLine = true;
    if (plotBand.color != null) {
      Path path;
      for (int i = 1; i < dashArray.length; i = i + 2) {
        if (dashArray[i] == 0) {
          needDashLine = false;
        }
      }

      path = Path()
        ..moveTo(plotBandRect.left, plotBandRect.top)
        ..lineTo(plotBandRect.left + plotBandRect.width, plotBandRect.top)
        ..lineTo(plotBandRect.left + plotBandRect.width,
            plotBandRect.top + plotBandRect.height)
        ..lineTo(plotBandRect.left, plotBandRect.top + plotBandRect.height)
        ..close();

      final Paint paint = Paint();
      Path? dashPath;
      if (needDashLine) {
        paint.isAntiAlias = false;
        dashPath = !kIsWeb
            ? _dashPath(path,
                dashArray: _CircularIntervalList<double>(dashArray))
            : path;
      } else {
        dashPath = path;
      }
      Paint fillPaint;
      if (plotBand.gradient != null) {
        fillPaint = Paint()
          ..shader = plotBand.gradient!.createShader(plotBandRect)
          ..style = PaintingStyle.fill;
      } else {
        fillPaint = Paint()
          ..color = plotBand.color.withOpacity(plotBand.opacity)
          ..style = PaintingStyle.fill;
      }
      canvas.drawPath(path, fillPaint);
      if (plotBand.borderWidth > 0 &&
          plotBand.borderColor != null &&
          dashPath != null) {
        canvas.drawPath(
            dashPath,
            paint
              ..color = plotBand.borderColor.withOpacity(plotBand.opacity)
              ..style = PaintingStyle.stroke
              ..strokeWidth = plotBand.borderWidth);
      }
    }
    if (plotBand.text != null && plotBand.text!.isNotEmpty) {
      final Size textSize =
          _measureText(plotBand.text, plotBand.textStyle, textAngle);
      num? x = 0;
      num? y = 0;
      if (plotBand.horizontalTextPadding != null &&
          plotBand.horizontalTextPadding != '') {
        if (plotBand.horizontalTextPadding!.contains('%')) {
          x = _percentageToValue(
              plotBand.horizontalTextPadding,
              chart.isTransposed
                  ? chartState._chartAxis!._axisClipRect!.bottom
                  : chartState._chartAxis!._axisClipRect!.right);
        } else if (plotBand.verticalTextPadding!.contains('px')) {
          x = double.parse(plotBand.horizontalTextPadding!
              .substring(0, plotBand.horizontalTextPadding!.length - 2));
        } else {
          x = double.parse(plotBand.horizontalTextPadding!);
        }
      }
      if (plotBand.verticalTextPadding != null &&
          plotBand.verticalTextPadding != '') {
        if (plotBand.verticalTextPadding!.contains('%')) {
          y = _percentageToValue(
              plotBand.verticalTextPadding,
              chart.isTransposed
                  ? chartState._chartAxis!._axisClipRect!.right
                  : chartState._chartAxis!._axisClipRect!.bottom);
        } else if (plotBand.verticalTextPadding!.contains('px')) {
          y = double.parse(plotBand.verticalTextPadding!
              .substring(0, plotBand.verticalTextPadding!.length - 2));
        } else {
          y = double.parse(plotBand.verticalTextPadding!);
        }
      }

      _drawText(
          canvas,
          plotBand.text,
          Offset(
              plotBand.horizontalTextAlignment == TextAnchor.middle
                  ? (plotBandRect.left +
                          plotBandRect.width / 2 -
                          ((plotBandRect.left ==
                                  chartState._chartAxis!._axisClipRect!.right)
                              ? 0
                              : (plotBandRect.right ==
                                      chartState
                                          ._chartAxis!._axisClipRect!.left)
                                  ? textSize.width
                                  : textSize.width / 2) +
                          x!) +
                      (textAngle != 0 ? textSize.width / 2 : 0)
                  : plotBand.horizontalTextAlignment == TextAnchor.start
                      ? plotBandRect.left + x!
                      : plotBandRect.right - textSize.width + x!,
              plotBand.verticalTextAlignment == TextAnchor.middle
                  ? (plotBandRect.top +
                          plotBandRect.height / 2 -
                          ((plotBandRect.bottom ==
                                  chartState._chartAxis!._axisClipRect!.top)
                              ? textSize.height
                              : (plotBandRect.top ==
                                      chartState
                                          ._chartAxis!._axisClipRect!.bottom)
                                  ? 0 + y!
                                  : textSize.height + y!)) +
                      (textAngle != 0 ? textSize.height / 2 : 0)
                  : plotBand.verticalTextAlignment == TextAnchor.start
                      ? (plotBandRect.top - y!)
                      : plotBandRect.bottom - textSize.height - y!),
          plotBand.textStyle,
          textAngle);
    }
  }

  @override
  bool shouldRepaint(_PlotBandPainter oldDelegate) => true;
}
