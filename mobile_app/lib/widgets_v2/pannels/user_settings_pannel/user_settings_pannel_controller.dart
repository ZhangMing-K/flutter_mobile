import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'user_setting_pannel_data.dart';

class UserSettingsPannelController extends GetxController {
  Rx<User>? user$;
  User? get user => user$?.value;
  final IAuthUserService authUserStore = Get.find();
  final BaseController baseController = Get.find();
  final JediUserService jediUserService = Get.find();
  final Events events = Get.find();
  UserRelationSerivce userRelationService = Get.find();
  UserSettingsPannelData? pannelData;

  void closeBottomSheet() {
    Get.back();
  }

  hideEntity(bool hide) async {
    final UserRelation? authUserRelation =
        await userRelationService.userRelationsUpdate(
            entityType: USER_RELATION_ENTITY_TYPE.USER,
            entityKeys: [user!.userKey],
            hide: hide);

    user$!.value = user!.copyWith(authUserRelation: authUserRelation);

    events.userHide(UserHideEvent(user: user));
  }

  blockEntity(bool block) async {
    final UserRelation? authUserRelation =
        await userRelationService.userRelationsUpdate(
            entityType: USER_RELATION_ENTITY_TYPE.USER,
            entityKeys: [user!.userKey],
            block: block);

    user$!.value = user!.copyWith(authUserRelation: authUserRelation);

    events.userHide(UserHideEvent(user: user));
  }

  unsuspend() async {
    final User? resUser = await jediUserService.jediUserEdit(
        userKey: user!.userKey, suspend: false);

    if (user != null) {
      events.userSuspend(UserSuspendEvent(user: resUser));
    }

    closeBottomSheet();
  }

  userRelationUpdate({bool? hide, bool? block}) async {
    closeBottomSheet();
    if (hide != null) await hideEntity(hide);
    if (block != null) await blockEntity(block);
  }
}
