part of charts;

class _WaterfallChartPainter extends CustomPainter {
  _WaterfallChartPainter(
      {required this.chartState,
      this.seriesRenderer,
      this.isRepaint,
      this.animationController,
      ValueNotifier<num>? notifier,
      this.painterKey})
      : chart = chartState._chart,
        super(repaint: notifier);
  final SfCartesianChartState chartState;
  final SfCartesianChart chart;
  final bool? isRepaint;
  final AnimationController? animationController;
  List<_ChartLocation> currentChartLocations = <_ChartLocation>[];
  WaterfallSeriesRenderer? seriesRenderer;
  final _PainterKey? painterKey;

  /// Painter method for waterfall series
  @override
  void paint(Canvas canvas, Size size) {
    final ChartAxisRenderer? xAxisRenderer = seriesRenderer!._xAxisRenderer;
    final ChartAxisRenderer yAxisRenderer = seriesRenderer!._yAxisRenderer!;
    final List<CartesianChartPoint<dynamic>?>? dataPoints =
        seriesRenderer!._dataPoints;
    final WaterfallSeries<dynamic, dynamic>? series =
        seriesRenderer!._series as WaterfallSeries<dynamic, dynamic>?;
    final num origin = math.max(yAxisRenderer._visibleRange!.minimum, 0);
    num currentEndValue = 0;
    num intermediateOrigin = 0;
    num prevEndValue = 0;
    num originValue = 0;
    if (seriesRenderer!._visible!) {
      assert(
          series!.animationDuration != null
              ? series.animationDuration >= 0
              : true,
          'The animation duration of the waterfall series must be greater or equal to 0.');
      Rect axisClipRect, clipRect;
      double animationFactor;
      CartesianChartPoint<dynamic>? point;
      canvas.save();
      final int? seriesIndex = painterKey!.index;
      seriesRenderer!._storeSeriesProperties(chartState, seriesIndex);
      axisClipRect = _calculatePlotOffset(
          chartState._chartAxis!._axisClipRect!,
          Offset(
              xAxisRenderer!._axis.plotOffset, yAxisRenderer._axis.plotOffset));
      canvas.clipRect(axisClipRect);
      animationFactor = seriesRenderer!._seriesAnimation != null
          ? seriesRenderer!._seriesAnimation!.value
          : 1;
      int segmentIndex = -1;
      for (int pointIndex = 0; pointIndex < dataPoints!.length; pointIndex++) {
        point = dataPoints[pointIndex];
        currentEndValue +=
            (point!.isIntermediateSum! || point.isTotalSum!) ? 0 : point.yValue;
        point.yValue =
            point.y = point.isTotalSum! ? currentEndValue : point.yValue;
        originValue = point.isIntermediateSum == true
            ? intermediateOrigin
            : ((prevEndValue != null) ? prevEndValue : origin);
        originValue = point.isTotalSum! ? 0 : originValue;
        point.yValue = point.y = point.isIntermediateSum!
            ? currentEndValue - originValue
            : point.yValue;
        point.endValue = currentEndValue;
        point.originValue = originValue;
        seriesRenderer!._calculateRegionData(
            chartState, seriesRenderer, painterKey!.index, point, pointIndex);
        if (chartState._templates.isNotEmpty) {
          chartState._templates[pointIndex].location = Offset(
              point.markerPoint!.x as double, point.markerPoint!.y as double);
        }
        if (point.isVisible && !point.isGap) {
          seriesRenderer!._drawSegment(
              canvas,
              seriesRenderer!._createSegments(point, segmentIndex += 1,
                  painterKey!.index, animationFactor));
        }
        if (point.isIntermediateSum!) {
          intermediateOrigin = currentEndValue;
        }
        prevEndValue = currentEndValue;
      }
      clipRect = _calculatePlotOffset(
          Rect.fromLTRB(
              chartState._chartAxis!._axisClipRect!.left -
                  series!.markerSettings.width,
              chartState._chartAxis!._axisClipRect!.top -
                  series.markerSettings.height,
              chartState._chartAxis!._axisClipRect!.right +
                  series.markerSettings.width,
              chartState._chartAxis!._axisClipRect!.bottom +
                  series.markerSettings.height),
          Offset(
              xAxisRenderer._axis.plotOffset, yAxisRenderer._axis.plotOffset));
      canvas.restore();
      if ((series.animationDuration <= 0 ||
              (!chartState._initialRender! &&
                  !seriesRenderer!._needAnimateSeriesElements!) ||
              animationFactor >= chartState._seriesDurationFactor) &&
          (series.markerSettings.isVisible ||
              series.dataLabelSettings.isVisible)) {
        assert(seriesRenderer != null,
            'The waterfall series should be available to render a marker on it.');
        canvas.clipRect(clipRect);
        seriesRenderer!._renderSeriesElements(
            chart, canvas, seriesRenderer!._seriesElementAnimation);
      }
      if (animationFactor >= 1) {
        chartState._setPainterKey(painterKey!.index, painterKey!.name, true);
      }
    }
  }

  @override
  bool shouldRepaint(_WaterfallChartPainter oldDelegate) => isRepaint!;
}
