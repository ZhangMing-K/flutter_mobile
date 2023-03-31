import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

class TouchableArea extends StatelessWidget {
  final Widget child;
  const TouchableArea({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: kTouchableSize, height: kTouchableSize, child: child);
  }
}
