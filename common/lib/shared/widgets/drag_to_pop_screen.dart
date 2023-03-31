import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DragToPopScreen extends StatefulWidget {
  const DragToPopScreen({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  _DragToPopScreenState createState() => _DragToPopScreenState();
}

class _DragToPopScreenState extends State<DragToPopScreen> {
  double? initialPositionY = 0;

  double? currentPositionY = 0;

  double positionYDelta = 0;

  double opacity = 0;

  double disposeLimit = 200;

  late Duration animationDuration;

  double scale = 1.0;
  double? beforeScale;

  @override
  Widget build(BuildContext context) {
    final sizeWidth = positionYDelta > 40 ? 40 : positionYDelta;
    return GestureDetector(
        onVerticalDragStart: (details) => _startVerticalDrag(details),
        onVerticalDragUpdate: (details) => _whileVerticalDrag(details),
        onVerticalDragEnd: (details) => _endVerticalDrag(details),
        onScaleStart: _startScale,
        onScaleUpdate: _updateScale,
        onScaleEnd: _endScale,
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: context.theme.scaffoldBackgroundColor.withOpacity(opacity),
            constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height,
            ),
            // color: context.theme.dialogBackgroundColor,

            child: Stack(children: <Widget>[
              AnimatedPositioned(
                  duration: animationDuration,
                  curve: Curves.fastOutSlowIn,
                  top: 0 + positionYDelta,
                  bottom: 0 - positionYDelta,
                  left: 0,
                  right: 0,
                  child: Opacity(
                    opacity: opacity,
                    child: Center(
                        child: Transform.scale(
                      scale: 1 - sizeWidth / 600,
                      child: widget.child,
                    )),
                  ))
            ])));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    animationDuration = Duration.zero;
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          opacity = 1;
        }));

    super.initState();
  }

  setOpacity() {
    final double tmp = positionYDelta < 0
        ? 1 - ((positionYDelta / 800) * -1)
        : 1 - (positionYDelta / 800);

    if (tmp > 1) {
      opacity = 1;
    } else if (tmp < 0) {
      opacity = 0;
    } else {
      opacity = tmp;
    }

    if (positionYDelta > disposeLimit || positionYDelta < -disposeLimit) {
      opacity = 0.0;
    }
  }

  void updateScale(double newScale) {
    setState(() {
      scale = newScale;
    });
  }

  _endScale(ScaleEndDetails details) {
    if (scale < 1.0) {
      // goes to the original size
      updateScale(1.0);
    }
    beforeScale = null;
  }

  _endVerticalDrag(DragEndDetails details) {
    if (positionYDelta > disposeLimit || positionYDelta < -disposeLimit) {
      // Navigator.of(context).pop();
      Get.back();
    } else {
      setState(() {
        animationDuration = const Duration(milliseconds: 300);
        opacity = 1;
        positionYDelta = 0;
      });

      Future.delayed(animationDuration).then((_) {
        setState(() {
          animationDuration = Duration.zero;
        });
      });
    }
  }

  _startScale(ScaleStartDetails details) {
    beforeScale = scale;
  }

  void _startVerticalDrag(details) {
    setState(() {
      initialPositionY = details.globalPosition.dy;
    });
  }

  _updateScale(ScaleUpdateDetails details) {
    scale = beforeScale! * details.scale;
    updateScale(scale);
  }

  void _whileVerticalDrag(details) {
    setState(() {
      currentPositionY = details.globalPosition.dy;
      positionYDelta = currentPositionY! - initialPositionY!;
      setOpacity();
    });
  }
}
