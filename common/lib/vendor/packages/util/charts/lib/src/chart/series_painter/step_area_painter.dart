part of charts;

class _StepAreaChartPainter extends CustomPainter {
  _StepAreaChartPainter(
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
  final StepAreaSeriesRenderer? seriesRenderer;
  final _PainterKey? painterKey;

  /// Painter method for step area series
  @override
  void paint(Canvas canvas, Size size) {
    Rect clipRect;
    double animationFactor;
    CartesianChartPoint<dynamic>? prevPoint, point;
    _ChartLocation? currentPoint, originPoint, previousPoint;
    final ChartAxisRenderer? xAxisRenderer = seriesRenderer!._xAxisRenderer;
    final ChartAxisRenderer? yAxisRenderer = seriesRenderer!._yAxisRenderer;
    final StepAreaSeries<dynamic, dynamic>? _series =
        seriesRenderer!._series as StepAreaSeries<dynamic, dynamic>?;
    final Path _path = Path();
    final Path _strokePath = Path();
    final List<Offset> _points = <Offset>[];
    final num? crossesAt = _getCrossesAtValue(seriesRenderer, chartState);
    final num origin = crossesAt ?? 0;

    /// Clip rect will be added for series.
    if (seriesRenderer!._visible!) {
      assert(
          _series!.animationDuration != null
              ? _series.animationDuration >= 0
              : true,
          'The animation duration of the step area series must be greater or equal to 0.');
      canvas.save();
      final List<CartesianChartPoint<dynamic>?> dataPoints =
          seriesRenderer!._dataPoints!;
      final int? seriesIndex = painterKey!.index;
      final StepAreaSeries<dynamic, dynamic> series =
          seriesRenderer!._series as StepAreaSeries<dynamic, dynamic>;
      final Rect axisClipRect = _calculatePlotOffset(
          chartState._chartAxis!._axisClipRect!,
          Offset(seriesRenderer!._xAxisRenderer!._axis.plotOffset,
              seriesRenderer!._yAxisRenderer!._axis.plotOffset));
      canvas.clipRect(axisClipRect);
      seriesRenderer!._storeSeriesProperties(chartState, seriesIndex);
      animationFactor = seriesRenderer!._seriesAnimation != null
          ? seriesRenderer!._seriesAnimation!.value
          : 1;
      if (seriesRenderer!._reAnimate ||
          ((!(chartState._widgetNeedUpdate || chartState._isLegendToggled!) ||
                  !chartState._oldSeriesKeys
                      .contains(seriesRenderer!._series!.key)) &&
              seriesRenderer!._series!.animationDuration > 0)) {
        _performLinearAnimation(chartState,
            seriesRenderer!._xAxisRenderer!._axis, canvas, animationFactor);
      }

      for (int pointIndex = 0; pointIndex < dataPoints.length; pointIndex++) {
        point = dataPoints[pointIndex];
        seriesRenderer!._calculateRegionData(
            chartState, seriesRenderer, painterKey!.index, point, pointIndex);
        if (point!.isVisible) {
          currentPoint = _calculatePoint(
              point.xValue,
              point.yValue,
              xAxisRenderer!,
              yAxisRenderer!,
              seriesRenderer!._chartState!._requireInvertedAxis!,
              series,
              axisClipRect);
          previousPoint = prevPoint != null
              ? _calculatePoint(
                  prevPoint.xValue,
                  prevPoint.yValue,
                  xAxisRenderer,
                  yAxisRenderer,
                  seriesRenderer!._chartState!._requireInvertedAxis!,
                  series,
                  axisClipRect)
              : prevPoint as _ChartLocation?;
          originPoint = _calculatePoint(
              point.xValue,
              math_lib.max(yAxisRenderer._visibleRange!.minimum, origin),
              xAxisRenderer,
              yAxisRenderer,
              seriesRenderer!._chartState!._requireInvertedAxis!,
              series,
              axisClipRect);
          _points
              .add(Offset(currentPoint.x as double, currentPoint.y as double));
          _drawStepAreaPath(_path, _strokePath, prevPoint, currentPoint,
              originPoint, previousPoint, pointIndex, _series!);
          prevPoint = point;
        }
      }

      seriesRenderer!._drawSegment(
          canvas,
          seriesRenderer!._createSegments(_path, _strokePath,
              painterKey!.index, animationFactor, _points));

      clipRect = _calculatePlotOffset(
          Rect.fromLTRB(
              chartState._chartAxis!._axisClipRect!.left -
                  seriesRenderer!._series!.markerSettings.width,
              chartState._chartAxis!._axisClipRect!.top -
                  seriesRenderer!._series!.markerSettings.height,
              chartState._chartAxis!._axisClipRect!.right +
                  seriesRenderer!._series!.markerSettings.width,
              chartState._chartAxis!._axisClipRect!.bottom +
                  seriesRenderer!._series!.markerSettings.height),
          Offset(seriesRenderer!._xAxisRenderer!._axis.plotOffset,
              seriesRenderer!._yAxisRenderer!._axis.plotOffset));
      canvas.restore();
      if ((series.animationDuration <= 0 ||
              !chartState._initialRender! ||
              animationFactor >= chartState._seriesDurationFactor) &&
          (series.markerSettings.isVisible ||
              series.dataLabelSettings.isVisible)) {
        assert(seriesRenderer != null,
            'The step area series should be available to render a marker on it.');
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
  bool shouldRepaint(_StepAreaChartPainter oldDelegate) => isRepaint!;

  /// To draw the step area path
  void _drawStepAreaPath(
      Path _path,
      Path _strokePath,
      CartesianChartPoint<dynamic>? prevPoint,
      _ChartLocation currentPoint,
      _ChartLocation originPoint,
      _ChartLocation? previousPoint,
      int pointIndex,
      StepAreaSeries<dynamic, dynamic> stepAreaSeries) {
    final num? x = currentPoint.x;
    final num? y = currentPoint.y;
    final bool closed =
        stepAreaSeries.emptyPointSettings.mode == EmptyPointMode.drop
            ? _getSeriesVisibility(seriesRenderer!._dataPoints!, pointIndex)
            : false;
    if (prevPoint == null ||
        seriesRenderer!._dataPoints![pointIndex - 1]!.isGap == true ||
        (seriesRenderer!._dataPoints![pointIndex]!.isGap == true) ||
        (seriesRenderer!._dataPoints![pointIndex - 1]!.isVisible == false &&
            stepAreaSeries.emptyPointSettings.mode == EmptyPointMode.gap)) {
      _path.moveTo(originPoint.x as double, originPoint.y as double);
      if (stepAreaSeries.borderDrawMode == BorderDrawMode.excludeBottom) {
        if (seriesRenderer!._dataPoints![pointIndex]!.isGap != true) {
          _strokePath.moveTo(originPoint.x as double, originPoint.y as double);
          _strokePath.lineTo(x as double, y as double);
        }
      } else if (stepAreaSeries.borderDrawMode == BorderDrawMode.all) {
        if (seriesRenderer!._dataPoints![pointIndex]!.isGap != true) {
          _strokePath.moveTo(originPoint.x as double, originPoint.y as double);
          _strokePath.lineTo(x as double, y as double);
        }
      } else if (stepAreaSeries.borderDrawMode == BorderDrawMode.top) {
        _strokePath.moveTo(x as double, y as double);
      }
      _path.lineTo(x as double, y as double);
    } else if (pointIndex == seriesRenderer!._dataPoints!.length - 1 ||
        seriesRenderer!._dataPoints![pointIndex + 1]!.isGap == true) {
      _strokePath.lineTo(x as double, previousPoint!.y as double);
      _strokePath.lineTo(x, y as double);
      if (stepAreaSeries.borderDrawMode == BorderDrawMode.excludeBottom) {
        _strokePath.lineTo(originPoint.x as double, originPoint.y as double);
      } else if (stepAreaSeries.borderDrawMode == BorderDrawMode.all) {
        _strokePath.lineTo(originPoint.x as double, originPoint.y as double);
        _strokePath.close();
      }
      _path.lineTo(x, previousPoint.y as double);
      _path.lineTo(x, y);
      _path.lineTo(originPoint.x as double, originPoint.y as double);
    } else {
      _path.lineTo(x as double, previousPoint!.y as double);
      _strokePath.lineTo(x, previousPoint.y as double);
      _strokePath.lineTo(x, y as double);
      _path.lineTo(x, y);
      if (closed) {
        _path.lineTo(originPoint.x as double, originPoint.y as double);
        if (stepAreaSeries.borderDrawMode == BorderDrawMode.excludeBottom) {
          _strokePath.lineTo(originPoint.x as double, originPoint.y as double);
        } else if (stepAreaSeries.borderDrawMode == BorderDrawMode.all) {
          _strokePath.lineTo(originPoint.x as double, originPoint.y as double);
          _strokePath.close();
        }
      }
    }
  }

  /// To find the visibility of a series
  bool _getSeriesVisibility(
      List<CartesianChartPoint<dynamic>?> points, int index) {
    for (int i = index; i < points.length - 1; i++) {
      if (!points[i + 1]!.isDrop) {
        return false;
      }
    }
    return true;
  }
}
