import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/consts/images.dart';
import '../../../shared/types/index.dart';
import '../../../shared/widgets/buttons/action_button.dart';
import '../../../shared/widgets/iris_instruction_form.dart';
import '../../../shared/widgets/iris_loading.dart';
import '../app_button_v2.dart';
import 'mfa_contact_permissions_controller.dart';

class MfaContactPermissions extends GetView<MfaContactPermissionsController> {
  final VoidCallback onCompleteCallBack;

  final VoidCallback? onSkip;
  const MfaContactPermissions({
    Key? key,
    required this.onCompleteCallBack,
    this.onSkip,
  }) : super(key: key);

  Widget actionButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (onSkip != null)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ActionButton(
                text: "Don't allow",
                appButtonType: APP_BUTTON_TYPE.OUTLINE,
                onPressed: onSkip!,
                textColor: Colors.white,
              ),
            ),
          ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ActionButton(
              text: 'Connect',
              textColor: Colors.white,
              onPressed: () async {
                await controller.syncContacts();
                onCompleteCallBack.call();
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetX<MfaContactPermissionsController>(
        init: MfaContactPermissionsController(),
        builder: (controller) {
          return Container(
            alignment: Alignment.topCenter,
            child: controller.apiStatus$.value == API_STATUS.PENDING
                ? const IrisLoading(
                    loadingText: 'Syncing your contacts :)',
                  )
                : SizedBox(
                    height: context.height * 0.75,
                    child: IrisInstructionForm(
                      actionButton: actionButton(context),
                      title: 'Connect with your friends',
                      subtitle:
                          'We can show you who is already a member and when new friends sign up',
                      content: Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: Image.asset(Images.connectionsBlue),
                      ),
                    )),
          );
        });
  }
}
