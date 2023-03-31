import 'package:flutter/material.dart';

class IrisBounceButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Duration duration;
  final AnimationController? controller;
  // This will get the data from the pages
  // Makes sure child won't be passed as null
  const IrisBounceButton({
    Key? key,
    required this.child,
    required this.duration,
    required this.onPressed,
    this.controller,
  }) : super(key: key);

  @override
  BounceState createState() => BounceState();
}

class BounceState extends State<IrisBounceButton>
    with SingleTickerProviderStateMixin {
  late double _scale;

  // This controller is responsible for the animation

  //Getting the VoidCallack onPressed passed by the user
  VoidCallback? get onPressed => widget.onPressed;

  //if no controller is passed in, we need to create a new one to use for animation
  AnimationController? backupController;
  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      backupController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
        lowerBound: 0.0,
        upperBound: .75,
      )..addListener(() {
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    // To dispose the contorller when not required
    backupController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = widget.controller == null
        ? 1 - backupController!.value
        : 1 - widget.controller!.value;
    return GestureDetector(
        onTap: _onTap,
        child: Transform.scale(
          scale: _scale,
          child: widget.child,
        ));
  }

  //This is where the animation works out for us
  // Both the animation happens in the same method,
  // but in a duration of time, and our callback is called here as well
  void _onTap() {
    //Firing the animation right away
    if (widget.controller != null) {
      widget.controller!.forward();
    } else {
      backupController?.forward();
    }

    //Now reversing the animation after the user defined duration
    Future.delayed(widget.duration, () {
      if (widget.controller != null) {
        widget.controller!.reverse();
      } else {
        backupController?.reverse();
      }

      //Calling the callback but with a null check
      onPressed?.call();
    });
  }
}
