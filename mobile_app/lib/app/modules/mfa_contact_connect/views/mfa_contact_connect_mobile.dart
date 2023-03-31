import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/mfa_contact_connect_controller.dart';

class MfaContactConnectMobile extends GetView<MfaContactConnectController> {
  const MfaContactConnectMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: context.theme.scaffoldBackgroundColor,
        height: double.infinity,
        width: double.infinity,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: main(context),
        ),
      ),
    );
  }

  Widget main(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          navHeader(),
          Container(
            width: 150,
            padding: const EdgeInsets.only(bottom: 10),
            child: IrisStepper(
                numberOfSteps: 5,
                width: MediaQuery.of(context).size.width,
                curStep: controller.currentStep$.value,
                color: IrisColor.primaryColor),
          ),
          Expanded(
            child: PageTransitionSwitcher(
              reverse: false,
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
                      onSendCodeCallback: controller.sendCode,
                      action: MFA_VERIFY_ACTION.MAKE_PRIMARY,
                    ),
                    MfaContactVerifyCode(
                      onVerifyCallback: controller.verifyCode,
                      mfaContact: controller.mfaContact$.value,
                      action: MFA_VERIFY_ACTION.MAKE_PRIMARY,
                    ),
                    MfaContactPermissions(
                      onCompleteCallBack: controller.contactsSyncComplete,
                      onSkip: () async {
                        await Get.dialog(
                          IrisDialog(
                            title: 'Are you sure?',
                            subtitle:
                                'We won\'t be able to show you friends that are already on iris, friends who sign up or people to invite. \n\nYou can always go to your settings and allow us to connect you to your friends.',
                            onCancel: () => Get.back(),
                            confirmButtonText: 'Skip',
                            onConfirm: () {
                              Get.back();
                              controller.doneProcess();
                            },
                          ),
                          barrierDismissible: true,
                        );
                      },
                    ),
                    if (controller.currentStep$.value > 2)
                      FindFriends(onNextCallback: controller.next),
                    InviteFriends(onNextCallBack: controller.next),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 20, left: 0),
            child: GestureDetector(
              onTap: () => controller.back(),
              child: const Icon(Icons.chevron_left, size: 38),
            ),
          )
        ],
      ),
    );
  }
}
