import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class VideoWatchWidget extends StatelessWidget {
  const VideoWatchWidget(
      {Key? key,
      required this.child,
      this.topContainer,
      this.statContainer,
      this.backgroundColor = Colors.white,
      this.backgroundIsTransparent = true,
      this.onClose,
      this.disposeLevel})
      : super(key: key);

  final Widget child;
  final Widget? topContainer;
  final Widget? statContainer;
  final Color backgroundColor;
  final bool backgroundIsTransparent;
  final DisposeLevel? disposeLevel;
  final Function? onClose;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: child,
    );
  }
}

class VideoWatchPage extends StatefulWidget {
  const VideoWatchPage(
      {Key? key,
      required this.child,
      required this.url,
      this.topContainer,
      this.statContainer,
      this.onClose,
      this.backgroundColor, // black
      this.backgroundIsTransparent = true,
      this.disposeLevel = DisposeLevel.Low})
      : super(key: key);

  final Widget child;
  final Widget? topContainer;
  final Widget? statContainer;
  final String url;
  final Color? backgroundColor;
  final bool backgroundIsTransparent;
  final DisposeLevel disposeLevel;
  final Function? onClose;

  @override
  _VideoWatchPageState createState() => _VideoWatchPageState();
}

class _VideoWatchPageState extends State<VideoWatchPage> {
  double? initialPositionY = 0;
  double initialPositionX = 0;

  double? currentPositionY = 0;
  double currentPositionX = 0;

  double positionYDelta = 0;
  double positionXDelta = 0;

  double opacity = 1;

  double disposeLimit = 150;

  late Duration animationDuration;

  final grayColor = const Color.fromRGBO(52, 52, 54, 0.9);

  @override
  void initState() {
    super.initState();
    setDisposeLevel();
    animationDuration = Duration.zero;
  }

  setDisposeLevel() {
    setState(() {
      if (widget.disposeLevel == DisposeLevel.High) {
        disposeLimit = 300;
      } else if (widget.disposeLevel == DisposeLevel.Medium) {
        disposeLimit = 200;
      } else {
        disposeLimit = 100;
      }
    });
  }

  void _startVerticalDrag(details) {
    setState(() {
      initialPositionY = details.globalPosition.dy;
    });
  }

  void _whileVerticalDrag(details) {
    setState(() {
      currentPositionY = details.globalPosition.dy;
      positionYDelta = currentPositionY! - initialPositionY!;
      setOpacity();
    });
  }

  setOpacity() {
    final double tmp = positionYDelta < 0
        ? 1 - ((positionYDelta / 1000) * -1)
        : 1 - (positionYDelta / 1000);

    if (tmp > 1) {
      opacity = 1;
    } else if (tmp < 0) {
      opacity = 0;
    } else {
      opacity = tmp;
    }

    if (positionYDelta > disposeLimit || positionYDelta < -disposeLimit) {
      opacity = 0.5;
    }
  }

  _endVerticalDrag(DragEndDetails details) {
    if (positionYDelta > disposeLimit || positionYDelta < -disposeLimit) {
      if (widget.onClose != null) widget.onClose!();
      // Navigator.of(context, rootNavigator: true).pop();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            widget.backgroundIsTransparent ? Colors.transparent : grayColor,
        appBar: AppBar(
          elevation: 0, //this is shadow below app bar 0 gets rid of it
          backgroundColor: context.theme.appBarTheme.backgroundColor,
          iconTheme: context.theme.appBarTheme.iconTheme,
          toolbarHeight: 0,
        ),
        body: GestureDetector(
          onVerticalDragStart: (details) => _startVerticalDrag(details),
          onVerticalDragUpdate: (details) => _whileVerticalDrag(details),
          onVerticalDragEnd: (details) => _endVerticalDrag(details),
          child: Container(
            color: grayColor.withOpacity(opacity),
            child: Stack(
              children: <Widget>[
                AnimatedPositioned(
                    duration: animationDuration,
                    curve: Curves.fastOutSlowIn,
                    top: 0 + positionYDelta,
                    bottom: 0 - positionYDelta,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Expanded(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints.tightFor(
                                width: double.infinity,
                                height: double.infinity),
                            child: widget.child,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
