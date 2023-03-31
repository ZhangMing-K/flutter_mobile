import 'package:flutter/material.dart';

class IrisCountDownTimer extends StatefulWidget {
  const IrisCountDownTimer({
    Key? key,
    required this.secondsRemaining,
    required this.whenTimeExpires,
    this.countDownTimerStyle,
    this.countDownFormatter,
  }) : super(key: key);

  final int secondsRemaining;
  final Function whenTimeExpires;
  final Function? countDownFormatter;
  final TextStyle? countDownTimerStyle;

  @override
  State createState() => _IrisCountDownTimerState();
}

class _IrisCountDownTimerState extends State<IrisCountDownTimer>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Duration duration;

  String get timerDisplayString {
    final Duration duration = _controller.duration! * _controller.value;
    return widget.countDownFormatter != null
        ? widget.countDownFormatter!(duration.inSeconds)
        : formatHHMMSS(duration.inSeconds);
    // In case user doesn't provide formatter use the default one
    // for that create a method which will be called formatHHMMSS or whatever you like
  }

  @override
  void initState() {
    super.initState();
    duration = Duration(seconds: widget.secondsRemaining);
    _controller = AnimationController(
      vsync: this,
      duration: duration,
    );
    _controller.reverse(from: widget.secondsRemaining.toDouble());
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        widget.whenTimeExpires();
      }
    });
  }

  @override
  void didUpdateWidget(IrisCountDownTimer oldWidget) {
    if (widget.secondsRemaining != oldWidget.secondsRemaining) {
      setState(() {
        duration = Duration(seconds: widget.secondsRemaining);
        _controller.dispose();
        _controller = AnimationController(
          vsync: this,
          duration: duration,
        );
        _controller.reverse(from: widget.secondsRemaining.toDouble());
        _controller.addStatusListener((status) {
          widget.whenTimeExpires();
        });
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget display() {
    return Text(
      timerDisplayString,
      style: widget.countDownTimerStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedBuilder(
            animation: _controller, builder: (_, Widget? child) => display()));
  }
}

String formatHHMMSS(int seconds) {
  final int hours = (seconds / 3600).truncate();
  seconds = (seconds % 3600).truncate();
  final int minutes = (seconds / 60).truncate();

  final String hoursStr = (hours).toString().padLeft(2, '0');
  final String minutesStr = (minutes).toString().padLeft(2, '0');
  final String secondsStr = (seconds % 60).toString().padLeft(2, '0');

  if (hours == 0) {
    return '$minutesStr:$secondsStr';
  }

  return '$hoursStr:$minutesStr:$secondsStr';
}
