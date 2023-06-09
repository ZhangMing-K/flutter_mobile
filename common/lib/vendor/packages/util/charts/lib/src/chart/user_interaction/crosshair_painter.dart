part of charts;

class _CrosshairPainter extends CustomPainter {
  _CrosshairPainter({required this.chartState, this.valueNotifier})
      : chart = chartState._chart,
        super(repaint: valueNotifier);
  final SfCartesianChartState chartState;
  final SfCartesianChart chart;
  Timer? timer;
  ValueNotifier<int>? valueNotifier;
  double? pointerLength;
  double? pointerWidth;
  double nosePointY = 0;
  double nosePointX = 0;
  double totalWidth = 0;
  double? x;
  double? y;
  double? xPos;
  double? yPos;
  bool isTop = false;
  double? cornerRadius;
  Path backgroundPath = Path();
  bool canResetPath = true;
  bool isLeft = false;
  bool isRight = false;
  bool? enable;
  double padding = 0;
  List<String> stringValue = <String>[];
  Rect boundaryRect = const Rect.fromLTWH(0, 0, 0, 0);
  double leftPadding = 0;
  double topPadding = 0;
  bool isHorizontalOrientation = false;
  TextStyle? labelStyle;

  @override
  void paint(Canvas canvas, Size size) {
    if (!canResetPath) {
      chartState._crosshairBehaviorRenderer.onPaint(canvas);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  /// calculate trackball points
  void _generateAllPoints(Offset position) {
    chartState._crosshairBehaviorRenderer._position =
        getPositionGivenRect(chartState._chartAxis!._axisClipRect!, position);
    // if (_isRectContains(chartState._chartAxis._axisClipRect, position)) {
    //   chartState._crosshairBehaviorRenderer._position = position;
    // }
  }

  /// Get line painter paint
  Paint _getLinePainter(Paint crosshairLinePaint) => crosshairLinePaint;

  /// Draw the path of the cross hair line
  void _drawCrosshairLine(Canvas canvas, Paint? paint, int? index) {
    if (chartState._crosshairBehaviorRenderer._position != null) {
      final Path dashArrayPath = Path();
      if (chart.crosshairBehavior.lineType == CrosshairLineType.horizontal ||
          chart.crosshairBehavior.lineType == CrosshairLineType.both) {
        dashArrayPath.moveTo(chartState._chartAxis!._axisClipRect!.left,
            chartState._crosshairBehaviorRenderer._position!.dy);
        dashArrayPath.lineTo(chartState._chartAxis!._axisClipRect!.right,
            chartState._crosshairBehaviorRenderer._position!.dy);
        chart.crosshairBehavior.lineDashArray != null
            ? _drawDashedLine(canvas, chart.crosshairBehavior.lineDashArray!,
                paint, dashArrayPath)
            : canvas.drawPath(dashArrayPath, paint!);
      }
      if (chart.crosshairBehavior.lineType == CrosshairLineType.vertical ||
          chart.crosshairBehavior.lineType == CrosshairLineType.both) {
        dashArrayPath.moveTo(
            chartState._crosshairBehaviorRenderer._position!.dx,
            chartState._chartAxis!._axisClipRect!.top);
        dashArrayPath.lineTo(
            chartState._crosshairBehaviorRenderer._position!.dx,
            chartState._chartAxis!._axisClipRect!.bottom);
        chart.crosshairBehavior.lineDashArray != null
            ? _drawDashedLine(canvas, chart.crosshairBehavior.lineDashArray!,
                paint, dashArrayPath)
            : canvas.drawPath(dashArrayPath, paint!);
      }
    }
  }

  /// To draw cross hair
  void _drawCrosshair(Canvas canvas) {
    final Paint fillPaint = Paint()
      ..color = chartState._chartTheme!.crosshairBackgroundColor
      ..strokeCap = StrokeCap.butt
      ..isAntiAlias = false
      ..style = PaintingStyle.fill;

    final Paint strokePaint = Paint()
      ..color = chartState._chartTheme!.crosshairBackgroundColor
      ..strokeCap = StrokeCap.butt
      ..isAntiAlias = false
      ..style = PaintingStyle.stroke;
    chart.crosshairBehavior.lineWidth == 0
        ? strokePaint.color = Colors.transparent
        : strokePaint.color = strokePaint.color;

    final Paint crosshairLinePaint = Paint();
    if (chartState._crosshairBehaviorRenderer._position != null) {
      final Offset? position = chartState._crosshairBehaviorRenderer._position;

      crosshairLinePaint.color = chart.crosshairBehavior.lineColor ??
          chartState._chartTheme!.crosshairLineColor;
      crosshairLinePaint.strokeWidth = chart.crosshairBehavior.lineWidth;
      crosshairLinePaint.style = PaintingStyle.stroke;
      CrosshairRenderArgs crosshairEventArgs;
      if (chart.onCrosshairPositionChanging != null) {
        crosshairEventArgs = CrosshairRenderArgs();
        crosshairEventArgs.lineColor = crosshairLinePaint.color;
        chart.onCrosshairPositionChanging!(crosshairEventArgs);
        crosshairLinePaint.color = crosshairEventArgs.lineColor!;
      }
      chartState._crosshairBehaviorRenderer._drawLine(
          canvas,
          chartState._crosshairBehaviorRenderer
              ._linePainter(crosshairLinePaint),
          null);

      _drawBottomAxesTooltip(canvas, position, strokePaint, fillPaint);
      _drawTopAxesTooltip(canvas, position, strokePaint, fillPaint);
      _drawLeftAxesTooltip(canvas, position, strokePaint, fillPaint);
      _drawRightAxesTooltip(canvas, position, strokePaint, fillPaint);
    }
  }

  /// draw bottom axes tooltip
  void _drawBottomAxesTooltip(
      Canvas canvas, Offset? position, Paint strokePaint, Paint fillPaint) {
    ChartAxisRenderer axisRenderer;
    dynamic value;
    Size labelSize;
    Rect labelRect, validatedRect;
    RRect tooltipRect;
    Color? color;
    const double padding = 10;
    CrosshairRenderArgs crosshairEventArgs;
    for (int index = 0;
        index < chartState._chartAxis!._bottomAxesCount!.length;
        index++) {
      axisRenderer =
          chartState._chartAxis!._bottomAxesCount![index].axisRenderer;
      final ChartAxis axis = axisRenderer._axis;
      if (_needToAddTooltip(axisRenderer)) {
        fillPaint.color = axis.interactiveTooltip.color != null
            ? axis.interactiveTooltip.color!
            : chartState._chartTheme!.crosshairBackgroundColor;
        strokePaint.color = axis.interactiveTooltip.borderColor != null
            ? axis.interactiveTooltip.borderColor!
            : chartState._chartTheme!.crosshairBackgroundColor;
        strokePaint.strokeWidth = axis.interactiveTooltip.borderWidth;
        value = _getXValue(axisRenderer, position!);
        if (chart.onCrosshairPositionChanging != null) {
          crosshairEventArgs = CrosshairRenderArgs(
              axis, value, axisRenderer._name, axisRenderer._orientation);
          crosshairEventArgs.text = value.toString();
          crosshairEventArgs.lineColor = chart.crosshairBehavior.lineColor ??
              chartState._chartTheme!.crosshairLineColor;
          crosshairEventArgs.lineColor = color;
          chart.onCrosshairPositionChanging!(crosshairEventArgs);
          value = crosshairEventArgs.text;
          color = crosshairEventArgs.lineColor;
        }
        labelSize =
            _measureText(value.toString(), axis.interactiveTooltip.textStyle);
        labelRect = Rect.fromLTWH(
            position.dx - (labelSize.width / 2 + padding / 2),
            axisRenderer._bounds.top + axis.interactiveTooltip.arrowLength,
            labelSize.width + padding,
            labelSize.height + padding);
        labelRect = _validateRectBounds(labelRect, chartState._containerRect!);
        validatedRect = _validateRectXPosition(labelRect, chartState);
        backgroundPath.reset();
        tooltipRect = _getRoundedCornerRect(
            validatedRect, axis.interactiveTooltip.borderRadius);
        backgroundPath.addRRect(tooltipRect);
        _drawTooltipArrowhead(
            canvas,
            backgroundPath,
            fillPaint,
            strokePaint,
            position.dx,
            tooltipRect.top - axis.interactiveTooltip.arrowLength,
            (tooltipRect.right - tooltipRect.width / 2) +
                axis.interactiveTooltip.arrowWidth,
            tooltipRect.top,
            (tooltipRect.left + tooltipRect.width / 2) -
                axis.interactiveTooltip.arrowWidth,
            tooltipRect.top,
            position.dx,
            tooltipRect.top - axis.interactiveTooltip.arrowLength);
        _drawText(
            canvas,
            value.toString(),
            Offset(
                (tooltipRect.left + tooltipRect.width / 2) -
                    labelSize.width / 2,
                (tooltipRect.top + tooltipRect.height / 2) -
                    labelSize.height / 2),
            TextStyle(
                color: axis.interactiveTooltip.textStyle.color ??
                    chartState._chartTheme!.tooltipLabelColor,
                fontSize: axis.interactiveTooltip.textStyle.fontSize,
                fontWeight: axis.interactiveTooltip.textStyle.fontWeight,
                fontFamily: axis.interactiveTooltip.textStyle.fontFamily,
                fontStyle: axis.interactiveTooltip.textStyle.fontStyle,
                inherit: axis.interactiveTooltip.textStyle.inherit,
                backgroundColor:
                    axis.interactiveTooltip.textStyle.backgroundColor,
                letterSpacing: axis.interactiveTooltip.textStyle.letterSpacing,
                wordSpacing: axis.interactiveTooltip.textStyle.wordSpacing,
                textBaseline: axis.interactiveTooltip.textStyle.textBaseline,
                height: axis.interactiveTooltip.textStyle.height,
                locale: axis.interactiveTooltip.textStyle.locale,
                foreground: axis.interactiveTooltip.textStyle.foreground,
                background: axis.interactiveTooltip.textStyle.background,
                shadows: axis.interactiveTooltip.textStyle.shadows,
                fontFeatures: axis.interactiveTooltip.textStyle.fontFeatures,
                decoration: axis.interactiveTooltip.textStyle.decoration,
                decorationColor:
                    axis.interactiveTooltip.textStyle.decorationColor,
                decorationStyle:
                    axis.interactiveTooltip.textStyle.decorationStyle,
                decorationThickness:
                    axis.interactiveTooltip.textStyle.decorationThickness,
                debugLabel: axis.interactiveTooltip.textStyle.debugLabel,
                fontFamilyFallback:
                    axis.interactiveTooltip.textStyle.fontFamilyFallback),
            0);
      }
    }
  }

  /// draw top axes tooltip
  void _drawTopAxesTooltip(
      Canvas canvas, Offset? position, Paint strokePaint, Paint fillPaint) {
    ChartAxis axis;
    ChartAxisRenderer axisRenderer;
    dynamic value;
    Size labelSize;
    Rect labelRect, validatedRect;
    RRect tooltipRect;
    const double padding = 10;
    Color? color;
    CrosshairRenderArgs crosshairEventArgs;
    for (int index = 0;
        index < chartState._chartAxis!._topAxesCount!.length;
        index++) {
      axisRenderer = chartState._chartAxis!._topAxesCount![index].axisRenderer;
      axis = axisRenderer._axis;
      if (_needToAddTooltip(axisRenderer)) {
        fillPaint.color = axis.interactiveTooltip.color != null
            ? axis.interactiveTooltip.color!
            : chartState._chartTheme!.crosshairBackgroundColor;
        strokePaint.color = axis.interactiveTooltip.borderColor != null
            ? axis.interactiveTooltip.borderColor!
            : chartState._chartTheme!.crosshairBackgroundColor;
        strokePaint.strokeWidth = axis.interactiveTooltip.borderWidth;
        value = _getXValue(axisRenderer, position!);
        if (chart.onCrosshairPositionChanging != null) {
          crosshairEventArgs = CrosshairRenderArgs(axisRenderer._axis, value,
              axisRenderer._name, axisRenderer._orientation);
          crosshairEventArgs.text = value.toString();
          crosshairEventArgs.lineColor = chart.crosshairBehavior.lineColor ??
              chartState._chartTheme!.crosshairLineColor;
          crosshairEventArgs.lineColor = color;
          chart.onCrosshairPositionChanging!(crosshairEventArgs);
          value = crosshairEventArgs.text;
          color = crosshairEventArgs.lineColor;
        }
        labelSize =
            _measureText(value.toString(), axis.interactiveTooltip.textStyle);
        labelRect = Rect.fromLTWH(
            position.dx - (labelSize.width / 2 + padding / 2),
            axisRenderer._bounds.top -
                (labelSize.height + padding) -
                axis.interactiveTooltip.arrowLength,
            labelSize.width + padding,
            labelSize.height + padding);
        labelRect = _validateRectBounds(labelRect, chartState._containerRect!);
        validatedRect = _validateRectXPosition(labelRect, chartState);
        backgroundPath.reset();
        tooltipRect = _getRoundedCornerRect(
            validatedRect, axis.interactiveTooltip.borderRadius);
        backgroundPath.addRRect(tooltipRect);

        _drawTooltipArrowhead(
            canvas,
            backgroundPath,
            fillPaint,
            strokePaint,
            position.dx,
            tooltipRect.bottom + axis.interactiveTooltip.arrowLength,
            (tooltipRect.right - tooltipRect.width / 2) +
                axis.interactiveTooltip.arrowWidth,
            tooltipRect.bottom,
            (tooltipRect.left + tooltipRect.width / 2) -
                axis.interactiveTooltip.arrowWidth,
            tooltipRect.bottom,
            position.dx,
            tooltipRect.bottom + axis.interactiveTooltip.arrowLength);
        _drawText(
            canvas,
            value.toString(),
            Offset(
                (tooltipRect.left + tooltipRect.width / 2) -
                    labelSize.width / 2,
                (tooltipRect.top + tooltipRect.height / 2) -
                    labelSize.height / 2),
            TextStyle(
                color: axis.interactiveTooltip.textStyle.color ??
                    chartState._chartTheme!.tooltipLabelColor,
                fontSize: axis.interactiveTooltip.textStyle.fontSize,
                fontWeight: axis.interactiveTooltip.textStyle.fontWeight,
                fontFamily: axis.interactiveTooltip.textStyle.fontFamily,
                fontStyle: axis.interactiveTooltip.textStyle.fontStyle,
                inherit: axis.interactiveTooltip.textStyle.inherit,
                backgroundColor:
                    axis.interactiveTooltip.textStyle.backgroundColor,
                letterSpacing: axis.interactiveTooltip.textStyle.letterSpacing,
                wordSpacing: axis.interactiveTooltip.textStyle.wordSpacing,
                textBaseline: axis.interactiveTooltip.textStyle.textBaseline,
                height: axis.interactiveTooltip.textStyle.height,
                locale: axis.interactiveTooltip.textStyle.locale,
                foreground: axis.interactiveTooltip.textStyle.foreground,
                background: axis.interactiveTooltip.textStyle.background,
                shadows: axis.interactiveTooltip.textStyle.shadows,
                fontFeatures: axis.interactiveTooltip.textStyle.fontFeatures,
                decoration: axis.interactiveTooltip.textStyle.decoration,
                decorationColor:
                    axis.interactiveTooltip.textStyle.decorationColor,
                decorationStyle:
                    axis.interactiveTooltip.textStyle.decorationStyle,
                decorationThickness:
                    axis.interactiveTooltip.textStyle.decorationThickness,
                debugLabel: axis.interactiveTooltip.textStyle.debugLabel,
                fontFamilyFallback:
                    axis.interactiveTooltip.textStyle.fontFamilyFallback),
            0);
      }
    }
  }

  /// draw left axes tooltip
  void _drawLeftAxesTooltip(
      Canvas canvas, Offset? position, Paint strokePaint, Paint fillPaint) {
    ChartAxis axis;
    ChartAxisRenderer axisRenderer;
    dynamic value;
    Size labelSize;
    Rect labelRect, validatedRect;
    RRect tooltipRect;
    const double padding = 10;
    Color? color;
    CrosshairRenderArgs crosshairEventArgs;
    for (int index = 0;
        index < chartState._chartAxis!._leftAxesCount!.length;
        index++) {
      axisRenderer = chartState._chartAxis!._leftAxesCount![index].axisRenderer;
      axis = axisRenderer._axis;
      if (_needToAddTooltip(axisRenderer)) {
        fillPaint.color = axis.interactiveTooltip.color ??
            chartState._chartTheme!.crosshairBackgroundColor;
        strokePaint.color = axis.interactiveTooltip.borderColor != null
            ? axis.interactiveTooltip.borderColor!
            : chartState._chartTheme!.crosshairBackgroundColor;
        strokePaint.strokeWidth = axis.interactiveTooltip.borderWidth;
        value = _getYValue(axisRenderer, position!);
        if (chart.onCrosshairPositionChanging != null) {
          crosshairEventArgs = CrosshairRenderArgs(
              axis, value, axisRenderer._name, axisRenderer._orientation);
          crosshairEventArgs.text = value.toString();
          crosshairEventArgs.lineColor = chart.crosshairBehavior.lineColor ??
              chartState._chartTheme!.crosshairLineColor;
          crosshairEventArgs.lineColor = color;
          chart.onCrosshairPositionChanging!(crosshairEventArgs);
          value = crosshairEventArgs.text;
          color = crosshairEventArgs.lineColor;
        }
        labelSize =
            _measureText(value.toString(), axis.interactiveTooltip.textStyle);
        labelRect = Rect.fromLTWH(
            axisRenderer._bounds.left -
                (labelSize.width + padding) -
                axis.interactiveTooltip.arrowLength,
            position.dy - (labelSize.height + padding) / 2,
            labelSize.width + padding,
            labelSize.height + padding);
        labelRect = _validateRectBounds(labelRect, chartState._containerRect!);
        validatedRect = _validateRectYPosition(labelRect, chartState);
        backgroundPath.reset();
        tooltipRect = _getRoundedCornerRect(
            validatedRect, axis.interactiveTooltip.borderRadius);

        backgroundPath.addRRect(tooltipRect);
        _drawTooltipArrowhead(
            canvas,
            backgroundPath,
            fillPaint,
            strokePaint,
            tooltipRect.right,
            tooltipRect.top +
                tooltipRect.height / 2 -
                axis.interactiveTooltip.arrowWidth,
            tooltipRect.right,
            tooltipRect.bottom -
                tooltipRect.height / 2 +
                axis.interactiveTooltip.arrowWidth,
            tooltipRect.right + axis.interactiveTooltip.arrowLength,
            position.dy,
            tooltipRect.right + axis.interactiveTooltip.arrowLength,
            position.dy);
        _drawText(
            canvas,
            value.toString(),
            Offset(
                (tooltipRect.left + tooltipRect.width / 2) -
                    labelSize.width / 2,
                (tooltipRect.top + tooltipRect.height / 2) -
                    labelSize.height / 2),
            TextStyle(
                color: axis.interactiveTooltip.textStyle.color ??
                    chartState._chartTheme!.tooltipLabelColor,
                fontSize: axis.interactiveTooltip.textStyle.fontSize,
                fontWeight: axis.interactiveTooltip.textStyle.fontWeight,
                fontFamily: axis.interactiveTooltip.textStyle.fontFamily,
                fontStyle: axis.interactiveTooltip.textStyle.fontStyle,
                inherit: axis.interactiveTooltip.textStyle.inherit,
                backgroundColor:
                    axis.interactiveTooltip.textStyle.backgroundColor,
                letterSpacing: axis.interactiveTooltip.textStyle.letterSpacing,
                wordSpacing: axis.interactiveTooltip.textStyle.wordSpacing,
                textBaseline: axis.interactiveTooltip.textStyle.textBaseline,
                height: axis.interactiveTooltip.textStyle.height,
                locale: axis.interactiveTooltip.textStyle.locale,
                foreground: axis.interactiveTooltip.textStyle.foreground,
                background: axis.interactiveTooltip.textStyle.background,
                shadows: axis.interactiveTooltip.textStyle.shadows,
                fontFeatures: axis.interactiveTooltip.textStyle.fontFeatures,
                decoration: axis.interactiveTooltip.textStyle.decoration,
                decorationColor:
                    axis.interactiveTooltip.textStyle.decorationColor,
                decorationStyle:
                    axis.interactiveTooltip.textStyle.decorationStyle,
                decorationThickness:
                    axis.interactiveTooltip.textStyle.decorationThickness,
                debugLabel: axis.interactiveTooltip.textStyle.debugLabel,
                fontFamilyFallback:
                    axis.interactiveTooltip.textStyle.fontFamilyFallback),
            0);
      }
    }
  }

  /// draw right axes tooltip
  void _drawRightAxesTooltip(
      Canvas canvas, Offset? position, Paint strokePaint, Paint fillPaint) {
    ChartAxis axis;
    ChartAxisRenderer axisRenderer;
    dynamic value;
    Size labelSize;
    Rect labelRect, validatedRect;
    CrosshairRenderArgs crosshairEventArgs;
    RRect tooltipRect;
    Color? color;
    const double padding = 10;
    for (int index = 0;
        index < chartState._chartAxis!._rightAxesCount!.length;
        index++) {
      axisRenderer =
          chartState._chartAxis!._rightAxesCount![index].axisRenderer;
      axis = axisRenderer._axis;
      if (_needToAddTooltip(axisRenderer)) {
        fillPaint.color = axis.interactiveTooltip.color ??
            chartState._chartTheme!.crosshairBackgroundColor;
        strokePaint.color = axis.interactiveTooltip.borderColor != null
            ? axis.interactiveTooltip.borderColor!
            : chartState._chartTheme!.crosshairBackgroundColor;
        strokePaint.strokeWidth = axis.interactiveTooltip.borderWidth;
        value = _getYValue(axisRenderer, position!);
        if (chart.onCrosshairPositionChanging != null) {
          crosshairEventArgs = CrosshairRenderArgs(
              axis, value, axisRenderer._name, axisRenderer._orientation);
          crosshairEventArgs.text = value.toString();
          crosshairEventArgs.lineColor = chart.crosshairBehavior.lineColor ??
              chartState._chartTheme!.crosshairLineColor;
          crosshairEventArgs.lineColor = color;
          chart.onCrosshairPositionChanging!(crosshairEventArgs);
          value = crosshairEventArgs.text;
          color = crosshairEventArgs.lineColor;
        }
        labelSize =
            _measureText(value.toString(), axis.interactiveTooltip.textStyle);
        labelRect = Rect.fromLTWH(
            axisRenderer._bounds.left + axis.interactiveTooltip.arrowLength,
            position.dy - (labelSize.height / 2 + padding / 2),
            labelSize.width + padding,
            labelSize.height + padding);
        labelRect = _validateRectBounds(labelRect, chartState._containerRect!);
        validatedRect = _validateRectYPosition(labelRect, chartState);
        backgroundPath.reset();
        tooltipRect = _getRoundedCornerRect(
            validatedRect, axis.interactiveTooltip.borderRadius);
        backgroundPath.addRRect(tooltipRect);
        _drawTooltipArrowhead(
            canvas,
            backgroundPath,
            fillPaint,
            strokePaint,
            tooltipRect.left,
            tooltipRect.top +
                tooltipRect.height / 2 -
                axis.interactiveTooltip.arrowWidth,
            tooltipRect.left,
            tooltipRect.bottom -
                tooltipRect.height / 2 +
                axis.interactiveTooltip.arrowWidth,
            tooltipRect.left - axis.interactiveTooltip.arrowLength,
            position.dy,
            tooltipRect.left - axis.interactiveTooltip.arrowLength,
            position.dy);
        _drawText(
            canvas,
            value.toString(),
            Offset(
                (tooltipRect.left + tooltipRect.width / 2) -
                    labelSize.width / 2,
                (tooltipRect.top + tooltipRect.height / 2) -
                    labelSize.height / 2),
            TextStyle(
                color: axis.interactiveTooltip.textStyle.color ??
                    chartState._chartTheme!.tooltipLabelColor,
                fontSize: axis.interactiveTooltip.textStyle.fontSize,
                fontWeight: axis.interactiveTooltip.textStyle.fontWeight,
                fontFamily: axis.interactiveTooltip.textStyle.fontFamily,
                fontStyle: axis.interactiveTooltip.textStyle.fontStyle,
                inherit: axis.interactiveTooltip.textStyle.inherit,
                backgroundColor:
                    axis.interactiveTooltip.textStyle.backgroundColor,
                letterSpacing: axis.interactiveTooltip.textStyle.letterSpacing,
                wordSpacing: axis.interactiveTooltip.textStyle.wordSpacing,
                textBaseline: axis.interactiveTooltip.textStyle.textBaseline,
                height: axis.interactiveTooltip.textStyle.height,
                locale: axis.interactiveTooltip.textStyle.locale,
                foreground: axis.interactiveTooltip.textStyle.foreground,
                background: axis.interactiveTooltip.textStyle.background,
                shadows: axis.interactiveTooltip.textStyle.shadows,
                fontFeatures: axis.interactiveTooltip.textStyle.fontFeatures,
                decoration: axis.interactiveTooltip.textStyle.decoration,
                decorationColor:
                    axis.interactiveTooltip.textStyle.decorationColor,
                decorationStyle:
                    axis.interactiveTooltip.textStyle.decorationStyle,
                decorationThickness:
                    axis.interactiveTooltip.textStyle.decorationThickness,
                debugLabel: axis.interactiveTooltip.textStyle.debugLabel,
                fontFamilyFallback:
                    axis.interactiveTooltip.textStyle.fontFamilyFallback),
            0);
      }
    }
  }

  /// To find the x value of crosshair
  dynamic _getXValue(ChartAxisRenderer axisRenderer, Offset position) {
    final dynamic value = _pointToXValue(
        chartState._requireInvertedAxis,
        axisRenderer,
        axisRenderer._bounds,
        position.dx -
            (chartState._chartAxis!._axisClipRect!.left +
                axisRenderer._axis.plotOffset),
        position.dy -
            (chartState._chartAxis!._axisClipRect!.top +
                axisRenderer._axis.plotOffset));
    return _getInteractiveTooltipLabel(value, axisRenderer);
  }

  /// To find the y value of crosshair
  dynamic _getYValue(ChartAxisRenderer axisRenderer, Offset position) {
    final num? value = _pointToYVal(
        chart,
        axisRenderer,
        axisRenderer._bounds,
        position.dx -
            (chartState._chartAxis!._axisClipRect!.left +
                axisRenderer._axis.plotOffset),
        position.dy -
            (chartState._chartAxis!._axisClipRect!.top +
                axisRenderer._axis.plotOffset));
    return _getInteractiveTooltipLabel(value, axisRenderer);
  }

  /// To add the tooltip for crosshair
  bool _needToAddTooltip(ChartAxisRenderer axisRenderer) {
    return axisRenderer._axis.interactiveTooltip.enable &&
        ((axisRenderer is! CategoryAxisRenderer &&
                axisRenderer._visibleLabels.isNotEmpty) ||
            (axisRenderer is CategoryAxisRenderer &&
                axisRenderer._labels.isNotEmpty));
  }
}
