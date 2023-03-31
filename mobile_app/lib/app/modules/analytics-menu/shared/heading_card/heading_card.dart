import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HeadingCardWidget extends StatelessWidget {
  const HeadingCardWidget(
      {Key? key,
      required this.title,
      required this.description,
      this.width = 138,
      this.color,
      this.hasGraph = false,
      this.graphVal})
      : super(key: key);
  final num? width;
  final String title;
  final String description;
  final Color? color;
  final bool hasGraph;
  final double? graphVal;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: context.theme.backgroundColor,
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
      height: ScreenUtil().setWidth(103),
      width: ScreenUtil().setWidth(width!),
      child: Column(
        crossAxisAlignment:
            hasGraph ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: context.theme.cardColor)),
          const SizedBox(height: 16),
          Row(
              mainAxisAlignment: hasGraph
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [
                Text(description,
                    style: TextStyle(
                        color:
                            color ?? context.theme.textTheme.bodyText1!.color,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                if (graphVal != null)
                  IrisCircularTraderPercent(
                    value: graphVal! * 100,
                    label: '',
                    size: 50,
                    showNa: false,
                  )
              ])
        ],
      ),
    );
  }
}

class IrisCircularTraderPercent extends StatelessWidget {
  const IrisCircularTraderPercent({
    Key? key,
    required this.value,
    required this.showNa,
    this.label,
    this.size = 150.0,
  }) : super(key: key);
  final double value;
  final String? label;
  final double size;
  final bool showNa;

  Color get percentageColor {
    if (value <= 35) return Colors.red;
    if (value > 35 && value < 70) return Colors.yellow;
    if (value >= 70) return Colors.green;
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return IrisCircularGraph(
      value: value,
      showNa: showNa,
      appearance: CircularSliderAppearance(
        trackWidth: 2,
        size: size,
        progressBarWidth: size / 10,
        shadowWidth: 35,
        handlerSize: size / 10 / 5.0,
        bottomLabelText: label,
        mainLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: size / 5,
          color: context.theme.colorScheme.secondary,
        ),
        customColors: CustomSliderColors(
          trackColor: context.theme.colorScheme.secondary.withOpacity(.3),
          shadowMaxOpacity: .05,
          shadowColor: percentageColor,
          progressBarColor: percentageColor,
          // progressBarColors: [
          // if (value > 50) ...[Colors.green[800]!, Colors.greenAccent],
          // if (value < 80) Colors.yellow,
          // if (value < 35) ...[Colors.red[800]!, Colors.redAccent],
          // ],
        ),
      ),
    );
  }
}

class IrisCircularGraph extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final CircularSliderAppearance appearance;
  final Widget Function(double percentage)? innerWidget;
  final bool showNa;

  double get angle {
    return valueToAngle(value, min, max, appearance.angleRange);
  }

  const IrisCircularGraph(
      {Key? key,
      this.value = 50,
      this.min = 0,
      this.max = 100,
      required this.appearance,
      required this.showNa,
      this.innerWidget})
      : assert(min <= max),
        assert(value >= min && value <= max),
        super(key: key);
  @override
  _IrisCircularGraphState createState() => _IrisCircularGraphState();
}

class _IrisCircularGraphState extends State<IrisCircularGraph>
    with SingleTickerProviderStateMixin {
  _CurvePainter? _painter;
  double? _oldWidgetAngle;
  double? _oldWidgetValue;
  double? _currentAngle;
  late double _startAngle;
  late double _angleRange;
  double? _selectedAngle;
  double? _rotation;

  ValueChangedAnimationController? _animationManager;
  late int _appearanceHashCode;

  @override
  void initState() {
    super.initState();
    _startAngle = widget.appearance.startAngle;
    _angleRange = widget.appearance.angleRange;
    _appearanceHashCode = widget.appearance.hashCode;

    if (!widget.appearance.animationEnabled) {
      return;
    }

    _animate();
  }

  @override
  void didUpdateWidget(IrisCircularGraph oldWidget) {
    if (oldWidget.angle != widget.angle &&
        _currentAngle?.toStringAsFixed(4) != widget.angle.toStringAsFixed(4)) {
      _animate();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _animate() {
    if (!widget.appearance.animationEnabled) {
      _setupPainter();

      return;
    }
    _animationManager ??= ValueChangedAnimationController(
      tickerProvider: this,
      minValue: widget.min,
      maxValue: widget.max,
      durationMultiplier: widget.appearance.animDurationMultiplier,
    );

    _animationManager!.animate(
        value: widget.value,
        angle: widget.angle,
        oldAngle: _oldWidgetAngle,
        oldValue: _oldWidgetValue,
        valueChangedAnimation: (double anim, bool animationCompleted) {
          setState(() {
            if (!animationCompleted) {
              _currentAngle = anim;
              _setupPainter();
            }
          });
        });
  }

  @override
  void didChangeDependencies() {
    if (_painter == null || _appearanceHashCode != widget.appearance.hashCode) {
      _appearanceHashCode = widget.appearance.hashCode;
      _setupPainter();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = Size(widget.appearance.size, widget.appearance.size);
    if (_rotation != null) {
      return Transform(
          transform: Matrix4.identity()
            ..rotateZ((_rotation!) * 5 * math.pi / 6),
          alignment: FractionalOffset.center,
          child: _buildPainter(size: size));
    } else {
      return _buildPainter(size: size);
    }
  }

  @override
  void dispose() {
    _animationManager?.dispose();
    super.dispose();
  }

  void _setupPainter({bool counterClockwise = false}) {
    var defaultAngle = _currentAngle ?? widget.angle;
    if (_oldWidgetAngle != null) {
      if (_oldWidgetAngle != widget.angle) {
        _selectedAngle = null;
        defaultAngle = widget.angle;
      }
    }

    _currentAngle = calculateAngle(
        startAngle: _startAngle,
        angleRange: _angleRange,
        selectedAngle: _selectedAngle,
        defaultAngle: defaultAngle,
        counterClockwise: counterClockwise);

    _painter = _CurvePainter(
        startAngle: _startAngle,
        angleRange: _angleRange,
        angle: _currentAngle! < 0.5 ? 0.5 : _currentAngle!,
        appearance: widget.appearance);
    _oldWidgetAngle = widget.angle;
    _oldWidgetValue = widget.value;
  }

  Widget _buildPainter({required Size size}) {
    return CustomPaint(
        painter: _painter,
        child: SizedBox(
            width: size.width,
            height: size.height,
            child: _buildChildWidget()));
  }

  Widget? _buildChildWidget() {
    final value =
        angleToValue(_currentAngle!, widget.min, widget.max, _angleRange);
    final childWidget = widget.innerWidget != null
        ? widget.innerWidget!(value)
        : SliderLabel(
            value: value,
            appearance: widget.appearance,
            showNa: widget.showNa,
          );
    return childWidget;
  }
}

double degreeToRadians(double degree) {
  return (math.pi / 180) * degree;
}

double radiansToDegrees(double radians) {
  return radians * (180 / math.pi);
}

Offset degreesToCoordinates(Offset center, double degrees, double radius) {
  return radiansToCoordinates(center, degreeToRadians(degrees), radius);
}

Offset radiansToCoordinates(Offset center, double radians, double radius) {
  final dx = center.dx + radius * math.cos(radians);
  final dy = center.dy + radius * math.sin(radians);
  return Offset(dx, dy);
}

double coordinatesToRadians(Offset center, Offset coords) {
  final a = coords.dx - center.dx;
  final b = center.dy - coords.dy;
  return radiansNormalized(math.atan2(b, a));
}

double radiansNormalized(double radians) {
  final normalized = radians < 0 ? -radians : 2 * math.pi - radians;
  return normalized;
}

bool isPointInsideCircle(Offset point, Offset center, double rradius) {
  final radius = rradius * 1.2;
  return point.dx < (center.dx + radius) &&
      point.dx > (center.dx - radius) &&
      point.dy < (center.dy + radius) &&
      point.dy > (center.dy - radius);
}

bool isPointAlongCircle(
    Offset point, Offset center, double radius, double width) {
  final dx = math.pow(point.dx - center.dx, 2);
  final dy = math.pow(point.dy - center.dy, 2);
  final distance = math.sqrt(dx + dy);
  return (distance - radius).abs() < width;
}

double calculateRawAngle(
    {required double startAngle,
    required double angleRange,
    required double selectedAngle,
    bool counterClockwise = false}) {
  final angle = radiansToDegrees(selectedAngle);

  double calcAngle = 0.0;
  if (!counterClockwise) {
    if (angle >= startAngle && angle <= 360.0) {
      calcAngle = angle - startAngle;
    } else {
      calcAngle = 360.0 - startAngle + angle;
    }
  } else {
    if (angle <= startAngle) {
      calcAngle = startAngle - angle;
    } else {
      calcAngle = 360.0 - angle + startAngle;
    }
  }
  return calcAngle;
}

double calculateAngle(
    {required double startAngle,
    required double angleRange,
    required selectedAngle,
    required defaultAngle,
    bool counterClockwise = false}) {
  if (selectedAngle == null) {
    return defaultAngle;
  }

  final calcAngle = calculateRawAngle(
      startAngle: startAngle,
      angleRange: angleRange,
      selectedAngle: selectedAngle,
      counterClockwise: counterClockwise);

  if (calcAngle - angleRange > (360.0 - angleRange) * 0.5) {
    return 0.0;
  } else if (calcAngle > angleRange) {
    return angleRange;
  }

  return calcAngle;
}

bool isAngleWithinRange(
    {required double startAngle,
    required double angleRange,
    required touchAngle,
    required previousAngle,
    bool counterClockwise = false}) {
  final calcAngle = calculateRawAngle(
      startAngle: startAngle,
      angleRange: angleRange,
      selectedAngle: touchAngle,
      counterClockwise: counterClockwise);

  if (calcAngle > angleRange) {
    return false;
  }
  return true;
}

int valueToDuration(double value, double previous, double min, double max) {
  final divider = (max - min) / 100;
  return divider != 0 ? (value - previous).abs() ~/ divider * 15 : 0;
}

double valueToPercentage(double value, double min, double max) {
  return value / ((max - min) / 100);
}

double valueToAngle(double value, double min, double max, double angleRange) {
  return percentageToAngle(
      valueToPercentage(value - min, min, max), angleRange);
}

double percentageToValue(double percentage, double min, double max) {
  return ((max - min) / 100) * percentage + min;
}

double percentageToAngle(double percentage, double angleRange) {
  final step = angleRange / 100;
  if (percentage > 100) {
    return angleRange;
  } else if (percentage < 0) {
    return 0.5;
  }
  return percentage * step;
}

double angleToValue(double angle, double min, double max, double angleRange) {
  return percentageToValue(angleToPercentage(angle, angleRange), min, max);
}

double angleToPercentage(double angle, double angleRange) {
  final step = angleRange / 100;
  if (angle > angleRange) {
    return 100;
  } else if (angle < 0.5) {
    return 0;
  }
  return angle / step;
}

class _CurvePainter extends CustomPainter {
  final double angle;
  final CircularSliderAppearance appearance;
  final double startAngle;
  final double angleRange;

  Offset? handler;
  Offset? center;
  late double radius;

  _CurvePainter(
      {required this.appearance,
      this.angle = 30,
      required this.startAngle,
      required this.angleRange});

  @override
  void paint(Canvas canvas, Size size) {
    radius = math.min(size.width / 2, size.height / 2) -
        appearance.progressBarWidth * 0.5;
    center = Offset(size.width / 2, size.height / 2);

    final progressBarRect = Rect.fromLTWH(0.0, 0.0, size.width, size.width);

    Paint trackPaint;
    if (appearance.trackColors != null) {
      final trackGradient = SweepGradient(
        startAngle: degreeToRadians(appearance.trackGradientStartAngle),
        endAngle: degreeToRadians(appearance.trackGradientStopAngle),
        tileMode: TileMode.mirror,
        colors: appearance.trackColors!,
      );
      trackPaint = Paint()
        ..shader = trackGradient.createShader(progressBarRect)
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = appearance.trackWidth;
    } else {
      trackPaint = Paint()
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = appearance.trackWidth
        ..color = appearance.trackColor;
    }
    drawCircularArc(
      canvas: canvas,
      size: size,
      paint: trackPaint,
      ignoreAngle: true,
    );

    if (!appearance.hideShadow) {
      drawShadow(canvas: canvas, size: size);
    }

    final currentAngle = appearance.counterClockwise ? -angle : angle;
    final dynamicGradient = appearance.dynamicGradient;
    final gradientRotationAngle = dynamicGradient
        ? appearance.counterClockwise
            ? startAngle + 10.0
            : startAngle - 10.0
        : 0.0;
    final GradientRotation rotation =
        GradientRotation(degreeToRadians(gradientRotationAngle));

    final gradientStartAngle = dynamicGradient
        ? appearance.counterClockwise
            ? 360.0 - currentAngle.abs()
            : 0.0
        : appearance.gradientStartAngle;
    final gradientEndAngle = dynamicGradient
        ? appearance.counterClockwise
            ? 360.0
            : currentAngle.abs()
        : appearance.gradientStopAngle;
    final colors = dynamicGradient && appearance.counterClockwise
        ? appearance.progressBarColors.reversed.toList()
        : appearance.progressBarColors;

    final progressBarGradient = kIsWeb
        ? LinearGradient(
            tileMode: TileMode.mirror,
            colors: colors,
          )
        : SweepGradient(
            transform: rotation,
            startAngle: degreeToRadians(gradientStartAngle),
            endAngle: degreeToRadians(gradientEndAngle),
            tileMode: TileMode.mirror,
            colors: colors,
          );

    final progressBarPaint = Paint()
      ..shader = progressBarGradient.createShader(progressBarRect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = appearance.progressBarWidth;
    drawCircularArc(canvas: canvas, size: size, paint: progressBarPaint);

    final dotPaint = Paint()..color = appearance.dotColor;

    final Offset handler = degreesToCoordinates(
        center!, -math.pi / 2 + startAngle + currentAngle + 1.5, radius);
    canvas.drawCircle(handler, appearance.handlerSize, dotPaint);
  }

  drawCircularArc({
    required Canvas canvas,
    required Size size,
    required Paint paint,
    bool ignoreAngle = false,
  }) {
    final double angleValue = ignoreAngle ? 0 : (angleRange - angle);
    final range = appearance.counterClockwise ? -angleRange : angleRange;
    final currentAngle = appearance.counterClockwise ? angleValue : -angleValue;
    canvas.drawArc(
        Rect.fromCircle(center: center!, radius: radius),
        degreeToRadians(startAngle),
        degreeToRadians(range + currentAngle),
        false,
        paint);
  }

  drawShadow({required Canvas canvas, required Size size}) {
    final shadowStep = appearance.shadowStep != null
        ? appearance.shadowStep!
        : math.max(
            1, (appearance.shadowWidth - appearance.progressBarWidth) ~/ 10);
    final maxOpacity = math.min(1.0, appearance.shadowMaxOpacity);
    final repetitions = math.max(1,
        (appearance.shadowWidth - appearance.progressBarWidth) ~/ shadowStep);
    final opacityStep = maxOpacity / repetitions;
    final shadowPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (int i = 1; i <= repetitions; i++) {
      shadowPaint.strokeWidth = appearance.progressBarWidth + i * shadowStep;
      shadowPaint.color = appearance.shadowColor
          .withOpacity(maxOpacity - (opacityStep * (i - 1)));
      drawCircularArc(canvas: canvas, size: size, paint: shadowPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class SliderLabel extends StatelessWidget {
  final double value;
  final bool showNa;
  final CircularSliderAppearance appearance;
  const SliderLabel(
      {Key? key,
      required this.value,
      required this.appearance,
      required this.showNa})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final label = value.ceil().toInt();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showNa)
          Text('N/A', style: appearance.mainLabelStyle)
        else
          Text('$label%', style: appearance.mainLabelStyle),
        if (appearance.bottomLabelText != null)
          Text(
            appearance.bottomLabelText!,
            style: appearance.infoBottomLabelStyle,
          )
      ],
    );
  }
}

typedef ValueChangeAnimation = void Function(
    double animation, bool animationFinished);

class ValueChangedAnimationController {
  final TickerProvider tickerProvider;
  final double durationMultiplier;
  final double minValue;
  final double maxValue;

  ValueChangedAnimationController({
    required this.tickerProvider,
    required this.minValue,
    required this.maxValue,
    this.durationMultiplier = 1.0,
  });

  late Animation<double> _animation;
  late final AnimationController _animController =
      AnimationController(vsync: tickerProvider);
  bool _animationCompleted = false;

  void animate(
      {required double value,
      double? oldValue,
      required double angle,
      double? oldAngle,
      required ValueChangeAnimation valueChangedAnimation}) {
    _animationCompleted = false;

    final duration = (durationMultiplier *
            valueToDuration(value, oldValue ?? minValue, minValue, maxValue))
        .toInt();

    _animController.duration = Duration(milliseconds: duration);

    final curvedAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );

    _animation =
        Tween<double>(begin: oldAngle ?? 0, end: angle).animate(curvedAnimation)
          ..addListener(() {
            valueChangedAnimation(_animation.value, _animationCompleted);
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationCompleted = true;

              _animController.reset();
            }
          });
    _animController.forward();
  }

  void dispose() {
    _animController.dispose();
  }
}

class CircularSliderAppearance {
  final double size;
  final double startAngle;
  final double angleRange;
  final bool animationEnabled;
  final bool counterClockwise;
  final double animDurationMultiplier;
  final CustomSliderColors customColors;
  final TextStyle mainLabelStyle;
  final TextStyle? bottomLabelStyle;
  final String? bottomLabelText;
  final double trackWidth;
  final double progressBarWidth;
  final double handlerSize;
  final double shadowWidth;

  List<Color> get _customProgressBarColors {
    if (customColors.progressBarColors != null) {
      return customColors.progressBarColors!;
    } else if (customColors.progressBarColor != null) {
      return [customColors.progressBarColor!, customColors.progressBarColor!];
    } else {
      return [];
    }
  }

  Color get trackColor => customColors.trackColor;
  List<Color>? get trackColors => customColors.trackColors;
  List<Color> get progressBarColors => _customProgressBarColors;
  double get gradientStartAngle => customColors.gradientStartAngle;
  double get gradientStopAngle => customColors.gradientEndAngle;
  double get trackGradientStartAngle => customColors.trackGradientStartAngle;
  double get trackGradientStopAngle => customColors.trackGradientEndAngle;
  bool get dynamicGradient => customColors.dynamicGradient;
  bool get hideShadow => customColors.hideShadow;
  Color get shadowColor => customColors.shadowColor;
  double get shadowMaxOpacity => customColors.shadowMaxOpacity;
  double? get shadowStep => customColors.shadowStep;
  Color get dotColor => customColors.dotColor;

  TextStyle get infoBottomLabelStyle {
    return bottomLabelStyle ??
        TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: size / 10.0,
          color: Colors.grey,
        );
  }

  const CircularSliderAppearance({
    required this.trackWidth,
    required this.progressBarWidth,
    required this.handlerSize,
    required this.shadowWidth,
    required this.mainLabelStyle,
    required this.customColors,
    this.bottomLabelStyle,
    this.bottomLabelText,
    this.size = 150.0,
    this.startAngle = 150.0,
    this.angleRange = 240.0,
    this.animationEnabled = true,
    this.counterClockwise = false,
    this.animDurationMultiplier = 1.0,
  });
}

class CustomSliderColors {
  final Color trackColor;
  final Color? progressBarColor;
  final List<Color>? progressBarColors;
  final double gradientStartAngle;
  final double gradientEndAngle;
  final List<Color>? trackColors;
  final double trackGradientStartAngle;
  final double trackGradientEndAngle;
  final bool dynamicGradient;
  final bool hideShadow;
  final Color shadowColor;
  final double shadowMaxOpacity;
  final double? shadowStep;
  final Color dotColor;

  CustomSliderColors({
    this.trackColor = Colors.grey,
    this.progressBarColor,
    this.progressBarColors,
    this.gradientStartAngle = 0.0,
    this.gradientEndAngle = 180.0,
    this.trackColors,
    this.trackGradientStartAngle = 0.0,
    this.trackGradientEndAngle = 180.0,
    this.hideShadow = false,
    this.shadowColor = const Color.fromRGBO(44, 87, 192, 1.0),
    this.shadowMaxOpacity = 0.05,
    this.shadowStep,
    this.dotColor = Colors.white,
    this.dynamicGradient = false,
  });
}
