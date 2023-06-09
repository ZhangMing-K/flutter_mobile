part of charts;

/// Returns the LegendRenderArgs.
typedef FunnelLegendRenderCallback = void Function(
    LegendRenderArgs legendRenderArganimateCompleteds);

/// Returns the TooltipArgs.
typedef FunnelTooltipCallback = void Function(TooltipArgs tooltipArgs);

/// Returns the DataLabelRenderArgs.
typedef FunnelDataLabelRenderCallback = void Function(
    DataLabelRenderArgs dataLabelArgs);

/// Returns the SelectionArgs.
typedef FunnelSelectionCallback = void Function(SelectionArgs? selectionArgs);

///Returns tha PointTapArgs.
typedef FunnelPointTapCallback = void Function(PointTapArgs pointTapArgs);

/// Returns the Offset
typedef FunnelTouchInteractionCallback = void Function(
    ChartTouchInteractionArgs tapArgs);

///Renders the funnel chart
///
///A funnel chart is a specialized chart type that demonstrates the flow of users through a business or sales process.
/// The chart begins with a broad head and ends in a narrow neck.
///
/// The number of users at each stage of the process are indicated from the funnel's width as it narrows
///
/// To render a funnel chart, create an instance of FunnelSeries, and add it to the series property of [SfFunnelChart].
//ignore:must_be_immutable
class SfFunnelChart extends StatefulWidget {
  /// Creating an argument constructor of SfFunnelChart class.
  SfFunnelChart({
    Key? key,
    this.backgroundColor,
    this.backgroundImage,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0.0,
    this.onLegendItemRender,
    this.onTooltipRender,
    this.onDataLabelRender,
    this.onPointTapped,
    this.onLegendTapped,
    this.onDataLabelTapped,
    this.onSelectionChanged,
    this.onChartTouchInteractionUp,
    this.onChartTouchInteractionDown,
    this.onChartTouchInteractionMove,
    ChartTitle? title,
    FunnelSeries<dynamic, dynamic>? series,
    EdgeInsets? margin,
    Legend? legend,
    this.palette = const <Color>[
      Color.fromRGBO(75, 135, 185, 1),
      Color.fromRGBO(192, 108, 132, 1),
      Color.fromRGBO(246, 114, 128, 1),
      Color.fromRGBO(248, 177, 149, 1),
      Color.fromRGBO(116, 180, 155, 1),
      Color.fromRGBO(0, 168, 181, 1),
      Color.fromRGBO(73, 76, 162, 1),
      Color.fromRGBO(255, 205, 96, 1),
      Color.fromRGBO(255, 240, 219, 1),
      Color.fromRGBO(238, 238, 238, 1)
    ],
    TooltipBehavior? tooltipBehavior,
    SmartLabelMode? smartLabelMode,
    ActivationMode? selectionGesture,
    bool? enableMultiSelection,
  })  : title = title ?? ChartTitle(),
        series = series ?? FunnelSeries<dynamic, dynamic>(),
        margin = margin ?? const EdgeInsets.fromLTRB(10, 10, 10, 10),
        legend = legend ?? Legend(),
        tooltipBehavior = tooltipBehavior ?? TooltipBehavior(),
        smartLabelMode = smartLabelMode ?? SmartLabelMode.hide,
        selectionGesture = selectionGesture ?? ActivationMode.singleTap,
        enableMultiSelection = enableMultiSelection ?? false,
        super(key: key);

  ///Customizes the chart title
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            title: ChartTitle(text: 'Funnel Chart')
  ///        ));
  ///}
  ///```
  final ChartTitle title;

  ///Background color of the chart
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            backgroundColor: Colors.blue
  ///        ));
  ///}
  ///```
  final Color? backgroundColor;

  ///Background color of the chart
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            backgroundColor: Colors.blue
  ///        ));
  ///}
  ///```
  final Color borderColor;

  ///Border width of the chart
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            backgroundColor: Colors.blue
  ///        ));
  ///}
  ///```
  final double borderWidth;

  ///Customizes the chart series.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<_FunnelData, String>(
  ///                          dataSource: data,
  ///                          xValueMapper: (_FunnelData data, _) => data.xData,
  ///                          yValueMapper: (_FunnelData data, _) => data.yData)
  ///        ));
  ///}
  ///```
  final FunnelSeries<dynamic, dynamic> series;

  ///Margin for chart
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            margin: const EdgeInsets.all(2),
  ///        ));
  ///}
  ///```
  final EdgeInsets margin;

  ///Customizes the legend in the chart
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            legend: Legend(isVisible: true)
  ///        ));
  ///}
  ///```
  final Legend legend;

  ///Color palette for the data points in the chart series.
  ///
  ///If the series color is not specified, then the series will be rendered with appropriate palette color.
  ///
  ///Ten colors are available by default.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            palette: <Color>[Colors.red, Colors.green]
  ///        ));
  ///}
  ///```
  final List<Color> palette;

  ///Customizes the tooltip in chart
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            tooltipBehavior: TooltipBehavior(enable: true)
  ///        ));
  ///}
  ///```
  final TooltipBehavior tooltipBehavior;

  /// Occurs while legend is rendered.
  ///
  ///  Here, you can get the legend's text, shape, series index, and point index case of circular series.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            legend: Legend(isVisible: true),
  ///            onLegendItemRender: (LegendRendererArgs args) => legend(args),
  ///        ));
  ///}
  ///void legend(LegendRendererArgs args) {
  ///   args.legendIconType = LegendIconType.diamond;
  ///}
  ///```
  final FunnelLegendRenderCallback? onLegendItemRender;

  /// Occurs while tooltip is rendered.
  ///
  ///  Here, you can get the Tooltip render arguments and customize them.
  final FunnelTooltipCallback? onTooltipRender;

  /// Occurs when the data label is rendered
  ///
  /// Here we can get get the datalabel render arguments and customise the datalabel parameters.
  final FunnelDataLabelRenderCallback? onDataLabelRender;

  /// Occurs when the legend is tapped ,using this event the legend tap arguments can be customized.
  final ChartLegendTapCallback? onLegendTapped;

  ///Overlapping of the labels can be avoided by using the smartLabelMode property.
  ///
  ///The default value is true for accumulation type series and false for other series types.
  final SmartLabelMode smartLabelMode;

  ///Data points or series can be selected while performing interaction on the chart.
  ///
  ///It can also be selected at the initial rendering using this property.
  ///
  ///Defaults to `[]`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///           series: FunnelSeries<ChartData, String>(
  ///                  initialSelectedDataIndexes: <int>[1,0],
  ///                  selectionSettings: SelectionSettings(
  ///                    selectedColor: Colors.red,
  ///                    unselectedColor: Colors.grey
  ///                  ),
  ///                ),
  ///        ));
  ///}
  ///```

  ///Gesture for activating the selection.
  ///
  ///Selection can be activated in tap, double tap, and long press.
  ///
  ///Defaults to `ActivationMode.tap`.
  ///
  ///Also refer [ActivationMode]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///           selectionGesture: ActivationMode.singleTap,
  ///           series: FunnelSeries<ChartData, String>(
  ///                  selectionSettings: SelectionSettings(
  ///                    selectedColor: Colors.red,
  ///                    unselectedColor: Colors.grey
  ///                  ),
  ///                ),
  ///        ));
  ///}
  ///```
  final ActivationMode selectionGesture;

  ///Enables or disables the multiple data points selection.
  ///
  ///Defaults to `false`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///           enableMultiSelection: true,
  ///           series: FunnelSeries<ChartData, String>(
  ///                  selectionSettings: SelectionSettings(
  ///                    selectedColor: Colors.red,
  ///                    unselectedColor: Colors.grey
  ///                  ),
  ///                ),
  ///        ));
  ///}
  ///```
  final bool enableMultiSelection;

  ///Background image for chart.
  ///
  ///Defaults to `null`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            backgroundImage: const AssetImage('image.png'),
  ///        ));
  ///}
  ///```
  final ImageProvider? backgroundImage;

  /// Occurs while selection changes. Here, you can get the series, selected color,
  /// unselected color, selected border color, unselected border color, selected
  /// border width, unselected border width, series index, and point index.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            onSelectionChanged: (SelectionArgs args) => select(args),
  ///        ));
  ///}
  ///void select(SelectionArgs args) {
  ///   debugPrint(args.selectedBorderColor);
  ///}
  ///```
  final FunnelSelectionCallback? onSelectionChanged;

  /// Occurs when tapped on the chart area.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            onChartTouchInteractionUp: (ChartTouchInteractionArgs args){
  ///               debugPrint(args.position.dx.toString());
  ///               debugPrint(args.position.dy.toString());
  ///             }
  ///        ));
  ///}
  ///```
  final FunnelTouchInteractionCallback? onChartTouchInteractionUp;

  /// Occurs when touched on the chart area.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            onChartTouchInteractionDown: (ChartTouchInteractionArgs args){
  ///               debugPrint(args.position.dx.toString());
  ///               debugPrint(args.position.dy.toString());
  ///             }
  ///        ));
  ///}
  ///```
  final FunnelTouchInteractionCallback? onChartTouchInteractionDown;

  /// Occurs when touched and moved on the chart area.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            onChartTouchInteractionMove: (ChartTouchInteractionArgs args){
  ///               debugPrint(args.position.dx.toString());
  ///               debugPrint(args.position.dy.toString());
  ///             }
  ///        ));
  ///}
  ///```
  final FunnelTouchInteractionCallback? onChartTouchInteractionMove;

  /// Occurs when tapping a series point. Here, you can get the series, series index
  /// and point index.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            onPointTapped: (PointTapArgs args) => point(args),
  ///        ));
  ///}
  ///void point(PointTapArgs args) {
  ///   debugPrint(args.pointIndex);
  ///}
  ///```
  final FunnelPointTapCallback? onPointTapped;

  //Called when the data label is tapped.
  ///
  ///Whenever the data label is tapped, `onDataLabelTapped` callback will be called. Provides options to
  /// get the position of the data label, series index, point index and its text.
  ///
  ///_Note:_ - This callback will not be called, when the builder is specified for data label
  /// (data label template). For this case, custom widget specified in the `DataLabelSettings.builder` property
  /// can be wrapped using the `GestureDetector` and this functionality can be achieved in the application level.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            onDataLabelTapped: (DataLabelTapDetails args) {
  ///                 debugPrint(arg.seriesIndex);
  ///                  }
  ///        ));
  ///}
  ///
  ///```

  final DataLabelTapCallback? onDataLabelTapped;

  @override
  State<StatefulWidget> createState() => SfFunnelChartState();
}

/// Represents the state class of [SfFunnelChart] widget
///
class SfFunnelChartState extends State<SfFunnelChart>
    with TickerProviderStateMixin {
  // Holds the animation controller list for all series
  //ignore: unused_field
  List<AnimationController>? _controllerList;
  AnimationController?
      _animationController; // Animation controller for Annotations
  //ignore: unused_field
  AnimationController? _annotationController;
  ValueNotifier<int>? _seriesRepaintNotifier;
  late List<_MeasureWidgetContext>
      _legendWidgetContext; // To measure legend size and position
  List<_ChartTemplateInfo>? _templates; // Chart Template info
  late List<Widget> _chartWidgets;

  /// Holds the information of chart theme arguments
  SfChartThemeData? _chartTheme;
  //Here, we are using get keyword inorder to get the proper & updated instance of chart widget
  //When we initialize chart widget as a property to other classes like _ChartSeries, the chart widget is not updated properly and by using get we can rectify this.
  SfFunnelChart get _chart => widget;
  Rect? _chartContainerRect;
  Rect? _chartAreaRect;
  _ChartTemplate? _chartTemplate;
  _ChartInteraction? _currentActive;
  late bool _initialRender;
  late List<_LegendRenderContext> _legendToggleStates;
  late List<_MeasureWidgetContext> _legendToggleTemplateStates;
  late bool _isLegendToggled;
  Offset? _tapPosition;
  bool? _animateCompleted;
  //ignore: unused_field
  Animation<double>? _chartElementAnimation;
  _FunnelDataLabelRenderer? _renderDataLabel;
  late bool _widgetNeedUpdate;
  late List<int> _explodedPoints;
  List<Rect>? _dataLabelTemplateRegions;
  List<int?>? _selectionData;
  int? _tooltipPointIndex;
  FunnelSeriesRenderer? _seriesRenderer;
  Orientation? _oldDeviceOrientation;
  Orientation? _deviceOrientation;
  Size? _prevSize;
  bool _didSizeChange = false;
  //Internal variables
  String? _seriesType;
  List<PointInfo<dynamic>>? _dataPoints;
  List<PointInfo<dynamic>>? _renderPoints;
  _FunnelSeries? _chartSeries;
  late _ChartLegend _chartLegend;
  //ignore: unused_field
  _FunnelPlotArea? _funnelplotArea;
  TooltipBehaviorRenderer? _tooltipBehaviorRenderer;
  late LegendRenderer _legendRenderer;

  @override
  void initState() {
    _initializeDefaultValues();
    // Create the series renderer while initial rendering //
    _createAndUpdateSeriesRenderer();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _chartTheme = SfChartTheme.of(context);

    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(SfFunnelChart oldWidget) {
    //Update and maintain the series state, when we update the series in the series collection //
    _createAndUpdateSeriesRenderer(oldWidget);
    _initialRender = !widget.series.explode;

    super.didUpdateWidget(oldWidget);
    _isLegendToggled = false;
    _widgetNeedUpdate = true;
  }

  @override
  Widget build(BuildContext context) {
    _prevSize = _prevSize ?? MediaQuery.of(context).size;
    _didSizeChange = _prevSize != MediaQuery.of(context).size;
    _prevSize = MediaQuery.of(context).size;
    _oldDeviceOrientation = _oldDeviceOrientation == null
        ? MediaQuery.of(context).orientation
        : _deviceOrientation;
    _deviceOrientation = MediaQuery.of(context).orientation;
    return RepaintBoundary(
        child: Container(
            child: GestureDetector(
                child: Container(
                    decoration: BoxDecoration(
                        color: widget.backgroundColor,
                        image: widget.backgroundImage != null
                            ? DecorationImage(
                                image: widget.backgroundImage!,
                                fit: BoxFit.fill)
                            : null,
                        border: Border.all(
                            color: widget.borderColor,
                            width: widget.borderWidth)),
                    child: Column(
                      children: <Widget>[
                        _renderChartTitle(this),
                        _renderChartElements()
                      ],
                    )))));
  }

  @override
  void dispose() {
    _disposeAnimationController(_animationController, _repaintChartElements);
    super.dispose();
  }

  /// Method to convert the [SfFunnelChart] as an image.
  ///
  /// Returns the [dart:ui.image]
  ///
  /// As this method is in the widget’s state class, you have to use a global key
  /// to access the state to call this method.
  ///
  /// ```dart
  /// final GlobalKey<SfFunnelChartState> _key = GlobalKey();
  /// @override
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Column(
  ///      children: [SfFunnelChart(
  ///        key: _key
  ///       series: FunnelSeries<_FunnelData, String>(
  ///                          dataSource: data,
  ///                          xValueMapper: (_FunnelData data, _) => data.xData,
  ///                          yValueMapper: (_FunnelData data, _) => data.yData)
  ///        ),
  ///             ],
  ///        ),
  ///              RaisedButton(
  ///                child: Text(
  ///                  'To Image',
  ///                ),
  ///               onPressed: _renderImage,
  ///                shape: RoundedRectangleBorder(
  ///                    borderRadius: BorderRadius.circular(20)),
  ///              )
  ///      ],
  ///    ),
  ///  );
  /// }

  /// Future<void> _renderImage() async {
  ///  dart_ui.Image data = await _key.currentState.toImage(pixelRatio: 3.0);
  ///  final bytes = await data.toByteData(format: dart_ui.ImageByteFormat.png);
  ///  if (data != null) {
  ///    await Navigator.of(context).push(
  ///      MaterialPageRoute(
  ///        builder: (BuildContext context) {
  ///          return Scaffold(
  ///            appBar: AppBar(),
  ///            body: Center(
  ///              child: Container(
  ///                color: Colors.white,
  ///                child: Image.memory(bytes.buffer.asUint8List()),
  ///            ),
  ///            ),
  ///         );
  ///        },
  ///      ),
  ///    );
  ///  }
  ///}
  ///```

  Future<dart_ui.Image> toImage({double pixelRatio = 1.0}) async {
    final RenderRepaintBoundary boundary = context.findRenderObject()
        as RenderRepaintBoundary; //get the render object from context
    final dart_ui.Image image =
        await boundary.toImage(pixelRatio: pixelRatio); // Convert
    // the repaint boundary as image
    return image;
  }

  /// To initialise chart default values
  void _initializeDefaultValues() {
    _chartSeries = _FunnelSeries(this);
    _chartLegend = _ChartLegend(this);
    _funnelplotArea = _FunnelPlotArea(chartState: this);
    _initialRender = true;
    _controllerList = <AnimationController>[];
    _annotationController = AnimationController(vsync: this);
    _seriesRepaintNotifier = ValueNotifier<int>(0);
    _legendToggleStates = <_LegendRenderContext>[];
    _legendToggleTemplateStates = <_MeasureWidgetContext>[];
    _explodedPoints = <int>[];
    _animateCompleted = true;
    _isLegendToggled = false;
    _widgetNeedUpdate = false;
    _dataLabelTemplateRegions = <Rect>[];
    _selectionData = <int?>[];
    _legendWidgetContext = <_MeasureWidgetContext>[];
    _animationController = AnimationController(vsync: this)
      ..addListener(_repaintChartElements);
    _tooltipBehaviorRenderer = TooltipBehaviorRenderer(this);
    _legendRenderer = LegendRenderer(widget.legend);
  }

  // In this method, create and update the series renderer for each series //
  void _createAndUpdateSeriesRenderer([SfFunnelChart? oldWidget]) {
    final FunnelSeriesRenderer? oldSeriesRenderer = _seriesRenderer;
    dynamic series;
    series = widget.series;

    // Create and update the series list here
    FunnelSeriesRenderer? seriesRenderers;

    if (oldSeriesRenderer != null && _isSameSeries(oldWidget!.series, series)) {
      seriesRenderers = oldSeriesRenderer;
    } else {
      seriesRenderers = series.createRenderer(series);
      if (seriesRenderers!._controller == null &&
          series.onRendererCreated != null) {
        seriesRenderers._controller = FunnelSeriesController(seriesRenderers);
        series.onRendererCreated(seriesRenderers._controller);
      }
    }

    seriesRenderers._series = series;
    seriesRenderers._isSelectionEnable =
        series.selectionBehavior.enable || series.selectionSettings.enable;
    seriesRenderers._chartState = this;
    _chartSeries!.visibleSeriesRenderers
      ..clear()
      ..add(seriesRenderers);
  }

  void _repaintChartElements() {
    _seriesRepaintNotifier!.value++;
  }

  /// To render chart elements
  Widget _renderChartElements() {
    return Expanded(child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      Widget? element;
      if (widget.series.dataSource != null) {
        _initialize(constraints);
        _chartSeries!._findVisibleSeries();
        _chartSeries!
            ._processDataPoints(_chartSeries!.visibleSeriesRenderers[0]!);
        final List<Widget> legendTemplates = _bindLegendTemplateWidgets(this);
        if (legendTemplates.isNotEmpty && _legendWidgetContext.isEmpty) {
          element = Stack(children: legendTemplates);
          SchedulerBinding.instance.addPostFrameCallback((_) => _refresh());
        } else {
          _chartLegend._calculateLegendBounds(_chartLegend.chartSize);
          element = _getElements(
              this, _FunnelPlotArea(chartState: this), constraints);
        }
      } else {
        element = Container();
      }
      return element!;
    }));
  }

  /// To refresh chart elements
  void _refresh() {
    if (_legendWidgetContext.isNotEmpty) {
      for (int i = 0; i < _legendWidgetContext.length; i++) {
        final _MeasureWidgetContext templateContext = _legendWidgetContext[i];
        final RenderBox renderBox =
            templateContext.context!.findRenderObject() as RenderBox;
        templateContext.size = renderBox.size;
      }
      setState(() {
        /// The chart will be rebuilding again, Once legend template sizes will be calculated.
      });
    }
  }

  /// To redraw chart elements
  // ignore:unused_element
  void _redraw() {
    _initialRender = false;
    setState(() {
      /// The chart will be rebuilding again, When we do the legend toggle, zoom/pan the chart.
    });
  }

  /// To initialize chart container
  void _initialize(BoxConstraints constraints) {
    _chartWidgets = <Widget>[];
    final num width = constraints.maxWidth;
    final num height = constraints.maxHeight;
    final EdgeInsets margin = widget.margin;
    if (widget.legend.position == LegendPosition.auto) {
      _legendRenderer._legendPosition =
          height > width ? LegendPosition.bottom : LegendPosition.right;
    } else {
      _legendRenderer._legendPosition = widget.legend.position;
    }
    _chartLegend.chartSize = Size(width - margin.left - margin.right,
        height - margin.top - margin.bottom);
  }
}

// ignore: must_be_immutable
class _FunnelPlotArea extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  _FunnelPlotArea({this.chartState});
  final SfFunnelChartState? chartState;
  //Here, we are using get keyword inorder to get the proper & updated instance of chart widget
  //When we initialize chart widget as a property to other classes like _ChartSeries, the chart widget is not updated properly and by using get we can rectify this.
  SfFunnelChart get chart => chartState!._chart;
  FunnelSeriesRenderer? seriesRenderer;
  RenderBox? renderBox;
  _Region? pointRegion;
  TapDownDetails? tapDownDetails;
  Offset? doubleTapPosition;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
          child: MouseRegion(
              onHover: (PointerEvent event) => _onHover(event),
              onExit: (PointerEvent event) {
                chartState!._tooltipBehaviorRenderer!._isHovering = false;
              },
              child: Stack(children: <Widget>[
                _initializeChart(constraints, context),
                Listener(
                    onPointerUp: (PointerUpEvent event) => _onTapUp(event),
                    onPointerDown: (PointerDownEvent event) =>
                        _onTapDown(event),
                    onPointerMove: (PointerMoveEvent event) =>
                        _performPointerMove(event),
                    child: GestureDetector(
                        onLongPress: _onLongPress,
                        onDoubleTap: _onDoubleTap,
                        child: Container(
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                        )))
              ])));
    });
  }

  /// To intialize chart elements
  Widget _initializeChart(BoxConstraints constraints, BuildContext context) {
    _calculateContainerSize(constraints);
    return GestureDetector(
        child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            child: _renderWidgets(constraints, context)));
  }

  /// To calculate size of chart
  void _calculateContainerSize(BoxConstraints constraints) {
    final num width = constraints.maxWidth;
    final num height = constraints.maxHeight;
    chartState!._chartContainerRect =
        Rect.fromLTWH(0, 0, width as double, height as double);
    final EdgeInsets margin = chart.margin;
    chartState!._chartAreaRect = Rect.fromLTWH(
        margin.left,
        margin.top,
        width - margin.right - margin.left,
        height - margin.top - margin.bottom);
  }

  Widget _renderWidgets(BoxConstraints constraints, BuildContext context) {
    _bindSeriesWidgets();
    _calculatePathRegion();
    _findTemplates(chartState);
    _renderTemplates(chartState);
    _bindTooltipWidgets(constraints);
    renderBox = context.findRenderObject() as RenderBox?;
    chartState!._funnelplotArea = this;
    return Container(child: Stack(children: chartState!._chartWidgets));
  }

  /// To calculate region path for rendering funnel chart
  void _calculatePathRegion() {
    if (chartState!._chartSeries!.visibleSeriesRenderers.isNotEmpty) {
      final FunnelSeriesRenderer seriesRenderer =
          chartState!._chartSeries!.visibleSeriesRenderers[0]!;
      for (int i = 0; i < seriesRenderer._renderPoints!.length; i++) {
        if (seriesRenderer._renderPoints![i].isVisible) {
          chartState!._chartSeries!
              ._calculateFunnelPathRegion(i, seriesRenderer);
        }
      }
    }
  }

  /// To bind series widgets in chart
  void _bindSeriesWidgets() {
    CustomPainter seriesPainter;
    Animation<double>? seriesAnimation;
    FunnelSeries<dynamic, dynamic>? series;
    for (int i = 0;
        i < chartState!._chartSeries!.visibleSeriesRenderers.length;
        i++) {
      seriesRenderer = chartState!._chartSeries!.visibleSeriesRenderers[i];
      series = seriesRenderer!._series;
      series!.selectionBehavior._chartState = chartState;
      series.selectionSettings._chartState = chartState;
      chartState!._chartSeries!._initializeSeriesProperties(seriesRenderer!);
      SelectionBehaviorRenderer selectionBehaviorRenderer;
      final dynamic selectionBehavior = seriesRenderer!._selectionBehavior =
          series.selectionBehavior.enable
              ? series.selectionBehavior
              : series.selectionSettings;
      selectionBehaviorRenderer = seriesRenderer!._selectionBehaviorRenderer =
          SelectionBehaviorRenderer(selectionBehavior, chart, chartState);
      selectionBehaviorRenderer._selectionRenderer ??= _SelectionRenderer();
      selectionBehaviorRenderer._selectionRenderer!.chart = chart;
      selectionBehaviorRenderer._selectionRenderer!.seriesRenderer =
          seriesRenderer;
      if (series.initialSelectedDataIndexes.isNotEmpty) {
        for (int index = 0;
            index < series.initialSelectedDataIndexes.length;
            index++) {
          chartState!._selectionData!
              .add(series.initialSelectedDataIndexes[index]);
        }
      }

      if (series.animationDuration > 0 &&
          !chartState!._didSizeChange &&
          (chartState!._oldDeviceOrientation ==
              chartState!._deviceOrientation) &&
          (chartState!._initialRender ||
              chartState!._widgetNeedUpdate ||
              chartState!._isLegendToggled)) {
        chartState!._animationController!.duration =
            Duration(milliseconds: series.animationDuration.toInt());
        seriesAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: chartState!._animationController!,
          curve: const Interval(0.1, 0.8, curve: Curves.linear),
        )..addStatusListener((AnimationStatus status) {
                if (status == AnimationStatus.completed) {
                  chartState!._animateCompleted = true;
                  if (chartState!._renderDataLabel != null) {
                    chartState!._renderDataLabel!.state!.render();
                  }
                  if (chartState!._chartTemplate != null &&
                      chartState!._chartTemplate!.state != null) {
                    chartState!._chartTemplate!.state!.templateRender();
                  }
                }
              }));
        chartState!._chartElementAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: chartState!._animationController!,
          curve: const Interval(0.85, 1.0, curve: Curves.decelerate),
        ));
        chartState!._animationController!.forward(from: 0.0);
      } else {
        chartState!._animateCompleted = true;
        if (chartState!._renderDataLabel?.state != null) {
          chartState!._renderDataLabel!.state!.render();
        }
      }
      seriesRenderer!._repaintNotifier = chartState!._seriesRepaintNotifier;
      seriesPainter = _FunnelChartPainter(
          chartState: chartState,
          seriesIndex: i,
          isRepaint: seriesRenderer!._needsRepaint,
          animationController: chartState!._animationController,
          seriesAnimation: seriesAnimation,
          notifier: chartState!._seriesRepaintNotifier);
      chartState!._chartWidgets
          .add(RepaintBoundary(child: CustomPaint(painter: seriesPainter)));
      chartState!._renderDataLabel = _FunnelDataLabelRenderer(
          chartState: chartState,
          show: series.animationDuration > 0 &&
                  (chartState!._deviceOrientation ==
                      chartState!._oldDeviceOrientation) &&
                  !chartState!._didSizeChange
              ? false
              : chartState!._animateCompleted);
      chartState!._chartWidgets.add(chartState!._renderDataLabel!);
    }
  }

  /// To bind tooltip widgets to chart
  void _bindTooltipWidgets(BoxConstraints constraints) {
    chart.tooltipBehavior._chartState = chartState;
    if (chart.tooltipBehavior.enable) {
      if (chart.tooltipBehavior.builder != null) {
        chartState!._tooltipBehaviorRenderer!._tooltipTemplate =
            _TooltipTemplate(
                show: false,
                clipRect: chartState!._chartContainerRect,
                duration: chart.tooltipBehavior.duration);
        // chartState._tooltipBehaviorRenderer._sfChart = chart;
        //  chart.tooltipBehavior._chartState = chartState;
        chartState!._chartWidgets
            .add(chartState!._tooltipBehaviorRenderer!._tooltipTemplate!);
      } else {
        // chartState._tooltipBehaviorRenderer._sfChart = chart;
        chartState!._tooltipBehaviorRenderer!._chartTooltip =
            _ChartTooltipRenderer(chartState: chartState);
        chartState!._chartWidgets
            .add(chartState!._tooltipBehaviorRenderer!._chartTooltip!);
      }
    }
  }

  void _calculatePointSeriesIndex(SfFunnelChart chart,
      FunnelSeriesRenderer seriesRenderer, Offset? touchPosition) {
    PointTapArgs pointTapArgs;
    num? index;
    for (int i = 0; i < seriesRenderer._renderPoints!.length; i++) {
      if (seriesRenderer._renderPoints![i].region!.contains(touchPosition!)) {
        index = i;
        break;
      }
    }
    if (index != null) {
      pointTapArgs = PointTapArgs(0, index as int?, seriesRenderer._dataPoints);
      chart.onPointTapped!(pointTapArgs);
    }
  }

  /// To perform pointer down event
  void _onTapDown(PointerDownEvent event) {
    // renderBox = context.findRenderObject();
    chartState!._tooltipBehaviorRenderer!._isHovering = false;
    chartState!._currentActive = null;
    chartState!._tapPosition = renderBox!.globalToLocal(event.position);
    bool? isPoint;
    const num seriesIndex = 0;
    num? pointIndex;
    final FunnelSeriesRenderer seriesRenderer =
        chartState!._chartSeries!.visibleSeriesRenderers[seriesIndex as int]!;
    if (chart.onPointTapped != null) {
      _calculatePointSeriesIndex(
          chart, seriesRenderer, chartState!._tapPosition);
    }
    if (chart.onDataLabelTapped != null) {
      _triggerFunnelDataLabelEvent(
          chart, seriesRenderer, chartState, chartState!._tapPosition);
    }
    ChartTouchInteractionArgs touchArgs;
    for (int j = 0; j < seriesRenderer._renderPoints!.length; j++) {
      if (seriesRenderer._renderPoints![j].isVisible) {
        isPoint = _isPointInPolygon(seriesRenderer._renderPoints![j].pathRegion,
            chartState!._tapPosition);
        if (isPoint) {
          pointIndex = j;
          break;
        }
      }
    }
    doubleTapPosition = chartState!._tapPosition;
    if (chartState!._tapPosition != null && isPoint != null && isPoint) {
      chartState!._currentActive = _ChartInteraction(
        seriesIndex,
        pointIndex as int?,
        seriesRenderer._series,
        seriesRenderer._renderPoints![pointIndex!],
      );
    } else {
      //hides the tooltip if the point of interaction is outside funnel region of the chart
      if (chart.tooltipBehavior.builder != null) {
        chartState!._tooltipBehaviorRenderer!._tooltipTemplate!.show = false;
        chartState!._tooltipBehaviorRenderer?._tooltipTemplate?.state
            ?.hideOnTimer();
      }
    }
    if (chart.onChartTouchInteractionDown != null) {
      touchArgs = ChartTouchInteractionArgs();
      touchArgs.position = renderBox!.globalToLocal(event.position);
      chart.onChartTouchInteractionDown!(touchArgs);
    }
  }

  /// To perform pointer move event
  void _performPointerMove(PointerMoveEvent event) {
    ChartTouchInteractionArgs touchArgs;
    final Offset position = renderBox!.globalToLocal(event.position);
    if (chart.onChartTouchInteractionMove != null) {
      touchArgs = ChartTouchInteractionArgs();
      touchArgs.position = position;
      chart.onChartTouchInteractionMove!(touchArgs);
    }
  }

  /// To perform double tap touch interactions
  void _onDoubleTap() {
    const num seriesIndex = 0;
    if (doubleTapPosition != null && chartState!._currentActive != null) {
      final num pointIndex = chartState!._currentActive!.pointIndex!;
      chartState!._currentActive = _ChartInteraction(
          seriesIndex as int?,
          pointIndex as int?,
          chartState!._chartSeries!.visibleSeriesRenderers[seriesIndex as int]!
              ._series,
          chartState!._chartSeries!.visibleSeriesRenderers[seriesIndex]!
              ._renderPoints![pointIndex as int]);
      if (chartState!._currentActive != null) {
        if (chartState!._currentActive!.series.explodeGesture ==
            ActivationMode.doubleTap) {
          chartState!._chartSeries!._pointExplode(pointIndex);
        }
      }
      chartState!._chartSeries!
          ._seriesPointSelection(pointIndex, ActivationMode.doubleTap);
      if (chart.tooltipBehavior.enable &&
          chart.tooltipBehavior.activationMode == ActivationMode.doubleTap) {
        if (chart.tooltipBehavior.builder != null) {
          _showFunnelTooltipTemplate();
        } else {
          chartState!._tooltipBehaviorRenderer!.onDoubleTap(
              doubleTapPosition!.dx.toDouble(),
              doubleTapPosition!.dy.toDouble());
        }
      }
    }
  }

  /// To perform long press touch interactions
  void _onLongPress() {
    const num seriesIndex = 0;
    if (chartState!._tapPosition != null &&
        chartState!._currentActive != null) {
      final num pointIndex = chartState!._currentActive!.pointIndex!;
      chartState!._currentActive = _ChartInteraction(
          seriesIndex as int?,
          pointIndex as int?,
          chartState!._chartSeries!.visibleSeriesRenderers[seriesIndex as int]!
              ._series,
          chartState!._chartSeries!.visibleSeriesRenderers[seriesIndex]!
              ._renderPoints![pointIndex as int],
          pointRegion);
      chartState!._chartSeries!
          ._seriesPointSelection(pointIndex, ActivationMode.longPress);
      if (chartState!._currentActive != null) {
        if (chartState!._currentActive!.series.explodeGesture ==
            ActivationMode.longPress) {
          chartState!._chartSeries!._pointExplode(pointIndex);
        }
      }
      if (chart.tooltipBehavior.enable &&
          chart.tooltipBehavior.activationMode == ActivationMode.longPress) {
        if (chart.tooltipBehavior.builder != null) {
          _showFunnelTooltipTemplate();
        } else {
          chartState!._tooltipBehaviorRenderer!.onLongPress(
              chartState!._tapPosition!.dx.toDouble(),
              chartState!._tapPosition!.dy.toDouble());
        }
      }
    }
  }

  /// To perform pointer up event
  void _onTapUp(PointerUpEvent event) {
    chartState!._tooltipBehaviorRenderer!._isHovering = false;
    chartState!._tapPosition = renderBox!.globalToLocal(event.position);
    ChartTouchInteractionArgs touchArgs;
    if (chartState!._tapPosition != null) {
      if (chartState!._currentActive != null &&
          chartState!._currentActive!.series != null &&
          chartState!._currentActive!.series.explodeGesture ==
              ActivationMode.singleTap) {
        chartState!._chartSeries!
            ._pointExplode(chartState!._currentActive!.pointIndex!);
      }
      if (chartState!._tapPosition != null &&
          chartState!._currentActive != null) {
        chartState!._chartSeries!._seriesPointSelection(
            chartState!._currentActive!.pointIndex, ActivationMode.singleTap);
      }
      if (chart.tooltipBehavior.enable &&
          chart.tooltipBehavior.activationMode == ActivationMode.singleTap &&
          chartState!._currentActive != null &&
          chartState!._currentActive!.series != null) {
        if (chart.tooltipBehavior.builder != null) {
          _showFunnelTooltipTemplate();
        } else {
          final Offset position = renderBox!.globalToLocal(event.position);
          chartState!._tooltipBehaviorRenderer!
              .onTouchUp(position.dx.toDouble(), position.dy.toDouble());
        }
      }
      if (chart.onChartTouchInteractionUp != null) {
        touchArgs = ChartTouchInteractionArgs();
        touchArgs.position = renderBox!.globalToLocal(event.position);
        chart.onChartTouchInteractionUp!(touchArgs);
      }
    }
    chartState!._tapPosition = null;
  }

  /// To perform event on mouse hover
  void _onHover(PointerEvent event) {
    chartState!._currentActive = null;
    chartState!._tapPosition = renderBox!.globalToLocal(event.position);
    late bool isPoint;
    const num seriesIndex = 0;
    num? pointIndex;
    final FunnelSeriesRenderer seriesRenderer =
        chartState!._chartSeries!.visibleSeriesRenderers[seriesIndex as int]!;
    for (int j = 0; j < seriesRenderer._renderPoints!.length; j++) {
      if (seriesRenderer._renderPoints![j].isVisible) {
        isPoint = _isPointInPolygon(seriesRenderer._renderPoints![j].pathRegion,
            chartState!._tapPosition);
        if (isPoint) {
          pointIndex = j;
          break;
        }
      }
    }
    if (chartState!._tapPosition != null && isPoint) {
      chartState!._currentActive = _ChartInteraction(
        seriesIndex,
        pointIndex as int?,
        chartState!._chartSeries!.visibleSeriesRenderers[seriesIndex]!._series,
        chartState!._chartSeries!.visibleSeriesRenderers[seriesIndex]!
            ._renderPoints![pointIndex!],
      );
    } else {
      //hides the tooltip if the point of interaction is outside funnel region of the chart
      chartState!._tooltipBehaviorRenderer?._tooltipTemplate?.show = false;
      chartState!._tooltipBehaviorRenderer?._tooltipTemplate?.state
          ?.hideOnTimer();
    }
    if (chartState!._tapPosition != null) {
      if (chart.tooltipBehavior.enable &&
          chartState!._currentActive != null &&
          chartState!._currentActive!.series != null) {
        chartState!._tooltipBehaviorRenderer!._isHovering = true;
        if (chart.tooltipBehavior.builder != null) {
          _showFunnelTooltipTemplate();
        } else {
          final Offset position = renderBox!.globalToLocal(event.position);
          chartState!._tooltipBehaviorRenderer!
              .onEnter(position.dx.toDouble(), position.dy.toDouble());
        }
      } else {
        chartState?._tooltipBehaviorRenderer?._painter?.prevTooltipValue = null;
        chartState?._tooltipBehaviorRenderer?._painter?.currentTooltipValue =
            null;
        chartState?._tooltipBehaviorRenderer?._painter?.hide();
      }
    }
    chartState!._tapPosition = null;
  }

  /// This method gets executed for showing tooltip when builder is provided in behavior
  void _showFunnelTooltipTemplate([int? pointIndex]) {
    final _TooltipTemplate? tooltipTemplate =
        chartState!._tooltipBehaviorRenderer!._tooltipTemplate;
    tooltipTemplate?._alwaysShow = chart.tooltipBehavior.shouldAlwaysShow;
    if (!chartState!._tooltipBehaviorRenderer!._isHovering) {
      //assingning null for the previous and current tooltip values in case of touch interaction
      tooltipTemplate?.state?.prevTooltipValue = null;
      tooltipTemplate?.state?.currentTooltipValue = null;
    }
    final FunnelSeries<dynamic, dynamic> chartSeries =
        chartState!._currentActive?.series ?? chart.series;
    final PointInfo<dynamic> point = pointIndex == null
        ? chartState!._currentActive?.point
        : chartState!
            ._chartSeries!.visibleSeriesRenderers[0]!._dataPoints![pointIndex];
    final Offset? location = point.symbolLocation;
    if (location != null && (chartSeries.enableTooltip ?? true)) {
      tooltipTemplate!.rect = Rect.fromLTWH(location.dx, location.dy, 0, 0);
      tooltipTemplate.template = chart.tooltipBehavior.builder!(
          chartSeries.dataSource![
              (pointIndex ?? chartState!._currentActive?.pointIndex!)!],
          point,
          chartSeries,
          0,
          pointIndex ?? chartState!._currentActive?.pointIndex);
      if (chartState!._tooltipBehaviorRenderer!._isHovering) {
        //assingning values for the previous and current tooltip values on mouse hover
        tooltipTemplate.state!.prevTooltipValue =
            tooltipTemplate.state!.currentTooltipValue;
        tooltipTemplate.state!.currentTooltipValue = TooltipValue(
            0, pointIndex ?? chartState!._currentActive?.pointIndex);
      }
      tooltipTemplate.show = true;
      tooltipTemplate.state?._performTooltip();
    }
  }
}
