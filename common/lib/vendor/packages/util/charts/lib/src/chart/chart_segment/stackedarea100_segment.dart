part of charts;

/// Creates the segments for 100% stacked area series.
///
/// Generates the stacked area100 series points and has the [calculateSegmentPoints] method overrided to customize
/// the stacked area100 segment point calculation.
///
/// Gets the path and color from the [series].
class StackedArea100Segment extends ChartSegment {
  Rect? _pathRect;
  Path? _path, _strokePath;

  /// Gets the color of the series.
  @override
  Paint? getFillPaint() {
    fillPaint = Paint();
    if (_series!.gradient == null) {
      if (_color != null) {
        fillPaint!.color = _color!;
        fillPaint!.style = PaintingStyle.fill;
      }
    } else {
      fillPaint = (_pathRect != null)
          ? _getLinearGradientPaint(_series!.gradient!, _pathRect!,
              _seriesRenderer!._chartState!._requireInvertedAxis)
          : fillPaint;
    }
    assert(_series!.opacity >= 0,
        'The opacity value of the stacked area 100 series should be greater than or equal to 0.');
    assert(_series!.opacity <= 1,
        'The opacity value of the stacked area 100 series should be less than or equal to 1.');
    fillPaint!.color =
        (_series!.opacity < 1 && fillPaint!.color != Colors.transparent)
            ? fillPaint!.color.withOpacity(_series!.opacity)
            : fillPaint!.color;
    _defaultFillColor = fillPaint;
    return fillPaint;
  }

  /// Gets the border color of the series.
  @override
  Paint getStrokePaint() {
    final Paint strokePaint = Paint();
    strokePaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = _series!.borderWidth;
    if (_series!.borderGradient != null && _strokePath != null) {
      strokePaint.shader =
          _series!.borderGradient!.createShader(_strokePath!.getBounds());
    } else if (_strokeColor != null) {
      strokePaint.color = _series!.borderColor;
    }
    _series!.borderWidth == 0
        ? strokePaint.color = Colors.transparent
        : strokePaint.color;
    strokePaint.strokeCap = StrokeCap.round;
    _defaultStrokeColor = strokePaint;
    return strokePaint;
  }

  /// Calculates the rendering bounds of a segment.
  @override
  void calculateSegmentPoints() {}

  /// Draws segment in series bounds.
  @override
  void onPaint(Canvas canvas) {
    _renderStackedAreaSeries(_seriesRenderer!, fillPaint, strokePaint, canvas,
        _seriesIndex, getFillPaint(), _path!, _strokePath);
  }
}
