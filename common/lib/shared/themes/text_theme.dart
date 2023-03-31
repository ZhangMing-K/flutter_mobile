import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

class IrisTextTheme {
  static var dark = main.copyWith(
    subtitle1: const TextStyle(color: IrisColor.subTitle),
    bodyText1: const TextStyle(color: IrisColor.defaultTextColorDark),
  );

  static var light = main.copyWith(
    subtitle1: const TextStyle(color: IrisColor.subTitle),
    bodyText1: const TextStyle(color: IrisColor.defaultTextColor),
  );

  static const main = TextTheme(
    headline1: TextStyle(
      fontWeight: FontWeight.w700,
      fontFamily: 'Inter',
      fontSize: 32,
    ),
    headline2: TextStyle(
      fontWeight: FontWeight.w700,
      fontFamily: 'Inter',
      fontSize: 28,
    ),
    headline3: TextStyle(
      fontWeight: FontWeight.w700,
      fontFamily: 'Inter',
      fontSize: 24,
    ),
    headline4: TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
      fontSize: 20,
    ),
    // headline4: TextStyle(), 4 Bold
    headline5: TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
      fontSize: 17,
    ),
    // headline5: TextStyle(), h5 bold
    headline6: TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
      fontSize: 16,
    ),
    // headline6: TextStyle(),  h7
    // headline6: TextStyle(), h7 bold
    subtitle1: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
      fontSize: 12,
    ),
    // subtitle1: TextStyle(), sub 1 med
    subtitle2: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
      fontSize: 13,
    ),
    // subtitle2: TextStyle(), sub 2 med
    // subtitle2: TextStyle(), sub 2 semi
    // subtitle2: TextStyle(), sub 2 bold
    button: TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
      fontSize: 16,
    ),
    bodyText1: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
      fontSize: 16,
    ),
    bodyText2: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
      fontSize: 14,
    ),
    //body small
    // bodyText2: TextStyle(), //body small med
    // bodyText2: TextStyle(), //body small semi
    // bodyText2: TextStyle(), //body small bold
    caption: TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
      fontSize: 10,
    ),
    // tertiary
    // overline: TextStyle(),
  );
}
