import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IrisGoldGradientRapper extends StatelessWidget {
  const IrisGoldGradientRapper({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: [
          Color.fromRGBO(212, 190, 95, 1),
          Color.fromRGBO(255, 239, 168, 1),
          Color.fromRGBO(212, 190, 95, 1)
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
