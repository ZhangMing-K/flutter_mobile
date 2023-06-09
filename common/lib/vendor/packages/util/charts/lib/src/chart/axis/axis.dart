part of charts;

/// This class holds the properties of ChartAxis.
///
/// Charts typically have two axes that are used to measure and categorize data: a vertical (Y) axis, and a horizontal (X) axis.
/// Vertical(Y) axis always uses a numerical scale. Horizontal(X) axis supports Category, Numeric, Date-time, Logarithmic.
///
/// Provides the options for plotOffset, series visible, axis title, label padding, and alignment to customize the appearance.
///
abstract class ChartAxis {
  /// Creating an argument constructor of ChartAxis class.
  ChartAxis({
    this.name,
    double? plotOffset,
    bool? isVisible,
    bool? anchorRangeToVisiblePoints,
    AxisTitle? title,
    AxisLine? axisLine,
    ChartRangePadding? rangePadding,
    int? labelRotation,
    ChartDataLabelPosition? labelPosition,
    LabelAlignment? labelAlignment,
    TickPosition? tickPosition,
    MajorTickLines? majorTickLines,
    MinorTickLines? minorTickLines,
    TextStyle? labelStyle,
    AxisLabelIntersectAction? labelIntersectAction,
    this.desiredIntervals,
    MajorGridLines? majorGridLines,
    MinorGridLines? minorGridLines,
    int? maximumLabels,
    int? minorTicksPerInterval,
    bool? isInversed,
    bool? opposedPosition,
    EdgeLabelPlacement? edgeLabelPlacement,
    bool? enableAutoIntervalOnZooming,
    double? zoomFactor,
    double? zoomPosition,
    InteractiveTooltip? interactiveTooltip,
    this.interval,
    this.crossesAt,
    this.associatedAxisName,
    bool? placeLabelsNearAxisLine,
    List<PlotBand>? plotBands,
    this.rangeController,
  })  : isVisible = isVisible ?? true,
        anchorRangeToVisiblePoints = anchorRangeToVisiblePoints ?? true,
        interactiveTooltip = interactiveTooltip ?? InteractiveTooltip(),
        isInversed = isInversed ?? false,
        plotOffset = plotOffset ?? 0,
        placeLabelsNearAxisLine = placeLabelsNearAxisLine ?? true,
        opposedPosition = opposedPosition ?? false,
        rangePadding = rangePadding ?? ChartRangePadding.auto,
        labelRotation = labelRotation ?? 0,
        labelPosition = labelPosition ?? ChartDataLabelPosition.outside,
        labelAlignment = labelAlignment ?? LabelAlignment.center,
        tickPosition = tickPosition ?? TickPosition.outside,
        labelIntersectAction =
            labelIntersectAction ?? AxisLabelIntersectAction.hide,
        minorTicksPerInterval = minorTicksPerInterval ?? 0,
        maximumLabels = maximumLabels ?? 3,
        labelStyle = _getTextStyle(
            textStyle: labelStyle,
            fontSize: 12.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal,
            fontFamily: 'Normal'),
        title = title ?? AxisTitle(),
        axisLine = axisLine ?? AxisLine(),
        majorTickLines = majorTickLines ?? MajorTickLines(),
        minorTickLines = minorTickLines ?? MinorTickLines(),
        majorGridLines = majorGridLines ?? MajorGridLines(),
        minorGridLines = minorGridLines ?? MinorGridLines(),
        edgeLabelPlacement = edgeLabelPlacement ?? EdgeLabelPlacement.none,
        zoomFactor = zoomFactor ?? 1,
        zoomPosition = zoomPosition ?? 0,
        enableAutoIntervalOnZooming = enableAutoIntervalOnZooming ?? true,
        plotBands = plotBands ?? <PlotBand>[];

  ///Toggles the visibility of the axis.
  ///
  ///Visibility of all the elements in the axis
  ///such as title, labels, major tick lines, and major grid lines will be toggled together.
  ///
  ///Defaults to `true`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(isVisible: false),
  ///        ));
  ///}
  ///```
  final bool isVisible;

  ///Determines the value axis range, based on the visible data points or based
  /// on the overall data points available in chart.
  ///
  ///By default, value axis range will be calculated automatically based on the visible data points on
  /// dynamic changes. The visible data points are changed on performing interactions like pinch
  /// zooming, selection zooming, panning and also on specifying [visibleMinimum] and [visibleMaximum] values.
  ///
  ///To toggle this functionality, this property can be used. i.e. on setting false to this property,
  /// value axis range will be calculated based on all the data points in chart irrespective of
  /// visible points.
  ///
  ///_Note:_ This is applicable only to the value axis and not for other axis.
  ///
  ///Defaults to `true`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryYAxis: NumericAxis(anchorRangeToVisiblePoints: false),
  ///        ));
  ///}
  ///```
  final bool anchorRangeToVisiblePoints;

  ///Customizes the appearance of the axis line. The axis line is visible by default.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(axisLine: AxisLine(width: 10)),
  ///        ));
  ///}
  ///```
  final AxisLine axisLine;

  ///Customizes the appearance of the major tick lines.
  ///
  ///Major ticks are small lines
  ///used to indicate the intervals in an axis. Major tick lines are visible by default.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(majorTickLines: MajorTickLines(width: 2)),
  ///        ));
  ///}
  ///```
  final MajorTickLines majorTickLines;

  ///Customizes the appearance of the minor tick lines.
  ///
  /// Minor ticks are small lines
  ///used to indicate the minor intervals between a major interval
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(minorTickLines: MinorTickLines(width: 2)),
  ///        ));
  ///}
  ///```
  final MinorTickLines minorTickLines;

  ///Customizes the appearance of the major grid lines.
  ///
  /// Major grids are the lines
  ///drawn on the plot area at all the major intervals in an axis. Major grid lines
  ///are visible by default.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(majorGridLines: MajorGridLines(width: 2)),
  ///        ));
  ///}
  ///```
  final MajorGridLines majorGridLines;

  ///Customizes the appearance of the minor grid lines.
  ///
  /// Minor grids are the lines drawn
  ///on the plot area at all the minor intervals between the major intervals.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(minorGridLines: MinorGridLines(width: 0)),
  ///        ));
  ///}
  ///```
  final MinorGridLines minorGridLines;

  ///Customizes the appearance of the axis labels.
  ///
  ///Labels are the axis values
  ///placed at each interval. Axis labels are visible by default.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(labelStyle: TextStyle(color: Colors.black)),
  ///        ));
  ///}
  ///```
  /// This property is used to show or hide the axis labels.
  final TextStyle labelStyle;

  ///Customizes the appearance of the axis title.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(title: AxisTitle( text: 'Year')),
  ///        ));
  ///}
  ///```
  final AxisTitle title;

  ///Padding for minimum and maximum values in an axis.
  ///
  /// Various types of range padding
  ///such as round, none, normal, and additional can be applied.
  ///
  ///Also refer [ChartRangePadding]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(rangePadding:  ChartRangePadding.round),
  ///        ));
  ///}
  ///```
  final ChartRangePadding rangePadding;

  ///The number of intervals in an axis.
  ///
  /// By default, the number of intervals is
  ///calculated based on the minimum and maximum values and the axis width and height.
  ///
  ///Defaults to `null`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(desiredIntervals: 2),
  ///        ));
  ///}
  ///```
  final int? desiredIntervals;

  ///The maximum number of labels to be displayed in an axis in 100 logical pixels.
  ///
  ///Defaults to `3`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(maximumLabels: 4),
  ///        ));
  ///}
  ///```
  final int maximumLabels;

  ///Interval of the minor ticks.
  ///
  ///Defaults to `0`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(minorTicksPerInterval: 2),
  ///        ));
  ///}
  ///```
  final int minorTicksPerInterval;

  ///Angle for axis labels.
  ///The axis labels can be rotated to any angle.
  ///
  ///Defaults to `0`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(labelRotation: 90),
  ///        ));
  ///}
  ///```
  final int labelRotation;

  ///Axis labels intersecting action.
  ///
  ///Various actions such as hide, trim, wrap, rotate
  ///90 degree, rotate 45 degree, and placing the labels in multiple rows can be
  ///handled when the axis labels collide with each other.
  ///
  ///Defaults to `AxisLabelIntersectAction.hide`.
  ///
  ///Also refer [AxisLabelIntersectAction].
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(labelIntersectAction: AxisLabelIntersectAction.multipleRows),
  ///        ));
  ///}
  ///```
  final AxisLabelIntersectAction labelIntersectAction;

  ///Opposes the axis position.
  ///
  ///An axis can be placed at the opposite side of its default position.
  ///
  ///Defaults to `false`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(opposedPosition: true),
  ///        ));
  ///}
  ///```
  final bool opposedPosition;

  ///Inverts the axis.
  ///
  /// Axis is rendered from the minimum value to maximum value by
  ///default, and it can be inverted to render the axis from the maximum value
  ///to minimum value.
  ///
  ///Defaults to `false`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(isInversed: true),
  ///        ));
  ///}
  ///```
  final bool isInversed;

  ///Position of the labels.
  ///
  ///Axis labels can be placed either inside or
  ///outside the plot area.
  ///
  ///Defaults to `ChartDataLabelPosition.outside`.
  ///
  ///Also refer [ChartDataLabelPosition].
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(labelPosition: ChartDataLabelPosition.inside),
  ///        ));
  ///}
  ///```
  final ChartDataLabelPosition labelPosition;

  ///Alignment of the labels.
  ///
  ///Axis labels can be placed either start or
  ///end or center of the grid lines.
  ///
  ///Defaults to `LabelAlignment.start`.
  ///
  ///Also refer [LabelAlignment].
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(labelAlignment: LabelAlignment.start),
  ///        ));
  ///}
  ///```
  final LabelAlignment labelAlignment;

  ///Position of the tick lines.
  ///
  /// Tick lines can be placed either inside or
  ///outside the plot area.
  ///
  ///Defaults to `TickPosition.outside`.
  ///
  ///Also refer [TickPosition]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(tickPosition: TickPosition.inside),
  ///        ));
  ///}
  ///```
  final TickPosition tickPosition;

  ///Position of the edge labels.
  ///
  ///The edge labels in an axis can be hidden or shifted
  ///inside the axis bounds.
  ///
  ///Defaults to `EdgeLabelPlacement.none`.
  ///
  ///Also refer [EdgeLabelPlacement].
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.hide),
  ///        ));
  ///}
  ///```
  final EdgeLabelPlacement edgeLabelPlacement;

  ///Axis interval value.
  ///
  ///Using this, the axis labels can be displayed after
  ///certain interval value. By default, interval will be
  ///calculated based on the minimum and maximum values of the provided data.
  ///
  ///Defaults to `null`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(interval: 1),
  ///        ));
  ///}
  ///```
  final double? interval;

  ///Padding for plot area. The axis is rendered in chart with padding.
  ///
  ///Defaults to `0`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(plotOffset: 60),
  ///        ));
  ///}
  ///```
  final double plotOffset;

  ///Name of an axis.
  ///
  /// A unique name further used for linking the series to this
  ///appropriate axis.
  ///
  ///Defaults to `null`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(name: 'primaryXAxis'),
  ///        ));
  ///}
  ///```
  final String? name;

  ///Zoom factor of an axis.
  ///
  /// Scale the axis based on this value, and it ranges
  ///from 0 to 1.
  ///
  ///Defaults to `1`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(zoomFactor: 0.5),
  ///        ));
  ///}
  ///```
  final double zoomFactor;

  ///Position of the zoomed axis. The value ranges from 0 to 1.
  ///
  ///Defaults to `0`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(zoomPosition: 0.6),
  ///        ));
  ///}
  ///```
  final double zoomPosition;

  ///Enables or disables the automatic interval while zooming.
  ///
  ///Defaults to `true`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(enableAutoIntervalOnZooming: true),
  ///        ));
  ///}
  ///```
  final bool enableAutoIntervalOnZooming;

  ///Customizes the crosshair and selection zooming tooltip. Tooltip displays the current
  ///axis value based on the crosshair position/selectionZoomRect position at an axis.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(interactiveTooltip: InteractiveTooltip(enable: true)),
  ///        ));
  ///}
  ///```
  final InteractiveTooltip interactiveTooltip;

  ///Customize to place the axis crossing on another axis based on the value
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(crossesAt:10),
  ///        ));
  ///}
  ///```
  final dynamic crossesAt;

  ///Axis line crossed on mentioned axis name, and applicable for plot band also.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(associatedAxisName: 'primaryXAxis'),
  ///        ));
  ///}
  ///```
  final String? associatedAxisName;

  ///Consider to place the axis label respect to near axis line.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(placeLabelsNearAxisLine: false),
  ///        ));
  ///}
  ///```
  final bool placeLabelsNearAxisLine;

  ///Render the plot band in axis
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands:<PlotBand>[plotBands(start:20, end:30, color:Colors.red, text:'Flutter')]
  ///               ),
  ///        ));
  ///}
  ///```
  final List<PlotBand> plotBands;

  /// Controller used to set the maximum and minimum values for the chart.By providing the range controller, the maximum and
  ///The minimum range of charts can be customized
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             rangeController: controller,
  ///               ),
  ///        ));
  ///}
  ///```
  final RangeController? rangeController;
}

/// Holds the axis label information.
///
/// Axis Label used by the user-specified or by default to make the label for both x and y-axis.
///
/// Provides  options for label style, label size, text, and value to customize the appearance.
///
class AxisLabel {
  /// Creating an argument constructor of AxisLabel class.
  AxisLabel(this.labelStyle, this.labelSize, this.text, this.value);

  /// Specifies the label text style.
  ///
  /// The [TextStyle] is used to customize the chart title text style.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///               primaryXAxis: CategoryAxis(
  ///                      labelStyle: TextStyle(color: Colors.black),
  ///                  ));
  ///}
  ///```
  TextStyle labelStyle;

  /// Hold the size of the label.
  Size labelSize;

  /// Contains the text of the label.
  String? text;

  /// Holds the value of the visible range of the axis.
  num value;

  List<String>? _labelCollection;

  int _index = 1;

  ///Stores the location of an label.
  late Rect _labelRegion;

  //ignore: prefer_final_fields
  bool _needRender = true;
}

/// This class Renders the major tick lines for axis.
///
/// To render major grid lines, create an instance of [MajorTickLines], and assign it to the majorTickLines property of [ChartAxis].
/// The Major tick lines can be drawn for each axis on the plot area.
///
/// Provides options for [size], [width], and [color] to customize the appearance.
///
class MajorTickLines {
  /// Creating an argument constructor of MajorTickLines class.
  MajorTickLines({this.size = 5, this.width = 1, this.color});

  ///Size of the major tick lines.
  ///
  ///Defaults to `8`.
  ///
  ///
  ///Size representation of the major ticks.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///     return Container(
  ///         child: SfCartesianChart(
  ///             primaryXAxis: NumericAxis(
  ///                  majorTickLines: MajorTickLines(
  ///                    size: 6
  ///                  )
  ///                 ),
  ///         ));
  /// }
  /// ```
  ///
  final double size;

  ///Width of the major tick lines.
  ///
  ///Defaults to `1`.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 majorTickLines: MajorTickLines(
  ///                   width: 2
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final double width;

  /// Colors of the major tick lines.
  ///
  /// Defaults to `null`.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 majorTickLines: MajorTickLines(
  ///                   color: Colors.black
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final Color? color;
}

/// This class has the properties of minor tick lines.
///
/// To render minor grid lines, create an instance of [MinorTickLines], and assign it to the minorTickLines property of [ChartAxis].
/// The Minor tick lines can be drawn for each axis on the plot area.
///
/// Provides the color option to change the [color] of the tick line for the customization.
///
class MinorTickLines {
  /// Creating an argument constructor of MinorTickLines class.
  MinorTickLines({this.size = 3, this.width = 0.7, this.color});

  ///Height of the minor tick lines.
  ///
  ///Defaults to `5`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///            minorTicksPerInterval: 5,
  ///            minorTickLines: MinorTickLines(
  ///            size: 5.0,
  ///           )
  ///         )
  ///        ));
  ///}
  ///```
  final double size;

  ///Width of the minor tick lines.
  ///
  ///Defaults to `0.7`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///            minorTicksPerInterval: 5,
  ///            minorTickLines: MinorTickLines(
  ///            width: 0.5,
  ///           )
  ///         )
  ///        ));
  ///}
  ///```
  final double width;

  ///Color of the minor tick lines.
  ///
  ///Defaults to `null`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///            minorTicksPerInterval: 5,
  ///            minorTickLines: MinorTickLines(
  ///            color:Colors.red,
  ///           )
  ///         )
  ///        ));
  ///}
  ///```
  final Color? color;
}

/// Customizes the major grid lines.
///
/// This class Renders the major grid lines for the axis.
///
/// To render major grid lines, create an instance of [MajorGridLines], and assign it to the major gridLines property of [ChartAxis].
/// Major grid lines can be drawn for each axis on the plot area.
///
/// Provides options for [color], [width], and [dashArray] to customize the appearance.
///
class MajorGridLines {
  /// Creating an argument constructor of MajorGridLines class.
  MajorGridLines({this.width = 0.7, this.color, this.dashArray});

  ///Dashes of the major grid lines.
  ///
  ///Defaults to `[0,0]`.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 majorGridLines: MajorGridLines(
  ///                   dashArray: [1,2]
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final List<double>? dashArray;

  /// Width of the major grid lines.
  ///
  /// Defaults to  `0.7`.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 majorGridLines: MajorGridLines(
  ///                   width:2
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final double width;

  ///Color of the major grid lines.
  ///
  ///Defaults to `null`.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 majorGridLines: MajorGridLines(
  ///                   color:Colors.red
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final Color? color;
}

/// Customizes the minor grid lines.
///
/// To render minor grid lines, create an instance of [MinorGridLines], and assign it to the property of [ChartAxis].
/// The Minor grid lines can be drawn for each axis on the plot area.
///
/// Provides the options of [width], [color], and [dashArray] values to customize the appearance.
///
class MinorGridLines {
  /// Creating an argument constructor of MinorGridLines class.
  MinorGridLines({this.width = 0.5, this.color, this.dashArray});

  ///Dashes of minor grid lines.
  ///
  ///Defaults to `[0,0]`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///            minorTicksPerInterval: 5,
  ///            minorGridLines: MinorGridLines(
  ///            dashArray: <double>[10, 20],
  ///          )
  ///         )
  ///        ));
  ///}
  ///```
  final List<double>? dashArray;

  ///Width of the minor grid lines.
  ///
  ///Defaults to `0.5`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///            minorTicksPerInterval: 5,
  ///            minorGridLines: MinorGridLines(
  ///            width: 0.7,
  ///         )
  ///         )
  ///        ));
  ///}
  ///```
  final double width;

  ///Color of the minor grid lines.
  ///
  ///Defaults to `null`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///            minorTicksPerInterval: 5,
  ///            minorGridLines: MinorGridLines(
  ///            color: Colors.red,
  ///         ),
  ///         )
  ///        ));
  ///}
  ///```
  final Color? color;
}

/// This class holds the property of the axis title.
///
/// It has public properties to customize the text and font of the axis title. Axis does not display title by default.
/// Use of the property will customize the title.
///
/// Provides text, text style, and text alignment options for customization of appearance.
///
class AxisTitle {
  /// Creating an argument constructor of AxisTitle class.
  AxisTitle(
      {this.text, TextStyle? textStyle, this.alignment = ChartAlignment.center})
      : textStyle = _getTextStyle(
            textStyle: textStyle,
            fontFamily: 'Segoe UI',
            fontSize: 15.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal);

  ///Text to be displayed as axis title.
  ///
  ///Defaults to `‘’`.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 title: AxisTitle(
  ///                   text: 'Axis Title',
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final String? text;

  ///Customizes the appearance of text in axis title.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 title: AxisTitle(
  ///                   text: 'Axis Title',
  ///                   textStyle: TextStyle(
  ///                     color: Colors.blue,
  ///                     fontStyle: FontStyle.italic,
  ///                     fontWeight: FontWeight.w600,
  ///                     fontFamily: 'Roboto'
  ///                   )
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final TextStyle textStyle;

  ///Aligns the axis title.
  ///
  ///It is applicable for both vertical and horizontal axes.
  ///
  /// * `ChartAlignment.near`, moves the axis title to the beginning of the axis
  ///
  /// * `ChartAlignment.far`, moves the axis title to the end of the axis
  ///
  /// * `ChartAlignment.center`, moves the axis title to the center position of the axis.
  ///
  ///Defaults to `ChartAlignment.center`.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 title: AxisTitle(
  ///                   text: 'Axis Title',
  ///                   alignment: ChartAlignment.far,
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final ChartAlignment alignment;
}

/// This class consists of axis line properties.
///
/// It has the public properties to customize the axis line by increasing or decreasing the width of the axis line and
/// render the axis line with dashes by defining the [dashArray] value.
///
///Provides options for color, dash array, and width to customize the appearance of the axis line.
///
class AxisLine {
  /// Creating an argument constructor of AxisLine class.
  AxisLine({this.color, this.dashArray, this.width = 1});

  ///Width of the axis line.
  ///
  ///Defaults to `1`.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 axisLine:AxisLine(
  ///                   width: 2
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final double width;

  ///Color of the axis line. Color will be applied based on the brightness property of the app.
  ///
  ///Defaults to `null`.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 axisLine:AxisLine(
  ///                   color:Colors.blue,
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final Color? color;

  ///Dashes of the axis line. Any number of values can be provided in the list. Odd value is
  ///considered as rendering size and even value is considered as gap.
  ///
  ///Defaults to `null`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 axisLine:AxisLine(
  ///                   dashArray: <double>[5,5],
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final List<double>? dashArray;
}

///calculate visible range based on min, max values
class _VisibleRange {
  _VisibleRange(dynamic min, dynamic max) {
    if (min < max) {
      minimum = min;
      maximum = max;
    } else {
      minimum = max;
      maximum = min;
    }
  }

  /// specifies minimum range
  dynamic minimum;

  /// Specifies maximum range
  dynamic maximum;

  /// Specifies range interval
  dynamic interval;

  /// Specifies delta value for min-max
  num? delta;
}

/// Creates an axis renderer for chart axis.
abstract class ChartAxisRenderer with _CustomizeAxisElements {
  /// Creating an argument constructor of ChartAxisRenderer class.
  ChartAxisRenderer(this._axis) {
    _visibleLabels = <AxisLabel>[];
    _maximumLabelSize = const Size(0, 0);
    _seriesRenderers = <CartesianSeriesRenderer>[];
    _name = _axis.name;
    _labelRotation = _axis.labelRotation;
    _zoomFactor = _axis.zoomFactor;
    _zoomPosition = _axis.zoomPosition;
  }
  //ignore: prefer_final_fields
  ChartAxis _axis;
  SfCartesianChartState? _chartState;
  SfCartesianChart? _chart;
  //ignore: prefer_final_fields
  bool _isStack100 = false;
  dynamic _rangeMinimum, _rangeMaximum;

  late List<AxisLabel> _visibleLabels;

  /// Holds the size of larger label.
  Size _maximumLabelSize = const Size(0, 0);

  /// Specifies axis orientations such as vertical, horizontal.
  AxisOrientation? _orientation;

  /// Specifies the visible range based on min, max values.
  _VisibleRange? _visibleRange;

  /// Specifies the actual range based on min, max values.
  _VisibleRange? _actualRange;

  /// Holds the chart series
  List<CartesianSeriesRenderer>? _seriesRenderers;

  // ignore: prefer_final_fields
  Rect _bounds = const Rect.fromLTWH(0, 0, 0, 0);

  bool? _isInsideTickPosition;

  double? _totalSize;

  ///Internal variable
  double? _previousZoomFactor, _previousZoomPosition;

  ///Internal variables
  String? _name;

  int? _labelRotation;

  double? _zoomFactor, _zoomPosition;

  ///Checking the axis label collision
  bool _isCollide = false;

  num? _min, _max, _lowMin, _lowMax, _highMin, _highMax;

  Size? _axisSize;

  ChartAxisRenderer? _crossAxisRenderer;

  num? _crossValue;

  _VisibleRange? _crossRange;

  num? _labelOffset;

  Offset? _xAxisStart, _xAxisEnd;

  @override
  Color? getAxisLineColor(ChartAxis axis) => axis.axisLine.color;
  @override
  double getAxisLineWidth(ChartAxis axis) => axis.axisLine.width;

  @override
  Color? getAxisMajorTickColor(ChartAxis axis, int majorTickIndex) =>
      axis.majorTickLines.color;

  @override
  double getAxisMajorTickWidth(ChartAxis axis, int majorTickIndex) =>
      axis.majorTickLines.width;

  @override
  Color? getAxisMinorTickColor(
          ChartAxis axis, int majorTickIndex, int minorTickIndex) =>
      axis.minorTickLines.color;

  @override
  double getAxisMinorTickWidth(
          ChartAxis axis, int majorTickIndex, int minorTickIndex) =>
      axis.minorTickLines.width;

  @override
  Color? getAxisMajorGridColor(ChartAxis axis, int majorGridIndex) =>
      axis.majorGridLines.color;

  @override
  double getAxisMajorGridWidth(ChartAxis axis, int majorGridIndex) =>
      axis.majorGridLines.width;

  @override
  Color? getAxisMinorGridColor(
          ChartAxis axis, int majorGridIndex, int minorGridIndex) =>
      axis.minorGridLines.color;
  @override
  double getAxisMinorGridWidth(
          ChartAxis axis, int majorGridIndex, int minorGridIndex) =>
      axis.minorGridLines.width;

  @override
  String? getAxisLabel(ChartAxis axis, String? text, int labelIndex) => text;

  @override
  TextStyle getAxisLabelStyle(ChartAxis axis, String text, int labelIndex) =>
      axis.labelStyle;

  /// It returns the axis label angle
  @override
  int? getAxisLabelAngle(
          ChartAxisRenderer axisRenderer, String? text, int labelIndex) =>
      (axisRenderer._axis.labelIntersectAction ==
                  AxisLabelIntersectAction.rotate45 &&
              axisRenderer._isCollide)
          ? -45
          : (axisRenderer._axis.labelIntersectAction ==
                      AxisLabelIntersectAction.rotate90 &&
                  axisRenderer._isCollide)
              ? -90
              : axisRenderer._labelRotation;

  /// To draw the horizontal axis line
  @override
  void drawHorizontalAxesLine(
      Canvas canvas, ChartAxisRenderer axisRenderer, SfCartesianChart chart) {
    final ChartAxis axis = axisRenderer._axis;
    final Rect rect = Rect.fromLTWH(
        axisRenderer._bounds.left - axis.plotOffset,
        axisRenderer._bounds.top,
        axisRenderer._bounds.width + 2 * axis.plotOffset,
        axisRenderer._bounds.height);

    final _CustomPaintStyle paintStyle = _CustomPaintStyle(
        axisRenderer.getAxisLineWidth(axis),
        axisRenderer.getAxisLineColor(axis) ??
            _chartState!._chartTheme!.axisLineColor,
        PaintingStyle.stroke);
    _drawDashedPath(canvas, paintStyle, Offset(rect.left, rect.top),
        Offset(rect.left + rect.width, rect.top), axis.axisLine.dashArray);
    _xAxisStart = Offset(rect.left, rect.top);
    _xAxisEnd = Offset(rect.left + rect.width, rect.top);
  }

  /// To draw the vertical axis line
  @override
  void drawVerticalAxesLine(Canvas canvas, ChartAxisRenderer axisRenderer,
      SfCartesianChart chartState) {
    final ChartAxis axis = axisRenderer._axis;
    final Rect rect = Rect.fromLTWH(
        axisRenderer._bounds.left,
        axisRenderer._bounds.top - axis.plotOffset,
        axisRenderer._bounds.width,
        axisRenderer._bounds.height + 2 * axis.plotOffset);
    final _CustomPaintStyle paintStyle = _CustomPaintStyle(
        axisRenderer.getAxisLineWidth(axis),
        axisRenderer.getAxisLineColor(axis) ??
            _chartState!._chartTheme!.axisLineColor,
        PaintingStyle.stroke);
    _drawDashedPath(canvas, paintStyle, Offset(rect.left, rect.top),
        Offset(rect.left, rect.top + rect.height), axis.axisLine.dashArray);
  }

  /// To draw the horizontal axes tick lines
  @override
  void drawHorizontalAxesTickLines(
      Canvas canvas, ChartAxisRenderer axisRenderer, SfCartesianChart chart,
      [String? renderType,
      double? animationFactor,
      ChartAxisRenderer? oldAxisRenderer,
      bool? needAnimate]) {
    final Rect axisBounds = axisRenderer._bounds;
    final ChartAxis axis = axisRenderer._axis;
    final List<AxisLabel> visibleLabels = axisRenderer._visibleLabels;
    num tempInterval, pointX, pointY, length = visibleLabels.length;
    if (length > 0) {
      final MajorTickLines ticks = axis.majorTickLines;
      const num padding = 1;
      final bool isBetweenTicks = axis is CategoryAxis &&
          axis.labelPlacement == LabelPlacement.betweenTicks;
      final num tickBetweenLabel = isBetweenTicks ? 0.5 : 0;
      length += isBetweenTicks ? 1 : 0;
      for (int i = 0; i < length; i++) {
        tempInterval = isBetweenTicks
            ? i < length - 1
                ? visibleLabels[i].value - tickBetweenLabel
                : (visibleLabels[i - 1].value +
                        axisRenderer._visibleRange!.interval) -
                    tickBetweenLabel
            : visibleLabels[i].value;
        pointX = ((_valueToCoefficient(tempInterval, axisRenderer) *
                    axisBounds.width) +
                axisBounds.left)
            .roundToDouble();
        pointY = axisBounds.top - padding + axis.axisLine.width / 2;

        if (needAnimate!) {
          final double oldLocation =
              _getPrevLocation(axisRenderer, oldAxisRenderer!, tempInterval);
          pointX = oldLocation != null
              ? (oldLocation - (oldLocation - pointX) * animationFactor!)
              : pointX;
        }
        if (axisBounds.left.roundToDouble() <= pointX &&
            axisBounds.right.roundToDouble() >= pointX) {
          if (axis.majorGridLines.width > 0 &&
              renderType == 'outside' &&
              (axis.plotOffset > 0 ||
                  (i != 0 && i != length - 1) ||
                  (axisBounds.left <= pointX &&
                      axisBounds.right >= pointX &&
                      !_chartState!._requireInvertedAxis!))) {
            axisRenderer.drawHorizontalAxesMajorGridLines(
                canvas,
                Offset(pointX as double, pointY as double),
                axisRenderer,
                axis.majorGridLines,
                i,
                chart);
          }
          if (axis.minorGridLines.width > 0 || axis.minorTickLines.width > 0) {
            num? nextValue = isBetweenTicks
                ? (tempInterval + axisRenderer._visibleRange!.interval)
                : i == length - 1
                    ? axisRenderer._visibleRange!.maximum
                    : visibleLabels[i + 1].value;
            if (nextValue != null) {
              nextValue = ((_valueToCoefficient(nextValue, axisRenderer) *
                          axisBounds.width) +
                      axisBounds.left)
                  .roundToDouble();
              axisRenderer.drawHorizontalAxesMinorLines(canvas, axisRenderer,
                  pointX, axisBounds, nextValue, i, chart, renderType);
            }
          }
        }
        if (axis.majorTickLines.width > 0 &&
            (axisBounds.left <= pointX &&
                axisBounds.right.roundToDouble() >= pointX) &&
            renderType == axis.tickPosition.toString().split('.')[1]) {
          _drawDashedPath(
              canvas,
              _CustomPaintStyle(
                  axisRenderer.getAxisMajorTickWidth(axis, i),
                  axisRenderer.getAxisMajorTickColor(axis, i) ??
                      _chartState!._chartTheme!.majorTickLineColor,
                  PaintingStyle.stroke),
              Offset(pointX as double, pointY as double),
              Offset(
                  pointX,
                  !axis.opposedPosition
                      ? (axisRenderer._isInsideTickPosition!
                          ? pointY - ticks.size
                          : pointY + ticks.size)
                      : (axisRenderer._isInsideTickPosition!
                          ? pointY + ticks.size
                          : pointY - ticks.size)));
        }
      }
    }
  }

  /// To draw the major grid lines of horizontal axes
  @override
  void drawHorizontalAxesMajorGridLines(
      Canvas canvas,
      Offset point,
      ChartAxisRenderer axisRenderer,
      MajorGridLines grids,
      int index,
      SfCartesianChart chart) {
    final _CustomPaintStyle paintStyle = _CustomPaintStyle(
        axisRenderer.getAxisMajorGridWidth(axisRenderer._axis, index),
        axisRenderer.getAxisMajorGridColor(axisRenderer._axis, index) ??
            _chartState!._chartTheme!.majorGridLineColor,
        PaintingStyle.stroke);
    _drawDashedPath(
        canvas,
        paintStyle,
        Offset(point.dx, _chartState!._chartAxis!._axisClipRect!.top),
        Offset(
            point.dx,
            _chartState!._chartAxis!._axisClipRect!.top +
                _chartState!._chartAxis!._axisClipRect!.height),
        grids.dashArray);
  }

  /// To draw the minor grid lines of horizontal axes
  @override
  void drawHorizontalAxesMinorLines(
      Canvas canvas,
      ChartAxisRenderer axisRenderer,
      num tempInterval,
      Rect rect,
      num nextValue,
      int index,
      SfCartesianChart chart,
      [String? renderType]) {
    num position = tempInterval;
    final ChartAxis axis = axisRenderer._axis;
    final MinorTickLines ticks = axis.minorTickLines;
    final num interval =
        (tempInterval - nextValue).abs() / (axis.minorTicksPerInterval + 1);
    for (int i = 0; i < axis.minorTicksPerInterval; i++) {
      position =
          axis.isInversed ? (position - interval) : (position + interval);
      final num pointY = rect.top;
      if (axis.minorGridLines.width > 0 &&
          renderType == 'outside' &&
          (axisRenderer._bounds.left <= position &&
              axisRenderer._bounds.right >= position)) {
        _drawDashedPath(
            canvas,
            _CustomPaintStyle(
                axisRenderer.getAxisMinorGridWidth(
                    axisRenderer._axis, index, i),
                axisRenderer.getAxisMinorGridColor(
                        axisRenderer._axis, index, i) ??
                    _chartState!._chartTheme!.minorGridLineColor,
                PaintingStyle.stroke),
            Offset(position as double,
                _chartState!._chartAxis!._axisClipRect!.top),
            Offset(
                position,
                _chartState!._chartAxis!._axisClipRect!.top +
                    _chartState!._chartAxis!._axisClipRect!.height),
            axis.minorGridLines.dashArray);
      }

      if (axis.minorTickLines.width > 0 &&
          axisRenderer._bounds.left <= position &&
          axisRenderer._bounds.right >= position &&
          renderType == axis.tickPosition.toString().split('.')[1]) {
        _drawDashedPath(
            canvas,
            _CustomPaintStyle(
                axisRenderer.getAxisMinorTickWidth(axis, index, i),
                axisRenderer.getAxisMinorTickColor(axis, index, i) ??
                    _chartState!._chartTheme!.minorTickLineColor,
                PaintingStyle.stroke),
            Offset(position as double, pointY as double),
            Offset(
                position,
                !axis.opposedPosition
                    ? (axisRenderer._isInsideTickPosition!
                        ? pointY - ticks.size
                        : pointY + ticks.size)
                    : (axisRenderer._isInsideTickPosition!
                        ? pointY + ticks.size
                        : pointY - ticks.size)),
            axis.minorGridLines.dashArray);
      }
    }
  }

  /// To draw tick lines of vertical axes
  @override
  void drawVerticalAxesTickLines(
      Canvas canvas, ChartAxisRenderer axisRenderer, SfCartesianChart chart,
      [String? renderType,
      double? animationFactor,
      ChartAxisRenderer? oldAxisRenderer,
      bool? needAnimate]) {
    final ChartAxis axis = axisRenderer._axis;
    final Rect axisBounds = axisRenderer._bounds;
    final List<AxisLabel> visibleLabels = axisRenderer._visibleLabels;
    num tempInterval, pointX, pointY, length = visibleLabels.length;
    const num padding = 1;
    final bool isBetweenTicks = axis is CategoryAxis &&
        axis.labelPlacement == LabelPlacement.betweenTicks;
    final num tickBetweenLabel = isBetweenTicks ? 0.5 : 0;
    length += isBetweenTicks ? 1 : 0;
    for (int i = 0; i < length; i++) {
      tempInterval = isBetweenTicks
          ? i < length - 1
              ? visibleLabels[i].value - tickBetweenLabel
              : (visibleLabels[i - 1].value +
                      axisRenderer._visibleRange!.interval) -
                  tickBetweenLabel
          : visibleLabels[i].value;
      pointY = (_valueToCoefficient(tempInterval, axisRenderer) *
              axisBounds.height) +
          axisBounds.top;
      pointY = (axisBounds.top + axisBounds.height) -
          (pointY - axisBounds.top).abs();
      pointX = axisBounds.left + padding - axis.axisLine.width / 2;

      if (needAnimate!) {
        final double oldLocation =
            _getPrevLocation(axisRenderer, oldAxisRenderer!, tempInterval);
        pointY = oldLocation != null
            ? (oldLocation - (oldLocation - pointY) * animationFactor!)
            : pointY;
      }
      if (pointY >= axisBounds.top && pointY <= axisBounds.bottom) {
        if (axis.majorGridLines.width > 0 &&
            renderType == 'outside' &&
            (axis.plotOffset > 0 ||
                ((i == 0 || i == length - 1) &&
                    chart.plotAreaBorderWidth == 0) ||
                (((i == 0 && !axis.opposedPosition) ||
                        (i == length - 1 && axis.opposedPosition)) &&
                    axis.axisLine.width == 0) ||
                (axisBounds.top < pointY - axis.majorGridLines.width &&
                    axisBounds.bottom > pointY + axis.majorGridLines.width))) {
          axisRenderer.drawVerticalAxesMajorGridLines(
              canvas,
              Offset(pointX as double, pointY as double),
              axisRenderer,
              axis.majorGridLines,
              i,
              chart);
        }
        if (axis.minorGridLines.width > 0 || axis.minorTickLines.width > 0) {
          axisRenderer.drawVerticalAxesMinorTickLines(canvas, axisRenderer,
              tempInterval, axisBounds, i, chart, renderType);
        }
        if (axis.majorTickLines.width > 0 &&
            renderType == axis.tickPosition.toString().split('.')[1]) {
          _drawDashedPath(
              canvas,
              _CustomPaintStyle(
                  axisRenderer.getAxisMajorTickWidth(axis, i),
                  axisRenderer.getAxisMajorTickColor(axis, i) ??
                      _chartState!._chartTheme!.majorTickLineColor,
                  PaintingStyle.stroke),
              Offset(pointX as double, pointY as double),
              Offset(
                  !axis.opposedPosition
                      ? (axisRenderer._isInsideTickPosition!
                          ? pointX + axis.majorTickLines.size
                          : pointX - axis.majorTickLines.size)
                      : (axisRenderer._isInsideTickPosition!
                          ? pointX - axis.majorTickLines.size
                          : pointX + axis.majorTickLines.size),
                  pointY));
        }
      }
    }
  }

  /// To draw the major grid lines of vertical axes
  @override
  void drawVerticalAxesMajorGridLines(
      Canvas canvas,
      Offset point,
      ChartAxisRenderer axisRenderer,
      MajorGridLines grids,
      int index,
      SfCartesianChart chart) {
    final _CustomPaintStyle paintStyle = _CustomPaintStyle(
        axisRenderer.getAxisMajorGridWidth(axisRenderer._axis, index),
        axisRenderer.getAxisMajorGridColor(axisRenderer._axis, index) ??
            _chartState!._chartTheme!.majorGridLineColor,
        PaintingStyle.stroke);
    if (_chartState!._chartAxis!._primaryXAxisRenderer!._xAxisStart !=
            Offset(_chartState!._chartAxis!._axisClipRect!.left, point.dy) &&
        _chartState!._chartAxis!._primaryXAxisRenderer!._xAxisEnd !=
            Offset(
                _chartState!._chartAxis!._axisClipRect!.left +
                    _chartState!._chartAxis!._axisClipRect!.width,
                point.dy)) {
      _drawDashedPath(
          canvas,
          paintStyle,
          Offset(_chartState!._chartAxis!._axisClipRect!.left, point.dy),
          Offset(
              _chartState!._chartAxis!._axisClipRect!.left +
                  _chartState!._chartAxis!._axisClipRect!.width,
              point.dy),
          grids.dashArray);
    }
  }

  /// To draw the minor grid lines of vertical axes
  @override
  void drawVerticalAxesMinorTickLines(
      Canvas canvas,
      ChartAxisRenderer axisRenderer,
      num tempInterval,
      Rect rect,
      int index,
      SfCartesianChart chart,
      [String? renderType]) {
    final ChartAxis axis = axisRenderer._axis;
    num value = tempInterval, position = 0;
    final _VisibleRange? range = axisRenderer._visibleRange;
    final bool rendering = axis.minorTicksPerInterval > 0 &&
        (axis.minorGridLines.width > 0 || axis.minorTickLines.width > 0);
    if (rendering) {
      for (int i = 0; i < axis.minorTicksPerInterval; i++) {
        value += range!.interval / (axis.minorTicksPerInterval + 1);
        if ((value < range.maximum) && (value > range.minimum)) {
          position = _valueToCoefficient(value, axisRenderer) * rect.height;
          position = (position + rect.top).floor().toDouble();
          if (axis.minorGridLines.width > 0 &&
              renderType == 'outside' &&
              rect.top <= position &&
              rect.bottom >= position) {
            _drawDashedPath(
                canvas,
                _CustomPaintStyle(
                    axisRenderer.getAxisMinorGridWidth(axis, index, i),
                    axisRenderer.getAxisMinorGridColor(axis, index, i) ??
                        _chartState!._chartTheme!.minorGridLineColor,
                    PaintingStyle.stroke),
                Offset(_chartState!._chartAxis!._axisClipRect!.left,
                    position as double),
                Offset(
                    _chartState!._chartAxis!._axisClipRect!.left +
                        _chartState!._chartAxis!._axisClipRect!.width,
                    position),
                axis.minorGridLines.dashArray);
          }
          if (axis.minorTickLines.width > 0 &&
              renderType == axis.tickPosition.toString().split('.')[1]) {
            _drawDashedPath(
                canvas,
                _CustomPaintStyle(
                    axisRenderer.getAxisMinorTickWidth(axis, index, i),
                    axisRenderer.getAxisMinorTickColor(axis, index, i) ??
                        _chartState!._chartTheme!.minorTickLineColor,
                    PaintingStyle.stroke),
                Offset(rect.left, position as double),
                Offset(
                    !axis.opposedPosition
                        ? (axisRenderer._isInsideTickPosition!
                            ? rect.left + axis.minorTickLines.size
                            : rect.left - axis.minorTickLines.size)
                        : (axisRenderer._isInsideTickPosition!
                            ? rect.left - axis.minorTickLines.size
                            : rect.left + axis.minorTickLines.size),
                    position));
          }
        }
      }
    }
  }

  /// To draw the axis labels of horizontal axes
  @override
  void drawHorizontalAxesLabels(
      Canvas canvas, ChartAxisRenderer axisRenderer, SfCartesianChart chart,
      [String? renderType,
      double? animationFactor,
      ChartAxisRenderer? oldAxisRenderer,
      bool? needAnimate]) {
    final ChartAxis axis = axisRenderer._axis;
    if (renderType == axis.labelPosition.toString().split('.')[1]) {
      final Rect axisBounds = axisRenderer._bounds;
      int? angle;
      TextStyle textStyle;
      final List<AxisLabel> visibleLabels = axisRenderer._visibleLabels;
      num? tempInterval, pointX, pointY, previousLabelEnd;
      for (int i = 0; i < visibleLabels.length; i++) {
        final AxisLabel label = visibleLabels[i];
        final String? labelText =
            axisRenderer.getAxisLabel(axis, label.text, i);

        textStyle = label.labelStyle;
        textStyle = _getTextStyle(
            textStyle: textStyle,
            fontColor:
                textStyle.color ?? _chartState!._chartTheme!.axisLabelColor);
        tempInterval = label.value;
        angle = axisRenderer.getAxisLabelAngle(axisRenderer, labelText, i);

        /// For negative angle calculations
        if (angle!.isNegative) {
          angle = angle + 360;
        }
        axisRenderer._labelRotation = angle;
        final Size textSize = _measureText(labelText, textStyle);
        final Size rotatedTextSize = _measureText(labelText, textStyle, angle);
        pointX = ((_valueToCoefficient(tempInterval, axisRenderer) *
                    axisBounds.width) +
                axisBounds.left)
            .roundToDouble();
        pointY = _getPointY(axisRenderer, label, axisBounds);
        pointY -= angle == 0 ? textSize.height / 2 : 0;
        pointY += rotatedTextSize.height / 2;
        pointX -= angle == 0 ? textSize.width / 2 : 0;

        ///  Edge label placement - shift for x-Axis
        pointX = _getShiftedPosition(axisRenderer, axisBounds,
            pointX as double?, pointY as double, textSize, i);
        if (axis.labelAlignment == LabelAlignment.end) {
          pointX = pointX! + textSize.height / 2;
        } else if (axis.labelAlignment == LabelAlignment.start) {
          pointX = pointX! - textSize.height / 2;
        }
        if (axis.edgeLabelPlacement == EdgeLabelPlacement.hide) {
          if (axis.labelAlignment == LabelAlignment.center) {
            if (i == 0 || (i == axisRenderer._visibleLabels.length - 1)) {
              axisRenderer._visibleLabels[i]._needRender = false;
              continue;
            }
          } else if ((axis.labelAlignment == LabelAlignment.end) &&
              (i == axisRenderer._visibleLabels.length - 1 ||
                  (i == 0 && axis.isInversed))) {
            axisRenderer._visibleLabels[i]._needRender = false;
            continue;
          } else if ((axis.labelAlignment == LabelAlignment.start) &&
              (i == 0 ||
                  (i == axisRenderer._visibleLabels.length - 1 &&
                      axis.isInversed))) {
            axisRenderer._visibleLabels[i]._needRender = false;
            continue;
          }
        }

        if (axis.labelIntersectAction == AxisLabelIntersectAction.hide &&
            axis.labelRotation % 180 == 0 &&
            i != 0 &&
            axisRenderer._visibleLabels[i - 1]._needRender &&
            (!axis.isInversed
                ? pointX! <= previousLabelEnd!
                : (pointX! + textSize.width) >= previousLabelEnd!)) {
          continue;
        }

        previousLabelEnd = axis.isInversed ? pointX : pointX! + textSize.width;

        if (needAnimate!) {
          final double oldLocation = _getPrevLocation(
              axisRenderer, oldAxisRenderer!, tempInterval, textSize, angle);
          pointX = oldLocation != null
              ? (oldLocation - (oldLocation - pointX!) * animationFactor!)
              : pointX;
        }
        final Offset point = Offset(pointX as double, pointY);
        if (axisBounds.left - textSize.width <= pointX &&
            axisBounds.right + textSize.width >= pointX) {
          _drawText(canvas, labelText, point, textStyle, angle);
        }
        if (label._labelCollection != null &&
            label._labelCollection!.isNotEmpty &&
            axis.labelIntersectAction == AxisLabelIntersectAction.wrap) {
          for (int j = 1; j < label._labelCollection!.length; j++) {
            final String wrapTxt = label._labelCollection![j];
            _drawText(
                canvas,
                wrapTxt,
                Offset(
                    pointX,
                    pointY +
                        (j *
                            _measureText(wrapTxt, axis.labelStyle, angle)
                                .height)),
                textStyle,
                angle);
          }
        }
      }
    }
  }

  /// To draw the axis labels of vertical axes
  @override
  void drawVerticalAxesLabels(
      Canvas canvas, ChartAxisRenderer axisRenderer, SfCartesianChart chart,
      [String? renderType,
      double? animationFactor,
      ChartAxisRenderer? oldAxisRenderer,
      bool? needAnimate]) {
    final ChartAxis axis = axisRenderer._axis;
    if (axis.labelPosition.toString().split('.')[1] == renderType) {
      final Rect axisBounds = axisRenderer._bounds;
      final List<AxisLabel> visibleLabels = axisRenderer._visibleLabels;
      TextStyle textStyle;
      num? tempInterval, pointX, pointY, previousEnd;
      for (int i = 0; i < visibleLabels.length; i++) {
        final String? labelText =
            axisRenderer.getAxisLabel(axis, visibleLabels[i].text, i);
        final int angle =
            axisRenderer.getAxisLabelAngle(axisRenderer, labelText, i)!;
        assert(angle - angle.floor() == 0,
            'The angle value of the vertical axis must be the whole number.');
        textStyle = visibleLabels[i].labelStyle;
        textStyle = _getTextStyle(
            textStyle: textStyle,
            fontColor:
                textStyle.color ?? _chartState!._chartTheme!.axisLabelColor);
        tempInterval = visibleLabels[i].value;
        final Size textSize = _measureText(labelText, textStyle, 0);
        pointY = (_valueToCoefficient(tempInterval, axisRenderer) *
                axisBounds.height) +
            axisBounds.top;
        pointY = ((axisBounds.top + axisBounds.height) -
                ((axisBounds.top - pointY).abs())) -
            textSize.height / 2;
        pointX = _getPointX(axisRenderer, textSize, axisBounds);
        final _ChartLocation location = _getRotatedTextLocation(
            pointX as double,
            pointY as double,
            labelText,
            textStyle,
            angle,
            axis);
        if (axis.labelAlignment == LabelAlignment.center) {
          pointX = location.x;
          pointY = location.y;
        } else if (axis.labelAlignment == LabelAlignment.end) {
          pointX = location.x;
          pointY = location.y! - textSize.height / 2;
        } else if (axis.labelAlignment == LabelAlignment.start) {
          pointX = location.x;
          pointY = location.y! + textSize.height / 2;
        }
        if (axis.labelIntersectAction == AxisLabelIntersectAction.hide &&
            i != 0 &&
            (!axis.isInversed
                ? pointY! + (textSize.height / 2) > previousEnd!
                : pointY! - (textSize.height / 2) < previousEnd!)) {
          continue;
        }
        previousEnd = !axis.isInversed
            ? pointY! - textSize.height / 2
            : pointY! + textSize.height / 2;

        ///  Edge label placement for y-Axis
        if (axis.edgeLabelPlacement == EdgeLabelPlacement.shift) {
          if (axis.labelAlignment == LabelAlignment.center) {
            if (i == 0 && axisBounds.bottom <= pointY + textSize.height / 2) {
              pointY = axisBounds.top + axisBounds.height - textSize.height;
            } else if (i == axisRenderer._visibleLabels.length - 1 &&
                axisBounds.top >= pointY + textSize.height / 2) {
              pointY = axisBounds.top;
            }
          } else if (axis.labelAlignment == LabelAlignment.start) {
            if (i == 0 && axisBounds.bottom <= pointY + textSize.height / 2) {
              pointY = axisBounds.top + axisBounds.height - textSize.height;
            }
          } else if (axis.labelAlignment == LabelAlignment.end) {
            if (i == axisRenderer._visibleLabels.length - 1 &&
                axisBounds.top >= pointY + textSize.height / 2) {
              pointY = axisBounds.top + textSize.height / 2;
            }
          }
        } else if (axis.edgeLabelPlacement == EdgeLabelPlacement.hide) {
          if (axis.labelAlignment == LabelAlignment.center) {
            if (i == 0 || i == axisRenderer._visibleLabels.length - 1) {
              continue;
            }
          } else if ((axis.labelAlignment == LabelAlignment.end) &&
              (i == axisRenderer._visibleLabels.length - 1 ||
                  (i == 0 && axis.isInversed))) {
            continue;
          } else if ((axis.labelAlignment == LabelAlignment.start) &&
              (i == 0 ||
                  (i == axisRenderer._visibleLabels.length - 1 &&
                      axis.isInversed))) {
            continue;
          }
        }
        axisRenderer._visibleLabels[i]._labelRegion = Rect.fromLTWH(
            pointX as double,
            pointY as double,
            textSize.width,
            textSize.height);

        if (needAnimate!) {
          final double oldLocation = _getPrevLocation(
              axisRenderer, oldAxisRenderer!, tempInterval, textSize);
          pointY = oldLocation != null
              ? (oldLocation - (oldLocation - pointY) * animationFactor!)
              : pointY;
        }

        final Offset point = Offset(pointX, pointY);
        if (axisBounds.top - textSize.height <= pointY &&
            axisBounds.bottom + textSize.height >= pointY) {
          _drawText(
              canvas, labelText, point, textStyle, axisRenderer._labelRotation);
        }
      }
    }
  }

  /// To get the previous location of an axis
  double _getPrevLocation(ChartAxisRenderer axisRenderer,
      ChartAxisRenderer oldAxisRenderer, num? value,
      [Size? textSize, num? angle]) {
    double location;
    final Rect bounds = axisRenderer._bounds;
    final ChartAxis axis = axisRenderer._axis;
    textSize ??= const Size(0, 0);
    if (oldAxisRenderer._visibleRange!.minimum > value) {
      location = axisRenderer._orientation == AxisOrientation.vertical
          ? (axis.isInversed
              ? ((bounds.top + bounds.height) -
                  ((bounds.top -
                          (bounds.top -
                                  (_valueToCoefficient(value, oldAxisRenderer) *
                                      bounds.height))
                              .roundToDouble())
                      .abs()))
              : (bounds.bottom -
                      (_valueToCoefficient(value, oldAxisRenderer) *
                          bounds.height))
                  .roundToDouble())
          : (axis.isInversed
              ? ((_valueToCoefficient(value, axisRenderer) * bounds.width) +
                      bounds.right)
                  .roundToDouble()
              : ((_valueToCoefficient(value, oldAxisRenderer) * bounds.width) -
                      bounds.left)
                  .roundToDouble());
    } else if (oldAxisRenderer._visibleRange!.maximum < value) {
      location = axisRenderer._orientation == AxisOrientation.vertical
          ? (axis.isInversed
              ? (bounds.bottom -
                      (_valueToCoefficient(value, oldAxisRenderer) *
                          bounds.height))
                  .roundToDouble()
              : ((bounds.top + bounds.height) -
                  ((bounds.top -
                          (bounds.top -
                                  (_valueToCoefficient(value, oldAxisRenderer) *
                                      bounds.height))
                              .roundToDouble())
                      .abs())))
          : (axis.isInversed
              ? ((_valueToCoefficient(value, oldAxisRenderer) * bounds.width) -
                      bounds.left)
                  .roundToDouble()
              : ((_valueToCoefficient(value, axisRenderer) * bounds.width) +
                      bounds.right)
                  .roundToDouble());
    } else {
      if (axisRenderer._orientation == AxisOrientation.vertical) {
        location = (_valueToCoefficient(value, oldAxisRenderer) *
                oldAxisRenderer._bounds.height) +
            oldAxisRenderer._bounds.top;
        location =
            ((oldAxisRenderer._bounds.top + oldAxisRenderer._bounds.height) -
                    ((oldAxisRenderer._bounds.top - location).abs())) -
                textSize.height / 2;
      } else {
        location = ((_valueToCoefficient(value, oldAxisRenderer) *
                    oldAxisRenderer._bounds.width) +
                oldAxisRenderer._bounds.left)
            .roundToDouble();
        if (angle != null) {
          location -= angle == 0 ? textSize.width / 2 : 0;
        }
      }
    }
    return location;
  }

  /// Return the x point
  double _getPointX(
      ChartAxisRenderer axisRenderer, Size textSize, Rect axisBounds) {
    num pointX;
    const num innerPadding = 5;
    final ChartAxis axis = axisRenderer._axis;
    if (axis.labelPosition == ChartDataLabelPosition.inside) {
      pointX = (!axis.opposedPosition)
          ? (axisBounds.left +
              innerPadding +
              (axisRenderer._isInsideTickPosition!
                  ? axis.majorTickLines.size
                  : 0))
          : (axisBounds.left -
              axisRenderer._maximumLabelSize.width -
              innerPadding -
              (axisRenderer._isInsideTickPosition!
                  ? axis.majorTickLines.size
                  : 0));
    } else {
      pointX = (!axis.opposedPosition)
          ? axisRenderer._labelOffset != null
              ? axisRenderer._labelOffset! - textSize.width
              : (axisBounds.left -
                  (axisRenderer._isInsideTickPosition!
                      ? 0
                      : axis.majorTickLines.size) -
                  textSize.width -
                  innerPadding)
          : (axisRenderer._labelOffset ??
              (axisBounds.left +
                  (axisRenderer._isInsideTickPosition!
                      ? 0
                      : axis.majorTickLines.size) +
                  innerPadding));
    }
    return pointX as double;
  }

  /// Return the y point
  double _getPointY(
      ChartAxisRenderer axisRenderer, AxisLabel label, Rect axisBounds) {
    final ChartAxis axis = axisRenderer._axis;
    double pointY;
    const num innerPadding = 3;
    if (axis.labelPosition == ChartDataLabelPosition.inside) {
      pointY = !axis.opposedPosition
          ? axisBounds.top -
              innerPadding -
              (label._index > 1
                  ? axisRenderer._maximumLabelSize.height / 2
                  : axisRenderer._maximumLabelSize.height) -
              (axisRenderer._isInsideTickPosition!
                  ? axis.majorTickLines.size
                  : 0)
          : axisBounds.top +
              (axisRenderer._isInsideTickPosition!
                  ? axis.majorTickLines.size
                  : 0) +
              (label._index > 1
                  ? axisRenderer._maximumLabelSize.height / 2
                  : 0);
    } else {
      pointY = !axis.opposedPosition
          ? axisRenderer._labelOffset as double? ??
              (axisBounds.top +
                  ((axisRenderer._isInsideTickPosition!
                          ? 0
                          : axis.majorTickLines.size) +
                      innerPadding) +
                  (label._index > 1
                      ? axisRenderer._maximumLabelSize.height / 2
                      : 0))
          : axisRenderer._labelOffset != null
              ? axisRenderer._labelOffset! -
                  axisRenderer._maximumLabelSize.height
              : (axisBounds.top -
                  (((axisRenderer._isInsideTickPosition!
                              ? 0
                              : axis.majorTickLines.size) +
                          innerPadding) -
                      (label._index > 1
                          ? axisRenderer._maximumLabelSize.height / 2
                          : 0)) -
                  axisRenderer._maximumLabelSize.height);
    }
    return pointY;
  }

  /// To get shifted position for both axes
  double? _getShiftedPosition(ChartAxisRenderer axisRenderer, Rect axisBounds,
      double? pointX, double pointY, Size textSize, int i) {
    final ChartAxis axis = axisRenderer._axis;
    if (axis.edgeLabelPlacement == EdgeLabelPlacement.shift) {
      if (axis.labelAlignment == LabelAlignment.center) {
        if (i == 0 &&
            ((pointX! < axisBounds.left && !axis.isInversed) ||
                (pointX + textSize.width > axisBounds.right &&
                    axis.isInversed))) {
          pointX = axis.isInversed
              ? axisBounds.left + axisBounds.width - textSize.width
              : axisBounds.left;
        }

        if (i == axisRenderer._visibleLabels.length - 1 &&
            ((((pointX! + textSize.width) > axisBounds.right) &&
                    !axis.isInversed) ||
                (pointX < axisBounds.left && axis.isInversed))) {
          pointX = axis.isInversed
              ? axisBounds.left
              : axisBounds.left + axisBounds.width - textSize.width;
        }
      } else if ((axis.labelAlignment == LabelAlignment.end) &&
          (i == axisRenderer._visibleLabels.length - 1 &&
              ((((pointX! + textSize.width) > axisBounds.right) &&
                      !axis.isInversed) ||
                  (pointX < axisBounds.left && axis.isInversed)))) {
        pointX = axis.isInversed
            ? axisBounds.left
            : axisBounds.left +
                axisBounds.width -
                textSize.width -
                textSize.height / 2;
      } else if ((axis.labelAlignment == LabelAlignment.start) &&
          (i == 0 &&
              ((pointX! < axisBounds.left && !axis.isInversed) ||
                  (pointX + textSize.width > axisBounds.right &&
                      axis.isInversed)))) {
        pointX = axis.isInversed
            ? axisBounds.left + axisBounds.width - textSize.width
            : axisBounds.left + textSize.height / 2;
      }
    }
    axisRenderer._visibleLabels[i]._labelRegion =
        Rect.fromLTWH(pointX!, pointY, textSize.width, textSize.height);
    return pointX;
  }

  /// To draw the axis title of horizontal axes
  @override
  void drawHorizontalAxesTitle(
      Canvas canvas, ChartAxisRenderer axisRenderer, SfCartesianChart chart) {
    final ChartAxis axis = axisRenderer._axis;
    final Rect axisBounds = axisRenderer._bounds;
    Offset point;
    final String title = axis.title.text ?? '';
    const int labelRotation = 0, innerPadding = 8;
    TextStyle style = axis.title.textStyle;
    style = _getTextStyle(
        textStyle: style,
        fontColor: style.color ?? _chartState!._chartTheme!.axisTitleColor);
    final Size textSize = _measureText(title, style);
    num top;
    if (axis.labelPosition == ChartDataLabelPosition.inside) {
      top = !axis.opposedPosition
          ? axisBounds.top +
              (axisRenderer._isInsideTickPosition!
                  ? 0
                  : axis.majorTickLines.size) +
              (!kIsWeb ? innerPadding : innerPadding + textSize.height / 2)
          : axisBounds.top -
              (axisRenderer._isInsideTickPosition!
                  ? 0
                  : axis.majorTickLines.size) -
              innerPadding -
              textSize.height;
    } else {
      top = !axis.opposedPosition
          ? axisBounds.top +
              (axisRenderer._isInsideTickPosition!
                  ? 0
                  : axis.majorTickLines.size) +
              innerPadding +
              (!kIsWeb
                  ? axisRenderer._maximumLabelSize.height
                  : axisRenderer._maximumLabelSize.height + textSize.height / 2)
          : axisBounds.top -
              (axisRenderer._isInsideTickPosition!
                  ? 0
                  : axis.majorTickLines.size) -
              innerPadding -
              axisRenderer._maximumLabelSize.height -
              textSize.height;
    }
    axis.title.alignment == ChartAlignment.near
        ? point =
            Offset(_chartState!._chartAxis!._axisClipRect!.left, top as double)
        : axis.title.alignment == ChartAlignment.far
            ? point = Offset(
                _chartState!._chartAxis!._axisClipRect!.right - textSize.width,
                top as double)
            : point = Offset(
                axisBounds.left +
                    ((axisBounds.width / 2) - (textSize.width / 2)),
                top as double);
    if (axisRenderer._seriesRenderers!.isNotEmpty ||
        axisRenderer._name == 'primaryXAxis') {
      _drawText(canvas, title, point, style, labelRotation);
    }
  }

  /// To draw the axis title of vertical axes
  @override
  void drawVerticalAxesTitle(
      Canvas canvas, ChartAxisRenderer axisRenderer, SfCartesianChart chart) {
    final ChartAxis axis = axisRenderer._axis;
    final Rect axisBounds = axisRenderer._bounds;
    Offset point;
    final String title = axis.title.text ?? '';
    final int labelRotation = axis.opposedPosition ? 90 : 270;
    const int innerPadding = 10;
    TextStyle style = axis.title.textStyle;
    style = _getTextStyle(
        textStyle: style,
        fontColor: style.color ?? _chartState!._chartTheme!.axisTitleColor);
    final Size textSize = _measureText(title, style);
    num left;
    if (axis.labelPosition == ChartDataLabelPosition.inside) {
      left = (!axis.opposedPosition)
          ? axisBounds.left -
              (axisRenderer._isInsideTickPosition!
                  ? 0
                  : axis.majorTickLines.size) -
              innerPadding -
              textSize.height
          : axisBounds.left +
              (axisRenderer._isInsideTickPosition!
                  ? 0
                  : axis.majorTickLines.size) +
              innerPadding * 2;
    } else {
      left = (!axis.opposedPosition)
          ? (axisBounds.left -
              (axisRenderer._isInsideTickPosition!
                  ? 0
                  : axis.majorTickLines.size) -
              innerPadding -
              axisRenderer._maximumLabelSize.width -
              textSize.height / 2)
          : axisBounds.left +
              (axisRenderer._isInsideTickPosition!
                  ? 0
                  : axis.majorTickLines.size) +
              innerPadding +
              axisRenderer._maximumLabelSize.width +
              textSize.height / 2;
    }
    axis.title.alignment == ChartAlignment.near
        ? point = Offset(left as double,
            _chartState!._chartAxis!._axisClipRect!.bottom - textSize.width / 2)
        : axis.title.alignment == ChartAlignment.far
            ? point = Offset(
                left as double,
                _chartState!._chartAxis!._axisClipRect!.top +
                    textSize.width / 2)
            : point = Offset(
                left as double, axisBounds.top + (axisBounds.height / 2));
    if (axisRenderer._seriesRenderers!.isNotEmpty ||
        axisRenderer._name == 'primaryYAxis') {
      _drawText(canvas, title, point, style, labelRotation);
    }
  }

  /// returns the calculated interval for axis
  num? calculateInterval(_VisibleRange range, Size? availableSize);

  /// to apply the range padding for the axis
  void applyRangePadding(_VisibleRange range, num interval);

  /// calculates the visible range of the axis
  void calculateVisibleRange(Size availableSize);

  /// this method generates the visible labels for the specific axis
  void generateVisibleLabels();

  /// To calculate the range points
  void calculateRange(ChartAxisRenderer _axisRenderer) {
    _min = null;
    _max = null;
    List<CartesianSeriesRenderer>? seriesRenderers;
    CartesianSeriesRenderer seriesRenderer;
    double paddingInterval = 0;
    ChartAxisRenderer? _xAxisRenderer, _yAxisRenderer;
    num? minimumX, maximumX, minimumY, maximumY;
    String? seriesType;
    seriesRenderers = _seriesRenderers;
    for (int i = 0; i < seriesRenderers!.length; i++) {
      seriesRenderer = seriesRenderers[i];
      minimumX = seriesRenderer._minimumX;
      maximumX = seriesRenderer._maximumX;
      minimumY = seriesRenderer._minimumY;
      maximumY = seriesRenderer._maximumY;
      seriesType = seriesRenderer._seriesType;
      if (seriesRenderer._visible! &&
          minimumX != null &&
          maximumX != null &&
          minimumY != null &&
          maximumY != null) {
        paddingInterval = 0;
        _xAxisRenderer = seriesRenderer._xAxisRenderer;
        _yAxisRenderer = seriesRenderer._yAxisRenderer;
        if (((_xAxisRenderer is DateTimeAxisRenderer ||
                    _xAxisRenderer is NumericAxisRenderer) &&
                _xAxisRenderer?._axis.rangePadding == ChartRangePadding.auto) &&
            (seriesType!.contains('column') ||
                seriesType.contains('bar') ||
                seriesType == 'histogram')) {
          seriesRenderer._minDelta = seriesRenderer._minDelta ??
              _calculateMinPointsDelta(
                  _xAxisRenderer, seriesRenderers, _chartState);
          paddingInterval = seriesRenderer._minDelta! / 2;
        }
        if (((_chartState!._requireInvertedAxis!
                    ? _yAxisRenderer
                    : _xAxisRenderer) ==
                _axisRenderer) &&
            _orientation == AxisOrientation.horizontal) {
          _chartState!._requireInvertedAxis!
              ? _findMinMax(minimumY, maximumY)
              : _findMinMax(
                  minimumX - paddingInterval, maximumX + paddingInterval);
        }

        if (((_chartState!._requireInvertedAxis!
                    ? _xAxisRenderer
                    : _yAxisRenderer) ==
                _axisRenderer) &&
            _orientation == AxisOrientation.vertical) {
          _chartState!._requireInvertedAxis!
              ? _findMinMax(
                  minimumX - paddingInterval, maximumX + paddingInterval)
              : _findMinMax(minimumY, maximumY);
        }
      }
    }
  }

  /// Find min and max values
  void _findMinMax(num minVal, num maxVal) {
    if (_min == null || _min! > minVal) {
      _min = minVal;
    }
    if (_max == null || _max! < maxVal) {
      _max = maxVal;
    }
  }

  /// Calculate the interval based min and max values in axis
  num _calculateNumericNiceInterval(
      ChartAxisRenderer axisRenderer, num delta, Size? size) {
    final List<num> intervalDivisions = <num>[10, 5, 2, 1];
    num niceInterval;

    /// Get the desired interval if desired interval not specified
    final num actualDesiredIntervalCount =
        _calculateDesiredIntervalCount(size, axisRenderer)!;
    niceInterval = delta / actualDesiredIntervalCount;
    if (axisRenderer._axis.desiredIntervals != null) {
      return niceInterval;
    }

    /// Get the minimum interval
    final num minimumInterval = niceInterval == 0
        ? 0
        : math.pow(10, _calculateLogBaseValue(niceInterval, 10).floor());
    for (int i = 0; i < intervalDivisions.length; i++) {
      final num interval = intervalDivisions[i];
      final num currentInterval = minimumInterval * interval;
      if (actualDesiredIntervalCount < (delta / currentInterval)) {
        break;
      }
      niceInterval = currentInterval;
    }
    return niceInterval;
  }

  /// Calculate the axis interval for numeric axis
  num? _calculateDesiredIntervalCount(
      Size? availableSize, ChartAxisRenderer axisRenderer) {
    final num size = axisRenderer._orientation == AxisOrientation.horizontal
        ? availableSize!.width
        : availableSize!.height;
    if (axisRenderer._axis.desiredIntervals == null) {
      num desiredIntervalCount =
          (axisRenderer._orientation == AxisOrientation.horizontal
                  ? 0.533
                  : 1) *
              axisRenderer._axis.maximumLabels;
      desiredIntervalCount = math.max(size * (desiredIntervalCount / 100), 1);
      return desiredIntervalCount;
    } else {
      return axisRenderer._axis.desiredIntervals;
    }
  }

  /// Get the range padding of an axis
  ChartRangePadding? _calculateRangePadding(
      ChartAxisRenderer axisRenderer, SfCartesianChart? chart) {
    final ChartAxis axis = axisRenderer._axis;
    ChartRangePadding? padding;
    if (axis.rangePadding != ChartRangePadding.auto) {
      padding = axis.rangePadding;
    } else if (axis.rangePadding == ChartRangePadding.auto &&
        axisRenderer._orientation != null) {
      switch (axisRenderer._orientation!) {
        case AxisOrientation.horizontal:
          padding = _chartState!._requireInvertedAxis!
              ? (_isStack100
                  ? ChartRangePadding.round
                  : ChartRangePadding.normal)
              : ChartRangePadding.none;
          break;
        case AxisOrientation.vertical:
          padding = !_chartState!._requireInvertedAxis!
              ? (_isStack100
                  ? ChartRangePadding.round
                  : ChartRangePadding.normal)
              : ChartRangePadding.none;
          break;
      }
    }
    return padding;
  }

  ///Applying range padding
  void _applyRangePadding(ChartAxisRenderer axisRenderer,
      SfCartesianChartState? chartState, _VisibleRange range, num? interval) {
    final num? start = range.minimum;
    final num? end = range.maximum;
    final ChartRangePadding? padding = _calculateRangePadding(this, _chart);
    if (padding == ChartRangePadding.additional ||
        padding == ChartRangePadding.round) {
      /// Get the additional range
      _findAdditionalRange(this, start!, end!, interval!);
    } else if (padding == ChartRangePadding.normal) {
      /// Get the normal range
      _findNormalRange(this, start, end, interval);
    } else {
      _updateActualRange(this, start, end, interval);
    }
    range.delta = range.maximum - range.minimum;
  }

  /// Find the additional range
  void _findAdditionalRange(
      ChartAxisRenderer axisRenderer, num start, num end, num interval) {
    num minimum;
    num maximum;
    minimum = ((start / interval).floor()) * interval;
    maximum = ((end / interval).ceil()) * interval;
    if (axisRenderer._axis.rangePadding == ChartRangePadding.additional) {
      minimum -= interval;
      maximum += interval;
    }

    /// Update the visible range to the axis.
    _updateActualRange(axisRenderer, minimum, maximum, interval);
  }

  /// Update visible range
  void _updateActualRange(ChartAxisRenderer axisRenderer, num? minimum,
      num? maximum, num? interval) {
    final dynamic axis = axisRenderer._axis;
    axisRenderer._actualRange!.minimum = axis.minimum ?? minimum;
    axisRenderer._actualRange!.maximum = axis.maximum ?? maximum;
    axisRenderer._actualRange!.delta =
        axisRenderer._actualRange!.maximum - axisRenderer._actualRange!.minimum;
    axisRenderer._actualRange!.interval = axis.interval ?? interval;
  }

  /// Find the normal range
  void _findNormalRange(
      ChartAxisRenderer axisRenderer, num? start, num? end, num? interval) {
    final ChartAxis axis = axisRenderer._axis;
    num remaining, minimum, maximum;
    num? startValue = start;
    if (axis is CategoryAxis && axis.labelPlacement == LabelPlacement.onTicks) {
      minimum = start! - 0.5;
      maximum = end! + 0.5;
    } else {
      if (start! < 0) {
        startValue = 0;
        minimum = start + (start / 20);
        remaining = interval! + _getValueByPercentage(minimum, interval)!;
        if ((0.365 * interval) >= remaining) {
          minimum -= interval;
        }
        if (_getValueByPercentage(minimum, interval)! < 0) {
          minimum =
              (minimum - interval) - _getValueByPercentage(minimum, interval)!;
        }
      } else {
        minimum =
            start < ((5.0 / 6.0) * end!) ? 0 : (start - (end - start) / 2);
        if (minimum % interval! > 0) {
          minimum -= minimum % interval;
        }
      }
      maximum = (end! > 0)
          ? (end + (end - startValue!) / 20)
          : (end - (end - startValue!) / 20);
      remaining = interval - (maximum % interval);
      if ((0.365 * interval) >= remaining) {
        maximum += interval;
      }
      if (maximum % interval > 0) {
        maximum = (maximum + interval) - (maximum % interval);
      }
    }
    if (minimum == 0) {
      interval = (axisRenderer is NumericAxisRenderer)
          ? _calculateNumericNiceInterval(
              axisRenderer, maximum - minimum, _axisSize)
          : calculateInterval(_VisibleRange(minimum, maximum), _axisSize);
      maximum = (maximum / interval!).ceil() * interval;
    }

    /// Update the visible range to the axis.
    _updateActualRange(axisRenderer, minimum, maximum, interval);
  }

  /// To trigger the render label event
  void _triggerLabelRenderEvent(String? labelText, num labelValue) {
    AxisLabelRenderArgs axisLabelArgs;
    TextStyle fontStyle = _axis.labelStyle;
    if (_chart!.onAxisLabelRender != null) {
      axisLabelArgs =
          AxisLabelRenderArgs(labelValue, _name, _orientation, _axis);
      axisLabelArgs.text = labelText;
      axisLabelArgs.textStyle = fontStyle;
      _chart!.onAxisLabelRender!(axisLabelArgs);
      labelText = axisLabelArgs.text;
      fontStyle = axisLabelArgs.textStyle;
    }
    final Size labelSize =
        _measureText(labelText, fontStyle, _axis.labelRotation);
    _visibleLabels.add(AxisLabel(fontStyle, labelSize, labelText, labelValue));
  }

  /// Calculate the maximum lable's size
  void _calculateMaximumLabelSize(
      ChartAxisRenderer axisRenderer, SfCartesianChartState chartState) {
    AxisLabelIntersectAction action;
    AxisLabel label;
    final ChartAxis axis = axisRenderer._axis;
    num maximumLabelHeight = 0.0,
        maximumLabelWidth = 0.0,
        labelMaximumWidth,
        pointX;
    action = axis.labelIntersectAction;
    labelMaximumWidth = chartState._chartAxis!._axisClipRect!.width /
        axisRenderer._visibleLabels.length;
    if (axisRenderer._orientation == AxisOrientation.horizontal &&
        axis.labelIntersectAction != AxisLabelIntersectAction.none &&
        axisRenderer._visibleLabels.length > 1) {
      final Rect? axisBounds = chartState._chartAxis!._axisClipRect;
      AxisLabel label1;
      num pointX1;
      for (int i = 0; i < axisRenderer._visibleLabels.length - 1; i++) {
        label = axisRenderer._visibleLabels[i];
        pointX = (_valueToCoefficient(label.value, axisRenderer) *
                axisBounds!.width) +
            axisBounds.left;
        pointX -= label.labelSize.width / 2;
        pointX = (i == 0 &&
                axis.edgeLabelPlacement == EdgeLabelPlacement.shift &&
                ((pointX < axisBounds.left && !axis.isInversed) ||
                    (pointX + label.labelSize.width > axisBounds.right &&
                        axis.isInversed)))
            ? (axis.isInversed
                ? axisBounds.left + axisBounds.width - label.labelSize.width
                : axisBounds.left)
            : ((i == axisRenderer._visibleLabels.length - 1 &&
                    axis.edgeLabelPlacement == EdgeLabelPlacement.shift &&
                    ((((pointX + label.labelSize.width) > axisBounds.right) &&
                            !axis.isInversed) ||
                        (pointX < axisBounds.left && axis.isInversed)))
                ? (axis.isInversed
                    ? axisBounds.left
                    : axisBounds.left +
                        axisBounds.width -
                        label.labelSize.width)
                : pointX);

        label1 = axisRenderer._visibleLabels[i + 1];
        pointX1 = (_valueToCoefficient(label1.value, axisRenderer) *
                chartState._chartAxis!._axisClipRect!.width) +
            chartState._chartAxis!._axisClipRect!.left;
        pointX1 -= label1.labelSize.width / 2;

        if ((((pointX + label.labelSize.width) > pointX1) &&
                !axis.isInversed) ||
            (((pointX - label.labelSize.width) < pointX1) && axis.isInversed)) {
          _isCollide = true;
          break;
        }
      }
    }

    for (int i = 0; i < axisRenderer._visibleLabels.length; i++) {
      label = axisRenderer._visibleLabels[i];
      if (label.labelSize.width > maximumLabelWidth) {
        maximumLabelWidth = label.labelSize.width;
      }
      if (label.labelSize.height > maximumLabelHeight) {
        maximumLabelHeight = label.labelSize.height;
      }

      if (axisRenderer._orientation == AxisOrientation.horizontal) {
        pointX = (_valueToCoefficient(label.value, axisRenderer) *
                chartState._chartAxis!._axisClipRect!.width) +
            chartState._chartAxis!._axisClipRect!.left;
        pointX -= label.labelSize.width / 2;

        /// Based on below options, perform label intersection
        if (_isCollide) {
          final List<num> _list = _performLabelIntersectAction(
              label,
              action,
              maximumLabelWidth,
              maximumLabelHeight,
              labelMaximumWidth,
              pointX,
              i,
              axisRenderer,
              _chart);
          maximumLabelWidth = _list[0];
          maximumLabelHeight = _list[1];
        }
      }
    }
    axisRenderer._maximumLabelSize =
        Size(maximumLabelWidth as double, maximumLabelHeight as double);
  }

  /// Return the height and width values of labelIntersectAction
  List<num> _performLabelIntersectAction(
      AxisLabel label,
      AxisLabelIntersectAction action,
      num maximumLabelWidth,
      num maximumLabelHeight,
      num labelMaximumWidth,
      num pointX,
      int i,
      ChartAxisRenderer axisRenderer,
      SfCartesianChart? chart) {
    num height;
    int? angle = axisRenderer._labelRotation;
    Size currentLabelSize;
    final ChartAxis axis = axisRenderer._axis;
    switch (action) {
      case AxisLabelIntersectAction.multipleRows:
        if (i > 0) {
          height = _findMultiRows(i, pointX, label, axisRenderer, chart);
          if (height > maximumLabelHeight) {
            maximumLabelHeight = height;
          }
        }
        break;
      case AxisLabelIntersectAction.rotate45:
      case AxisLabelIntersectAction.rotate90:
        angle = action == AxisLabelIntersectAction.rotate45 ? -45 : -90;
        axisRenderer._labelRotation = angle;
        currentLabelSize = _measureText(label.text, axis.labelStyle, angle);
        if (currentLabelSize.height > maximumLabelHeight) {
          maximumLabelHeight = currentLabelSize.height;
        }
        if (currentLabelSize.width > maximumLabelWidth) {
          maximumLabelWidth = currentLabelSize.width;
        }
        break;
      case AxisLabelIntersectAction.wrap:
        label._labelCollection = _gettingLabelCollection(
            label.text!, labelMaximumWidth, axisRenderer);
        if (label._labelCollection!.isNotEmpty) {
          label.text = label._labelCollection![0];
        }
        height = label.labelSize.height * label._labelCollection!.length;
        if (height > maximumLabelHeight) {
          maximumLabelHeight = height;
        }
        break;
      default:
        break;
    }
    return <num>[maximumLabelWidth, maximumLabelHeight];
  }

  /// To find the height of the current label
  num _findMultiRows(num length, num currentX, AxisLabel currentLabel,
      ChartAxisRenderer axisRenderer, SfCartesianChart? chart) {
    AxisLabel label;
    num pointX;
    final ChartAxis axis = axisRenderer._axis;
    final List<int> labelIndex = <int>[];
    bool isMultiRows;
    for (int i = length - 1 as int; i >= 0; i--) {
      label = axisRenderer._visibleLabels[i];
      pointX = (_valueToCoefficient(label.value, axisRenderer) *
              _chartState!._chartAxis!._axisClipRect!.width) +
          _chartState!._chartAxis!._axisClipRect!.left;
      isMultiRows = !axis.isInversed
          ? currentX < (pointX + label.labelSize.width / 2)
          : currentX + currentLabel.labelSize.width >
              (pointX - label.labelSize.width / 2);
      if (isMultiRows) {
        labelIndex.add(label._index);
        currentLabel._index = (currentLabel._index > label._index)
            ? currentLabel._index
            : label._index + 1;
      } else {
        currentLabel._index = labelIndex.contains(label._index)
            ? currentLabel._index
            : label._index;
      }
    }
    return currentLabel.labelSize.height * currentLabel._index;
  }

  /// To get the label collection
  List<String> _gettingLabelCollection(
      String currentLabel, num maximumWidth, ChartAxisRenderer axisRenderer) {
    final ChartAxis axis = axisRenderer._axis;
    final List<String> textCollection = currentLabel.split(RegExp(' '));
    final List<String> labelCollection = <String>[];
    String text;
    for (int i = 0; i < textCollection.length; i++) {
      text = textCollection[i];
      (_measureText(text, axis.labelStyle, axisRenderer._labelRotation).width <
              maximumWidth)
          ? labelCollection.add(text)
          : labelCollection.add(_trimAxisLabelsText(
              text, maximumWidth, axis.labelStyle, axisRenderer));
    }
    return labelCollection;
  }

  /// To trim the specific label text
  String _trimAxisLabelsText(String text, num maximumWidth,
      TextStyle labelStyle, ChartAxisRenderer axisRenderer) {
    String label = text;
    num size = _measureText(
            text, axisRenderer._axis.labelStyle, axisRenderer._labelRotation)
        .width;
    if (size > maximumWidth) {
      final int textLength = text.length;
      for (int i = textLength - 1; i >= 0; --i) {
        label = text.substring(0, i) + '...';
        size =
            _measureText(label, labelStyle, axisRenderer._labelRotation).width;
        if (size <= maximumWidth) {
          return label;
        }
      }
    }
    return label;
  }

  ///Below method is for changing range while zooming
  void _calculateZoomRange(ChartAxisRenderer axisRenderer, Size? axisSize) {
    ChartAxisRenderer? oldAxisRenderer;
    final ChartAxis axis = axisRenderer._axis;
    assert(
        axis.zoomFactor != null
            ? axis.zoomFactor >= 0 && axis.zoomFactor <= 1
            : true,
        'The zoom factor of the axis should be between 0 and 1.');
    assert(
        axis.zoomPosition != null
            ? axis.zoomPosition >= 0 && axis.zoomPosition <= 1
            : true,
        'The zoom position of the axis should be between 0 and 1.');

    /// Restrict zoom factor and zoom position values between 0 to 1
    axisRenderer._zoomFactor = axisRenderer._zoomFactor! > 1
        ? 1
        : axisRenderer._zoomFactor! < 0
            ? 0
            : axisRenderer._zoomFactor;
    axisRenderer._zoomPosition = axisRenderer._zoomPosition! > 1
        ? 1
        : axisRenderer._zoomPosition! < 0
            ? 0
            : axisRenderer._zoomPosition;
    if (_chartState!._oldAxisRenderers != null &&
        _chartState!._oldAxisRenderers!.isNotEmpty) {
      oldAxisRenderer =
          _getOldAxisRenderer(axisRenderer, _chartState!._oldAxisRenderers!);
    }
    if (oldAxisRenderer != null) {
      axisRenderer._zoomFactor =
          oldAxisRenderer._axis.zoomFactor != axis.zoomFactor
              ? axis.zoomFactor
              : axisRenderer._zoomFactor;
      axisRenderer._zoomPosition =
          oldAxisRenderer._axis.zoomPosition != axis.zoomPosition
              ? axis.zoomPosition
              : axisRenderer._zoomPosition;
    }

    final _VisibleRange baseRange = axisRenderer._visibleRange!;
    num? start, end;
    start = axisRenderer._visibleRange!.minimum +
        axisRenderer._zoomPosition! * axisRenderer._visibleRange!.delta!;
    end =
        start! + axisRenderer._zoomFactor! * axisRenderer._visibleRange!.delta!;

    if (start < baseRange.minimum) {
      end = end + (baseRange.minimum - start);
      start = baseRange.minimum;
    }
    if (end > baseRange.maximum) {
      start = start! - (end - baseRange.maximum);
      end = baseRange.maximum;
    }
    axisRenderer._visibleRange!.minimum = start;
    axisRenderer._visibleRange!.maximum = end;
    axisRenderer._visibleRange!.delta = end! - start!;
  }

  /// To check zommed axis state
  void _checkWithZoomState(ChartAxisRenderer axisRenderer,
      List<ChartAxisRenderer?> axisRendererStates) {
    for (int i = 0; i < axisRendererStates.length; i++) {
      final ChartAxisRenderer zoomedAxisRenderer = axisRendererStates[i]!;
      if (zoomedAxisRenderer._name == axisRenderer._name) {
        axisRenderer._zoomFactor = zoomedAxisRenderer._zoomFactor;
        axisRenderer._zoomPosition = zoomedAxisRenderer._zoomPosition;
        break;
      }
    }
  }

  /// To provide chart changes to range controller
  void _setRangeControllerValues(ChartAxisRenderer _axisRenderer) {
    if (_axisRenderer is DateTimeAxisRenderer) {
      _axis.rangeController!.start = DateTime.fromMillisecondsSinceEpoch(
          _axisRenderer._visibleRange!.minimum);
      _axis.rangeController!.end = DateTime.fromMillisecondsSinceEpoch(
          _axisRenderer._visibleRange!.maximum);
    } else {
      _axis.rangeController!.start = _axisRenderer._visibleRange!.minimum;
      _axis.rangeController!.end = _axisRenderer._visibleRange!.maximum;
    }
  }

  /// To change chart based on range controller
  void _updateRangeControllerValues(ChartAxisRenderer _axisRenderer) {
    if (_axisRenderer is DateTimeAxisRenderer) {
      _axisRenderer._rangeMinimum =
          _axis.rangeController!.start.millisecondsSinceEpoch;
      _axisRenderer._rangeMaximum =
          _axis.rangeController!.end.millisecondsSinceEpoch;
    } else {
      _axisRenderer._rangeMinimum = _axis.rangeController!.start;
      _axisRenderer._rangeMaximum = _axis.rangeController!.end;
    }
  }
}
