import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

/// Default values are the light mode color styles
class CustomColorScheme {
  final Color buyColor;
  final Color sellColor;
  final Color white;

  final Color primaryGray;
  final Color grayText;
  final Color darkgray;
  final Color primaryBlue;
  final Color onPrimaryBlue;
  final Color darkBlue;
  final Color autoPilotText;

  CustomColorScheme(
      {required this.buyColor,
      required this.sellColor,
      required this.white,
      required this.primaryGray,
      required this.grayText,
      required this.darkgray,
      required this.primaryBlue,
      required this.onPrimaryBlue,
      required this.darkBlue,
      required this.autoPilotText});

  factory CustomColorScheme.light() => CustomColorScheme(
        white: const Color(0xffffffff),
        primaryGray: const Color(0xffececec),
        grayText: const Color(0xff595959),
        darkgray: const Color(0xff222222),
        primaryBlue: const Color(0xff1982fc),
        onPrimaryBlue: Colors.white,
        darkBlue: const Color(0xff0d51a3),
        buyColor: IrisColors.lightMode().green,
        sellColor: IrisColors.lightMode().red,
        autoPilotText: const Color(0xffAC54FF),
      );

  factory CustomColorScheme.dark() => CustomColorScheme(
        white: const Color(0xffffffff),
        primaryGray: const Color(0xff222222),
        grayText: const Color(0xff9e9e9e),
        darkgray: const Color(0xff222222),
        primaryBlue: const Color(0xff1982fc),
        onPrimaryBlue: Colors.white,
        darkBlue: const Color(0xff0d51a3),
        buyColor: IrisColors.darkMode().green,
        sellColor: IrisColors.darkMode().red,
        autoPilotText: const Color(0xff47E9FF),
      );
}
