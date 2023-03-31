import 'package:flutter/material.dart';

Future<T> overlayLoader<T>({
  required BuildContext context,
  required Future<T> Function() asyncFunction,
  Color loaderColor = Colors.green,
  Color opacityColor = Colors.black,
  num opacity = .5,
}) async {
  final navigatorState = Navigator.of(context, rootNavigator: true);
  final overlayState = navigatorState.overlay!;

  final OverlayEntry overlayEntryOpacity = OverlayEntry(builder: (context) {
    return Opacity(
        opacity: opacity as double,
        child: Container(
          color: opacityColor,
        ));
  });
  final OverlayEntry overlayEntryLoader = OverlayEntry(builder: (context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: Loader3(
        color: loaderColor,
      ),
    );
  });
  overlayState.insert(overlayEntryOpacity);
  overlayState.insert(overlayEntryLoader);

  T data;

  try {
    data = await asyncFunction();
  } catch (err) {
    overlayEntryLoader.remove();
    overlayEntryOpacity.remove();
    rethrow;
  }

  overlayEntryLoader.remove();
  overlayEntryOpacity.remove();
  return data;
}

class Loader3 extends StatefulWidget {
  final Color? color;

  const Loader3({Key? key, this.color}) : super(key: key);

  @override
  _Loader3State createState() => _Loader3State();
}

class _Loader3State extends State<Loader3> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationRotation;
  late Animation<double> _animationRadiousOut;
  late Animation<double> _animationRadiousIn;
  final double _initialRadious = 20.0;
  double _radious = 20.0;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _animationRadiousIn = Tween<double>(begin: 1.0, end: 0.5).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.5, curve: Curves.linear)));

    _animationRadiousOut = Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.5, 1.0, curve: Curves.linear)));

    _animationRotation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 1.0, curve: Curves.linear)));

    _controller.addListener(() {
      setState(() {
        if (_controller.value >= 0.0 && _controller.value <= 0.5) {
          _radious = _initialRadious * _animationRadiousIn.value;
        } else if (_controller.value >= 0.5 && _controller.value <= 1.0) {
          _radious = _initialRadious * _animationRadiousOut.value;
        }
      });
    });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RotationTransition(
      turns: _animationRotation,
      child: SizedBox(
        width: 50.0,
        height: 50.0,
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(0, _radious),
              child: Dot(
                radious: 10.0,
                color: widget.color,
              ),
            ),
            Transform.translate(
              offset: Offset(_radious, 0),
              child: Dot(
                radious: 10.0,
                color: widget.color,
              ),
            ),
            Transform.translate(
              offset: Offset(-_radious, 0),
              child: Dot(
                radious: 10.0,
                color: widget.color,
              ),
            ),
            Transform.translate(
              offset: Offset(0, -_radious),
              child: Dot(
                radious: 10.0,
                color: widget.color,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class Dot extends StatelessWidget {
  final double? radious;
  final Color? color;

  const Dot({Key? key, this.radious, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: radious,
        height: radious,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
