import 'package:get/get.dart';

import '../../../../../routes/pages.dart';

class PhoneNumberPickerController extends GetxController {
  final mfaContact$ = Rx<MFAContact?>(null);

  String? get mfaContact => mfaContact$.value?.challengeId;

  void sendCode(MFAContact? mfaContact) {
    mfaContact$.value = mfaContact;
    if (mfaContact != null) {
      goToVerifyCodeScreen();
    }
  }

  void goToVerifyCodeScreen() {
    Get.toNamed(Paths.PhoneNumberVerify, arguments: mfaContact$.value);
  }
}
