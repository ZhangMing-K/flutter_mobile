part of charts;

class _BarChartPainter extends CustomPainter {
  _BarChartPainter(
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
  final BarSeriesRenderer? seriesRenderer;
  final _PainterKey? painterKey;

  /// Painter method for bar series
  @override
  void paint(Canvas canvas, Size size) {
    final ChartAxisRenderer? xAxisRenderer = seriesRenderer!._xAxisRenderer;
    final ChartAxisRenderer? yAxisRenderer = seriesRenderer!._yAxisRenderer;
    final List<CartesianChartPoint<dynamic>?>? dataPoints =
        seriesRenderer!._dataPoints;
    final BarSeries<dynamic, dynamic>? series =
        seriesRenderer!._series as BarSeries<dynamic, dynamic>?;
    if (seriesRenderer!._visible!) {
      assert(
          series!.animationDuration != null
              ? series.animationDuration >= 0
              : true,
          'The animation duration of the bar series must be greater than or equal to 0.');
      Rect axisClipRect, clipRect;
      double animationFactor;
      CartesianChartPoint<dynamic>? point;
      canvas.save();
      final int? seriesIndex = painterKey!.index;
      seriesRenderer!._storeSeriesProperties(chartState, seriesIndex);
      axisClipRect = _calculatePlotOffset(
          chartState._chartAxis!._axisClipRect!,
          Offset(xAxisRenderer!._axis.plotOffset,
              yAxisRenderer!._axis.plotOffset));
      canvas.clipRect(axisClipRect);
      animationFactor = seriesRenderer!._seriesAnimation != null
          ? seriesRenderer!._seriesAnimation!.value
          : 1;
      int segmentIndex = -1;
      for (int pointIndex = 0; pointIndex < dataPoints!.length; pointIndex++) {
        point = dataPoints[pointIndex];
        seriesRenderer!._calculateRegionData(
            chartState, seriesRenderer, painterKey!.index, point, pointIndex);
        if (point!.isVisible && !point.isGap) {
          seriesRenderer!._drawSegment(
              canvas,
              seriesRenderer!._createSegments(point, segmentIndex += 1,
                  painterKey!.index, animationFactor));
        }
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
            'The bar series should be available to render a marker on it.');
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
  bool shouldRepaint(_BarChartPainter oldDelegate) => isRepaint!;
}
