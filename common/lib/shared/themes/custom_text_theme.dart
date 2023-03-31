import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

class CustomTextTheme {
  final TextStyle h5Bold;
  final TextStyle h6Bold;
  final TextStyle h6Semi;
  final TextStyle subHeader1;
  final TextStyle bodySmall;

  const CustomTextTheme({
    this.h5Bold = const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
    this.h6Bold = const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
    this.h6Semi = const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
    this.subHeader1 =
        const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
    this.bodySmall = const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
  });

  factory CustomTextTheme.dark() => CustomTextTheme(
      h6Bold: const CustomTextTheme()
          .h6Bold
          .copyWith(color: IrisColors.darkMode().white));

  factory CustomTextTheme.light() => CustomTextTheme(
      h6Bold: const CustomTextTheme()
          .h6Bold
          .copyWith(color: IrisColors.lightMode().black));
}
