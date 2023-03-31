import 'package:flutter/widgets.dart';
import 'package:unicons/unicons.dart';

class Font {
  static const airbnbFont = 'AirbnbCerealApp';
}

class IrisIcon {
  static IconData share = UniconsLine.upload;

  IrisIcon._();

  static const IconData carat_right = UniconsLine.angle_right;

  static const _kFontFam = 'IrisIcon';
  static const String? _kFontPkg = null;

  static const IconData like =
      IconData(0xe900, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData magnifier =
      IconData(0xe86f, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData message = UniconsLine.location_arrow;
  static const IconData secure = UniconsLine.university;
}

class TikTokIcons {
  TikTokIcons._();

  static const _kFontFam = 'TikTokIcons';

  static const IconData chat_bubble = IconData(0xe808, fontFamily: _kFontFam);
  static const IconData create = IconData(0xe809, fontFamily: _kFontFam);
  static const IconData heart = IconData(0xe80a, fontFamily: _kFontFam);
  static const IconData home = IconData(0xe80b, fontFamily: _kFontFam);
  static const IconData messages = IconData(0xe80c, fontFamily: _kFontFam);
  static const IconData profile = IconData(0xe80d, fontFamily: _kFontFam);
  static const IconData reply = IconData(0xe80e, fontFamily: _kFontFam);
  static const IconData search = IconData(0xe80f, fontFamily: _kFontFam);
}
