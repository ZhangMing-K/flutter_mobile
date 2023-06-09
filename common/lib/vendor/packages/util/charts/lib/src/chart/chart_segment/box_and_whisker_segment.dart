part of charts;

/// Creates the segments for box and whisker series.
///
/// Generates the box and whisker series points and has the [calculateSegmentPoints] override method
/// used to customize the box and whisker series segment point calculation.
///
/// Gets the path and fill color from the [series] to render the box and whisker segment.
///
class BoxAndWhiskerSegment extends ChartSegment {
  num? _x,
      _min,
      _max,
      _maxY,
      _lowerX,
      _lowerY,
      _upperX,
      _upperY,
      _centerMax,
      _centerMin,
      _minY,
      _centersY,
      _topRectY,
      _topLineY,
      _bottomRectY,
      _bottomLineY,
      _medianX,
      _medianY;
  Path? _path;
  late Paint _meanPaint;
  // ignore: unused_field
  Color? _pointColorMapper;

  @override
  CartesianChartPoint<dynamic>? _currentPoint;

  bool? _isTransposed;

  _ChartLocation? _minPoint, _maxPoint, _centerMinPoint, _centerMaxPoint;

  BoxAndWhiskerSeries<dynamic, dynamic>? _boxAndWhiskerSeries;

  /// Gets the color of the series.
  @override
  Paint? getFillPaint() {
    /// Get and set the paint options for box and whisker series.
    if (_series!.gradient == null) {
      fillPaint = Paint()
        ..color = _currentPoint!.isEmpty == true
            ? _series!.emptyPointSettings.color
            : (_currentPoint!.pointColorMapper ?? _color!)
        ..style = PaintingStyle.fill;
    } else {
      fillPaint = _getLinearGradientPaint(
          _series!.gradient!,
          _currentPoint!.region!,
          _seriesRenderer!._chartState!._requireInvertedAxis);
    }
    assert(_series!.opacity >= 0,
        'The opacity value of the box plot series should be greater than or equal to 0.');
    assert(_series!.opacity <= 1,
        'The opacity value of the box plot series should be less than or equal to 1.');
    fillPaint!.color =
        (_series!.opacity < 1 && fillPaint!.color != Colors.transparent)
            ? fillPaint!.color.withOpacity(_series!.opacity)
            : fillPaint!.color;
    _defaultFillColor = fillPaint;
    return fillPaint;
  }

  /// Gets the border color of the series.
  @override
  Paint? getStrokePaint() {
    strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = _currentPoint!.isEmpty == true
          ? _series!.emptyPointSettings.borderWidth
          : _strokeWidth!;
    _meanPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = _currentPoint!.isEmpty == true
          ? _series!.emptyPointSettings.borderWidth
          : _strokeWidth!;
    if (_series!.borderGradient != null) {
      strokePaint!.shader =
          _series!.borderGradient!.createShader(_currentPoint!.region!);
      _meanPaint.shader =
          _series!.borderGradient!.createShader(_currentPoint!.region!);
    } else {
      strokePaint!.color = _currentPoint!.isEmpty == true
          ? _series!.emptyPointSettings.borderColor
          : _strokeColor!;
      _meanPaint.color = _currentPoint!.isEmpty == true
          ? _series!.emptyPointSettings.borderColor
          : _strokeColor!;
    }
    _series!.borderWidth == 0
        ? strokePaint!.color = Colors.transparent
        : strokePaint!.color;
    _defaultStrokeColor = strokePaint;
    return strokePaint;
  }

  /// Calculates the rendering bounds of a segment.
  @override
  void calculateSegmentPoints() {
    _boxAndWhiskerSeries = _series as BoxAndWhiskerSeries<dynamic, dynamic>?;
    _x = _max = double.nan;
    _isTransposed = _seriesRenderer!._chartState!._requireInvertedAxis;
    _minPoint = _currentPoint!.minimumPoint;
    _maxPoint = _currentPoint!.maximumPoint;
    _centerMinPoint = _currentPoint!.centerMinimumPoint;
    _centerMaxPoint = _currentPoint!.centerMaximumPoint;
    _x = _minPoint!.x;
    _min = _minPoint!.y;
    _max = _maxPoint!.y;
    _centerMax = _centerMaxPoint!.x;
    _maxY = _centerMaxPoint!.y;
    _centerMin = _centerMinPoint!.x;
    _minY = _centerMinPoint!.y;
    _lowerX = _currentPoint!.lowerQuartilePoint!.x;
    _lowerY = _currentPoint!.lowerQuartilePoint!.y;
    _upperX = _currentPoint!.upperQuartilePoint!.x;
    _upperY = _currentPoint!.upperQuartilePoint!.y;
    _medianX = _currentPoint!.medianPoint!.x;
    _medianY = _currentPoint!.medianPoint!.y;

    if (_lowerY! > _upperY!) {
      _centersY = _upperY! + ((_upperY! - _lowerY!).abs() / 2);
    } else {
      _centersY = _lowerY! + ((_lowerY! - _upperY!).abs() / 2);
    }
    _topRectY = _centersY! - ((_centersY! - _upperY!).abs() * 1);
    _bottomRectY = _centersY! + ((_centersY! - _lowerY!).abs() * 1);
  }

  /// To draw rect path of box and whisker segments
  void _drawRectPath() {
    _path!.moveTo(!_isTransposed! ? _lowerX as double : _topRectY as double,
        !_isTransposed! ? _topRectY as double : _upperY as double);
    _path!.lineTo(!_isTransposed! ? _upperX as double : _topRectY as double,
        !_isTransposed! ? _topRectY as double : _lowerY as double);
    _path!.lineTo(!_isTransposed! ? _upperX as double : _bottomRectY as double,
        !_isTransposed! ? _bottomRectY as double : _lowerY as double);
    _path!.lineTo(!_isTransposed! ? _lowerX as double : _bottomRectY as double,
        !_isTransposed! ? _bottomRectY as double : _upperY as double);
    _path!.lineTo(!_isTransposed! ? _lowerX as double : _topRectY as double,
        !_isTransposed! ? _topRectY as double : _upperY as double);
    _path!.close();
  }

  /// To draw line path of box and whisker segments
  void _drawLine(Canvas canvas) {
    canvas.drawLine(Offset(_lowerX as double, _topLineY as double),
        Offset(_upperX as double, _topLineY as double), strokePaint!);
    canvas.drawLine(Offset(_centerMax as double, _topRectY as double),
        Offset(_centerMax as double, _topLineY as double), strokePaint!);
    canvas.drawLine(Offset(_lowerX as double, _medianY as double),
        Offset(_upperX as double, _medianY as double), strokePaint!);
    canvas.drawLine(Offset(_centerMax as double, _bottomRectY as double),
        Offset(_centerMax as double, _bottomLineY as double), strokePaint!);
    canvas.drawLine(Offset(_lowerX as double, _bottomLineY as double),
        Offset(_upperX as double, _bottomLineY as double), strokePaint!);
  }

  /// To draw mean line path of box and whisker segments
  void _drawMeanLine(
      Canvas canvas, Offset position, Size size, bool isTransposed) {
    final x = !isTransposed ? position.dx : position.dy;
    final y = !isTransposed ? position.dy : position.dx;
    if (_series!.animationDuration <= 0 ||
        animationFactor! >=
            _seriesRenderer!._chartState!._seriesDurationFactor) {
      /// `0.15` is animation duration of mean point value, as like marker.
      final double opacity = (animationFactor! -
              _seriesRenderer!._chartState!._seriesDurationFactor) *
          (1 / 0.15);
      _meanPaint.color = Color.fromRGBO(_meanPaint.color.red,
          _meanPaint.color.green, _meanPaint.color.blue, opacity);
      canvas.drawLine(Offset(x + size.width / 2, y - size.height / 2),
          Offset(x - size.width / 2, y + size.height / 2), _meanPaint);
      canvas.drawLine(Offset(x + size.width / 2, y + size.height / 2),
          Offset(x - size.width / 2, y - size.height / 2), _meanPaint);
    }
  }

  /// To draw line path of box and whisker segments
  void _drawFillLine(Canvas canvas) {
    final bool isOpen =
        _currentPoint!.lowerQuartile! > _currentPoint!.upperQuartile!;
    canvas.drawLine(
        Offset(_topRectY as double, _maxY as double),
        Offset(
            _topRectY! +
                ((isOpen ? (_lowerX! - _centerMax!) : (_upperX! - _centerMax!))
                        .abs() *
                    animationFactor!),
            _maxY as double),
        strokePaint!);
    canvas.drawLine(
        Offset(_bottomRectY as double, _maxY as double),
        Offset(
            _bottomRectY! -
                ((isOpen ? (_upperX! - _centerMin!) : (_lowerX! - _centerMin!))
                        .abs() *
                    animationFactor!),
            _maxY as double),
        strokePaint!);
  }

  /// Draws segment in series bounds.
  @override
  void onPaint(Canvas canvas) {
    if (fillPaint != null && _seriesRenderer!._reAnimate ||
        (!(_seriesRenderer!._chartState!._widgetNeedUpdate &&
            !_seriesRenderer!._chartState!._isLegendToggled!))) {
      _path = Path();
      if (!_isTransposed! &&
          _currentPoint!.lowerQuartile! > _currentPoint!.upperQuartile!) {
        final num? temp = _upperY;
        _upperY = _lowerY;
        _lowerY = temp;
      }

      if (_seriesRenderer!._chartState!._isLegendToggled!) {
        animationFactor = 1;
      }
      if (_lowerY! > _upperY!) {
        _centersY = _upperY! + ((_upperY! - _lowerY!).abs() / 2);
        _topRectY =
            _centersY! - ((_centersY! - _upperY!).abs() * animationFactor!);
        _bottomRectY =
            _centersY! + ((_centersY! - _lowerY!).abs() * animationFactor!);
      } else {
        _centersY = _lowerY! + ((_lowerY! - _upperY!).abs() / 2);
        _topRectY =
            _centersY! - ((_centersY! - _upperY!).abs() * animationFactor!);
        _bottomRectY =
            _centersY! + ((_centersY! - _lowerY!).abs() * animationFactor!);
      }
      _topLineY = _topRectY! - ((_topRectY! - _maxY!).abs() * animationFactor!);
      _bottomLineY =
          _bottomRectY! + ((_bottomRectY! - _minY!).abs() * animationFactor!);

      _bottomLineY = _minY! < _lowerY!
          ? _bottomRectY! + ((_upperY! - _maxY!).abs() * animationFactor!)
          : _bottomLineY;

      _topLineY = _maxY! > _upperY!
          ? _topRectY! - ((_lowerY! - _minY!).abs() * animationFactor!)
          : _topLineY;

      if (_isTransposed!) {
        if (_lowerX! > _upperX!) {
          _centersY = _upperX! + ((_lowerX! - _upperX!).abs() / 2);
          _topRectY =
              _centersY! + ((_centersY! - _lowerX!).abs() * animationFactor!);
          _bottomRectY =
              _centersY! - ((_centersY! - _upperX!).abs() * animationFactor!);
        } else {
          _centersY = _lowerX! + (_upperX! - _lowerX!).abs() / 2;
          _topRectY =
              _centersY! + ((_centersY! - _upperX!).abs() * animationFactor!);
          _bottomRectY =
              _centersY! - ((_centersY! - _lowerX!).abs() * animationFactor!);
        }
        _path!.moveTo(_centerMax as double, _upperY as double);
        _path!.lineTo(_centerMax as double, _lowerY as double);
        if (_centerMax! < _upperX!) {
          _path!.moveTo(_bottomRectY as double, _maxY as double);
          _path!.lineTo(
              _topRectY! - ((_lowerX! - _centerMax!).abs() * animationFactor!),
              _maxY as double);
        } else {
          _path!.moveTo(_topRectY as double, _maxY as double);
          _path!.lineTo(
              _topRectY! + ((_upperX! - _centerMax!).abs() * animationFactor!),
              _maxY as double);
        }
        _path!.moveTo(_medianX as double, _upperY as double);
        _path!.lineTo(_medianX as double, _lowerY as double);
        if (_centerMin! > _lowerX!) {
          _path!.moveTo(_topRectY as double, _maxY as double);
          _path!.lineTo(
              _bottomRectY! +
                  ((_upperX! - _centerMin!).abs() * animationFactor!),
              _maxY as double);
        } else {
          _path!.moveTo(_bottomRectY as double, _maxY as double);
          _path!.lineTo(
              _bottomRectY! -
                  ((_lowerX! - _centerMin!).abs() * animationFactor!),
              _maxY as double);
        }
        _path!.moveTo(_centerMin as double, _upperY as double);
        _path!.lineTo(_centerMin as double, _lowerY as double);
        if (_boxAndWhiskerSeries!.showMean) {
          _drawMeanLine(
              canvas,
              Offset(_currentPoint!.centerMeanPoint!.y as double,
                  _currentPoint!.centerMeanPoint!.x as double),
              Size(_series!.markerSettings.width,
                  _series!.markerSettings.height),
              _isTransposed!);
        }

        _lowerX == _upperX
            ? canvas.drawLine(Offset(_lowerX as double, _lowerY as double),
                Offset(_upperX as double, _upperY as double), fillPaint!)
            : _drawRectPath();
      } else {
        if (_currentPoint!.lowerQuartile! > _currentPoint!.upperQuartile!) {
          final num? temp = _upperY;
          _upperY = _lowerY;
          _lowerY = temp;
        }
        _drawLine(canvas);
        if (_boxAndWhiskerSeries!.showMean) {
          _drawMeanLine(
              canvas,
              Offset(_currentPoint!.centerMeanPoint!.x as double,
                  _currentPoint!.centerMeanPoint!.y as double),
              Size(_series!.markerSettings.width,
                  _series!.markerSettings.height),
              _isTransposed!);
        }
        _lowerY == _upperY
            ? canvas.drawLine(Offset(_lowerX as double, _lowerY as double),
                Offset(_upperX as double, _upperY as double), fillPaint!)
            : _drawRectPath();
      }

      if (_series!.dashArray[0] != 0 &&
          _series!.dashArray[1] != 0 &&
          _series!.animationDuration <= 0) {
        canvas.drawPath(_path!, fillPaint!);
        _drawDashedLine(canvas, _series!.dashArray, strokePaint, _path);
      } else {
        canvas.drawPath(_path!, fillPaint!);
        canvas.drawPath(_path!, strokePaint!);
      }
      if (fillPaint!.style == PaintingStyle.fill) {
        if (_isTransposed!) {
          if (_currentPoint!.lowerQuartile! > _currentPoint!.upperQuartile!) {
            _drawFillLine(canvas);
          }
          if (_boxAndWhiskerSeries!.showMean) {
            _drawMeanLine(
                canvas,
                Offset(_currentPoint!.centerMeanPoint!.y as double,
                    _currentPoint!.centerMeanPoint!.x as double),
                Size(_series!.markerSettings.width,
                    _series!.markerSettings.height),
                _isTransposed!);
          }
        } else {
          _drawLine(canvas);
          if (_boxAndWhiskerSeries!.showMean) {
            _drawMeanLine(
                canvas,
                Offset(_currentPoint!.centerMeanPoint!.x as double,
                    _currentPoint!.centerMeanPoint!.y as double),
                Size(_series!.markerSettings.width,
                    _series!.markerSettings.height),
                _isTransposed!);
          }
        }
      }
    } else if (!_seriesRenderer!._chartState!._isLegendToggled!) {
      final BoxAndWhiskerSegment currentSegment = _seriesRenderer!
          ._segments[currentSegmentIndex!] as BoxAndWhiskerSegment;
      final BoxAndWhiskerSegment? oldSegment =
          (currentSegment._oldSeriesRenderer != null &&
                  currentSegment._oldSeriesRenderer!._segments.isNotEmpty &&
                  currentSegment._oldSeriesRenderer!._segments[0]
                      is BoxAndWhiskerSegment &&
                  currentSegment._oldSeriesRenderer!._segments.length - 1 >=
                      currentSegmentIndex!)
              ? currentSegment._oldSeriesRenderer!
                  ._segments[currentSegmentIndex!] as BoxAndWhiskerSegment?
              : null;
      _animateBoxSeries(
          _boxAndWhiskerSeries!.showMean,
          Offset(_currentPoint!.centerMeanPoint!.x as double,
              _currentPoint!.centerMeanPoint!.y as double),
          Offset(_currentPoint!.centerMeanPoint!.y as double,
              _currentPoint!.centerMeanPoint!.x as double),
          Size(_series!.markerSettings.width, _series!.markerSettings.height),
          _max,
          _isTransposed!,
          _currentPoint!.lowerQuartile,
          _currentPoint!.upperQuartile,
          _minY,
          _maxY,
          oldSegment?._minY,
          oldSegment?._maxY,
          _lowerX,
          _lowerY,
          _upperX,
          _upperY,
          _centerMin,
          _centerMax,
          oldSegment?._lowerX,
          oldSegment?._lowerY,
          oldSegment?._upperX,
          oldSegment?._upperY,
          oldSegment?._centerMin,
          oldSegment?._centerMax,
          _medianX,
          _medianY,
          animationFactor,
          fillPaint!,
          strokePaint,
          canvas,
          _seriesRenderer!);
    }
  }
}
