part of charts;

class _AreaChartPainter extends CustomPainter {
  _AreaChartPainter(
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
  final AreaSeriesRenderer? seriesRenderer;
  final _PainterKey? painterKey;

  /// Painter method for area series
  @override
  void paint(Canvas canvas, Size size) {
    final int? seriesIndex = painterKey!.index;
    Rect clipRect;
    final AreaSeries<dynamic, dynamic>? series =
        seriesRenderer!._series as AreaSeries<dynamic, dynamic>?;
    seriesRenderer!._storeSeriesProperties(chartState, seriesIndex);
    double animationFactor;
    CartesianChartPoint<dynamic>? prevPoint, point, _point;
    _ChartLocation? currentPoint, originPoint, _oldPoint;
    final ChartAxisRenderer? xAxisRenderer = seriesRenderer!._xAxisRenderer;
    final ChartAxisRenderer? yAxisRenderer = seriesRenderer!._yAxisRenderer;
    CartesianSeriesRenderer? oldSeriesRenderer;
    final Path _path = Path();
    final Path _strokePath = Path();
    final num? crossesAt = _getCrossesAtValue(seriesRenderer, chartState);
    final num origin = crossesAt ?? 0;
    final List<Offset> _points = <Offset>[];
    if (seriesRenderer!._visible!) {
      assert(
          series!.animationDuration != null
              ? series.animationDuration >= 0
              : true,
          'The animation duration of the area series must be greater than or equal to 0.');
      final List<CartesianSeriesRenderer?>? oldSeriesRenderers =
          chartState._oldSeriesRenderers;
      final List<CartesianChartPoint<dynamic>?> dataPoints =
          seriesRenderer!._dataPoints!;
      final bool widgetNeedUpdate = chartState._widgetNeedUpdate;
      final bool? isLegendToggled = chartState._isLegendToggled;
      final bool? isTransposed =
          seriesRenderer!._chartState!._requireInvertedAxis;
      canvas.save();
      animationFactor = seriesRenderer!._seriesAnimation != null
          ? seriesRenderer!._seriesAnimation!.value
          : 1;
      final Rect axisClipRect = _calculatePlotOffset(
          chartState._chartAxis!._axisClipRect!,
          Offset(xAxisRenderer!._axis.plotOffset,
              yAxisRenderer!._axis.plotOffset));
      canvas.clipRect(axisClipRect);
      if (widgetNeedUpdate &&
          xAxisRenderer._zoomFactor == 1 &&
          yAxisRenderer._zoomFactor == 1 &&
          oldSeriesRenderers != null &&
          oldSeriesRenderers.isNotEmpty &&
          oldSeriesRenderers.length - 1 >= seriesIndex! &&
          oldSeriesRenderers[seriesIndex]!._seriesName ==
              seriesRenderer!._seriesName) {
        oldSeriesRenderer = oldSeriesRenderers[seriesIndex];
      }
      if (seriesRenderer!._reAnimate ||
          ((!(widgetNeedUpdate || isLegendToggled!) ||
                  !chartState._oldSeriesKeys.contains(series!.key)) &&
              series!.animationDuration > 0)) {
        _performLinearAnimation(
            chartState, xAxisRenderer._axis, canvas, animationFactor);
      }
      for (int pointIndex = 0; pointIndex < dataPoints.length; pointIndex++) {
        point = dataPoints[pointIndex];
        seriesRenderer!._calculateRegionData(
            chartState, seriesRenderer, painterKey!.index, point, pointIndex);
        if (point!.isVisible && !point.isDrop) {
          _point = !seriesRenderer!._reAnimate &&
                  (series!.animationDuration > 0 &&
                      widgetNeedUpdate &&
                      !isLegendToggled! &&
                      oldSeriesRenderers != null &&
                      oldSeriesRenderers.isNotEmpty &&
                      oldSeriesRenderer != null &&
                      oldSeriesRenderer._segments.isNotEmpty &&
                      oldSeriesRenderer._segments[0] is AreaSegment &&
                      oldSeriesRenderers.length - 1 >= seriesIndex! &&
                      oldSeriesRenderer._dataPoints!.length - 1 >= pointIndex)
              ? oldSeriesRenderer._dataPoints![pointIndex]
              : null;
          _oldPoint = _point != null
              ? _calculatePoint(
                  _point.xValue,
                  _point.yValue,
                  oldSeriesRenderer!._xAxisRenderer!,
                  oldSeriesRenderer._yAxisRenderer!,
                  isTransposed!,
                  oldSeriesRenderer._series,
                  axisClipRect)
              : null;
          currentPoint = _calculatePoint(
              point.xValue,
              point.yValue,
              xAxisRenderer,
              yAxisRenderer,
              isTransposed!,
              series,
              axisClipRect);
          originPoint = _calculatePoint(
              point.xValue,
              math_lib.max(yAxisRenderer._visibleRange!.minimum, origin),
              xAxisRenderer,
              yAxisRenderer,
              isTransposed,
              series,
              axisClipRect);
          num x = currentPoint.x!;
          num y = currentPoint.y!;
          _points.add(Offset(x as double, y as double));
          final bool closed =
              series!.emptyPointSettings.mode == EmptyPointMode.drop
                  ? _getSeriesVisibility(dataPoints, pointIndex)
                  : false;
          if (_oldPoint != null) {
            if (isTransposed) {
              x = _getAnimateValue(animationFactor, x, _oldPoint.x,
                  currentPoint.x, seriesRenderer)!;
            } else {
              y = _getAnimateValue(animationFactor, y, _oldPoint.y,
                  currentPoint.y, seriesRenderer)!;
            }
          }
          if (prevPoint == null ||
              dataPoints[pointIndex - 1]!.isGap == true ||
              (dataPoints[pointIndex]!.isGap == true) ||
              (dataPoints[pointIndex - 1]!.isVisible == false &&
                  series.emptyPointSettings.mode == EmptyPointMode.gap)) {
            _path.moveTo(originPoint.x as double, originPoint.y as double);
            if (series.borderDrawMode == BorderDrawMode.excludeBottom ||
                series.borderDrawMode == BorderDrawMode.all) {
              if (dataPoints[pointIndex]!.isGap != true) {
                _strokePath.moveTo(
                    originPoint.x as double, originPoint.y as double);
                _strokePath.lineTo(x as double, y as double);
              }
            } else if (series.borderDrawMode == BorderDrawMode.top) {
              _strokePath.moveTo(x as double, y as double);
            }
            _path.lineTo(x as double, y as double);
          } else if (pointIndex == dataPoints.length - 1 ||
              dataPoints[pointIndex + 1]!.isGap == true) {
            _strokePath.lineTo(x as double, y as double);
            if (series.borderDrawMode == BorderDrawMode.excludeBottom) {
              _strokePath.lineTo(
                  originPoint.x as double, originPoint.y as double);
            } else if (series.borderDrawMode == BorderDrawMode.all) {
              _strokePath.lineTo(
                  originPoint.x as double, originPoint.y as double);
              _strokePath.close();
            }
            _path.lineTo(x, y);
            _path.lineTo(originPoint.x as double, originPoint.y as double);
          } else {
            _strokePath.lineTo(x as double, y as double);
            _path.lineTo(x, y);

            if (closed) {
              _path.lineTo(originPoint.x as double, originPoint.y as double);
              if (series.borderDrawMode == BorderDrawMode.excludeBottom) {
                _strokePath.lineTo(
                    originPoint.x as double, originPoint.y as double);
              } else if (series.borderDrawMode == BorderDrawMode.all) {
                _strokePath.lineTo(
                    originPoint.x as double, originPoint.y as double);
                _strokePath.close();
              }
            }
          }
          prevPoint = point;
        }
      }

      seriesRenderer!._drawSegment(
          canvas,
          seriesRenderer!._createSegments(
              _path, _strokePath, painterKey!.index, animationFactor, _points));
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
            'The area series should be available to render a marker on it.');
        canvas.clipRect(clipRect);
        seriesRenderer!._renderSeriesElements(
            chart, canvas, seriesRenderer!._seriesElementAnimation);
      }
      if (animationFactor >= 1) {
        chartState._setPainterKey(painterKey!.index, painterKey!.name, true);
      }
    }
  }

  /// It returns the visibility of area series
  bool _getSeriesVisibility(
      List<CartesianChartPoint<dynamic>?> points, int index) {
    for (int i = index; i < points.length - 1; i++) {
      if (!points[i + 1]!.isDrop) {
        return false;
      }
    }
    return true;
  }

  @override
  bool shouldRepaint(_AreaChartPainter oldDelegate) => isRepaint!;
}
