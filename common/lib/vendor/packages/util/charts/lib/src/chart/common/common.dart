part of charts;

class _CustomPaintStyle {
  _CustomPaintStyle(this.strokeWidth, this.color, this.paintStyle);
  Color color;
  double strokeWidth;
  PaintingStyle paintStyle;
}

class _AxisSize {
  _AxisSize(this.axisRenderer, this.size);
  num? size;
  ChartAxisRenderer axisRenderer;
}

class _PainterKey {
  _PainterKey({this.index, this.name, this.isRenderCompleted});
  final int? index;
  final String? name;
  bool? isRenderCompleted;
}

/// Customizes the interactive tooltip.
///
///Shows the information about the segments.To enable the interactiveToolTip, set the property to true.
///
/// By using this,to customize the [color], [borderwidth], [borderRadius],
/// [format] and so on.
///
/// _Note:_ IntereactivetoolTip applicable for axis types and trackball.

class InteractiveTooltip {
  /// Creating an argument constructor of InteractiveTooltip class.
  InteractiveTooltip(
      {this.enable = true,
      this.color,
      this.borderColor,
      this.borderWidth = 0,
      this.borderRadius = 5,
      this.arrowLength = 7,
      this.arrowWidth = 5,
      this.format,
      this.connectorLineColor,
      this.connectorLineWidth = 1.5,
      this.connectorLineDashArray,
      this.decimalPlaces = 3,
      TextStyle? textStyle})
      : textStyle = textStyle ??
            const TextStyle(
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal,
                fontSize: 12);

  ///Toggles the visibility of the interactive tooltip in an axis.
  ///
  /// This tooltip will be displayed at the axis for crosshair and
  /// will be displayed near to the trackline for trackball.
  ///
  ///Defaults to `true`.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true,
  ///           tooltipSettings: InteractiveTooltip(enable:false)),
  ///        ));
  ///}
  ///```
  final bool enable;

  ///Color of the interactive tooltip.
  ///
  ///Used to change the color of the tooltip text.
  ///
  ///Defaults to `null`.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true,
  ///           tooltipSettings: InteractiveTooltip(
  ///             color:Colors.grey)),
  ///        ));
  ///}
  ///```
  final Color? color;

  ///Border color of the interactive tooltip.
  ///
  ///Used to change the stroke color of the axis tooltip.
  ///
  ///Defaults to `Colors.black`.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true,
  ///           tooltipSettings: InteractiveTooltip(
  ///             borderColor:Colors.white,
  ///             borderWidth:2)),
  ///        ));
  ///}
  ///```
  final Color? borderColor;

  ///Border width of the interactive tooltip.
  ///
  ///Used to change the stroke width of the axis tooltip.
  ///
  ///Defaults to `0`.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true,
  ///           tooltipSettings: InteractiveTooltip(
  ///             borderColor:Colors.white,
  ///             borderWidth:2)),
  ///        ));
  ///}
  ///```
  final double borderWidth;

  ///Customizes the text in the interactive tooltip.
  ///
  ///Used to change the text color, size, font family, fontStyle, and font weight.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true,
  ///           tooltipSettings: InteractiveTooltip(
  ///             textStyle: TextStyle(color:Colors.red))),
  ///        ));
  ///}
  ///```
  final TextStyle textStyle;

  ///Customizes the corners of the interactive tooltip.
  ///
  ///Each corner can be customized with a desired value or with a single value.
  ///
  ///Defaults to `Radius.zero`.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true,
  ///           tooltipSettings: InteractiveTooltip(
  ///             borderColor:Colors.white,
  ///             borderWidth:3,
  ///             borderRadius:2)),
  ///        ));
  ///}
  ///```
  final double borderRadius;

  ///It Specifies the length of the tooltip.
  ///
  ///Defaults to `7`.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true,
  ///           tooltipSettings: InteractiveTooltip(
  ///             arrowLength:4)),
  ///        ));
  ///}
  ///```
  final double arrowLength;

  ///It specifies the width of the tooltip arrow.
  ///
  ///Defaults to `5`.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true,
  ///           tooltipSettings: InteractiveTooltip(
  ///             arrowWidth:4)),
  ///        ));
  ///}
  ///```
  final double arrowWidth;

  ///Text format of the interactive tooltip.
  ///
  /// By default, axis value will be displayed in the tooltip, and it can be customized by
  /// adding desired text as prefix or suffix.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true,
  ///           tooltipSettings: InteractiveTooltip(
  ///             format:'point.x %')),
  ///        ));
  ///}
  ///```
  final String? format;

  ///Width of the selection zooming tooltip connector line.
  ///
  ///Defaults to `1.5`.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(interactiveTooltip:
  ///                               InteractiveTooltip(connectorLineWidth:2)),
  ///        ));
  ///}
  ///```
  final double connectorLineWidth;

  ///Color of the selection zooming tooltip connector line.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             interactiveTooltip: InteractiveTooltip(connectorLineColor:Colors.red)),
  ///        ));
  ///}
  ///```
  final Color? connectorLineColor;

  ///Giving dashArray to the selection zooming tooltip connector line.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///              interactiveTooltip: InteractiveTooltip(connectorLineDashArray:[2,3])),
  ///        ));
  ///}
  ///```
  final List<double>? connectorLineDashArray;

  ///Rounding decimal places of the selection zooming tooltip or trackball tooltip label.
  ///
  ///Defaults to `3`.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(interactiveTooltip: InteractiveTooltip(decimalPlaces:4)),
  ///        ));
  ///}
  ///```
  final int decimalPlaces;
}

class _StackedValues {
  _StackedValues(this.startValues, this.endValues);
  List<double> startValues;
  List<double> endValues;
}

class _ClusterStackedItemInfo {
  _ClusterStackedItemInfo(this.stackName, this.stackedItemInfo);
  String stackName;
  List<_StackedItemInfo> stackedItemInfo;
}

class _StackedItemInfo {
  _StackedItemInfo(this.seriesIndex, this.seriesRenderer);
  int seriesIndex;
  _StackedSeriesRenderer seriesRenderer;
}

class _ChartPointInfo {
  /// Marker x position
  double? markerXPos;

  /// Marker y position
  double? markerYPos;

  /// label for trackball and cross hair
  String? label;

  /// Data point index
  late int dataPointIndex;

  /// Instance of chart series
  CartesianSeries<dynamic, dynamic>? series;

  /// Instance of cartesian seriesRenderer
  CartesianSeriesRenderer? seriesRenderer;

  /// Chart data point
  CartesianChartPoint<dynamic>? chartDataPoint;

  /// X position of the label
  double? xPosition;

  /// Y position of the label
  double? yPosition;

  /// Color of the segment
  Color? color;

  /// header text
  String? header;

  /// Low Y position of financial series
  double? lowYPosition;

  /// High Y position of financial series
  double? highYPosition;

  /// Open y position of financial series
  double? openYPosition;

  /// close y position of financial series
  double? closeYPosition;

  /// open x position of finanical series
  double? openXPosition;

  /// close x position of finanical series
  double? closeXPosition;

  /// Minimum Y position of box plot series
  double? minYPosition;

  /// Maximum Y position of box plot series
  double? maxYPosition;

  /// Lower y position of box plot series
  double? lowerXPosition;

  /// Upper y position of box plot series
  double? upperXPosition;

  /// Lower x position of box plot series
  double? lowerYPosition;

  /// Upper x position of box plot series
  double? upperYPosition;

  /// series index value
  num? seriesIndex;
}

///Options to customize the markers that are displayed when trackball is enabled.
///
///Trackball markers are used to provide information about the exact point location,
/// when the trackball is visible. You can add a shape to adorn each data point.
/// Trackball markers can be enabled by using the
/// [markerVisibility] property in [TrackballMarkerSettings].
///Provides the options like color, border width, border color and shape of the
///marker to customize the appearance.
class TrackballMarkerSettings extends MarkerSettings {
  /// Creating an argument constructor of TrackballMarkerSettings class.
  TrackballMarkerSettings(
      {this.markerVisibility = TrackballVisibilityMode.auto,
      double? height,
      double? width,
      Color? color,
      DataMarkerType? shape,
      double? borderWidth,
      Color? borderColor,
      ImageProvider? image})
      : super(
            height: height,
            width: width,
            color: color,
            shape: shape,
            borderWidth: borderWidth,
            borderColor: borderColor,
            image: image);

  ///Whether marker should be visible or not when trackball is enabled.
  ///
  ///The below values are applicable for this:
  ///* auto - If the [isVisible] property in the series [markerSettings] is set
  /// to true, then the trackball marker will also be displayed for that
  /// particular series, else it will not be displayed.
  ///* visible - Makes the trackball marker visible for all the series,
  /// irrespective of considering the [isVisible] property's value in the [markerSettings].
  ///* hidden - Hides the trackball marker for all the series.
  ///
  ///Defaults to `TrackballVisibilityMode.auto`.

  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(
  ///                enable: true,
  ///                markerSettings: TrackballMarkerSettings(
  ///                    markerVisibility:  TrackballVisibilityMode.auto,
  ///                    width: 10
  ///             ),
  ///            series: <SplineSeries<SalesData, num>>[
  ///                  SplineSeries<SalesData, num>(
  ///                    markerSettings: MarkerSettings(isVisible: true),
  ///                 ),
  ///            ],
  /// );
  ///}
  ///```
  final TrackballVisibilityMode markerVisibility;
}

/// To get cartesian type data label saturation color
Color _getDataLabelSaturationColor(
    CartesianChartPoint<dynamic> currentPoint,
    CartesianSeriesRenderer seriesRenderer,
    SfCartesianChartState _chartState,
    DataLabelSettingsRenderer dataLabelSettingsRenderer) {
  final SfCartesianChart chart = _chartState._chart;
  Color? color;
  final DataLabelSettings dataLabel = seriesRenderer._series!.dataLabelSettings;
  final ChartDataLabelAlignment labelPosition =
      (seriesRenderer._seriesType == 'rangecolumn' &&
              (dataLabel.labelAlignment == ChartDataLabelAlignment.bottom ||
                  dataLabel.labelAlignment == ChartDataLabelAlignment.middle))
          ? ChartDataLabelAlignment.auto
          : dataLabel.labelAlignment;
  final ChartAlignment alignment = dataLabel.alignment;
  final String seriesType = seriesRenderer._seriesType == 'line' ||
          seriesRenderer._seriesType == 'stackedline' ||
          seriesRenderer._seriesType == 'stackedline100' ||
          seriesRenderer._seriesType == 'spline' ||
          seriesRenderer._seriesType == 'stepline'
      ? 'Line'
      : seriesRenderer._isRectSeries
          ? 'Column'
          : seriesRenderer._seriesType == 'bubble' ||
                  seriesRenderer._seriesType == 'scatter'
              ? 'Circle'
              : seriesRenderer._seriesType!.contains('area')
                  ? 'area'
                  : 'Default';
  if (dataLabel.useSeriesColor || dataLabelSettingsRenderer._color != null) {
    color = dataLabelSettingsRenderer._color ??
        (currentPoint.pointColorMapper ?? seriesRenderer._seriesColor);
  } else {
    switch (seriesType) {
      case 'Line':
        color = _getOuterDataLabelColor(dataLabelSettingsRenderer,
            chart.plotAreaBackgroundColor, _chartState._chartTheme);
        break;
      case 'Column':
        color = (!currentPoint.dataLabelSaturationRegionInside &&
                ((labelPosition == ChartDataLabelAlignment.outer &&
                        alignment != ChartAlignment.near) ||
                    (labelPosition == ChartDataLabelAlignment.top &&
                        alignment == ChartAlignment.far) ||
                    (labelPosition == ChartDataLabelAlignment.auto &&
                        (!seriesRenderer._seriesType!.contains('100') &&
                            seriesRenderer._seriesType != 'stackedbar' &&
                            seriesRenderer._seriesType != 'stackedcolumn'))))
            ? _getOuterDataLabelColor(dataLabelSettingsRenderer,
                chart.plotAreaBackgroundColor, _chartState._chartTheme)
            : _getInnerDataLabelColor(
                currentPoint, seriesRenderer, _chartState._chartTheme);
        break;
      case 'Circle':
        color = (labelPosition == ChartDataLabelAlignment.middle &&
                    alignment == ChartAlignment.center ||
                labelPosition == ChartDataLabelAlignment.bottom &&
                    alignment == ChartAlignment.far ||
                labelPosition == ChartDataLabelAlignment.top &&
                    alignment == ChartAlignment.near ||
                labelPosition == ChartDataLabelAlignment.outer &&
                    alignment == ChartAlignment.near)
            ? _getInnerDataLabelColor(
                currentPoint, seriesRenderer, _chartState._chartTheme)
            : _getOuterDataLabelColor(dataLabelSettingsRenderer,
                chart.plotAreaBackgroundColor, _chartState._chartTheme);
        break;

      case 'area':
        color = (!currentPoint.dataLabelSaturationRegionInside &&
                currentPoint.labelLocation.y! < currentPoint.markerPoint!.y!)
            ? _getOuterDataLabelColor(dataLabelSettingsRenderer,
                chart.plotAreaBackgroundColor, _chartState._chartTheme)
            : _getInnerDataLabelColor(
                currentPoint, seriesRenderer, _chartState._chartTheme);
        break;

      default:
        color = Colors.white;
    }
  }
  return _getSaturationColor(color!);
}

/// Get the data label color of open-close series
Color _getOpenCloseDataLabelColor(CartesianChartPoint<dynamic> currentPoint,
    CartesianSeriesRenderer seriesRenderer, SfCartesianChart? chart) {
  Color? color;
  color = seriesRenderer
              ._segments[seriesRenderer._dataPoints!.indexOf(currentPoint)]!
              .fillPaint!
              .style ==
          PaintingStyle.fill
      ? seriesRenderer
          ._segments[seriesRenderer._dataPoints!.indexOf(currentPoint)]!._color
      : const Color.fromRGBO(255, 255, 255, 1);
  return _getSaturationColor(color!);
}

/// To get outer data label color
Color _getOuterDataLabelColor(
        DataLabelSettingsRenderer dataLabelSettingsRenderer,
        Color? backgroundColor,
        SfChartThemeData? theme) =>
    dataLabelSettingsRenderer._color ??
    backgroundColor ??
    (theme!.brightness == Brightness.light
        ? const Color.fromRGBO(255, 255, 255, 1)
        : Colors.black);

///To get inner data label
Color? _getInnerDataLabelColor(CartesianChartPoint<dynamic> currentPoint,
    CartesianSeriesRenderer seriesRenderer, SfChartThemeData? theme) {
  final DataLabelSettingsRenderer dataLabelSettingsRenderer =
      seriesRenderer._dataLabelSettingsRenderer;
  Color? innerColor;
  Color? seriesColor = seriesRenderer._series!.color;
  if (seriesRenderer._seriesType == 'waterfall') {
    seriesColor = _getWaterfallSeriesColor(
        seriesRenderer._series as WaterfallSeries<dynamic, dynamic>?,
        currentPoint,
        seriesColor);
  }
  // ignore: prefer_if_null_operators
  innerColor = dataLabelSettingsRenderer._color != null
      ? dataLabelSettingsRenderer._color
      // ignore: prefer_if_null_operators
      : currentPoint.pointColorMapper != null
          // ignore: prefer_if_null_operators
          ? currentPoint.pointColorMapper
          // ignore: prefer_if_null_operators
          : seriesColor != null
              ? seriesColor
              // ignore: prefer_if_null_operators
              : seriesRenderer._seriesColor != null
                  ? seriesRenderer._seriesColor
                  : theme!.brightness == Brightness.light
                      ? const Color.fromRGBO(255, 255, 255, 1)
                      : Colors.black;
  return innerColor;
}

/// To animate column and bar series
void _animateRectSeries(
    Canvas canvas,
    CartesianSeriesRenderer seriesRenderer,
    Paint? fillPaint,
    RRect? segmentRect,
    num? yPoint,
    double? animationFactor,
    Rect? oldSegmentRect,
    num? oldYValue,
    bool? oldSeriesVisible) {
  final bool comparePrev = seriesRenderer._chartState!._widgetNeedUpdate &&
      oldYValue != null &&
      !seriesRenderer._reAnimate &&
      oldSegmentRect != null;
  final bool isLargePrev = oldYValue != null ? oldYValue > yPoint! : false;
  final bool isSingleSeries = seriesRenderer._chartState!._isLegendToggled!
      ? _checkSingleSeries(seriesRenderer)
      : false;
  if ((seriesRenderer._seriesType == 'column' &&
          seriesRenderer._chart!.isTransposed) ||
      (seriesRenderer._seriesType == 'bar' &&
          !seriesRenderer._chart!.isTransposed) ||
      (seriesRenderer._seriesType == 'histogram' &&
          seriesRenderer._chart!.isTransposed)) {
    _animateTransposedRectSeries(
        canvas,
        seriesRenderer,
        fillPaint!,
        segmentRect!,
        yPoint,
        animationFactor,
        oldSegmentRect,
        oldSeriesVisible,
        comparePrev,
        isLargePrev,
        isSingleSeries);
  } else {
    _animateNormalRectSeries(
        canvas,
        seriesRenderer,
        fillPaint!,
        segmentRect!,
        yPoint,
        animationFactor,
        oldSegmentRect,
        oldSeriesVisible,
        comparePrev,
        isLargePrev,
        isSingleSeries);
  }
}

/// To animate transposed bar and column series
void _animateTransposedRectSeries(
    Canvas canvas,
    CartesianSeriesRenderer seriesRenderer,
    Paint fillPaint,
    RRect segmentRect,
    num? yPoint,
    double? animationFactor,
    Rect? oldSegmentRect,
    bool? oldSeriesVisible,
    bool comparePrev,
    bool isLargePrev,
    bool isSingleSeries) {
  double width = segmentRect.width;
  final double height = segmentRect.height;
  final double top = segmentRect.top;
  double left = segmentRect.left, right = segmentRect.right;
  Rect? rect;
  final num? crossesAt =
      _getCrossesAtValue(seriesRenderer, seriesRenderer._chartState!);
  seriesRenderer._needAnimateSeriesElements =
      seriesRenderer._needAnimateSeriesElements! ||
          segmentRect.outerRect != oldSegmentRect;
  if (!seriesRenderer._chartState!._isLegendToggled! ||
      seriesRenderer._reAnimate) {
    width = segmentRect.width *
        ((!comparePrev &&
                !seriesRenderer._reAnimate &&
                !seriesRenderer._chartState!._initialRender! &&
                oldSegmentRect == null &&
                seriesRenderer._chartState!._oldSeriesKeys
                    .contains(seriesRenderer._series!.key))
            ? 1
            : animationFactor!);
    if (!seriesRenderer._yAxisRenderer!._axis.isInversed) {
      if (comparePrev) {
        if (yPoint! < (crossesAt ?? 0)) {
          left = isLargePrev
              ? oldSegmentRect!.left -
                  (animationFactor! * (oldSegmentRect.left - segmentRect.left))
              : oldSegmentRect!.left +
                  (animationFactor! * (segmentRect.left - oldSegmentRect.left));
          right = segmentRect.right;
          width = right - left;
        } else {
          right = isLargePrev
              ? oldSegmentRect!.right +
                  (animationFactor! *
                      (segmentRect.right - oldSegmentRect.right))
              : oldSegmentRect!.right -
                  (animationFactor! *
                      (oldSegmentRect.right - segmentRect.right));
          width = right - segmentRect.left;
        }
      } else {
        right = yPoint! < (crossesAt ?? 0)
            ? segmentRect.right
            : (segmentRect.right - segmentRect.width) + width;
      }
    } else {
      if (comparePrev) {
        if (yPoint! < (crossesAt ?? 0)) {
          right = isLargePrev
              ? oldSegmentRect!.right +
                  (animationFactor! *
                      (segmentRect.right - oldSegmentRect.right))
              : oldSegmentRect!.right -
                  (animationFactor! *
                      (oldSegmentRect.right - segmentRect.right));
          width = right - segmentRect.left;
        } else {
          left = isLargePrev
              ? oldSegmentRect!.left -
                  (animationFactor! * (oldSegmentRect.left - segmentRect.left))
              : oldSegmentRect!.left +
                  (animationFactor! * (segmentRect.left - oldSegmentRect.left));
          right = segmentRect.right;
          width = right - left;
        }
      } else {
        right = yPoint! < (crossesAt ?? 0)
            ? (segmentRect.right - segmentRect.width) + width
            : segmentRect.right;
      }
    }
    rect = Rect.fromLTWH(right - width, top, width, height);
  } else if (seriesRenderer._chartState!._isLegendToggled! &&
      oldSegmentRect != null) {
    rect = _performTransposedLegendToggleAnimation(seriesRenderer, segmentRect,
        oldSegmentRect, oldSeriesVisible, isSingleSeries, animationFactor);
  }

  canvas.drawRRect(
      RRect.fromRectAndRadius(
          rect ?? segmentRect.middleRect, segmentRect.blRadius),
      fillPaint);
}

/// To perform legend toggled animation on transposed chart
Rect _performTransposedLegendToggleAnimation(
    CartesianSeriesRenderer seriesRenderer,
    RRect segmentRect,
    Rect oldSegmentRect,
    bool? oldSeriesVisible,
    bool isSingleSeries,
    double? animationFactor) {
  final CartesianSeries<dynamic, dynamic>? series = seriesRenderer._series;
  num bottom;
  double height = segmentRect.height;
  double top = segmentRect.top;
  double right = segmentRect.right;
  final double width = segmentRect.width;
  if (oldSeriesVisible != null && oldSeriesVisible) {
    bottom = oldSegmentRect.bottom > segmentRect.bottom
        ? oldSegmentRect.bottom +
            (animationFactor! * (segmentRect.bottom - oldSegmentRect.bottom))
        : oldSegmentRect.bottom -
            (animationFactor! * (oldSegmentRect.bottom - segmentRect.bottom));
    top = oldSegmentRect.top > segmentRect.top
        ? oldSegmentRect.top -
            (animationFactor * (oldSegmentRect.top - segmentRect.top))
        : oldSegmentRect.top +
            (animationFactor * (segmentRect.top - oldSegmentRect.top));
    height = bottom - top;
  } else {
    if (series == seriesRenderer._chart!.series[0] && !isSingleSeries) {
      bottom = segmentRect.bottom;
      top = bottom - (segmentRect.height * animationFactor!);
      height = bottom - top;
    } else if (series ==
            seriesRenderer
                ._chart!.series[seriesRenderer._chart!.series.length - 1] &&
        !isSingleSeries) {
      top = segmentRect.top;
      height = segmentRect.height * animationFactor!;
    } else {
      height = segmentRect.height * animationFactor!;
      top = segmentRect.center.dy - height / 2;
    }
  }
  right = segmentRect.right;
  return Rect.fromLTWH(right - width, top, width, height);
}

/// Rect animation for bar and column series
void _animateNormalRectSeries(
    Canvas canvas,
    CartesianSeriesRenderer seriesRenderer,
    Paint fillPaint,
    RRect segmentRect,
    num? yPoint,
    double? animationFactor,
    Rect? oldSegmentRect,
    bool? oldSeriesVisible,
    bool comparePrev,
    bool isLargePrev,
    bool isSingleSeries) {
  double height = segmentRect.height;
  final double width = segmentRect.width;
  final double left = segmentRect.left;
  double top = segmentRect.top, bottom;
  Rect? rect;
  final num? crossesAt =
      _getCrossesAtValue(seriesRenderer, seriesRenderer._chartState!);
  seriesRenderer._needAnimateSeriesElements =
      seriesRenderer._needAnimateSeriesElements! ||
          segmentRect.outerRect != oldSegmentRect;
  if (!seriesRenderer._chartState!._isLegendToggled! ||
      seriesRenderer._reAnimate) {
    height = segmentRect.height *
        ((!comparePrev &&
                !seriesRenderer._reAnimate &&
                !seriesRenderer._chartState!._initialRender! &&
                oldSegmentRect == null &&
                seriesRenderer._chartState!._oldSeriesKeys
                    .contains(seriesRenderer._series!.key))
            ? 1
            : animationFactor!);
    if (!seriesRenderer._yAxisRenderer!._axis.isInversed) {
      if (comparePrev) {
        if (yPoint! < (crossesAt ?? 0)) {
          bottom = isLargePrev
              ? oldSegmentRect!.bottom -
                  (animationFactor! *
                      (oldSegmentRect.bottom - segmentRect.bottom))
              : oldSegmentRect!.bottom +
                  (animationFactor! *
                      (segmentRect.bottom - oldSegmentRect.bottom));
          height = bottom - top;
        } else {
          top = isLargePrev
              ? oldSegmentRect!.top +
                  (animationFactor! * (segmentRect.top - oldSegmentRect.top))
              : oldSegmentRect!.top -
                  (animationFactor! * (oldSegmentRect.top - segmentRect.top));
          height = segmentRect.bottom - top;
        }
      } else {
        top = yPoint! < (crossesAt ?? 0)
            ? segmentRect.top
            : (segmentRect.top + segmentRect.height) - height;
      }
    } else {
      if (comparePrev) {
        if (yPoint! < (crossesAt ?? 0)) {
          top = isLargePrev
              ? oldSegmentRect!.top +
                  (animationFactor! * (segmentRect.top - oldSegmentRect.top))
              : oldSegmentRect!.top -
                  (animationFactor! * (oldSegmentRect.top - segmentRect.top));
          height = segmentRect.bottom - top;
        } else {
          bottom = isLargePrev
              ? oldSegmentRect!.bottom -
                  (animationFactor! *
                      (oldSegmentRect.bottom - segmentRect.bottom))
              : oldSegmentRect!.bottom +
                  (animationFactor! *
                      (segmentRect.bottom - oldSegmentRect.bottom));
          height = bottom - top;
        }
      } else {
        top = yPoint! < (crossesAt ?? 0)
            ? (segmentRect.top + segmentRect.height) - height
            : segmentRect.top;
      }
    }
    rect = Rect.fromLTWH(left, top, width, height);
  } else if (seriesRenderer._chartState!._isLegendToggled! &&
      oldSegmentRect != null &&
      oldSeriesVisible != null) {
    rect = _performLegendToggleAnimation(seriesRenderer, segmentRect,
        oldSegmentRect, oldSeriesVisible, isSingleSeries, animationFactor);
  }
  canvas.drawRRect(
      RRect.fromRectAndRadius(
          rect ?? segmentRect.middleRect, segmentRect.blRadius),
      fillPaint);
}

/// Perform legend toggle animation
Rect _performLegendToggleAnimation(
    CartesianSeriesRenderer seriesRenderer,
    RRect segmentRect,
    Rect oldSegmentRect,
    bool oldSeriesVisible,
    bool isSingleSeries,
    double? animationFactor) {
  num right;
  final CartesianSeries<dynamic, dynamic>? series = seriesRenderer._series;
  final double height = segmentRect.height;
  double width = segmentRect.width;
  double left = segmentRect.left;
  final double top = segmentRect.top;
  if (oldSeriesVisible) {
    right = oldSegmentRect.right > segmentRect.right
        ? oldSegmentRect.right +
            (animationFactor! * (segmentRect.right - oldSegmentRect.right))
        : oldSegmentRect.right -
            (animationFactor! * (oldSegmentRect.right - segmentRect.right));
    left = oldSegmentRect.left > segmentRect.left
        ? oldSegmentRect.left -
            (animationFactor * (oldSegmentRect.left - segmentRect.left))
        : oldSegmentRect.left +
            (animationFactor * (segmentRect.left - oldSegmentRect.left));
    width = right - left;
  } else {
    if (series == seriesRenderer._chart!.series[0] && !isSingleSeries) {
      left = segmentRect.left;
      width = segmentRect.width * animationFactor!;
    } else if (series ==
            seriesRenderer
                ._chart!.series[seriesRenderer._chart!.series.length - 1] &&
        !isSingleSeries) {
      right = segmentRect.right;
      left = right - (segmentRect.width * animationFactor!);
      width = right - left;
    } else {
      width = segmentRect.width * animationFactor!;
      left = segmentRect.center.dx - width / 2;
    }
  }
  return Rect.fromLTWH(left, top, width, height);
}

/// To animation rect for stacked column series
void _animateStackedRectSeries(
    Canvas canvas,
    RRect segmentRect,
    Paint fillPaint,
    CartesianSeriesRenderer seriesRenderer,
    double animationFactor,
    CartesianChartPoint<dynamic>? currentPoint,
    SfCartesianChartState _chartState) {
  int index, seriesIndex;
  List<CartesianSeriesRenderer> seriesCollection;
  Rect? prevRegion;
  final _StackedSeriesBase<dynamic, dynamic>? series =
      seriesRenderer._series as _StackedSeriesBase<dynamic, dynamic>?;
  index = seriesRenderer._dataPoints!.indexOf(currentPoint);
  seriesCollection = _findSeriesCollection(_chartState);
  seriesIndex = seriesCollection.indexOf(seriesRenderer);
  bool isStackLine = false;
  if (seriesIndex != 0) {
    if (seriesRenderer._chartState!._chartSeries!
                .visibleSeriesRenderers[seriesIndex - 1]
            is StackedLineSeriesRenderer ||
        seriesRenderer._chartState!._chartSeries!
                .visibleSeriesRenderers[seriesIndex - 1]
            is StackedLine100SeriesRenderer) {
      isStackLine = true;
    }
    if (!isStackLine) {
      for (int j = 0;
          j < _chartState._chartSeries!.clusterStackedItemInfo.length;
          j++) {
        final _ClusterStackedItemInfo clusterStackedItemInfo =
            _chartState._chartSeries!.clusterStackedItemInfo[j];
        if (clusterStackedItemInfo.stackName == series!.groupName) {
          if (clusterStackedItemInfo.stackedItemInfo.length >= 2) {
            for (int k = 0;
                k < clusterStackedItemInfo.stackedItemInfo.length;
                k++) {
              final _StackedItemInfo stackedItemInfo =
                  clusterStackedItemInfo.stackedItemInfo[k];
              if (stackedItemInfo.seriesIndex == seriesIndex &&
                  k != 0 &&
                  index <
                      clusterStackedItemInfo.stackedItemInfo[k - 1]
                          .seriesRenderer._dataPoints!.length) {
                if ((currentPoint!.yValue > 0 &&
                        clusterStackedItemInfo.stackedItemInfo[k - 1]
                                .seriesRenderer._dataPoints![index]!.yValue >
                            0) ||
                    (currentPoint.yValue < 0 &&
                        clusterStackedItemInfo.stackedItemInfo[k - 1]
                                .seriesRenderer._dataPoints![index]!.yValue <
                            0)) {
                  prevRegion = clusterStackedItemInfo.stackedItemInfo[k - 1]
                      .seriesRenderer._dataPoints![index]!.region;
                } else {
                  if (k > 1) {
                    prevRegion = clusterStackedItemInfo
                        .stackedItemInfo[(k - 1) - 1]
                        .seriesRenderer
                        ._dataPoints![index]!
                        .region;
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  _drawAnimatedStackedRect(canvas, segmentRect, fillPaint, seriesRenderer,
      animationFactor, currentPoint, index, prevRegion);
}

/// To draw the animated rect for stacked series
void _drawAnimatedStackedRect(
    Canvas canvas,
    RRect segmentRect,
    Paint fillPaint,
    CartesianSeriesRenderer seriesRenderer,
    double animationFactor,
    CartesianChartPoint<dynamic>? currentPoint,
    int index,
    Rect? prevRegion) {
  double top = segmentRect.top, height = segmentRect.height;
  double right = segmentRect.right, width = segmentRect.width;
  final double height1 = segmentRect.height, top1 = segmentRect.top;
  final crossesAt =
      _getCrossesAtValue(seriesRenderer, seriesRenderer._chartState!);
  height = segmentRect.height * animationFactor;
  width = segmentRect.width * animationFactor;
  if ((seriesRenderer._seriesType!.contains('stackedcolumn')) &&
          seriesRenderer._chart!.isTransposed != true ||
      (seriesRenderer._seriesType!.contains('stackedbar')) &&
          seriesRenderer._chart!.isTransposed == true) {
    seriesRenderer._yAxisRenderer!._axis.isInversed != true
        ? seriesRenderer._dataPoints![index]!.y > (crossesAt ?? 0)
            ? prevRegion == null
                ? top = (segmentRect.top + segmentRect.height) - height
                : top = prevRegion.top - height
            : prevRegion == null
                ? top = segmentRect.top
                : top = prevRegion.bottom
        : seriesRenderer._dataPoints![index]!.y > (crossesAt ?? 0)
            ? prevRegion == null
                ? top = segmentRect.top
                : top = prevRegion.bottom
            : prevRegion == null
                ? top = (segmentRect.top + segmentRect.height) - height
                : top = prevRegion.top - height;

    segmentRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(segmentRect.left, top, segmentRect.width, height),
        segmentRect.blRadius);
    currentPoint!.region =
        Rect.fromLTWH(segmentRect.left, top, segmentRect.width, height);
    canvas.drawRRect(segmentRect, fillPaint);
  } else if ((seriesRenderer._seriesType!.contains('stackedcolumn')) &&
          seriesRenderer._chart!.isTransposed == true ||
      (seriesRenderer._seriesType!.contains('stackedbar')) &&
          seriesRenderer._chart!.isTransposed != true) {
    seriesRenderer._yAxisRenderer!._axis.isInversed != true
        ? seriesRenderer._dataPoints![index]!.y > (crossesAt ?? 0)
            ? prevRegion == null
                ? right = (segmentRect.right - segmentRect.width) + width
                : right = prevRegion.right + width
            : prevRegion == null
                ? right = segmentRect.right
                : right = prevRegion.left
        : seriesRenderer._dataPoints![index]!.y > (crossesAt ?? 0)
            ? prevRegion == null
                ? right = segmentRect.right
                : right = prevRegion.left
            : prevRegion == null
                ? right = (segmentRect.right - segmentRect.width) + width
                : right = prevRegion.right + width;

    segmentRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(right - width, top1, width, height1),
        segmentRect.blRadius);
    currentPoint!.region =
        Rect.fromLTWH(segmentRect.left, right, segmentRect.width, width);
    canvas.drawRRect(segmentRect, fillPaint);
  }
}

/// To check the series count
bool _checkSingleSeries(CartesianSeriesRenderer seriesRenderer) {
  int count = 0;
  for (final CartesianSeriesRenderer? seriesRenderer
      in seriesRenderer._chartState!._chartSeries!.visibleSeriesRenderers) {
    if (seriesRenderer!._visible! &&
        (seriesRenderer._seriesType == 'column' ||
            seriesRenderer._seriesType == 'bar')) {
      count++;
    }
  }
  return count == 1 ? true : false;
}

/// to animate dynamic update in line, spline, stepLine series
void _animateLineTypeSeries(
    Canvas canvas,
    CartesianSeriesRenderer seriesRenderer,
    Paint? strokePaint,
    double? animationFactor,
    num? newX1,
    num? newY1,
    num? newX2,
    num? newY2,
    num? oldX1,
    num? oldY1,
    num? oldX2,
    num? oldY2,
    [num? newX3,
    num? newY3,
    num? oldX3,
    num? oldY3,
    num? newX4,
    num? newY4,
    num? oldX4,
    num? oldY4]) {
  num? x1 = newX1;
  num? y1 = newY1;
  num? x2 = newX2;
  num? y2 = newY2;
  num? x3 = newX3;
  num? y3 = newY3;
  num? x4 = newX4;
  num? y4 = newY4;
  y1 = _getAnimateValue(
      animationFactor, y1 as double?, oldY1, newY1, seriesRenderer);
  y2 = _getAnimateValue(
      animationFactor, y2 as double?, oldY2, newY2, seriesRenderer);
  y3 = _getAnimateValue(
      animationFactor, y3 as double?, oldY3, newY3, seriesRenderer);
  y4 = _getAnimateValue(
      animationFactor, y4 as double?, oldY4, newY4, seriesRenderer);
  x1 = _getAnimateValue(
      animationFactor, x1 as double?, oldX1, newX1, seriesRenderer);
  x2 = _getAnimateValue(
      animationFactor, x2 as double?, oldX2, newX2, seriesRenderer);
  x3 = _getAnimateValue(
      animationFactor, x3 as double?, oldX3, newX3, seriesRenderer);
  x4 = _getAnimateValue(
      animationFactor, x4 as double?, oldX4, newX4, seriesRenderer);

  final Path path = Path();
  path.moveTo(x1 as double, y1 as double);
  if (seriesRenderer._seriesType == 'stepline') {
    path.lineTo(x3 as double, y3 as double);
  }
  seriesRenderer._seriesType == 'spline'
      ? path.cubicTo(x3 as double, y3 as double, x4 as double, y4 as double,
          x2 as double, y2 as double)
      : path.lineTo(x2 as double, y2 as double);
  _drawDashedLine(canvas, seriesRenderer._series!.dashArray, strokePaint, path);
}

/// To get value of animation based on animation factor
num? _getAnimateValue(
    double? animationFactor, double? value, num? oldvalue, num? newValue,
    [CartesianSeriesRenderer? seriesRenderer]) {
  if (seriesRenderer != null) {
    seriesRenderer._needAnimateSeriesElements =
        seriesRenderer._needAnimateSeriesElements! || oldvalue != newValue;
  }
  return (oldvalue != null && newValue != null && !oldvalue.isNaN)
      ? ((oldvalue > newValue)
          ? oldvalue - ((oldvalue - newValue) * animationFactor!)
          : oldvalue + ((newValue - oldvalue) * animationFactor!))
      : value;
}

/// To animate scatter series
void _animateScatterSeries(
    CartesianSeriesRenderer seriesRenderer,
    CartesianChartPoint<dynamic> point,
    CartesianChartPoint<dynamic>? _oldPoint,
    double? animationFactor,
    Canvas canvas,
    Paint? fillPaint,
    Paint? strokePaint) {
  final CartesianSeries<dynamic, dynamic> series = seriesRenderer._series!;
  final num width = series.markerSettings.width,
      height = series.markerSettings.height;
  final DataMarkerType markerType = series.markerSettings.shape;
  num? x = point.markerPoint!.x;
  num? y = point.markerPoint!.y;
  if (seriesRenderer._chartState!._widgetNeedUpdate &&
      _oldPoint != null &&
      !seriesRenderer._reAnimate &&
      _oldPoint.markerPoint != null) {
    x = _getAnimateValue(animationFactor, x as double?,
        _oldPoint.markerPoint!.x, x, seriesRenderer);
    y = _getAnimateValue(animationFactor, y as double?,
        _oldPoint.markerPoint!.y, y, seriesRenderer);
    animationFactor = 1;
  }

  final Path path = Path();
  {
    switch (markerType) {
      case DataMarkerType.circle:
        _ChartShapeUtils._drawCircle(path, x as double, y as double,
            animationFactor! * width, animationFactor * height);
        break;
      case DataMarkerType.rectangle:
        _ChartShapeUtils._drawRectangle(path, x as double, y as double,
            animationFactor! * width, animationFactor * height);
        break;
      case DataMarkerType.image:
        _drawImageMarker(seriesRenderer, canvas, x as double?, y as double?);
        break;
      case DataMarkerType.pentagon:
        _ChartShapeUtils._drawPentagon(path, x as double?, y as double?,
            animationFactor! * width, animationFactor * height);
        break;
      case DataMarkerType.verticalLine:
        _ChartShapeUtils._drawVerticalLine(path, x as double, y as double,
            animationFactor! * width, animationFactor * height);
        break;
      case DataMarkerType.invertedTriangle:
        _ChartShapeUtils._drawInvertedTriangle(path, x as double, y as double,
            animationFactor! * width, animationFactor * height);
        break;
      case DataMarkerType.horizontalLine:
        _ChartShapeUtils._drawHorizontalLine(path, x as double, y as double,
            animationFactor! * width, animationFactor * height);
        break;
      case DataMarkerType.diamond:
        _ChartShapeUtils._drawDiamond(path, x as double, y as double,
            animationFactor! * width, animationFactor * height);
        break;
      case DataMarkerType.triangle:
        _ChartShapeUtils._drawTriangle(path, x as double, y as double,
            animationFactor! * width, animationFactor * height);
        break;
      case DataMarkerType.none:
        break;
    }
  }
  canvas.drawPath(path, strokePaint!);
  canvas.drawPath(path, fillPaint!);
}

/// To animate bubble series
void _animateBubbleSeries(
    Canvas canvas,
    num? newX,
    num? newY,
    num? oldX,
    num? oldY,
    num? oldSize,
    double? animationFactor,
    num? radius,
    Paint strokePaint,
    Paint fillPaint,
    CartesianSeriesRenderer? seriesRenderer) {
  num? x = newX;
  num? y = newY;
  num? size = radius;
  x = _getAnimateValue(
      animationFactor, x as double?, oldX, newX, seriesRenderer);
  y = _getAnimateValue(
      animationFactor, y as double?, oldY, newY, seriesRenderer);
  size = _getAnimateValue(
      animationFactor, size as double?, oldSize, radius, seriesRenderer);
  canvas.drawCircle(
      Offset(x as double, y as double), size as double, fillPaint);
  canvas.drawCircle(Offset(x, y), size, strokePaint);
}

/// To animates range column series
void _animateRangeColumn(
    Canvas canvas,
    CartesianSeriesRenderer? seriesRenderer,
    Paint fillPaint,
    RRect segmentRect,
    Rect? oldSegmentRect,
    double? animationFactor) {
  double? height = segmentRect.height;
  double? width = segmentRect.width;
  double? left = segmentRect.left;
  double? top = segmentRect.top;
  if (oldSegmentRect == null || seriesRenderer!._reAnimate) {
    if (!seriesRenderer!._chart!.isTransposed) {
      height = segmentRect.height * animationFactor!;
      top = segmentRect.center.dy - height / 2;
    } else {
      width = segmentRect.width * animationFactor!;
      left = segmentRect.center.dx - width / 2;
    }
  } else {
    if (!seriesRenderer._chart!.isTransposed) {
      height = _getAnimateValue(animationFactor, height, oldSegmentRect.height,
          segmentRect.height, seriesRenderer) as double?;
      top = _getAnimateValue(animationFactor, top, oldSegmentRect.top,
          segmentRect.top, seriesRenderer) as double?;
    } else {
      width = _getAnimateValue(animationFactor, width, oldSegmentRect.width,
          segmentRect.width, seriesRenderer) as double?;
      left = _getAnimateValue(animationFactor, left, oldSegmentRect.left,
          segmentRect.left, seriesRenderer) as double?;
    }
  }
  canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(left!, top!, width!, height!), segmentRect.blRadius),
      fillPaint);
}

// To animate linear type animation
void _performLinearAnimation(SfCartesianChartState chartState, ChartAxis? axis,
    Canvas canvas, double animationFactor) {
  chartState._chart.isTransposed
      ? canvas.clipRect(Rect.fromLTRB(
          0,
          axis!.isInversed
              ? 0
              : (1 - animationFactor) *
                  chartState._chartAxis!._axisClipRect!.bottom,
          chartState._chartAxis!._axisClipRect!.left +
              chartState._chartAxis!._axisClipRect!.width,
          axis.isInversed
              ? animationFactor *
                  (chartState._chartAxis!._axisClipRect!.top +
                      chartState._chartAxis!._axisClipRect!.height)
              : chartState._chartAxis!._axisClipRect!.top +
                  chartState._chartAxis!._axisClipRect!.height))
      : canvas.clipRect(Rect.fromLTRB(
          axis!.isInversed
              ? (1 - animationFactor) *
                  (chartState._chartAxis!._axisClipRect!.right)
              : 0,
          0,
          axis.isInversed
              ? chartState._chartAxis!._axisClipRect!.left +
                  chartState._chartAxis!._axisClipRect!.width
              : animationFactor *
                  (chartState._chartAxis!._axisClipRect!.left +
                      chartState._chartAxis!._axisClipRect!.width),
          chartState._chartAxis!._axisClipRect!.top +
              chartState._chartAxis!._axisClipRect!.height));
}

/// To animate Hilo series
void _animateHiloSeries(
    bool transposed,
    _ChartLocation? newLow,
    _ChartLocation? newHigh,
    _ChartLocation? oldLow,
    _ChartLocation? oldHigh,
    double? animationFactor,
    Paint? paint,
    Canvas canvas,
    CartesianSeriesRenderer? seriesRenderer) {
  if (transposed) {
    num? lowX = newLow!.x;
    num? highX = newHigh!.x;
    num? y = newLow.y;
    y = _getAnimateValue(
        animationFactor, y as double?, oldLow?.y, newLow.y, seriesRenderer);
    lowX = _getAnimateValue(
        animationFactor, lowX as double?, oldLow?.x, newLow.x, seriesRenderer);
    highX = _getAnimateValue(animationFactor, highX as double?, oldHigh?.x,
        newHigh.x, seriesRenderer);
    canvas.drawLine(Offset(lowX as double, y as double),
        Offset(highX as double, y), paint!);
  } else {
    num? low = newLow!.y;
    num? high = newHigh!.y;
    num? x = newLow.x;
    x = _getAnimateValue(
        animationFactor, x as double?, oldLow?.x, newLow.x, seriesRenderer);
    low = _getAnimateValue(
        animationFactor, low as double?, oldLow?.y, newLow.y, seriesRenderer);
    high = _getAnimateValue(animationFactor, high as double?, oldHigh?.y,
        newHigh.y, seriesRenderer);
    canvas.drawLine(
        Offset(x as double, low as double), Offset(x, high as double), paint!);
  }
}

/// To animate the Hilo open-close series
void _animateHiloOpenCloseSeries(
    bool transposed,
    num? newLow,
    num? newHigh,
    num? oldLow,
    num? oldHigh,
    num? newOpenX,
    num? newOpenY,
    num? newCloseX,
    num? newCloseY,
    num? newCenterLow,
    num? newCenterHigh,
    num? oldOpenX,
    num? oldOpenY,
    num? oldCloseX,
    num? oldCloseY,
    num? oldCenterLow,
    num? oldCenterHigh,
    double? animationFactor,
    Paint? paint,
    Canvas canvas,
    CartesianSeriesRenderer? seriesRenderer) {
  num? low = newLow;
  num? high = newHigh;
  num? openX = newOpenX;
  num? openY = newOpenY;
  num? closeX = newCloseX;
  num? closeY = newCloseY;
  num? centerHigh = newCenterHigh;
  num? centerLow = newCenterLow;
  low = _getAnimateValue(
      animationFactor, low as double?, oldLow, newLow, seriesRenderer);
  high = _getAnimateValue(
      animationFactor, high as double?, oldHigh, newHigh, seriesRenderer);
  openX = _getAnimateValue(
      animationFactor, openX as double?, oldOpenX, newOpenX, seriesRenderer);
  openY = _getAnimateValue(
      animationFactor, openY as double?, oldOpenY, newOpenY, seriesRenderer);
  closeX = _getAnimateValue(
      animationFactor, closeX as double?, oldCloseX, newCloseX, seriesRenderer);
  closeY = _getAnimateValue(
      animationFactor, closeY as double?, oldCloseY, newCloseY, seriesRenderer);
  centerHigh = _getAnimateValue(animationFactor, centerHigh as double?,
      oldCenterHigh, newCenterHigh, seriesRenderer);
  centerLow = _getAnimateValue(animationFactor, centerLow as double?,
      oldCenterLow, newCenterLow, seriesRenderer);
  if (transposed) {
    canvas.drawLine(Offset(low as double, centerLow as double),
        Offset(high as double, centerHigh as double), paint!);
    canvas.drawLine(Offset(openX as double, openY as double),
        Offset(openX, centerHigh), paint);
    canvas.drawLine(Offset(closeX as double, centerLow),
        Offset(closeX, closeY as double), paint);
  } else {
    canvas.drawLine(Offset(centerHigh as double, low as double),
        Offset(centerLow as double, high as double), paint!);
    canvas.drawLine(Offset(openX as double, openY as double),
        Offset(centerHigh, openY), paint);
    canvas.drawLine(Offset(centerLow, closeY as double),
        Offset(closeX as double, closeY), paint);
  }
}

/// To animate the box and whisker series
void _animateBoxSeries(
    bool showMean,
    Offset meanPosition,
    Offset transposedMeanPosition,
    Size size,
    num? max,
    bool transposed,
    num? lowerQuartile1,
    num? upperQuartile1,
    num? newMin,
    num? newMax,
    num? oldMin,
    num? oldMax,
    num? newLowerQuartileX,
    num? newLowerQuartileY,
    num? newUpperQuartileX,
    num? newUpperQuartileY,
    num? newCenterMin,
    num? newCenterMax,
    num? oldLowerQuartileX,
    num? oldLowerQuartileY,
    num? oldUpperQuartileX,
    num? oldUpperQuartileY,
    num? oldCenterMin,
    num? oldCenterMax,
    num? medianX,
    num? medianY,
    double? animationFactor,
    Paint fillPaint,
    Paint? strokePaint,
    Canvas canvas,
    CartesianSeriesRenderer seriesRenderer) {
  final num? lowerQuartile = lowerQuartile1;
  final num? upperQuartile = upperQuartile1;
  num? minY = newMin;
  num? maxY = newMax;
  num? lowerQuartileX = newLowerQuartileX;
  num? lowerQuartileY = newLowerQuartileY;
  num? upperQuartileX = newUpperQuartileX;
  num? upperQuartileY = newUpperQuartileY;
  num? centerMax = newCenterMax;
  num? centerMin = newCenterMin;
  minY = _getAnimateValue(
      animationFactor, minY as double?, oldMin, newMin, seriesRenderer);
  maxY = _getAnimateValue(
      animationFactor, maxY as double?, oldMax, newMax, seriesRenderer);
  lowerQuartileX = _getAnimateValue(animationFactor, lowerQuartileX as double?,
      oldLowerQuartileX, newLowerQuartileX, seriesRenderer);
  lowerQuartileY = _getAnimateValue(animationFactor, lowerQuartileY as double?,
      oldLowerQuartileY, newLowerQuartileY, seriesRenderer);
  upperQuartileX = _getAnimateValue(animationFactor, upperQuartileX as double?,
      oldUpperQuartileX, newUpperQuartileX, seriesRenderer);
  upperQuartileY = _getAnimateValue(animationFactor, upperQuartileY as double?,
      oldUpperQuartileY, newUpperQuartileY, seriesRenderer);
  centerMax = _getAnimateValue(animationFactor, centerMax as double?,
      oldCenterMax, newCenterMax, seriesRenderer);
  centerMin = _getAnimateValue(animationFactor, centerMin as double?,
      oldCenterMin, newCenterMin, seriesRenderer);
  final Path path = Path();
  if (!transposed && lowerQuartile! > upperQuartile!) {
    final num? temp = upperQuartileY;
    upperQuartileY = lowerQuartileY;
    lowerQuartileY = temp;
  }
  if (transposed) {
    path.moveTo(centerMax as double, upperQuartileY as double);
    path.lineTo(centerMax, lowerQuartileY as double);
    path.moveTo(centerMax, maxY as double);
    if (centerMax < upperQuartileX!) {
      path.lineTo(upperQuartileX as double, maxY);
    } else {
      path.lineTo(upperQuartileX as double, maxY);
    }
    path.moveTo(medianX as double, upperQuartileY);
    path.lineTo(medianX, lowerQuartileY);
    path.moveTo(centerMin as double, maxY);
    if (centerMin > lowerQuartileX!) {
      path.lineTo(lowerQuartileX as double, maxY);
    } else {
      path.lineTo(lowerQuartileX as double, maxY);
    }
    path.moveTo(centerMin, upperQuartileY);
    path.lineTo(centerMin, lowerQuartileY);
    if (showMean) {
      _drawMeanValuePath(
          seriesRenderer,
          animationFactor,
          transposedMeanPosition.dy,
          transposedMeanPosition.dx,
          size,
          strokePaint,
          canvas);
    }
    if (lowerQuartileX == upperQuartileX) {
      canvas.drawLine(Offset(lowerQuartileX, lowerQuartileY),
          Offset(upperQuartileX, upperQuartileY), fillPaint);
    } else {
      path.moveTo(upperQuartileX, upperQuartileY);
      path.lineTo(upperQuartileX, lowerQuartileY);
      path.lineTo(lowerQuartileX, lowerQuartileY);
      path.lineTo(lowerQuartileX, upperQuartileY);
      path.lineTo(upperQuartileX, upperQuartileY);
      path.close();
    }
  } else {
    if (lowerQuartile! > upperQuartile!) {
      final num? temp = upperQuartileY;
      upperQuartileY = lowerQuartileY;
      lowerQuartileY = temp;
    }
    canvas.drawLine(Offset(lowerQuartileX as double, maxY as double),
        Offset(upperQuartileX as double, maxY), strokePaint!);
    canvas.drawLine(Offset(centerMax as double, upperQuartileY as double),
        Offset(centerMax, maxY), strokePaint);
    canvas.drawLine(Offset(lowerQuartileX, medianY as double),
        Offset(upperQuartileX, medianY), strokePaint);
    canvas.drawLine(Offset(centerMin as double, lowerQuartileY as double),
        Offset(centerMin, minY as double), strokePaint);
    canvas.drawLine(Offset(lowerQuartileX, minY), Offset(upperQuartileX, minY),
        strokePaint);
    if (showMean) {
      _drawMeanValuePath(seriesRenderer, animationFactor, meanPosition.dx,
          meanPosition.dy, size, strokePaint, canvas);
    }
    if (lowerQuartileY == upperQuartileY) {
      canvas.drawLine(Offset(lowerQuartileX, lowerQuartileY),
          Offset(upperQuartileX, upperQuartileY), fillPaint);
    } else {
      path.moveTo(lowerQuartileX, lowerQuartileY);
      path.lineTo(upperQuartileX, lowerQuartileY);
      path.lineTo(upperQuartileX, upperQuartileY);
      path.lineTo(lowerQuartileX, upperQuartileY);
      path.lineTo(lowerQuartileX, lowerQuartileY);
      path.close();
    }
  }
  if (seriesRenderer._series!.dashArray[0] != 0 &&
      seriesRenderer._series!.dashArray[1] != 0 &&
      seriesRenderer._series!.animationDuration <= 0) {
    canvas.drawPath(path, fillPaint);
    _drawDashedLine(
        canvas, seriesRenderer._series!.dashArray, strokePaint, path);
  } else {
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint!);
  }
  if (fillPaint.style == PaintingStyle.fill) {
    if (transposed) {
      canvas.drawLine(Offset(centerMax, upperQuartileY),
          Offset(centerMax, lowerQuartileY), strokePaint!);
      canvas.drawLine(
          Offset(centerMax, maxY), Offset(upperQuartileX, maxY), strokePaint);
      canvas.drawLine(Offset(medianX as double, upperQuartileY),
          Offset(medianX, lowerQuartileY), strokePaint);
      canvas.drawLine(
          Offset(centerMin, maxY), Offset(lowerQuartileX, maxY), strokePaint);
      canvas.drawLine(Offset(centerMin, upperQuartileY),
          Offset(centerMin, lowerQuartileY), strokePaint);
      if (showMean) {
        _drawMeanValuePath(
            seriesRenderer,
            animationFactor,
            transposedMeanPosition.dy,
            transposedMeanPosition.dx,
            size,
            strokePaint,
            canvas);
      }
    } else {
      canvas.drawLine(Offset(lowerQuartileX, maxY),
          Offset(upperQuartileX, maxY), strokePaint!);
      canvas.drawLine(Offset(centerMax, upperQuartileY),
          Offset(centerMax, maxY), strokePaint);
      canvas.drawLine(Offset(lowerQuartileX, medianY as double),
          Offset(upperQuartileX, medianY), strokePaint);
      canvas.drawLine(Offset(centerMin, lowerQuartileY),
          Offset(centerMin, minY as double), strokePaint);
      canvas.drawLine(Offset(lowerQuartileX, minY),
          Offset(upperQuartileX, minY), strokePaint);
      if (showMean) {
        _drawMeanValuePath(seriesRenderer, animationFactor, meanPosition.dx,
            meanPosition.dy, size, strokePaint, canvas);
      }
    }
  }
}

/// To draw the path of mean value in box plot series.
void _drawMeanValuePath(
    CartesianSeriesRenderer seriesRenderer,
    double? animationFactor,
    num x,
    num y,
    Size size,
    Paint? strokePaint,
    Canvas canvas) {
  if (seriesRenderer._series!.animationDuration <= 0 ||
      animationFactor! >= seriesRenderer._chartState!._seriesDurationFactor) {
    canvas.drawLine(Offset(x + size.width / 2, y - size.height / 2),
        Offset(x - size.width / 2, y + size.height / 2), strokePaint!);
    canvas.drawLine(Offset(x + size.width / 2, y + size.height / 2),
        Offset(x - size.width / 2, y - size.height / 2), strokePaint);
  }
}

/// To animate the candle series
void _animateCandleSeries(
    bool? showSameValue,
    num? high,
    bool transposed,
    num? open1,
    num? close1,
    num? newLow,
    num? newHigh,
    num? oldLow,
    num? oldHigh,
    num? newOpenX,
    num? newOpenY,
    num? newCloseX,
    num? newCloseY,
    num? newCenterLow,
    num? newCenterHigh,
    num? oldOpenX,
    num? oldOpenY,
    num? oldCloseX,
    num? oldCloseY,
    num? oldCenterLow,
    num? oldCenterHigh,
    double? animationFactor,
    Paint paint,
    Canvas canvas,
    CartesianSeriesRenderer seriesRenderer) {
  final num? open = open1;
  final num? close = close1;
  num? lowY = newLow;
  num? highY = newHigh;
  num? openX = newOpenX;
  num? openY = newOpenY;
  num? closeX = newCloseX;
  num? closeY = newCloseY;
  num? centerHigh = newCenterHigh;
  num? centerLow = newCenterLow;
  lowY = _getAnimateValue(
      animationFactor, lowY as double?, oldLow, newLow, seriesRenderer);
  highY = _getAnimateValue(
      animationFactor, highY as double?, oldHigh, newHigh, seriesRenderer);
  openX = _getAnimateValue(
      animationFactor, openX as double?, oldOpenX, newOpenX, seriesRenderer);
  openY = _getAnimateValue(
      animationFactor, openY as double?, oldOpenY, newOpenY, seriesRenderer);
  closeX = _getAnimateValue(
      animationFactor, closeX as double?, oldCloseX, newCloseX, seriesRenderer);
  closeY = _getAnimateValue(
      animationFactor, closeY as double?, oldCloseY, newCloseY, seriesRenderer);
  centerHigh = _getAnimateValue(animationFactor, centerHigh as double?,
      oldCenterHigh, newCenterHigh, seriesRenderer);
  centerLow = _getAnimateValue(animationFactor, centerLow as double?,
      oldCenterLow, newCenterLow, seriesRenderer);
  final Path path = Path();
  if (!transposed && open! > close!) {
    final num? temp = closeY;
    closeY = openY;
    openY = temp;
  }
  if (transposed) {
    if (showSameValue!) {
      canvas.drawLine(Offset(centerHigh as double, highY as double),
          Offset(centerLow as double, highY), paint);
    } else {
      path.moveTo(centerHigh as double, highY as double);
      if (centerHigh < closeX!) {
        path.lineTo(closeX as double, highY);
      } else {
        path.lineTo(closeX as double, highY);
      }
      path.moveTo(centerLow as double, highY);
      if (centerLow > openX!) {
        path.lineTo(openX as double, highY);
      } else {
        path.lineTo(openX as double, highY);
      }
    }
    if (openX == closeX) {
      canvas.drawLine(Offset(openX as double, openY as double),
          Offset(closeX as double, closeY as double), paint);
    } else {
      path.moveTo(closeX as double, closeY as double);
      path.lineTo(closeX, openY as double);
      path.lineTo(openX as double, openY);
      path.lineTo(openX, closeY);
      path.lineTo(closeX, closeY);
      path.close();
    }
  } else {
    if (open! > close!) {
      final num? temp = closeY;
      closeY = openY;
      openY = temp;
    }
    if (showSameValue!) {
      canvas.drawLine(Offset(centerHigh as double, high as double),
          Offset(centerHigh, lowY as double), paint);
    } else {
      canvas.drawLine(Offset(centerHigh as double, closeY as double),
          Offset(centerHigh, highY as double), paint);
      canvas.drawLine(Offset(centerLow as double, openY as double),
          Offset(centerLow, lowY as double), paint);
    }
    if (openY == closeY) {
      canvas.drawLine(Offset(openX as double, openY as double),
          Offset(closeX as double, closeY as double), paint);
    } else {
      path.moveTo(openX as double, openY as double);
      path.lineTo(closeX as double, openY);
      path.lineTo(closeX, closeY as double);
      path.lineTo(openX, closeY);
      path.lineTo(openX, openY);
      path.close();
    }
  }
  if (seriesRenderer._series!.dashArray[0] != 0 &&
      seriesRenderer._series!.dashArray[1] != 0 &&
      paint.style != PaintingStyle.fill &&
      seriesRenderer._series!.animationDuration <= 0) {
    _drawDashedLine(canvas, seriesRenderer._series!.dashArray, paint, path);
  } else {
    canvas.drawPath(path, paint);
  }
  if (paint.style == PaintingStyle.fill) {
    if (transposed) {
      if (open! > close!) {
        if (showSameValue) {
          canvas.drawLine(Offset(centerHigh, highY as double),
              Offset(centerLow as double, highY), paint);
        } else {
          canvas.drawLine(Offset(centerHigh, highY as double),
              Offset(closeX, highY), paint);
          canvas.drawLine(
              Offset(centerLow as double, highY), Offset(openX, highY), paint);
        }
      } else {
        if (showSameValue) {
          canvas.drawLine(Offset(centerHigh, highY as double),
              Offset(centerLow as double, highY), paint);
        } else {
          canvas.drawLine(Offset(centerHigh, highY as double),
              Offset(closeX, highY), paint);
          canvas.drawLine(
              Offset(centerLow as double, highY), Offset(openX, highY), paint);
        }
      }
    } else {
      if (showSameValue) {
        canvas.drawLine(Offset(centerHigh, high as double),
            Offset(centerHigh, lowY as double), paint);
      } else {
        canvas.drawLine(Offset(centerHigh, closeY),
            Offset(centerHigh, highY as double), paint);
        canvas.drawLine(Offset(centerLow as double, openY),
            Offset(centerLow, lowY as double), paint);
      }
    }
  }
}

// To get nearest chart points from the touch point
List<CartesianChartPoint<dynamic>> _getNearestChartPoints(
    double pointX,
    double pointY,
    ChartAxisRenderer actualXAxisRenderer,
    ChartAxisRenderer actualYAxisRenderer,
    CartesianSeriesRenderer cartesianSeriesRenderer,
    [List<CartesianChartPoint<dynamic>?>? firstNearestDataPoints]) {
  final List<CartesianChartPoint<dynamic>> dataPointList =
      <CartesianChartPoint<dynamic>>[];
  List<CartesianChartPoint<dynamic>?>? dataList =
      <CartesianChartPoint<dynamic>>[];
  final List<num?> xValues = <num?>[];
  final List<num?> yValues = <num?>[];

  firstNearestDataPoints != null
      ? dataList = firstNearestDataPoints
      : dataList = cartesianSeriesRenderer._dataPoints;

  for (int i = 0; i < dataList!.length; i++) {
    xValues.add(dataList[i]!.xValue);
    if (cartesianSeriesRenderer is BoxAndWhiskerSeriesRenderer) {
      yValues.add((dataList[i]!.maximum! + dataList[i]!.minimum!) / 2);
    } else {
      yValues.add(
          dataList[i]!.yValue ?? (dataList[i]!.high + dataList[i]!.low) / 2);
    }
  }
  num? nearPointX = actualXAxisRenderer._visibleRange!.minimum;
  num? nearPointY = actualYAxisRenderer._visibleRange!.minimum;

  final Rect rect = _calculatePlotOffset(
      cartesianSeriesRenderer._chartState!._chartAxis!._axisClipRect!,
      Offset(cartesianSeriesRenderer._xAxisRenderer!._axis.plotOffset,
          cartesianSeriesRenderer._yAxisRenderer!._axis.plotOffset));

  final num? touchXValue = _pointToXValue(
      cartesianSeriesRenderer._chartState!._requireInvertedAxis,
      actualXAxisRenderer,
      actualXAxisRenderer._axis.isVisible
          ? actualXAxisRenderer._bounds
          : cartesianSeriesRenderer._chartState!._chartAxis!._axisClipRect,
      pointX - rect.left,
      pointY - rect.top);
  final num? touchYValue = _pointToYValue(
      cartesianSeriesRenderer._chartState!._requireInvertedAxis,
      actualYAxisRenderer,
      actualYAxisRenderer._axis.isVisible
          ? actualYAxisRenderer._bounds
          : cartesianSeriesRenderer._chartState!._chartAxis!._axisClipRect,
      pointX - rect.left,
      pointY - rect.top);
  double delta = 0;
  for (int i = 0; i < dataList.length; i++) {
    final double currX = xValues[i]!.toDouble();
    final double currY = yValues[i]!.toDouble();
    if (delta == touchXValue! - currX) {
      final CartesianChartPoint<dynamic> dataPoint = dataList[i]!;
      if (dataPoint.isDrop != true && dataPoint.isGap != true) {
        if ((touchYValue! - currY).abs() > (touchYValue - nearPointY!).abs()) {
          dataPointList.clear();
        }
        dataPointList.add(dataPoint);
      }
    } else if ((touchXValue - currX).abs() <=
        (touchXValue - nearPointX!).abs()) {
      nearPointX = currX;
      nearPointY = currY;
      delta = touchXValue - currX;
      final CartesianChartPoint<dynamic> dataPoint = dataList[i]!;
      dataPointList.clear();
      if (dataPoint.isDrop != true && dataPoint.isGap != true) {
        dataPointList.add(dataPoint);
      }
    }
  }
  return dataPointList;
}

/// Return the arguments for zoom event
ZoomPanArgs _bindZoomEvent(
    SfCartesianChart chart,
    ChartAxisRenderer axisRenderer,
    ZoomPanArgs? zoomPanArgs,
    ChartZoomingCallback? zoomEventType) {
  zoomPanArgs = ZoomPanArgs(axisRenderer._axis,
      axisRenderer._previousZoomPosition, axisRenderer._previousZoomFactor);
  zoomPanArgs.currentZoomFactor = axisRenderer._zoomFactor;
  zoomPanArgs.currentZoomPosition = axisRenderer._zoomPosition;
  zoomEventType == chart.onZoomStart
      ? chart.onZoomStart!(zoomPanArgs)
      : zoomEventType == chart.onZoomEnd
          ? chart.onZoomEnd!(zoomPanArgs)
          : zoomEventType == chart.onZooming
              ? chart.onZooming!(zoomPanArgs)
              : chart.onZoomReset!(zoomPanArgs);

  return zoomPanArgs;
}

//Method to returning path for dashed border in rect type series
Path _findingRectSeriesDashedBorder(
    CartesianChartPoint<dynamic> currentPoint, double borderWidth) {
  Path path;
  Offset topLeft, topRight, bottomRight, bottomLeft;
  double width;
  topLeft = currentPoint.region!.topLeft;
  topRight = currentPoint.region!.topRight;
  bottomLeft = currentPoint.region!.bottomLeft;
  bottomRight = currentPoint.region!.bottomRight;
  width = borderWidth / 2;
  path = Path();
  path.moveTo(topLeft.dx + width, topLeft.dy + width);
  path.lineTo(topRight.dx - width, topRight.dy + width);
  path.lineTo(bottomRight.dx - width, bottomRight.dy - width);
  path.lineTo(bottomLeft.dx + width, bottomLeft.dy - width);
  path.lineTo(topLeft.dx + width, topLeft.dy + width);
  path.close();
  return path;
}

/// below method is for getting image from the imageprovider
Future<dart_ui.Image> _getImageInfo(ImageProvider imageProvider) async {
  final Completer<ImageInfo> completer = Completer<ImageInfo>();
  imageProvider
      .resolve(const ImageConfiguration())
      .addListener(ImageStreamListener((ImageInfo info, bool _) {
    completer.complete(info);
    completer.future;
  }));
  final ImageInfo imageInfo = await completer.future;
  return imageInfo.image;
}

//ignore: avoid_void_async
void _calculateImage(
    [dynamic chartState,
    dynamic seriesRenderer,
    TrackballBehavior? trackballBehavior]) async {
  final dynamic chart = chartState?._chart;
  if (chart != null && seriesRenderer == null) {
    if (chart.plotAreaBackgroundImage != null) {
      chartState._backgroundImage =
          await _getImageInfo(chart.plotAreaBackgroundImage);
      chartState._renderAxis.state.axisRepaintNotifier.value++;
    }
    if (chart.legend.image != null) {
      chartState._legendIconImage = await _getImageInfo(chart.legend.image);
      chartState._chartLegend.legendRepaintNotifier.value++;
    }
  } else if (trackballBehavior != null &&
      trackballBehavior.markerSettings!.image != null) {
    chartState._trackballMarkerSettingsRenderer._image =
        await _getImageInfo(trackballBehavior.markerSettings!.image!);
    chartState._trackballRepaintNotifier.value++;
  } else {
    final CartesianSeries<dynamic, dynamic> series = seriesRenderer._series;
    // final MarkerSettingsRenderer markerSettingsRenderer = seriesRenderer._markerSettingsRenderer;
    if (series.markerSettings.image != null) {
      seriesRenderer._markerSettingsRenderer._image =
          await _getImageInfo(series.markerSettings.image!);
      seriesRenderer._repaintNotifier.value++;
      if (seriesRenderer._seriesType == 'scatter' &&
          seriesRenderer._chart.legend.isVisible) {
        seriesRenderer._chartState._chartLegend.legendRepaintNotifier.value++;
      }
    }
  }
}
