import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class FlagPannelController extends GetxController {
  int? flagEntityKey;
  FLAG_ENTITY_TYPE? flagEntityType;
  final FlagService flagService = Get.find();
  GlobalKey<FormBuilderState>? reasonFormKey;

  final BaseController baseController = Get.find();
  List<FLAG_REASON_TYPE> reasons = [
    FLAG_REASON_TYPE.HARASSMENT,
    FLAG_REASON_TYPE.INAPPROPRIATE,
    FLAG_REASON_TYPE.SELF_PROMO,
    FLAG_REASON_TYPE.SPAM,
    FLAG_REASON_TYPE.SCAM,
    FLAG_REASON_TYPE.OTHER
  ];
  final IAuthUserService authUserStore = Get.find();
  final Events events = Get.find();

  RxBool flagReported = false.obs;

  RxBool otherView = false.obs;

  closeBottomSheet() {
    debugPrint('closing bottomsheet');
    Get.back();
  }

  createFlag(FLAG_ENTITY_TYPE? flagEntityType, int? flagEntityKey,
      FLAG_REASON_TYPE flagReason) async {
    String? reason;

    if (flagReason == FLAG_REASON_TYPE.OTHER) {
      final validated = reasonFormKey!.currentState!.saveAndValidate();
      if (!validated) {
        return;
      }
      final mapValues = reasonFormKey?.currentState?.fields;
      if (mapValues != null) reason = mapValues['reason']!.value;
    }

    final Flag flag = await flagService.flagCreate(
        flagEntityType: flagEntityType!,
        flagEntityKey: flagEntityKey,
        flagReasonType: flagReason,
        reason: reason);

    if (flag.user != null) {
      events.userSuspend(UserSuspendEvent(user: flag.user));
    }

    closeBottomSheet();
    return flag;
  }
}
