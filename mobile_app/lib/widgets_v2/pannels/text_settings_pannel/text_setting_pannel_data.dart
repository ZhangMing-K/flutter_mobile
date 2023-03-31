import 'package:iris_common/iris_common.dart';

class TextSettingsPannelData {
  User? authUser;

  TextModel? text;
  TextSettingsPannelData({this.authUser, this.text});

  double get maxHeight {
    double height = 0.23;

    if (pannelItems.length > 1) {
      height = height + (pannelItems.length - 1) * .08;
    }

    if (pannelItems.contains(PANNEL_ITEMS.SHARE)) height = 0.7;

    return height;
  }

  List<PANNEL_ITEMS> get pannelItems {
    final List<PANNEL_ITEMS> pannelItems = [];
    final bool textIsAuthUsers = text?.user?.userKey == authUser!.userKey;
    final bool interactedWith = text?.authUserInteractedAt != null;
    if ((text?.textType == TEXT_TYPE.POST ||
            text?.textType == TEXT_TYPE.COMMENT) &&
        textIsAuthUsers) {
      pannelItems.addAll([PANNEL_ITEMS.EDIT, PANNEL_ITEMS.DELETE]);
    } else if ((text?.textType == TEXT_TYPE.POST ||
            text?.textType == TEXT_TYPE.COMMENT) &&
        !textIsAuthUsers) {
      pannelItems.addAll([PANNEL_ITEMS.FLAG]);
    } else if (text?.textType == TEXT_TYPE.ORDER && textIsAuthUsers) {
      pannelItems.addAll(
          [PANNEL_ITEMS.EDIT, PANNEL_ITEMS.SHARE, PANNEL_ITEMS.COPY_LINK]);
    } else if (text?.textType == TEXT_TYPE.DUE_DILIGENCE &&
        textIsAuthUsers &&
        text!.dueDiligence!.canEdit) {
      pannelItems.addAll([PANNEL_ITEMS.EDIT]);
    }

    if (authUser!.verifiedAt != null) {
      if (text?.featuredAt == null && text?.textType == TEXT_TYPE.POST) {
        pannelItems.addAll([PANNEL_ITEMS.FEATURE]);
      } else if (text?.featuredAt != null && textIsAuthUsers) {
        pannelItems.addAll([PANNEL_ITEMS.FEATURE]);
      } else if (text?.textType == TEXT_TYPE.ORDER && textIsAuthUsers) {
        pannelItems.addAll([PANNEL_ITEMS.FEATURE]);
      }
    }

    if (!textIsHid &&
        (text?.textType == TEXT_TYPE.ORDER ||
            text?.textType == TEXT_TYPE.POST) &&
        !textIsAuthUsers) {
      pannelItems.add(PANNEL_ITEMS.HIDE);
    }

    if (interactedWith && text?.textType != TEXT_TYPE.COMMENT) {
      if (!textIsMuted) {
        pannelItems.add(PANNEL_ITEMS.MUTE);
      } else {
        pannelItems.add(PANNEL_ITEMS.UNMUTE);
      }
    }

    return pannelItems;
  }

  bool get textIsHid {
    return text?.textType == TEXT_TYPE.ORDER
        ? text?.order?.portfolio?.authUserRelation?.hideAt != null
        : text?.user?.authUserRelation?.hideAt != null;
  }

  bool get textIsMuted {
    return text?.authUserRelation?.mutedAt != null;
  }
}
