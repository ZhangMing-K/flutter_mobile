part of charts;

abstract class _FinancialSeriesBase<T, D> extends XyDataSeries<T, D> {
  _FinancialSeriesBase(
      {ValueKey<String>? key,
      ChartSeriesRendererFactory<T, D>? onCreateRenderer,
      required List<T> dataSource,
      required ChartValueMapper<T, D> xValueMapper,
      ChartValueMapper<T, num>? lowValueMapper,
      ChartValueMapper<T, num>? highValueMapper,
      this.openValueMapper,
      this.closeValueMapper,
      this.volumeValueMapper,
      ChartValueMapper<T, dynamic>? sortFieldValueMapper,
      ChartValueMapper<T, Color>? pointColorMapper,
      ChartValueMapper<T, String>? dataLabelMapper,
      SortingOrder? sortingOrder,
      List<double>? dashArray,
      String? xAxisName,
      String? yAxisName,
      String? name,
      Color? color,
      double? width,
      double? spacing,
      MarkerSettings? markerSettings,
      EmptyPointSettings? emptyPointSettings,
      DataLabelSettings? dataLabelSettings,
      bool? isVisible,
      LinearGradient? gradient,
      bool? enableTooltip,
      double? animationDuration,
      double? borderWidth,
      // ignore: deprecated_member_use_from_same_package
      SelectionSettings? selectionSettings,
      SelectionBehavior? selectionBehavior,
      List<int>? initialSelectedDataIndexes,
      bool? isVisibleInLegend,
      LegendIconType? legendIconType,
      String? legendItemText,
      this.enableSolidCandles,
      this.bearColor,
      this.bullColor,
      double? opacity,
      this.showIndicationForSameValues = false,
      List<Trendline>? trendlines,
      SeriesRendererCreatedCallback? onRendererCreated})
      : dashArray = dashArray ?? <double>[0, 0],
        spacing = spacing ?? 0,
        super(
            key: key,
            onCreateRenderer: onCreateRenderer,
            name: name,
            xValueMapper: xValueMapper,
            lowValueMapper: lowValueMapper,
            highValueMapper: highValueMapper,
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
            gradient: gradient,
            emptyPointSettings: emptyPointSettings,
            enableTooltip: enableTooltip,
            animationDuration: animationDuration,
            borderWidth: borderWidth,
            selectionSettings: selectionSettings,
            selectionBehavior: selectionBehavior,
            initialSelectedDataIndexes: initialSelectedDataIndexes,
            legendItemText: legendItemText,
            isVisibleInLegend: isVisibleInLegend,
            legendIconType: legendIconType,
            sortingOrder: sortingOrder,
            opacity: opacity,
            onRendererCreated: onRendererCreated,
            trendlines: trendlines);

  final ChartIndexedValueMapper<num>? volumeValueMapper;
  final ChartIndexedValueMapper<num>? openValueMapper;
  final ChartIndexedValueMapper<num>? closeValueMapper;
  final Color? bearColor;
  final Color? bullColor;
  final bool? enableSolidCandles;
  @override
  final List<double> dashArray;

  ///Spacing between the columns. The value ranges from 0 to 1.
  ///1 represents 100% and 0 represents 0% of the available space.
  ///
  ///Spacing also affects the width of the column. For example, setting 20% spacing
  ///and 100% width renders the column with 80% of total width.
  ///
  ///Defaults to `0`
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <HiloSeries<SalesData, num>>[
  ///                HiloSeries<SalesData, num>(
  ///                  spacing: 0,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double spacing;

  ///
  ///If it is set to true, a small vertical line will be rendered. Else nothing will
  /// be rendered for that specific data point and left as a blank area.
  ///
  ///This is applicable for the following series types:
  ///* HiLo (High low)
  ///* OHLC (Open high low close)
  ///* Candle
  ///
  ///Defaults to `false`
  final bool showIndicationForSameValues;
}

//ignore: unused_element
abstract class _FinancialSerieBaseRenderer extends XyDataSeriesRenderer {
  _FinancialSerieBaseRenderer();

  // ignore:unused_field
  num? _rectPosition;
  // ignore:unused_field
  num? _rectCount;
}
