part of charts;

class _HistogramChartPainter extends CustomPainter {
  _HistogramChartPainter(
      {required this.chartState,
      this.seriesRenderer,
      this.chartSeries,
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
  HistogramSeriesRenderer? seriesRenderer;
  _ChartSeries? chartSeries;
  final _PainterKey? painterKey;

  /// Painter method for histogram series
  @override
  void paint(Canvas canvas, Size size) {
    Rect axisClipRect, clipRect;
    double animationFactor;
    CartesianChartPoint<dynamic>? point;
    final ChartAxisRenderer? xAxisRenderer = seriesRenderer!._xAxisRenderer;
    final ChartAxisRenderer? yAxisRenderer = seriesRenderer!._yAxisRenderer;
    final List<CartesianChartPoint<dynamic>?>? dataPoints =
        seriesRenderer!._dataPoints;

    /// Clip rect added
    if (seriesRenderer!._visible!) {
      final HistogramSeries<dynamic, dynamic> series =
          seriesRenderer!._series as HistogramSeries<dynamic, dynamic>;
      canvas.save();
      assert(
          series.animationDuration != null
              ? series.animationDuration >= 0
              : true,
          'The animation duration of the histogram series must be greater or equal to 0.');
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

      /// side by side range calculated
      final _VisibleRange sideBySideInfo =
          _calculateSideBySideInfo(seriesRenderer!, chartState);

      int segmentIndex = -1;
      for (int pointIndex = 0; pointIndex < dataPoints!.length; pointIndex++) {
        point = dataPoints[pointIndex];
        seriesRenderer!._calculateRegionData(chartState, seriesRenderer,
            painterKey!.index, point, pointIndex, sideBySideInfo);
        if (point!.isVisible && !point.isGap) {
          seriesRenderer!._drawSegment(
              canvas,
              seriesRenderer!._createSegments(point, segmentIndex += 1,
                  sideBySideInfo, painterKey!.index, animationFactor)!);
        }
      }
      if (series.showNormalDistributionCurve) {
        if (seriesRenderer!._reAnimate ||
            ((!(chartState._widgetNeedUpdate || chartState._isLegendToggled!) ||
                    !chartState._oldSeriesKeys.contains(series.key)) &&
                series.animationDuration > 0)) {
          _performLinearAnimation(
              chartState, xAxisRenderer._axis, canvas, animationFactor);
        }
        final Path _path =
            seriesRenderer!._findNormalDistributionPath(series, chart);
        final Paint _paint = Paint()
          ..strokeWidth = series.curveWidth
          ..color = series.curveColor
          ..style = PaintingStyle.stroke;
        series.curveDashArray == null
            ? canvas.drawPath(_path, _paint)
            : _drawDashedLine(canvas, series.curveDashArray!, _paint, _path);
      }
      clipRect = _calculatePlotOffset(
          Rect.fromLTRB(
              chartState._chartAxis!._axisClipRect!.left -
                  series.markerSettings.width,
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
              !chartState._initialRender! ||
              animationFactor >= chartState._seriesDurationFactor) &&
          (series.markerSettings.isVisible ||
              series.dataLabelSettings.isVisible)) {
        assert(seriesRenderer != null,
            'The histogram series should be available to render a marker on it.');
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
  bool shouldRepaint(_HistogramChartPainter oldDelegate) => isRepaint!;
}
