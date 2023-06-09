part of charts;

/// This class holds the property of circular series.
///
/// To render the Circlular chart, create an instance of [PieSeries] or [DoughnutSeries] or [RadialBarSeries], and add it to the
/// series collection property of [SfCircularChart]. You can use the radius property to change the diameter of the circular chart for the plot area.
/// Also, explode the circular chart segment by enabling the explode property.
///
/// Provide the options of stroke width, stroke color, opacity, and point color mapper to customize the appearance.
///
class CircularSeries<T, D> extends ChartSeries<T, D>
    implements CircularChartEmptyPointBehavior {
  /// Creating an argument constructor of CircularSeries class.
  CircularSeries(
      {this.key,
      this.onCreateRenderer,
      this.onRendererCreated,
      this.dataSource,
      this.xValueMapper,
      this.yValueMapper,
      this.pointColorMapper,
      this.pointRadiusMapper,
      this.dataLabelMapper,
      this.sortFieldValueMapper,
      int? startAngle,
      int? endAngle,
      String? radius,
      String? innerRadius,
      bool? explode,
      bool? explodeAll,
      this.explodeIndex,
      ActivationMode? explodeGesture,
      String? explodeOffset,
      this.groupTo,
      this.groupMode,
      String? gap,
      double? opacity,
      EmptyPointSettings? emptyPointSettings,
      Color? borderColor,
      double? borderWidth,
      DataLabelSettings? dataLabelSettings,
      bool? enableTooltip,
      bool? enableSmartLabels,
      this.name,
      double? animationDuration,
      // ignore: deprecated_member_use_from_same_package
      SelectionSettings? selectionSettings,
      SelectionBehavior? selectionBehavior,
      SortingOrder? sortingOrder,
      LegendIconType? legendIconType,
      CornerStyle? cornerStyle,
      List<int>? initialSelectedDataIndexes})
      : startAngle = startAngle ?? 0,
        animationDuration = animationDuration ?? 1500,
        endAngle = endAngle ?? 360,
        radius = radius ?? '80%',
        innerRadius = innerRadius ?? '50%',
        explode = explode ?? false,
        explodeAll = explodeAll ?? false,
        explodeOffset = explodeOffset ?? '10%',
        explodeGesture = explodeGesture ?? ActivationMode.singleTap,
        gap = gap ?? '1%',
        cornerStyle = cornerStyle ?? CornerStyle.bothFlat,
        dataLabelSettings = dataLabelSettings ?? DataLabelSettings(),
        emptyPointSettings = emptyPointSettings ?? EmptyPointSettings(),
        // ignore: deprecated_member_use_from_same_package
        selectionSettings = selectionSettings ?? SelectionSettings(),
        selectionBehavior = selectionBehavior ?? SelectionBehavior(),
        borderColor = borderColor ?? Colors.transparent,
        borderWidth = borderWidth ?? 0.0,
        opacity = opacity ?? 1,
        enableTooltip = enableTooltip ?? true,
        sortingOrder = sortingOrder ?? SortingOrder.none,
        legendIconType = legendIconType ?? LegendIconType.seriesType,
        enableSmartLabels = enableSmartLabels ?? true,
        initialSelectedDataIndexes = initialSelectedDataIndexes ?? <int>[],
        super(name: name) {
    _renderer = _ChartSeriesRender();
  }

  ///Opacity of the series. The value ranges from 0 to 1.
  ///
  ///Defaults to `1`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///              PieSeries<ChartData, String>(
  ///                dataSource: <ChartData>[
  ///                   ChartData('USA', 10),
  ///                   ChartData('China', 11),
  ///                   ChartData('Russia', 9),
  ///                   ChartData('Germany', 10),
  ///                ],
  ///                 opacity: 1,
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///```
  @override
  final double opacity;

  ///Toggles the visibility of the tooltip for this series.
  ///
  ///Defaults to `true`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///              PieSeries<ChartData, String>(
  ///                dataSource: <ChartData>[
  ///                   ChartData('USA', 10),
  ///                   ChartData('China', 11),
  ///                   ChartData('Russia', 9),
  ///                   ChartData('Germany', 10),
  ///                ],
  ///                dataLabelSettings: DataLabelSettings(isVisible: true),
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///```
  @override
  final DataLabelSettings dataLabelSettings;

  late _ChartSeriesRender _renderer;

  ///A collection of data required for rendering the series.
  ///
  /// If no data source is specified,
  ///empty chart will be rendered without series.
  ///
  ///Defaults to `null`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///              PieSeries<ChartData, String>(
  ///                dataSource: <ChartData>[
  ///                   ChartData('USA', 10),
  ///                   ChartData('China', 11),
  ///                   ChartData('Russia', 9),
  ///                   ChartData('Germany', 10),
  ///                ],
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///```
  @override
  final List<T>? dataSource;

  ///Maps the field name, which will be considered as x-values.
  ///
  ///Defaults to `null`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///              PieSeries<ChartData, String>(
  ///                dataSource: <ChartData>[
  ///                   ChartData('USA', 10),
  ///                   ChartData('China', 11),
  ///                   ChartData('Russia', 9),
  ///                   ChartData('Germany', 10),
  ///                ],
  ///                xValueMapper: (ChartData data, _) => data.xVal,
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///class ChartData {
  ///   ChartData(this.xVal, this.yVal, [this.radius]);
  ///   final String xVal;
  ///   final int yVal;
  ///   final String radius;
  ///}
  ///```
  @override
  final ChartIndexedValueMapper<D>? xValueMapper;

  ///Maps the field name, which will be considered as y-values.
  ///
  ///Defaults to `null`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///              PieSeries<ChartData, String>(
  ///                dataSource: <ChartData>[
  ///                   ChartData('USA', 10),
  ///                   ChartData('China', 11),
  ///                   ChartData('Russia', 9),
  ///                   ChartData('Germany', 10),
  ///                ],
  ///                yValueMapper: (ChartData data, _) => data.yVal,
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///class ChartData {
  ///   ChartData(this.xVal, this.yVal, [this.radius]);
  ///   final String xVal;
  ///   final int yVal;
  ///   final String radius;
  ///}
  ///```
  @override
  final ChartIndexedValueMapper<num>? yValueMapper;

  ///Maps the field name, which will be considered as x-values.
  ///
  ///Defaults to `null`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///              PieSeries<ChartData, String>(
  ///                dataSource: <ChartData>[
  ///                   ChartData('USA', 10, Colors.red),
  ///                   ChartData('China', 11, Colors.green),
  ///                   ChartData('Russia', 9, Colors.blue),
  ///                   ChartData('Germany', 10, Colors.voilet),
  ///                ],
  ///                pointColorMapper: (ChartData data, _) => data.pointColor,
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///class ChartData {
  ///   ChartData(this.xVal, this.yVal, [this.pointColor]);
  ///   final String xVal;
  ///   final int yVal;
  ///   final Color pointColor;
  ///}
  ///```
  @override
  final ChartIndexedValueMapper<Color?>? pointColorMapper;

  ///Maps the field name, which will be considered for calculating the radius of
  /// all the data points.
  ///
  ///Defaults to `null`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///              PieSeries<ChartData, String>(
  ///                dataSource: <ChartData>[
  ///                   ChartData('USA', 10, '50%'),
  ///                   ChartData('China', 11, '55%'),
  ///                   ChartData('Russia', 9, '60%'),
  ///                   ChartData('Germany', 10, '65%'),
  ///                ],
  ///                pointRadiusMapper: (ChartData data, _) => data.radius,
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///class ChartData {
  ///   ChartData(this.xVal, this.yVal, [this.radius]);
  ///   final String xVal;
  ///   final int yVal;
  ///   final String radius;
  ///}
  ///```
  final ChartIndexedValueMapper<String?>? pointRadiusMapper;

  ///Maps the field name, which will be considered as text for the data points.
  ///
  ///Defaults to `null`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///              PieSeries<ChartData, String>(
  ///                dataSource: <ChartData>[
  ///                   ChartData('USA', 10),
  ///                   ChartData('China', 11),
  ///                   ChartData('Russia', 9),
  ///                   ChartData('Germany', 10),
  ///                ],
  ///                dataLabelMapper: (ChartData data, _) => data.xVal,
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///class ChartData {
  ///   ChartData(this.xVal, this.yVal, [this.radius]);
  ///   final String xVal;
  ///   final int yVal;
  ///   final String radius;
  ///}
  ///```
  @override
  final ChartIndexedValueMapper<String?>? dataLabelMapper;

  ///Field in the data source for performing sorting. Sorting will be performed
  ///based on this field.
  ///
  ///Defaults to `null`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///              PieSeries<ChartData, String>(
  ///                dataSource: <ChartData>[
  ///                   ChartData('USA', 10),
  ///                   ChartData('China', 11),
  ///                   ChartData('Russia', 9),
  ///                   ChartData('Germany', 10),
  ///                ],
  ///                sortFieldValueMapper: (ChartData data, _) => data.xVal,
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///class ChartData {
  ///   ChartData(this.xVal, this.yVal, [this.radius]);
  ///   final String xVal;
  ///   final int yVal;
  ///   final String radius;
  ///}
  ///```
  @override
  final ChartIndexedValueMapper<dynamic>? sortFieldValueMapper;

  ///Data label placement without collision.
  ///
  ///Defaults to `true`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///           series: <PieSeries<ChartData, String>>[
  ///                PieSeries<ChartData, String>(
  ///                   enableSmartLabels: true,
  ///                  )
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final bool enableSmartLabels;

  ///Shape of the legend icon.
  ///
  ///Any shape in the LegendIconType can be applied to this property.
  ///By default, icon will be rendered based on the type of the series.
  ///
  ///Defaults to `LegendIconType.seriesType``
  ///
  ///Also refer [LegendIconType]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///           series: <PieSeries<ChartData, String>>[
  ///                PieSeries<ChartData, String>(
  ///                  legendIconType: LegendIconType.diamond,
  ///                  )
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  @override
  final LegendIconType legendIconType;

  ///Type of sorting.
  ///
  ///The data points in the series can be sorted in ascending or descending
  ///order.The data points will be rendered in the specified order if it is set to none.
  ///
  ///Default to `none`
  ///
  ///Also refer [SortingOrder]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///           series: <PieSeries<ChartData, String>>[
  ///                PieSeries<ChartData, String>(
  ///                  sortingOrder: SortingOrder.ascending,
  ///                  )
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  @override
  final SortingOrder sortingOrder;

  ///Toggles the visibility of the tooltip for this series.
  ///
  ///Defaults to `true`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///              PieSeries<ChartData, String>(
  ///                enableTooltip: true,
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///```
  @override
  final bool enableTooltip;

  ///Border width of the data points in the series.
  ///
  ///Defaults to `0`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            borderColor: Colors.red,
  ///            borderWidth: 2
  ///        ));
  ///}
  ///```
  @override
  final double borderWidth;

  ///Border color of the data points in the series.
  ///
  ///Defaults to `Colors.transparent`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            borderColor: Colors.red
  ///        ));
  ///}
  ///```
  @override
  final Color borderColor;

  ///Customizes the empty data points in the series
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///                PieSeries<ChartData, String>(
  ///                  emptyPointSettings: EmptyPointSettings (color: Colors.red)
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  @override
  final EmptyPointSettings emptyPointSettings;

  ///Customizes the selection of series.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///           series: <PieSeries<ChartData, String>>[
  ///                PieSeries<ChartData, String>(
  ///                  selectionSettings: SelectionSettings(
  ///                    selectedColor: Colors.red,
  ///                    unselectedColor: Colors.grey
  ///                  ),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  @override
  // ignore: deprecated_member_use_from_same_package
  final SelectionSettings selectionSettings;

  ///Customizes the selection of series.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///           series: <PieSeries<ChartData, String>>[
  ///                PieSeries<ChartData, String>(
  ///                  selectionBehavior: SelectionBehavior(
  ///                    selectedColor: Colors.red,
  ///                    unselectedColor: Colors.grey
  ///                  ),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  @override
  final SelectionBehavior selectionBehavior;

  ///Starting angle of the series.
  ///
  ///Defaults to `0`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///                PieSeries<ChartData, String>(
  ///                  startAngle: 270;
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final int startAngle;

  ///Ending angle of the series.
  ///
  ///Defaults to `360`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///                PieSeries<ChartData, String>(
  ///                  endAngle: 270;
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final int endAngle;

  ///Radius of the series.
  ///
  /// The value ranges from 0% to 100%.
  ///
  ///Defaults to `‘80%’`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///                PieSeries<ChartData, String>(
  ///                  radius: '10%';
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final String radius;

  ///Inner radius of the series.
  ///
  ///The value ranges from 0% to 100%.
  ///
  ///Defaults to `‘50%’`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <DoughnutSeries<ChartData, String>>[
  ///                DoughnutSeries<ChartData, String>(
  ///                  innerRadius: '20%';
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final String innerRadius;

  ///Enables or disables the explode of slices on tap.
  ///
  ///Default to `false`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///                PieSeries<ChartData, String>(
  ///                  explode: true;
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final bool explode;

  ///Enables or disables exploding all the slices at the initial rendering.
  ///
  ///Defaults to `false`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///                PieSeries<ChartData, String>(
  ///                  explodeAll: true
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final bool explodeAll;

  ///Index of the slice to explode it at the initial rendering.
  ///
  ///Defaults to `null`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///                PieSeries<ChartData, String>(
  ///                  explode: true,
  ///                  explodeIndex: 2
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final int? explodeIndex;

  ///Offset of exploded slice. The value ranges from 0% to 100%.
  ///
  ///Defaults to `20%`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///                PieSeries<ChartData, String>(
  ///                  explode: true,
  ///                  explodeOffset: '30%'
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final String explodeOffset;

  ///Gesture for activating the explode.
  ///
  ///Explode can be activated in tap, double tap,
  ///and long press.
  ///
  ///Defaults to `ActivationMode.tap`
  ///
  ///Also refer [ActivationMode]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///                PieSeries<ChartData, String>(
  ///                  explode: true,
  ///                  explodeGesture: ActivationMode.singleTap
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final ActivationMode explodeGesture;

  ///Groups the data points of the series based on their index or values.
  ///
  ///Defaults to `null`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///                PieSeries<ChartData, String>(
  ///                  groupTo: 4,
  ///                  groupMode: CircularChartGroupMode.point
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double? groupTo;

  ///Slice can also be grouped based on the data points value or based on index.
  ///
  ///Defaults to `CircularChartGroupMode.point`
  ///
  ///Also refer [CircularChartGroupMode]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///                PieSeries<ChartData, String>(
  ///                  groupTo: 3,
  ///                  groupMode: CircularChartGroupMode.point,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final CircularChartGroupMode? groupMode;

  ///Specifies the gap between the radial bars in percentage.
  ///
  ///Defaults to `null`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <RadialBarSeries<ChartData, String>>[
  ///                RadialBarSeries<ChartData, String>(
  ///                  gap: '10%',
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final String gap;

  ///Specifies the radial bar’s corner type.
  ///
  /// _Note:_ This is applicable only for radial bar series type.
  ///
  ///Defaults to `CornerStyle.bothFlat`
  ///
  ///Also refer [CornerStyle]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <RadialBarSeries<ChartData, String>>[
  ///                RadialBarSeries<ChartData, String>(
  ///                  cornerStyle: CornerStyle.bothCurve,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final CornerStyle cornerStyle;

  ///Name of the series.
  ///
  ///Defaults to `‘’`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///              PieSeries<ChartData, String>(
  ///                name: 'default',
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///```
  @override
  final String? name;

  ///Duration for animating the data points.
  ///
  ///Defaults to `1500`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///                PieSeries<ChartData, String>(
  ///                  animationDuration: 3000;
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  @override
  final double animationDuration;

  /// List of data indexes initially selected
  ///
  /// Defaults to `null`.
  ///```dart
  ///     Widget build(BuildContext context) {
  ///    return Scaffold(
  ///        body: Center(
  ///            child: Container(
  ///                  child: SfCircularChart(
  ///                      initialSelectedDataIndexes: <IndexesModel>[IndexesModel(1, 0)]
  ///                 )
  ///              )
  ///          )
  ///      );
  ///  }
  List<int> initialSelectedDataIndexes;

  ///Key to identify a series in a collection.

  ///

  ///On specifying [ValueKey] as the series [key], existing series index can be changed in the series collection without losing its state.

  ///

  ///When a new series is added dynamically to the collection, existing series index will be changed. On that case,

  /// the existing series and its state will be linked based on its chart type and this key value.

  ///

  ///Defaults to `null`.

  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<SalesData, num>>[
  ///                PieSeries<SalesData, num>(
  ///                      key: const ValueKey<String>('pie_series_key'),
  ///                 ),
  ///              ],
  ///        ));
  ///}
  ///```
  final ValueKey<String>? key;

  ///Used to create the renderer for custom series.
  ///
  ///This is applicable only when the custom series is defined in the sample
  /// and for built-in series types, it is not applicable.
  ///
  ///Renderer created in this will hold the series state and
  /// this should be created for each series. [onCreateRenderer] callback
  /// function should return the renderer class and should not return null.
  ///
  ///Series state will be created only once per series and will not be created
  ///again when we update the series.
  ///
  ///Defaults to `null`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<SalesData, num>>[
  ///                PieSeries<SalesData, num>(
  ///                  onCreateRenderer:(CircularSeries<dynamic, dynamic> series){
  ///                      return CustomLinerSeriesRenderer();
  ///                    }
  ///                ),
  ///              ],
  ///        ));
  /// }
  ///  class CustomLinerSeriesRenderer extends PieSeriesRenderer {
  ///       // custom implementation here...
  ///  }
  ///```
  final ChartSeriesRendererFactory<T, D>? onCreateRenderer;

  ///Triggers when the series renderer is created.

  ///

  ///Using this callback, able to get the [ChartSeriesController] instance, which is used to access the public methods in the series.

  ///

  ///Defaults to `null`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    ChartSeriesController _chartSeriesController;
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <CircularSeries<SalesData, num>>[
  ///                PieSeries<SalesData, num>(
  ///                    onRendererCreated: (ChartSeriesController controller) {
  ///                       _chartSeriesController = controller;
  ///                    },
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final CircularSeriesRendererCreatedCallback? onRendererCreated;

  /// To calculate empty point values
  @override
  void calculateEmptyPointValue(
      int pointIndex, ChartPoint<dynamic> currentPoint,
      [CircularSeriesRenderer? seriesRenderer]) {
    final EmptyPointSettings empty = emptyPointSettings;
    final List<ChartPoint> dataPoints =
        (seriesRenderer == null) ? <ChartPoint>[] : seriesRenderer._dataPoints!;
    final int pointLength = dataPoints.length;
    final ChartPoint<dynamic> point = dataPoints[pointIndex];
    if (point.y == null) {
      switch (empty.mode) {
        case EmptyPointMode.average:
          final num previous =
              pointIndex - 1 >= 0 ? dataPoints[pointIndex - 1].y ?? 0 : 0;
          final num next = pointIndex + 1 <= pointLength - 1
              ? dataPoints[pointIndex + 1].y ?? 0
              : 0;
          point.y = (previous + next).abs() / 2;
          point.isVisible = true;
          point.isEmpty = true;
          break;
        case EmptyPointMode.zero:
          point.y = 0;
          point.isVisible = true;
          point.isEmpty = true;
          break;
        case EmptyPointMode.drop:
        case EmptyPointMode.gap:
          point.isEmpty = true;
          point.isVisible = false;
          break;
      }
    }
  }
}

/// To get visible point index
int? _getVisiblePointIndex(
    List<ChartPoint<dynamic>?>? points, String loc, int index) {
  if (loc == 'before') {
    for (int i = index; i >= 0; i--) {
      if (points![i - 1]!.isVisible) {
        return i - 1;
      }
    }
  } else {
    for (int i = index; i < points!.length; i++) {
      if (points[i + 1]!.isVisible) {
        return i + 1;
      }
    }
  }
  return null;
}

abstract class _CircularChartSegment {
  /// To get point color of current point
  Color? getPointColor(
      CircularSeriesRenderer seriesRenderer,
      ChartPoint<dynamic> point,
      int pointIndex,
      int seriesIndex,
      Color color,
      double opacity);

  /// To get opacity of current point
  double getOpacity(
      CircularSeriesRenderer seriesRenderer,
      ChartPoint<dynamic> point,
      int pointIndex,
      int seriesIndex,
      double opacity);

  /// To get Stroke color of current point
  Color? getPointStrokeColor(
      CircularSeriesRenderer seriesRenderer,
      ChartPoint<dynamic> point,
      int pointIndex,
      int seriesIndex,
      Color strokeColor);

  /// To get Stroke width of current point
  double? getPointStrokeWidth(
      CircularSeriesRenderer seriesRenderer,
      ChartPoint<dynamic> point,
      int pointIndex,
      int seriesIndex,
      double strokeWidth);
}

abstract class _LabelSegment {
  /// To get label text content
  String? getLabelContent(
      CircularSeriesRenderer seriesRenderer,
      ChartPoint<dynamic> point,
      int pointIndex,
      int seriesIndex,
      String content);

  /// To get textstyle of current point
  TextStyle getDataLabelStyle(
      CircularSeriesRenderer seriesRenderer,
      ChartPoint<dynamic> point,
      int pointIndex,
      int seriesIndex,
      TextStyle style,
      SfCircularChartState _chartState);

  /// To get data label color
  Color? getDataLabelColor(CircularSeriesRenderer seriesRenderer,
      ChartPoint<dynamic> point, int pointIndex, int seriesIndex, Color color);

  /// To get the data label stroke color
  Color getDataLabelStrokeColor(
      CircularSeriesRenderer seriesRenderer,
      ChartPoint<dynamic> point,
      int pointIndex,
      int seriesIndex,
      Color strokeColor);

  /// To get label stroke width
  double getDataLabelStrokeWidth(
      CircularSeriesRenderer seriesRenderer,
      ChartPoint<dynamic> point,
      int pointIndex,
      int seriesIndex,
      double strokeWidth);
}

class _ChartSeriesRender with _CircularChartSegment, _LabelSegment {
  _ChartSeriesRender();

  /// To get point color
  @override
  Color? getPointColor(
          CircularSeriesRenderer seriesRenderer,
          ChartPoint<dynamic> point,
          int pointIndex,
          int? seriesIndex,
          Color? color,
          double opacity) =>
      color?.withOpacity(opacity);

  /// To get point stroke color
  @override
  Color? getPointStrokeColor(
          CircularSeriesRenderer seriesRenderer,
          ChartPoint<dynamic> point,
          int pointIndex,
          int? seriesIndex,
          Color? strokeColor) =>
      strokeColor;

  /// To get point stroke width
  @override
  double? getPointStrokeWidth(
          CircularSeriesRenderer seriesRenderer,
          ChartPoint<dynamic> point,
          int pointIndex,
          int? seriesIndex,
          double? strokeWidth) =>
      strokeWidth;

  /// To return label text
  @override
  String? getLabelContent(
          CircularSeriesRenderer seriesRenderer,
          ChartPoint<dynamic> point,
          int pointIndex,
          int seriesIndex,
          String? content) =>
      content;

  /// To return textstyle of label
  @override
  TextStyle getDataLabelStyle(
      CircularSeriesRenderer seriesRenderer,
      ChartPoint<dynamic> point,
      int pointIndex,
      int seriesIndex,
      TextStyle? style,
      SfCircularChartState _chartState) {
    final DataLabelSettings dataLabel =
        seriesRenderer._series!.dataLabelSettings;
    final Color fontColor = dataLabel.textStyle.color ??
        _getCircularDataLabelColor(point, seriesRenderer, _chartState);
    final TextStyle textStyle = TextStyle(
        color: fontColor,
        fontSize: dataLabel.textStyle.fontSize,
        fontFamily: dataLabel.textStyle.fontFamily,
        fontStyle: dataLabel.textStyle.fontStyle,
        fontWeight: dataLabel.textStyle.fontWeight);
    return textStyle;
  }

  /// To return label color
  @override
  Color? getDataLabelColor(
          CircularSeriesRenderer seriesRenderer,
          ChartPoint<dynamic> point,
          int pointIndex,
          int seriesIndex,
          Color? color) =>
      color;

  /// To return label stroke color
  @override
  Color getDataLabelStrokeColor(
          CircularSeriesRenderer seriesRenderer,
          ChartPoint<dynamic> point,
          int pointIndex,
          int seriesIndex,
          Color strokeColor) =>
      strokeColor;

  /// To return label stroke width
  @override
  double getDataLabelStrokeWidth(
          CircularSeriesRenderer seriesRenderer,
          ChartPoint<dynamic> point,
          int pointIndex,
          int seriesIndex,
          double strokeWidth) =>
      strokeWidth;

  /// To return opacity of currrent point
  @override
  double getOpacity(
          CircularSeriesRenderer seriesRenderer,
          ChartPoint<dynamic> point,
          int pointIndex,
          int? seriesIndex,
          double opacity) =>
      opacity;
}

/// Creates a series renderer for Circular series
class CircularSeriesRenderer extends ChartSeriesRenderer {
  CircularSeries<dynamic, dynamic>? _series;

  String? _seriesType;

  List<ChartPoint<dynamic>>? _dataPoints;

  List<ChartPoint<dynamic>>? _renderPoints;

  List<ChartPoint<dynamic>>? _oldRenderPoints;

  num? _sumOfPoints;

  num? _start;

  num? _end;

  num? _totalAngle;

  num? _currentRadius;

  num? _currentInnerRadius;

  Offset? _center;

  late List<_Region> _pointRegions;

  // ignore:unused_field
  Rect? _rect;

  SelectionArgs? _selectionArgs;

  //Determines whether there is a need for animation
  late bool _needsAnimation;

  ///We can redraw the series with updating or creating new points by using this controller.If we need to access the redrawing methods
  ///in this before we must get the ChartSeriesController onRendererCreated event.
  CircularSeriesController? _controller;

  late SfCircularChartState _chartState;

  /// Repaint notifier for series
  ValueNotifier<int>? _repaintNotifier;

  DataLabelSettingsRenderer? _dataLabelSettingsRenderer;

  SelectionBehaviorRenderer? _selectionBehaviorRenderer;

  dynamic _selectionBehavior;

  // ignore: prefer_final_fields
  bool _isSelectionEnable = false;

  /// To set style properties for selected points
  _StyleOptions? _selectPoint(
      int currentPointIndex,
      CircularSeriesRenderer seriesRenderer,
      SfCircularChart chart,
      ChartPoint<dynamic> point) {
    _StyleOptions? pointStyle;
    final dynamic selection = _series!.selectionBehavior.enable
        ? _series!.selectionBehavior
        : _series!.selectionSettings;
    const num seriesIndex = 0;
    if (selection.enable) {
      if (_chartState._selectionData.isNotEmpty) {
        for (int i = 0; i < _chartState._selectionData.length; i++) {
          final int? selectionIndex = _chartState._selectionData[i];
          if (chart.onSelectionChanged != null &&
              selectionIndex == currentPointIndex) {
            chart.onSelectionChanged!(_getSelectionEventArgs(
                seriesRenderer, seriesIndex, currentPointIndex));
          }
          if (currentPointIndex == selectionIndex) {
            pointStyle = _StyleOptions(
                seriesRenderer._selectionArgs != null
                    ? seriesRenderer._selectionArgs!.selectedColor
                    : selection.selectedColor,
                seriesRenderer._selectionArgs != null
                    ? seriesRenderer._selectionArgs!.selectedBorderWidth
                    : selection.selectedBorderWidth,
                seriesRenderer._selectionArgs != null
                    ? seriesRenderer._selectionArgs!.selectedBorderColor
                    : selection.selectedBorderColor,
                selection.selectedOpacity);
            break;
          } else if (i == _chartState._selectionData.length - 1) {
            pointStyle = _StyleOptions(
                seriesRenderer._selectionArgs != null
                    ? seriesRenderer._selectionArgs!.unselectedColor
                    : selection.unselectedColor,
                seriesRenderer._selectionArgs != null
                    ? _selectionArgs!.unselectedBorderWidth
                    : selection.unselectedBorderWidth,
                seriesRenderer._selectionArgs != null
                    ? seriesRenderer._selectionArgs!.unselectedBorderColor
                    : selection.unselectedBorderColor,
                selection.unselectedOpacity);
          }
        }
      }
    }
    return pointStyle;
  }

  /// To perform slection event and return Selection Args
  SelectionArgs? _getSelectionEventArgs(
      dynamic seriesRenderer, num seriesIndex, num pointIndex) {
    if (seriesRenderer != null) {
      final dynamic selectionBehavior = seriesRenderer._selectionBehavior;
      final SelectionArgs args = SelectionArgs(seriesRenderer,
          seriesIndex as int?, pointIndex as int?, pointIndex as int?);
      args.selectedBorderColor = selectionBehavior.selectedBorderColor;
      args.selectedBorderWidth = selectionBehavior.selectedBorderWidth;
      args.selectedColor = selectionBehavior.selectedColor;
      args.unselectedBorderColor = selectionBehavior.unselectedBorderColor;
      args.unselectedBorderWidth = selectionBehavior.unselectedBorderWidth;
      args.unselectedColor = selectionBehavior.unselectedColor;
      seriesRenderer._selectionArgs = args;
    }
    return seriesRenderer._selectionArgs;
  }

  /// To calculate point start and end angle
  num? _circularRenderPoint(
      SfCircularChart chart,
      CircularSeriesRenderer seriesRenderer,
      ChartPoint<dynamic> point,
      num? pointStartAngle,
      num? innerRadius,
      num? outerRadius,
      Canvas canvas,
      num? seriesIndex,
      num pointIndex,
      num? animationDegreeValue,
      num? animationRadiusValue,
      bool isAnyPointSelect,
      ChartPoint<dynamic>? oldPoint,
      [List<ChartPoint<dynamic>?>? oldPointList]) {
    final bool isDynamicUpdate = oldPoint != null;
    final num? oldStartAngle = oldPoint?.startAngle;
    final num? oldEndAngle = oldPoint?.endAngle;
    num? pointEndAngle, degree;

    /// below lines for dynamic dataSource changes
    if (isDynamicUpdate) {
      if (!oldPoint.isVisible && point.isVisible) {
        final num val = point.startAngle == seriesRenderer._start
            ? seriesRenderer._start!
            : oldPointList![_getVisiblePointIndex(
                    oldPointList, 'before', pointIndex as int)!]!
                .endAngle!;
        pointStartAngle =
            val - (val - point.startAngle!) * animationDegreeValue!;
        pointEndAngle = val + (point.endAngle! - val) * animationDegreeValue;
        degree = pointEndAngle - pointStartAngle;
      } else if (oldPoint.isVisible && !point.isVisible) {
        if (oldPoint.startAngle!.round() == seriesRenderer._start &&
            (oldPoint.endAngle!.round() == seriesRenderer._end ||
                oldPoint.endAngle!.round() == 360 + seriesRenderer._end!)) {
          pointStartAngle = oldPoint.startAngle;
          pointEndAngle = oldPoint.endAngle! -
              (oldPoint.endAngle! - oldPoint.startAngle!) *
                  animationDegreeValue!;
        } else if (oldPoint.startAngle == oldPoint.endAngle) {
          pointStartAngle = pointEndAngle = oldPoint.startAngle;
        } else {
          pointStartAngle = oldPoint.startAngle! -
              (oldPoint.startAngle! -
                      (oldPoint.startAngle == seriesRenderer._start
                          ? seriesRenderer._start!
                          : seriesRenderer
                              ._renderPoints![_getVisiblePointIndex(
                                  seriesRenderer._renderPoints,
                                  'before',
                                  pointIndex as int)!]
                              .endAngle!)) *
                  animationDegreeValue!;
          pointEndAngle = oldPoint.endAngle! -
              (oldPoint.endAngle! -
                      ((oldPoint.endAngle!.round() == seriesRenderer._end ||
                              oldPoint.endAngle!.round() ==
                                  360 + seriesRenderer._end!)
                          ? oldPoint.endAngle!
                          : seriesRenderer
                              ._renderPoints![_getVisiblePointIndex(
                                  seriesRenderer._renderPoints,
                                  'after',
                                  pointIndex as int)!]
                              .startAngle!)) *
                  animationDegreeValue;
        }
        degree = pointEndAngle! - pointStartAngle!;
      } else if (point.isVisible && oldPoint.isVisible) {
        pointStartAngle = (point.startAngle! > oldStartAngle!)
            ? oldStartAngle +
                ((point.startAngle! - oldStartAngle) * animationDegreeValue!)
            : oldStartAngle -
                ((oldStartAngle - point.startAngle!) * animationDegreeValue!);
        pointEndAngle = (point.endAngle! > oldEndAngle!)
            ? oldEndAngle +
                ((point.endAngle! - oldEndAngle) * animationDegreeValue)
            : oldEndAngle -
                ((oldEndAngle - point.endAngle!) * animationDegreeValue);
        degree = pointEndAngle - pointStartAngle;
      }
    } else if (point.isVisible) {
      degree = animationDegreeValue! * point.degree;
      pointEndAngle = pointStartAngle! + degree;
    }
    outerRadius = _chartState._initialRender!
        ? animationRadiusValue! * outerRadius!
        : outerRadius;
    _calculatePath(
        pointIndex as int,
        seriesIndex as int?,
        chart,
        seriesRenderer,
        point,
        oldPoint,
        canvas,
        degree,
        innerRadius,
        outerRadius,
        pointStartAngle,
        pointEndAngle,
        isDynamicUpdate);
    return pointEndAngle;
  }

  /// calculating the data point path
  void _calculatePath(
      int pointIndex,
      int? seriesIndex,
      SfCircularChart chart,
      CircularSeriesRenderer seriesRenderer,
      ChartPoint<dynamic> point,
      ChartPoint<dynamic>? oldPoint,
      Canvas canvas,
      num? degree,
      num? innerRadius,
      num? outerRadius,
      num? pointStartAngle,
      num? pointEndAngle,
      bool isDynamicUpdate) {
    Path? renderPath;
    final CornerStyle cornerStyle = _series!.cornerStyle;
    num? actualStartAngle, actualEndAngle;
    if (!isDynamicUpdate ||
        (isDynamicUpdate &&
            ((oldPoint!.isVisible && point.isVisible) ||
                (oldPoint.isVisible && !point.isVisible) ||
                (!oldPoint.isVisible && point.isVisible)))) {
      innerRadius = innerRadius ?? oldPoint!.innerRadius;
      outerRadius = outerRadius ?? oldPoint!.outerRadius;
      if (cornerStyle != CornerStyle.bothFlat) {
        final num angleDeviation =
            _findAngleDeviation(innerRadius!, outerRadius!, 360);
        actualStartAngle = (cornerStyle == CornerStyle.startCurve ||
                cornerStyle == CornerStyle.bothCurve)
            ? (pointStartAngle! + angleDeviation)
            : pointStartAngle;
        actualEndAngle = (cornerStyle == CornerStyle.endCurve ||
                cornerStyle == CornerStyle.bothCurve)
            ? (pointEndAngle! - angleDeviation)
            : pointEndAngle;
      }
      renderPath = Path();
      renderPath = (cornerStyle == CornerStyle.startCurve ||
              cornerStyle == CornerStyle.endCurve ||
              cornerStyle == CornerStyle.bothCurve)
          ? _getRoundedCornerArcPath(
              innerRadius!,
              outerRadius!,
              point.center ?? oldPoint!.center!,
              actualStartAngle!,
              actualEndAngle!,
              degree,
              cornerStyle)
          : _getArcPath(
              innerRadius!,
              outerRadius!,
              point.center ?? oldPoint!.center!,
              pointStartAngle!,
              pointEndAngle!,
              degree!,
              chart,
              _chartState._animateCompleted!);
    }
    _drawDataPoints(pointIndex, seriesIndex, chart, seriesRenderer, point,
        canvas, renderPath, degree, innerRadius);
  }

  ///draw slice path
  void _drawDataPoints(
      int pointIndex,
      int? seriesIndex,
      SfCircularChart chart,
      CircularSeriesRenderer seriesRenderer,
      ChartPoint<dynamic> point,
      Canvas canvas,
      Path? renderPath,
      num? degree,
      num? innerRadius) {
    if (point.isVisible) {
      final _Region pointRegion = _Region(
          _degreesToRadians(point.startAngle!),
          _degreesToRadians(point.endAngle!),
          point.startAngle,
          point.endAngle,
          seriesIndex,
          pointIndex,
          point.center,
          innerRadius,
          point.outerRadius);
      seriesRenderer._pointRegions.add(pointRegion);
    }
    final _StyleOptions? style =
        _selectPoint(pointIndex, seriesRenderer, chart, point);
    final Color? fillColor = style != null && style.fill != null
        ? style.fill
        : (point.fill != Colors.transparent
            ? seriesRenderer._series!._renderer.getPointColor(
                seriesRenderer,
                point,
                pointIndex,
                seriesIndex,
                point.fill,
                seriesRenderer._series!.opacity)
            : point.fill);

    final Color? strokeColor = style != null && style.strokeColor != null
        ? style.strokeColor
        : seriesRenderer._series!._renderer.getPointStrokeColor(
            seriesRenderer, point, pointIndex, seriesIndex, point.strokeColor);

    final double? strokeWidth = style != null && style.strokeWidth != null
        ? style.strokeWidth as double?
        : seriesRenderer._series!._renderer.getPointStrokeWidth(seriesRenderer,
            point, pointIndex, seriesIndex, point.strokeWidth as double?);

    assert(seriesRenderer._series!.opacity >= 0,
        'The opacity value will not accept negative numbers.');
    assert(seriesRenderer._series!.opacity <= 1,
        'The opacity value must be less than 1.');
    final double? opacity = style != null && style.opacity != null
        ? style.opacity
        : _series!._renderer.getOpacity(seriesRenderer, point, pointIndex,
            seriesIndex, seriesRenderer._series!.opacity);

    if (renderPath != null && degree! > 0) {
      _drawPath(
          canvas,
          _StyleOptions(
              fillColor,
              _chartState._animateCompleted! ? strokeWidth : 0,
              strokeColor,
              opacity),
          renderPath);
    }
  }
}

/// Return the controller for circular series
typedef CircularSeriesRendererCreatedCallback = void Function(
    CircularSeriesController controller);

///We can redraw the series with updating or creating new points by using this controller.If we need to access the redrawing methods
///in this before we must get the ChartSeriesController onRendererCreated event.
class CircularSeriesController {
  /// Creating an argument constructor of CircularSeriesController class.
  CircularSeriesController(this.seriesRenderer);

  ///Used to access the series properties.
  ///
  ///Defaults to `null`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    ChartSeriesController _chartSeriesController;
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: PieSeries<SalesData, num>(
  ///                    onRendererCreated: (CircularSeriesController controller) {
  ///                       _chartSeriesController = controller;
  ///                       // prints series yAxisName
  ///                      debugPrint(_chartSeriesController.seriesRenderer._series.yAxisName);
  ///                    },
  ///                ),
  ///        ));
  ///}
  ///```
  final CircularSeriesRenderer? seriesRenderer;

  ///Used to process only the newly added, updated and removed data points in a series,
  /// instead of processing all the data points.
  ///
  ///To re-render the chart with modified data points, setState() will be called.
  /// This will render the process and render the chart from scratch.
  /// Thus, the app’s performance will be degraded on continuous update.
  /// To overcome this problem, [updateDataSource] method can be called by passing updated data points indexes.
  /// Chart will process only that point and skip various steps like bounds calculation,
  /// old data points processing, etc. Thus, this will improve the app’s performance.
  ///
  ///The following are the arguments of this method.
  /// * addedDataIndexes – `List<int>` type – Indexes of newly added data points in the existing series.
  /// * removedDataIndexes – `List<int>` type – Indexes of removed data points in the existing series.
  /// * updatedDataIndexes – `List<int>` type – Indexes of updated data points in the existing series.
  /// * addedDataIndex – `int` type – Index of newly added data point in the existing series.
  /// * removedDataIndex – `int` type – Index of removed data point in the existing series.
  /// * updatedDataIndex – `int` type – Index of updated data point in the existing series.
  ///
  ///Returns `void`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    CircularSeriesController seriesController;
  ///    return Column(
  ///      children: <Widget>[
  ///      Container(
  ///        child: SfCircularChart(
  ///            series: <CircularSeries<SalesData, num>>[
  ///                PieSeries<SalesData, num>(
  ///                   dataSource: chartData,
  ///                    onRendererCreated: (CircularSeriesController controller) {
  ///                       seriesController = controller;
  ///                    },
  ///                ),
  ///              ],
  ///        )),
  ///   Container(
  ///      child: RaisedButton(
  ///           onPressed: () {
  ///           chartData.removeAt(0);
  ///           chartData.add(ChartData(3,23));
  ///           seriesController.updateDataSource(
  ///               addedDataIndexes: <int>[chartData.length -1],
  ///               removedDataIndexes: <int>[0],
  ///           );
  ///      })
  ///   )]
  ///  );
  /// }
  ///```
  void updateDataSource(
      {List<int>? addedDataIndexes,
      List<int>? removedDataIndexes,
      List<int>? updatedDataIndexes,
      int? addedDataIndex,
      int? removedDataIndex,
      int? updatedDataIndex}) {
    if (removedDataIndexes != null && removedDataIndexes.isNotEmpty) {
      _removeDataPointsList(removedDataIndexes);
    } else if (removedDataIndex != null) {
      _removeDataPoint(removedDataIndex);
    }
    if (addedDataIndexes != null && addedDataIndexes.isNotEmpty) {
      _addOrUpdateDataPoints(addedDataIndexes, false);
    } else if (addedDataIndex != null) {
      _addOrUpdateDataPoint(addedDataIndex, false);
    }
    if (updatedDataIndexes != null && updatedDataIndexes.isNotEmpty) {
      _addOrUpdateDataPoints(updatedDataIndexes, true);
    } else if (updatedDataIndex != null) {
      _addOrUpdateDataPoint(updatedDataIndex, true);
    }
    _updateCircularSeries();
  }

  /// Add or update the data points on dynamic series update
  void _addOrUpdateDataPoints(List<int> indexes, bool needUpdate) {
    for (int i = 0; i < indexes.length; i++) {
      final int dataIndex = indexes[i];
      _addOrUpdateDataPoint(dataIndex, needUpdate);
    }
  }

  /// add or update a data point in the given index
  void _addOrUpdateDataPoint(int index, bool needUpdate) {
    final CircularSeries<dynamic, dynamic>? series = seriesRenderer!._series;
    if (index >= 0 &&
        series!.dataSource!.length > index &&
        series.dataSource![index] != null) {
      final ChartPoint<dynamic> _currentPoint =
          _getCircularPoint(seriesRenderer!, index)!;
      if (_currentPoint.x != null) {
        if (needUpdate) {
          if (seriesRenderer!._dataPoints!.length > index) {
            seriesRenderer!._dataPoints![index] = _currentPoint;
          }
        } else {
          if (seriesRenderer!._dataPoints!.length == index) {
            seriesRenderer!._dataPoints!.add(_currentPoint);
          } else if (seriesRenderer!._dataPoints!.length > index &&
              index >= 0) {
            seriesRenderer!._dataPoints!.insert(index, _currentPoint);
          }
        }
      }
    }
  }

  ///Remove list of points
  void _removeDataPointsList(List<int> removedDataIndexes) {
    ///Remove the redudant index from the list
    final List<int> indexList = removedDataIndexes.toSet().toList();
    indexList.sort((int b, int a) => a.compareTo(b));
    for (int i = 0; i < indexList.length; i++) {
      final int dataIndex = indexList[i];
      _removeDataPoint(dataIndex);
    }
  }

  /// remove a data point in the given index
  void _removeDataPoint(int index) {
    if (seriesRenderer!._dataPoints!.isNotEmpty &&
        index >= 0 &&
        index < seriesRenderer!._dataPoints!.length) {
      seriesRenderer!._dataPoints!.removeAt(index);
    }
  }

  /// After add/remove/update datapoints, recalculate the chart angle and positions
  void _updateCircularSeries() {
    final SfCircularChartState _chartState = seriesRenderer!._chartState;
    _chartState._chartSeries!._processDataPoints(seriesRenderer!);
    _chartState._chartSeries
        ?._calculateAngleAndCenterPositions(seriesRenderer!);
    seriesRenderer!._repaintNotifier!.value++;
    if (seriesRenderer!._series!.dataLabelSettings.isVisible &&
        _chartState._renderDataLabel != null) {
      _chartState._renderDataLabel!.state.render();
    }
    if (seriesRenderer!._series!.dataLabelSettings.isVisible &&
        _chartState._chartTemplate != null &&
        _chartState._chartTemplate!.state != null) {
      _chartState._chartTemplate!.state!.templateRender();
    }
  }
}
