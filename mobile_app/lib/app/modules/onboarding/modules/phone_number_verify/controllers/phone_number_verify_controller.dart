import 'package:get/get.dart';

import '../../../../../routes/pages.dart';

class PhoneNumberVerifyController extends GetxController {
  final mfaContact$ = const MFAContact().obs;

  @override
  void onInit() {
    final args = Get.arguments;
    if (args is MFAContact) {
      mfaContact$.value = args;
    }
    super.onInit();
  }

  String? get mfaContact => mfaContact$.value.challengeId;

  void verifyCode(MFAContact? mfaContact) {
    if (mfaContact?.verifiedAt != null) {
      mfaContact$.value = mfaContact!;
      goToPictureAndNamePickerScreen();
    }
  }

  void goToPictureAndNamePickerScreen() {
    Get.toNamed(Paths.PictureAndNamePicker, arguments: mfaContact$.value);
  }
}
