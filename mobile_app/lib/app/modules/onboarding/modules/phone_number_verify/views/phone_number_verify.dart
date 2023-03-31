import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iris_common/iris_common.dart';

import '../../../components/onboarding_wrapper.dart';
import '../controllers/phone_number_verify_controller.dart';

class PhoneNumberVerifyScreen extends GetView<PhoneNumberVerifyController> {
  const PhoneNumberVerifyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnboardingWrapper(
      child: SizedBox(
        // height: 280,
        child: MfaContactVerifyCode(
          onVerifyCallback: controller.verifyCode,
          mfaContact: controller.mfaContact$.value,
          action: MFA_VERIFY_ACTION.CREATE_ACCOUNT,
        ),
      ),
    );
  }
}
