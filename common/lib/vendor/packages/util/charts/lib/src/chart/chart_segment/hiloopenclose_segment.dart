part of charts;

/// Creates the segments for HiloOpenClose series.
///
/// Generates the HiloOpenClose series points and has the [calculateSegmentPoints] method overrided to customize
/// the HiloOpenClose segment point calculation.
///
/// Gets the path and color from the [series].
class HiloOpenCloseSegment extends ChartSegment {
  //ignore: unused_field
  num? _x,
      _low,
      _high,
      _centerY,
      _highY,
      _centerX,
      _lowX,
      _highX,
      _openX,
      _openY,
      _closeX,
      _closeY,
      _centerHigh,
      _centerLow,
      _lowY;

  ///Render path.
  Path? _path;

  Color? _pointColorMapper;
  @override
  CartesianChartPoint<dynamic>? _currentPoint;
  _ChartLocation? _centerLowPoint, _centerHighPoint, _lowPoint, _highPoint;
  bool? _showSameValue, _isTransposed, _isBull = false;
  HiloOpenCloseSegment? _currentSegment, _oldSegment;
  HiloOpenCloseSeries<dynamic, dynamic>? _hiloOpenCloseSeries;

  /// Gets the color of the series.
  @override
  Paint getFillPaint() {
    final Paint fillPaint = Paint();
    assert(_series!.opacity >= 0,
        'The opacity value of the Hilo open-close series should be greater than or equal to 0.');
    assert(_series!.opacity <= 1,
        'The opacity value of the Hilo open-close series should be less than or equal to 1.');
    if (_color != null) {
      fillPaint.color =
          _pointColorMapper ?? _color!.withOpacity(_series!.opacity);
    }
    fillPaint.strokeWidth = _strokeWidth!;
    fillPaint.style = PaintingStyle.fill;
    _defaultFillColor = fillPaint;
    return fillPaint;
  }

  /// Gets the border color of the series.
  @override
  Paint getStrokePaint() {
    final Paint strokePaint = Paint();
    assert(_series!.opacity >= 0,
        'The opacity value of the Hilo open-close series should be greater than or equal to 0.');
    assert(_series!.opacity <= 1,
        'The opacity value of the Hilo open-close series should be less than or equal to 1.');
    if (_strokeColor != null) {
      strokePaint.color =
          _currentPoint!.isEmpty != null && _currentPoint!.isEmpty!
              ? _series!.emptyPointSettings.color
              : _pointColorMapper ?? _strokeColor!;
      strokePaint.color =
          (_series!.opacity < 1 && strokePaint.color != Colors.transparent)
              ? strokePaint.color.withOpacity(_series!.opacity)
              : strokePaint.color;
    }
    strokePaint.strokeWidth = _strokeWidth!;
    strokePaint.style = PaintingStyle.stroke;
    strokePaint.strokeCap = StrokeCap.round;
    _defaultStrokeColor = strokePaint;
    return strokePaint;
  }

  /// Calculates the rendering bounds of a segment.
  @override
  void calculateSegmentPoints() {
    _hiloOpenCloseSeries = _series as HiloOpenCloseSeries<dynamic, dynamic>?;
    _isTransposed = _seriesRenderer!._chartState!._requireInvertedAxis;
    _isBull = _currentPoint!.open < _currentPoint!.close;
    _lowPoint = _currentPoint!.lowPoint;
    _highPoint = _currentPoint!.highPoint;
    _centerLowPoint = _currentPoint!.centerLowPoint;
    _centerHighPoint = _currentPoint!.centerHighPoint;
    _x = _lowX = _lowPoint!.x;
    _low = _lowPoint!.y;
    _high = _highPoint!.y;
    _highX = _highPoint!.x;
    _centerHigh = _centerHighPoint!.x;
    _highY = _centerHighPoint!.y;
    _centerLow = _centerLowPoint!.x;
    _lowY = _centerLowPoint!.y;
    _openX = _currentPoint!.openPoint!.x;
    _openY = _currentPoint!.openPoint!.y;
    _closeX = _currentPoint!.closePoint!.x;
    _closeY = _currentPoint!.closePoint!.y;

    _showSameValue = _hiloOpenCloseSeries!.showIndicationForSameValues &&
        (!_isTransposed!
            ? _centerHighPoint!.y == _centerLowPoint!.y
            : _centerHighPoint!.x == _centerLowPoint!.x);

    if (_showSameValue!) {
      if (_isTransposed!) {
        _x = _lowPoint!.x = _lowPoint!.x! - 2;
        _highPoint!.x = _highPoint!.x! + 2;
        _centerHigh = _centerHighPoint!.x = _centerHighPoint!.x! + 2;
        _centerLow = _centerLowPoint!.x = _centerLowPoint!.x! - 2;
      } else {
        _low = _lowPoint!.y = _lowPoint!.y! - 2;
        _high = _highPoint!.y = _highPoint!.y! + 2;
        _highY = _centerHighPoint!.y = _centerHighPoint!.y! + 2;
        _lowY = _centerLowPoint!.y = _centerLowPoint!.y! - 2;
      }
    }
  }

  /// Draws the _path between open and close values.
  void drawHiloOpenClosePath(Canvas canvas) {
    canvas.drawLine(Offset(_centerHigh as double, _highY as double),
        Offset(_centerLow as double, _lowY as double), strokePaint!);
    canvas.drawLine(
        Offset(_openX as double, _openY as double),
        Offset(_isTransposed! ? _openX as double : _centerHigh as double,
            _isTransposed! ? _highY as double : _openY as double),
        strokePaint!);
    canvas.drawLine(
        Offset(_closeX as double, _closeY as double),
        Offset(_isTransposed! ? _closeX as double : _centerLow as double,
            _isTransposed! ? _highY as double : _closeY as double),
        strokePaint!);
  }

  /// To draw dashed hilo open close path
  Path? _drawDashedHiloOpenClosePath(Canvas canvas) {
    _path!.moveTo(_centerHigh as double, _highY as double);
    _path!.lineTo(_centerLow as double, _lowY as double);
    _path!.moveTo(_openX as double, _openY as double);
    _path!.lineTo(_isTransposed! ? _openX as double : _centerHigh as double,
        _isTransposed! ? _highY as double : _openY as double);
    _path!.moveTo(_isTransposed! ? _closeX as double : _centerLow as double,
        _isTransposed! ? _highY as double : _closeY as double);
    _path!.lineTo(_closeX as double, _closeY as double);
    return _path;
  }

  /// Draws segment in series bounds.
  @override
  void onPaint(Canvas canvas) {
    if (strokePaint != null) {
      _path = Path();
      if (_series!.animationDuration > 0 &&
          !_seriesRenderer!._chartState!._isLegendToggled!) {
        if (!_seriesRenderer!._chartState!._widgetNeedUpdate ||
            _seriesRenderer!._reAnimate) {
          if (_isTransposed!) {
            _centerX = _highX! + ((_lowX! - _highX!) / 2);
            _openX = _centerX! -
                ((_centerX! - _currentPoint!.openPoint!.x!) * animationFactor!);
            _closeX = _centerX! +
                ((_currentPoint!.closePoint!.x! - _centerX!) *
                    animationFactor!);
            _highX =
                _centerX! + ((_centerX! - _highX!).abs() * animationFactor!);
            _lowX = _centerX! - ((_lowX! - _centerX!).abs() * animationFactor!);
            canvas.drawLine(
                Offset(_lowX as double, _centerLowPoint!.y as double),
                Offset(_highX as double, _centerHighPoint!.y as double),
                strokePaint!);
            canvas.drawLine(Offset(_openX as double, _openY as double),
                Offset(_openX as double, _highY as double), strokePaint!);
            canvas.drawLine(Offset(_closeX as double, _lowY as double),
                Offset(_closeX as double, _closeY as double), strokePaint!);
          } else {
            _centerY = _high! + ((_low! - _high!) / 2);
            _openY = _centerY! -
                ((_centerY! - _currentPoint!.openPoint!.y!) * animationFactor!);
            _closeY = _centerY! +
                ((_currentPoint!.closePoint!.y! - _centerY!) *
                    animationFactor!);
            _highY = _centerY! - ((_centerY! - _high!) * animationFactor!);
            _lowY = _centerY! + ((_low! - _centerY!) * animationFactor!);
            canvas.drawLine(Offset(_centerHigh as double, _highY as double),
                Offset(_centerLow as double, _lowY as double), strokePaint!);
            canvas.drawLine(Offset(_openX as double, _openY as double),
                Offset(_centerHigh as double, _openY as double), strokePaint!);
            canvas.drawLine(Offset(_centerLow as double, _closeY as double),
                Offset(_closeX as double, _closeY as double), strokePaint!);
          }
        } else {
          _currentSegment = _seriesRenderer!._segments[currentSegmentIndex!]
              as HiloOpenCloseSegment?;
          _oldSegment = !_seriesRenderer!._reAnimate &&
                  (_currentSegment!._oldSeriesRenderer != null &&
                      _currentSegment!
                          ._oldSeriesRenderer!._segments.isNotEmpty &&
                      _currentSegment!._oldSeriesRenderer!._segments[0]
                          is HiloOpenCloseSegment &&
                      _currentSegment!._oldSeriesRenderer!._segments.length -
                              1 >=
                          currentSegmentIndex!)
              ? _currentSegment!._oldSeriesRenderer!
                  ._segments[currentSegmentIndex!] as HiloOpenCloseSegment?
              : null;
          _animateHiloOpenCloseSeries(
              _isTransposed!,
              _isTransposed! ? _lowPoint!.x : _low,
              _isTransposed! ? _highPoint!.x : _high,
              _isTransposed!
                  ? (_oldSegment != null ? _oldSegment!._lowPoint!.x : null)
                  : _oldSegment?._low,
              _isTransposed!
                  ? (_oldSegment != null ? _oldSegment!._highPoint!.x : null)
                  : _oldSegment?._high,
              _openX,
              _openY,
              _closeX,
              _closeY,
              _isTransposed! ? _centerLowPoint!.y : _centerLow,
              _isTransposed! ? _centerHighPoint!.y : _centerHigh,
              _oldSegment?._openX,
              _oldSegment?._openY,
              _oldSegment?._closeX,
              _oldSegment?._closeY,
              _isTransposed!
                  ? (_oldSegment != null
                      ? _oldSegment!._centerLowPoint!.y
                      : null)
                  : _oldSegment?._centerLow,
              _isTransposed!
                  ? (_oldSegment != null
                      ? _oldSegment!._centerHighPoint!.y
                      : null)
                  : _oldSegment?._centerHigh,
              animationFactor,
              strokePaint,
              canvas,
              _seriesRenderer);
        }
      } else {
        if (_series!.dashArray[0] != 0 && _series!.dashArray[1] != 0) {
          _drawDashedLine(canvas, _series!.dashArray, strokePaint,
              _drawDashedHiloOpenClosePath(canvas));
        } else {
          drawHiloOpenClosePath(canvas);
        }
      }
    }
  }
}
