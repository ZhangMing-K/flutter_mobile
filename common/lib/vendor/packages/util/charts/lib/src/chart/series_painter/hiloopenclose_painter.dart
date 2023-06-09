part of charts;

class _HiloOpenClosePainter extends CustomPainter {
  _HiloOpenClosePainter(
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
  HiloOpenCloseSeriesRenderer? seriesRenderer;
  final _PainterKey? painterKey;

  /// Painter method for Hilo open-close  series
  @override
  void paint(Canvas canvas, Size size) {
    Rect clipRect;
    double animationFactor;
    CartesianChartPoint<dynamic>? point;
    final ChartAxisRenderer? xAxisRenderer = seriesRenderer!._xAxisRenderer;
    final ChartAxisRenderer? yAxisRenderer = seriesRenderer!._yAxisRenderer;
    final List<CartesianChartPoint<dynamic>?>? dataPoints =
        seriesRenderer!._dataPoints;
    final HiloOpenCloseSeries<dynamic, dynamic>? series =
        seriesRenderer!._series as HiloOpenCloseSeries<dynamic, dynamic>?;
    if (seriesRenderer!._visible!) {
      canvas.save();
      assert(
          series!.animationDuration != null
              ? series.animationDuration >= 0
              : true,
          'The animation duration of the Hilo open-close series must be greater or equal to 0.');
      final int? seriesIndex = painterKey!.index;
      seriesRenderer!._storeSeriesProperties(chartState, seriesIndex);
      final Rect axisClipRect = _calculatePlotOffset(
          chartState._chartAxis!._axisClipRect!,
          Offset(xAxisRenderer!._axis.plotOffset,
              yAxisRenderer!._axis.plotOffset));
      canvas.clipRect(axisClipRect);
      animationFactor = seriesRenderer!._seriesAnimation != null
          ? seriesRenderer!._seriesAnimation!.value
          : 1;

      final _VisibleRange sideBySideInfo =
          _calculateSideBySideInfo(seriesRenderer!, chartState);
      int segmentIndex = -1;
      for (int pointIndex = 0; pointIndex < dataPoints!.length; pointIndex++) {
        point = dataPoints[pointIndex];
        seriesRenderer!._calculateRegionData(chartState, seriesRenderer,
            painterKey!.index, point, pointIndex, sideBySideInfo);
        if (point!.isVisible &&
            !point.isGap &&
            (!((point.low == point.high) &&
                !series!.showIndicationForSameValues))) {
          seriesRenderer!._drawSegment(
              canvas,
              seriesRenderer!._createSegments(point, segmentIndex += 1,
                  painterKey!.index, animationFactor)!);
        }
      }
      clipRect = _calculatePlotOffset(
          Rect.fromLTWH(
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
              animationFactor >= chartState._seriesDurationFactor) &&
          series.dataLabelSettings.isVisible) {
        assert(seriesRenderer != null,
            'The Hilo open-close series should be available to render a marker on it.');
        canvas.clipRect(clipRect);
        seriesRenderer!._renderSeriesElements(
            chart, canvas, seriesRenderer!._seriesElementAnimation);
      }
      if (seriesRenderer!._visible! && animationFactor >= 1) {
        chartState._setPainterKey(painterKey!.index, painterKey!.name, true);
      }
    }
  }

  @override
  bool shouldRepaint(_HiloOpenClosePainter oldDelegate) => isRepaint!;
}
