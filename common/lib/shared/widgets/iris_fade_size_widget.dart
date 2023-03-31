import 'package:flutter/material.dart';

class IrisFadeSize extends StatefulWidget {
  final Widget child;

  final bool visible;
  final Duration duration;
  const IrisFadeSize(
      {Key? key,
      required this.child,
      required this.visible,
      this.duration = const Duration(milliseconds: 400)})
      : super(key: key);

  @override
  _IrisFadeSizeState createState() => _IrisFadeSizeState();
}

class _IrisFadeSizeState extends State<IrisFadeSize>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
      child: SizeTransition(
        axisAlignment: 1,
        sizeFactor: CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOut,
        ),
        child: widget.child,
      ),
    );
  }

  @override
  void didUpdateWidget(IrisFadeSize oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!oldWidget.visible && widget.visible) {
      _animationController.forward();
    } else if (oldWidget.visible && !widget.visible) {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      value: widget.visible ? 1.0 : 0.0,
      duration: widget.duration,
      vsync: this,
    );

    super.initState();
  }
}
