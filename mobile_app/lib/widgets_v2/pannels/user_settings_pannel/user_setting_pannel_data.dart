import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class UserSettingsPannelData {
  User? authUser;

  Rx<User>? user$;

  User? get user => user$?.value;

  UserSettingsPannelData({this.authUser, this.user$});

  double get maxHeight {
    double height = 0.2;

    if (pannelItems.length > 1) {
      height = height + (pannelItems.length - 1) * .08;
    }

    return height;
  }

  List<PANNEL_ITEMS> get pannelItems {
    final List<PANNEL_ITEMS> pannelItems = [];

    if (user?.userKey != authUser!.userKey) {
      pannelItems.add(PANNEL_ITEMS.FLAG);
    }

    if (user?.suspendedAt != null &&
        user?.userKey != authUser!.userKey &&
        authUser!.userAccessType == USER_ACCESS_TYPE.ADMIN) {
      pannelItems.add(PANNEL_ITEMS.UNSUSPEND);
    }

    if (user?.authUserRelation?.blockedAt == null) {
      pannelItems.add(PANNEL_ITEMS.BLOCK);
    }

    if (user?.authUserFollowInfo?.followStatus != FOLLOW_STATUS.APPROVED) {
      pannelItems.add(PANNEL_ITEMS.HIDE);
    }

    return pannelItems;
  }

  bool get userIsHid {
    return user?.authUserRelation?.hideAt != null;
  }

  updateUser(User updatedUser) {
    user$!.value = updatedUser;
  }
}
