import 'package:get/get.dart';

import '../../../routes/pages.dart';

class LoginPhoneController extends GetxController with IndexedStepMixin {
  final mfaContact$ = Rx<MFAContact?>(null);

  void sendCode(MFAContact? mfaContact) {
    mfaContact$.value = mfaContact;
    if (mfaContact != null) {
      nextStep();
    }
  }

  void verifyCode(MFAContact? mfaContact) {
    if (mfaContact?.verifiedAt != null) {
      Get.offAllNamed(Paths.Feed);
    }
  }
}
