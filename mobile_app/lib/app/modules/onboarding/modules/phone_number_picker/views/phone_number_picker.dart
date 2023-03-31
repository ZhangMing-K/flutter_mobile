import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iris_common/iris_common.dart';

import '../../../components/onboarding_wrapper.dart';
import '../controllers/phone_number_picker_controller.dart';
import 'package:get/get.dart';

class PhoneNumberPickerScreen extends GetView<PhoneNumberPickerController> {
  const PhoneNumberPickerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnboardingWrapper(
      child: SizedBox(
          // height: 280,
          child: MfaContactSendCode(
        onSendCodeCallback: controller.sendCode,
        action: MFA_VERIFY_ACTION.CREATE_ACCOUNT,
      )),
    );
  }
}
