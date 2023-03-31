import 'package:flutter/material.dart';

/// In no case should widgets access this file.
/// This file is accessed by IrisTheme, which will make all widgets inherit
/// the same pattern. Accessing this file causes the widget to ignore the
/// default theme, making the change to the light/dark theme not impact the
/// application.
/// This class will probably be sealed as private,
/// and used [part of] for only IrisTheme to access it, however,
/// it needs to be visible until the construction of IrisTheme for quick tests.
class IrisColor {
  static const primaryColor = Color(0xFF1982FC);

//TODO: put here all colors used to application

  static const lighterPrimaryColor =
      Color(0xFF73BCFF); //Color(0xFF21CE99) //0xFF147efb
  static const robinhoodGreen =
      Color(0xFF21CE99); //dont have yet tbd this is just a place holder
  static const fidelityGreen = Color(0xFF006044);
  static const etradePurple = Color(0xFF5627d8);
  static const schwabBlue = Color(0xFF469BDA);
  static const alternativePrimaryColor = Color(0xFF1982FC);

  static const irisBlueLight = Color(0xFF1982FC);
  static const irisBlue = Color.fromRGBO(2, 113, 227, 1); //for gradient
  static const irisBlueDark = Color(0xFF0d51a3);
  static const irisGrey = Color(0xFFE8E9EB);

  /// See https://coolors.co/1982fc
  static const analogousColor = Color(0xFF18FBDD);

  static const complementaryColor = Color(0xFFFB9118);
  static const imessagePurple = Color(0xff5D5CDE);

  static const scaffoldBackgroundColor = irisGrey;

  static const scaffoldBackgroundColorDark =
      Color(0xFF000000); //Color(0xfff5f6fa);
  static const backgroundColor = Color(0xFFFFFFFF);
  static const backgroundOffWhite = Color(0xFFFafafa);

  static const backgroundColorDark = Color(0xFF171818);
  static const accentColor = Color(0xFF000000);

  // static const dialogColorOnDarkBG = Color(0xff2C2D31);

  static const accentColorDark = Color(0xFFFFFFFF);
  static const brokerCardOnDarkBG = Color(0xff303235);

  static const brokerCardOnLightBG = Color(0xffECECEC);
  static const defaultTextColor = Color(0xFF0B0B0B);

  static const defaultTextColorDark = Color(0xFFECE8E8);

  static const subTitle = Color(0xFF8E9DB1);

  //static const buttonsColor = Color(0xFF21CE99);
  static const cloudyBlue = Color(0xFFB6C1CF);
  static const lighterPositiveChange = Color.fromRGBO(90, 199, 87, 1);
  static const positiveChange = Color(0xFF70b100);
  static const negativeChange = Color(0xffff6243);
  static const darkerPositiveChange = Color.fromRGBO(24, 64, 0, 1);
  static const lighterNegativeChange = Color.fromRGBO(255, 74, 65, 1);
  static const darkerNegativeChange = Color.fromRGBO(66, 18, 20, 1);
  static const buyColor = Colors.lightBlueAccent;
  static const buyColorV2 = Color(0xFF70b100);
  static const sellColor = Colors.redAccent;
  static const buyAndSellColor = Color(0xFFe8e017);
  static const gold = Color.fromRGBO(255, 215, 0, 1);
  static const active = Color(0xFF98C963);
  static const inactive = Color(0xFFE94950);
  static const discordColor = Color(0xff7289da);

  static const dateFromColor = Color(0xff9e9e9e);
  static const bullishBackground = Color.fromRGBO(60, 75, 31, 1);
  static const bullishText = Color.fromRGBO(127, 175, 52, 1);

  static const goldGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color.fromRGBO(212, 190, 95, 1),
      Color.fromRGBO(255, 239, 168, 1),
      Color.fromRGBO(212, 190, 95, 1),
    ],
  );

  static const backgroundUnderGold = Color.fromRGBO(51, 51, 51, 1);
  static const lightSecondaryColor = Color.fromRGBO(158, 158, 158, 1);

  IrisColor._();
}
