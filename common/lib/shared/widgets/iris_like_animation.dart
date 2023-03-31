import 'package:flutter/material.dart';

class IrisIconAnimation extends StatelessWidget {
  final bool isLiked;
  final Widget child;
  const IrisIconAnimation({
    Key? key,
    this.isLiked = false,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isLiked ? 1 : 0,
      duration: Duration(milliseconds: isLiked ? 400 : 200),
      child: AnimatedContainer(
          transform: Transform.scale(
            scale: isLiked ? 2 : 1,
          ).transform,
          transformAlignment: Alignment.center,
          duration: Duration(milliseconds: isLiked ? 600 : 200),
          curve: isLiked ? Curves.elasticOut : Curves.linear,
          width: 20,
          height: 20,
          child: child),
    );
  }
}
