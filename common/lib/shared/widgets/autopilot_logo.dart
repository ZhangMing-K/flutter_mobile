import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

enum AutopilotLogoStyle { iconOnly, withText }

class AutopilotLogo extends StatelessWidget {
  const AutopilotLogo({
    Key? key,
    this.style = AutopilotLogoStyle.withText,
    this.height,
    this.width,
  }) : super(key: key);

  final AutopilotLogoStyle style;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Image.asset(
      isDark ? Images.autopilotLogoDarkMode : Images.autopilotLogoLightMode,
      package: 'iris_common',
      height: height,
      width: width,
    );
  }
}
