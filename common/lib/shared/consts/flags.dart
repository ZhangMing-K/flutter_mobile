import '../../iris_common.dart';

class Flags {
  static const harassment = 'Harassment or Bullying';

  // static const fakeAccount = 'Fake Account';
  static const inappropriate = 'Inappropriate Content';
  static const scam = 'Scam';
  static const spam = 'Spam';
  static const selfPromo = 'Self Promotion';
  static const other = 'Other';
  Flags._();

  static getFlagText(FLAG_REASON_TYPE reason) {
    switch (reason) {
      case FLAG_REASON_TYPE.HARASSMENT:
        return harassment;

      case FLAG_REASON_TYPE.INAPPROPRIATE:
        return inappropriate;

      case FLAG_REASON_TYPE.SCAM:
        return scam;

      case FLAG_REASON_TYPE.SPAM:
        return spam;

      case FLAG_REASON_TYPE.SELF_PROMO:
        return selfPromo;

      case FLAG_REASON_TYPE.OTHER:
        return other;
    }
  }
}
