import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/utils.dart';
import 'package:iris_common/shared/themes/text_theme.dart';

import 'colors.dart';
import 'font.dart';

/// IrisTheme is the file responsible for the application's themes.
/// Any global modification must be done in this file, such as changing
/// the backgroundColor to scaffoldBackgroundColor. To make changes to
/// the color tone, modify the [colors.dart] file
class IrisTheme {
  static ThemeData darkful() {
    return ThemeData(
      fontFamily: GetPlatform.isWeb ? null : Font.airbnbFont,
      primaryColor: IrisColor.primaryColor,
      disabledColor: IrisColor.backgroundColorDark.withOpacity(0.38),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return IrisColor.primaryColor.withOpacity(0.38);
            }
            return IrisColor.primaryColor; // Use the component's default.
          },
        ),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide(
              color: IrisColor.accentColorDark.withOpacity(.2),
            ),
          ),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.only(left: 4, bottom: 4),
          fillColor: Colors.white,
          focusColor: Colors.white,
          hoverColor: Colors.white,
          labelStyle: TextStyle(color: IrisColor.subTitle)),
      hintColor: IrisColor.subTitle,
      focusColor: IrisColor.subTitle,
      canvasColor: Colors.transparent,
      cardColor: const Color(0xff222222),
      backgroundColor: IrisColor.backgroundColorDark,
      scaffoldBackgroundColor: IrisColor.scaffoldBackgroundColorDark,
      dividerColor: IrisColor.accentColorDark.withOpacity(.8),
      textTheme: IrisTextTheme.dark,
      bottomAppBarColor: Colors.black,
      // IrisColor.scaffoldBackgroundColorDark,
      appBarTheme: const AppBarTheme(
        color: Colors.black, // IrisColor.scaffoldBackgroundColorDark,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      textSelectionTheme:
          const TextSelectionThemeData(selectionColor: IrisColor.subTitle),
      colorScheme: const ColorScheme.dark(
        secondary: IrisColor.accentColorDark,
        primary: IrisColor.irisBlue,
        background: IrisColor.backgroundColorDark,
        surface: Color(0xff222222),
      ),
    );
  }

  static ThemeData light() {
    return ThemeData(
      fontFamily: Font.airbnbFont,
      primaryColor: IrisColor.primaryColor,
      disabledColor: IrisColor.backgroundColor.withOpacity(0.38),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return IrisColor.primaryColor.withOpacity(0.38);
            }
            return IrisColor.primaryColor; // Use the component's default.
          },
        ),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      )),
      inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.only(left: 4, bottom: 4),
          fillColor: Colors.black,
          focusColor: Colors.black,
          hoverColor: Colors.black,
          labelStyle: TextStyle(color: IrisColor.subTitle)),
      hintColor: IrisColor.subTitle,
      focusColor: IrisColor.subTitle,
      canvasColor: Colors.transparent,
      backgroundColor: IrisColor.scaffoldBackgroundColor,
      scaffoldBackgroundColor: IrisColor.backgroundColor,
      dividerColor: IrisColor.accentColor.withOpacity(.2),
      textTheme: IrisTextTheme.light,
      bottomAppBarColor: IrisColor.backgroundColor,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      colorScheme: const ColorScheme.light().copyWith(
        secondary: IrisColor.accentColor,
        primary: IrisColor.irisBlue,
      ),
      cardColor: Colors.white,
    );
  }
}
