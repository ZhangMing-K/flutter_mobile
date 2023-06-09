part of charts;

class _BubbleChartPainter extends CustomPainter {
  _BubbleChartPainter(
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
  final Animation<double>? animationController;
  final BubbleSeriesRenderer? seriesRenderer;
  final _PainterKey? painterKey;

  /// Painter method for bubble series
  @override
  void paint(Canvas canvas, Size size) {
    final ChartAxisRenderer? xAxisRenderer = seriesRenderer!._xAxisRenderer;
    final ChartAxisRenderer? yAxisRenderer = seriesRenderer!._yAxisRenderer;
    final List<CartesianChartPoint<dynamic>?>? dataPoints =
        seriesRenderer!._dataPoints;
    double animationFactor;
    final BubbleSeries<dynamic, dynamic>? series =
        seriesRenderer!._series as BubbleSeries<dynamic, dynamic>?;
    if (seriesRenderer!._visible!) {
      canvas.save();
      assert(
          series!.animationDuration != null
              ? series.animationDuration >= 0
              : true,
          'The animation duration of the bubble series must be greater than or equal to 0.');
      final int? seriesIndex = painterKey!.index;
      seriesRenderer!._storeSeriesProperties(chartState, seriesIndex);
      animationFactor = seriesRenderer!._seriesAnimation != null
          ? seriesRenderer!._seriesAnimation!.value
          : 1;
      final Rect axisClipRect = _calculatePlotOffset(
          chartState._chartAxis!._axisClipRect!,
          Offset(xAxisRenderer!._axis.plotOffset,
              yAxisRenderer!._axis.plotOffset));
      canvas.clipRect(axisClipRect);
      int segmentIndex = -1;
      for (int pointIndex = 0; pointIndex < dataPoints!.length; pointIndex++) {
        final CartesianChartPoint<dynamic> currentPoint =
            dataPoints[pointIndex]!;
        seriesRenderer!._calculateRegionData(chartState, seriesRenderer,
            painterKey!.index, currentPoint, pointIndex);
        if (currentPoint.isVisible && !currentPoint.isGap) {
          seriesRenderer!._drawSegment(
              canvas,
              seriesRenderer!._createSegments(currentPoint, segmentIndex += 1,
                  seriesIndex, animationFactor));
        }
      }
      canvas.restore();
      if ((series!.animationDuration <= 0 ||
              (!chartState._initialRender! &&
                  !seriesRenderer!._needAnimateSeriesElements!) ||
              animationFactor >= chartState._seriesDurationFactor) &&
          (series.markerSettings.isVisible ||
              series.dataLabelSettings.isVisible)) {
        assert(seriesRenderer != null,
            'The bubble series should be available to render a marker on it.');
        seriesRenderer!._renderSeriesElements(
            chart, canvas, seriesRenderer!._seriesElementAnimation);
      }
      if (animationFactor >= 1) {
        chartState._setPainterKey(painterKey!.index, painterKey!.name, true);
      }
    }
  }

  @override
  bool shouldRepaint(_BubbleChartPainter oldDelegate) => isRepaint!;
}
