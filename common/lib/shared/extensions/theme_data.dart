import 'package:flutter/material.dart';
import 'package:iris_common/shared/themes/custom_theme_data.dart';

extension ThemeExtensions on ThemeData {
  CustomThemeData get custom => brightness == Brightness.dark
      ? CustomThemeData.dark()
      : CustomThemeData.light();
}
