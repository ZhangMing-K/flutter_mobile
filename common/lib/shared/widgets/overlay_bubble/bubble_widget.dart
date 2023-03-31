import 'package:flutter/material.dart';

import 'canvas_touch_detector.dart';
import 'touchy_canvas.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    Key? key,
    required this.link,
    required this.offset,
    required this.child,
  }) : super(key: key);

  final LayerLink link;
  final Offset offset;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CompositedTransformFollower(
      offset: offset,
      link: link,
      child: child,
    );
  }
}

class OverlayBubble extends StatefulWidget {
  const OverlayBubble({Key? key, required this.child, required this.onTap})
      : super(key: key);
  final Widget child;
  final VoidCallback onTap;

  @override
  _OverlayBubbleState createState() => _OverlayBubbleState();
}

class _OverlayBubbleState extends State<OverlayBubble> {
  var _isShowed = false;

  final LayerLink layerLink = LayerLink();
  OverlayEntry? overlayEntry;
  Offset? indicatorOffset;

  Offset getIndicatorOffset(Offset dragOffset) {
    final double x = dragOffset.dx - 60;
    final double y = dragOffset.dy - 50;
    return Offset(x, y);
  }

  void showIndicator(DragStartDetails details) {
    _isShowed = true;
    indicatorOffset = getIndicatorOffset(details.localPosition);
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Indicator(
          offset: indicatorOffset!,
          link: layerLink,
          child: BubbleWidget(
            onClick: widget.onTap,
            text: 'See article',
            onTapOut: hideIndicator,
          ),
        );
      },
    );
    Overlay.of(context)?.insert(overlayEntry!);
  }

  void toggle(DragStartDetails details) {
    _isShowed ? hideIndicator() : showIndicator(details);
  }

  void hideIndicator() {
    _isShowed = false;
    overlayEntry?.remove();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: GestureDetector(
        onPanStart: toggle,
        child: widget.child,
      ),
    );
  }
}

class BubbleWidget extends StatelessWidget {
  final double padding;
  final double width;
  final double height;
  final Color color;
  final PaintingStyle style;
  final double stokeWidth;
  final double radius;
  final double arrowMargin;
  final double arrowHeight;
  final double arrowWidth;
  final String text;
  final VoidCallback onTapOut;
  final VoidCallback onClick;

  const BubbleWidget({
    Key? key,
    this.padding = 0,
    this.width = 120,
    this.height = 50,
    this.color = Colors.grey,
    this.style = PaintingStyle.fill,
    this.stokeWidth = 1,
    this.radius = 10,
    this.arrowMargin = 10,
    this.arrowHeight = 10,
    this.arrowWidth = 10,
    required this.text,
    required this.onTapOut,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CanvasTouchDetector(builder: (context) {
      return CustomPaint(
        child: GestureDetector(
          // behavior: HitTestBehavior.translucent,
          onTap: onTapOut,
          child: Container(
              // color: Colors.red,
              ),
        ),
        painter: BubblePainter(
          width,
          height,
          color,
          style,
          stokeWidth,
          radius,
          arrowMargin,
          arrowHeight,
          arrowWidth,
          text,
          context,
          onClick,
        ),
      );
    });
  }
}

class BubblePainter extends CustomPainter {
  final double width;
  final double height;
  final Color color;
  final PaintingStyle style;
  final double stokeWidth;
  final double radius;
  final double arrowMargin;
  final double arrowHeight;
  final double arrowWidth;
  final String text;
  final BuildContext context;
  final VoidCallback? onClick;

  BubblePainter(
    this.width,
    this.height,
    this.color,
    this.style,
    this.stokeWidth,
    this.radius,
    this.arrowMargin,
    this.arrowHeight,
    this.arrowWidth,
    this.text,
    this.context,
    this.onClick,
  );

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint
      ..style = style
      ..color = color
      ..strokeWidth = stokeWidth;

    canvas.save();
    _drawBottoms(canvas, paint);
    canvas.restore();
  }

  void _drawBottoms(Canvas canv, Paint paint) {
    var canvas = TouchyCanvas(context, canv);
    Path path = Path();
    Path rectPath = Path()
      ..addRRect(
          RRect.fromLTRBXY(0, 0, width, height - arrowHeight, radius, radius));

    path.relativeMoveTo(width / 2 - arrowWidth / 2, height - arrowHeight);

    path.relativeLineTo(arrowWidth / 2, arrowHeight);
    path.relativeLineTo(arrowWidth / 2, -arrowHeight);

    path.close();

    canvas.drawPath(Path.combine(PathOperation.union, path, rectPath), paint,
        onTapDown: (_) {
      onClick?.call();
    });

    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );

    final textSpan = TextSpan(
      text: '$text ',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0);
    const offset = Offset(12, 10);

    textPainter.paint(canv, offset);

    const icon = Icons.chevron_right;
    final textSpanIcon = TextSpan(
      style: textStyle.copyWith(fontFamily: icon.fontFamily, fontSize: 18),
      text: String.fromCharCode(icon.codePoint),
    );
    final textPainterIcon = TextPainter(
      text: textSpanIcon,
      textDirection: TextDirection.ltr,
    );
    textPainterIcon.layout(
      minWidth: 0,
    );
    const offsetIcon = Offset(92, 10);

    textPainterIcon.paint(canv, offsetIcon);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
