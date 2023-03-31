import 'package:flutter/material.dart';

class IrisBounceEffect extends StatefulWidget {
  const IrisBounceEffect({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 120),
    this.curve = Curves.easeInCubic,
    this.endScale = 0.5,
  }) : super(key: key);

  final Widget child;
  final double endScale;
  final Duration duration;
  final Curve curve;

  @override
  _IrisBounceEffectState createState() => _IrisBounceEffectState();
}

class _IrisBounceEffectState extends State<IrisBounceEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  final double _scrollTreshold = 0.2;

  bool _isScroll = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: 1, end: widget.endScale).animate(
      CurvedAnimation(
        curve: Curves.linear,
        parent: _controller,
      ),
    )
      ..addListener(_listener)
      ..addStatusListener(_statusListener);
    super.initState();
  }

  void _listener() {
    setState(() {});
  }

  void _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) _controller.reverse();
  }

  @override
  void dispose() {
    _animation.removeListener(_listener);
    _animation.removeStatusListener(_statusListener);
    _controller.dispose();
    super.dispose();
  }

  void onPointMove(PointerMoveEvent event) {
    if (event.delta.dy.abs() > _scrollTreshold ||
        event.delta.dy.abs() > _scrollTreshold) {
      _isScroll = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        _isScroll = false;
      },
      onPointerMove: onPointMove,
      onPointerUp: (_) {
        if (!_isScroll) {
          _controller.forward();
        }
      },
      child: Transform.scale(
        scale: _animation.value,
        child: widget.child,
      ),
    );
  }
}
