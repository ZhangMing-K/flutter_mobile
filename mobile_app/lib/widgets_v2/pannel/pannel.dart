import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppPannel extends StatelessWidget {
  const AppPannel({Key? key, required this.child, this.position = .9})
      : super(key: key);
  final Widget child;
  final double position;
  static open({required Widget widget, double position = .9}) {
    return Get.bottomSheet(
        AppPannel(
          child: widget,
          position: position,
        ),
        isScrollControlled: true);
  }

  @override
  Widget build(BuildContext context) {
    final double h = Get.height;
    final double height = h * position;
    debugPrint('App panel pos $height');
    return Container(
      height: height,
      width: 200,
      // decoration: ,
      color: Colors.red,
      child: child,
    );
  }
}
