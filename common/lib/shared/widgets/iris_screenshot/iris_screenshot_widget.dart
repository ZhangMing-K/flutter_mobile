import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'iris_screenshot_controller.dart';

class IrisScreenshotWidget extends StatelessWidget {
  final Widget child;
  final IrisScreenshotController controller;
  const IrisScreenshotWidget({
    Key? key,
    required this.child,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: controller.key,
      child: Container(
        color: context.theme.scaffoldBackgroundColor,
        child: child,
      ),
    );
  }
}
