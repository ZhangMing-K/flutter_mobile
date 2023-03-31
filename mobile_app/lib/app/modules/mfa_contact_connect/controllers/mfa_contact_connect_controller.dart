import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/referrals/referrals.dart';

enum INVITE_USER_FLOW_STEPS {
  SEND_CODE,
  VERIFY_CODE,
  CONNECT_PERMISSION,
  ADD_FRIENDS,
  INVITE
}

class MfaContactConnectController extends GetxController {
  final MfaContactService mfaContactService;
  final numberFormKey = GlobalKey<FormBuilderState>();

  final verificationFormKey = GlobalKey<FormBuilderState>();
  final pageType = INVITE_USER_FLOW_STEPS.SEND_CODE.obs;
  final RxnString phoneNumber$ = RxnString(null);

  final RxInt currentStep$ = RxInt(0);
  final RxBool stepComplete$ = RxBool(false);
  final Rx<MFAContact?> mfaContact$ = Rx<MFAContact?>(null);
  final RxString verificationCode$ = RxString('');
  final RxString verificationError$ = RxString('');
  final RxBool completed$ = RxBool(false);
  MfaContactConnectController({required this.mfaContactService});

  void back() {
    if (currentStep$.value == 0 || currentStep$.value == 2) {
      Get.back();
    } else {
      currentStep$.value = currentStep$.value - 1;
    }
  }

  void contactsSyncComplete() {
    currentStep$.value = currentStep$.value + 1;
  }

  void doneProcess() {
    Get.offAndToNamed(ReferralsScreen.routeName());
  }

  void next() {
    currentStep$.value = currentStep$.value + 1;
    if (currentStep$.value == 5) {
      doneProcess();
    }
  }

  void sendCode(MFAContact? mfaContact) {
    if (mfaContact == null) {
      Get.snackbar('Error!', 'Can not send code.');
      return;
    }
    mfaContact$.value = mfaContact;
    if (mfaContact.challengeId != null) {
      next();
    }
  }

  void verifyCode(MFAContact mfaContact) {
    mfaContact$.value = mfaContact;
    if (mfaContact.verifiedAt != null) {
      next();
    }
  }
}
