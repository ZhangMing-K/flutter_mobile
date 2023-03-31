import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/login_phone_controller.dart';

class LoginWithPhone extends GetWidget<LoginPhoneController> {
  const LoginWithPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 36,
          ),
          onPressed: () {
            controller.backButtonPressed();
          },
        ),
      ),
      body: main(),
    );
  }

  Widget main() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: //Obx( () =>
              PageTransitionSwitcher(
            reverse: controller.reverse,
            transitionBuilder: (Widget child,
                Animation<double> primaryAnimation,
                Animation<double> secondaryAnimation) {
              return SharedAxisTransition(
                fillColor: Colors.transparent,
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                child: child,
              );
            },
            child: Obx(
              () => IndexedStack(
                index: controller.currentStep$.value,
                children: [
                  MfaContactSendCode(
                    title: 'Welcome back',
                    subtitle: 'Enter your phone number',
                    onSendCodeCallback: controller.sendCode,
                    action: MFA_VERIFY_ACTION.LOGIN,
                  ),
                  MfaContactVerifyCode(
                    onVerifyCallback: controller.verifyCode,
                    mfaContact: controller.mfaContact$.value,
                    action: MFA_VERIFY_ACTION.LOGIN,
                  ),
                ],
              ),
            ),
          ),
        ),
        // ),
      ),
    );
  }
}
