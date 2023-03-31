import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../iris_common.dart';

class MfaContactVerifyCode extends GetView<MfaContactVerifyCodeController> {
  final ValueChanged<MFAContact> onVerifyCallback;

  final MFAContact? mfaContact;
  final MFA_VERIFY_ACTION action;
  const MfaContactVerifyCode({
    Key? key,
    required this.onVerifyCallback,
    required this.mfaContact,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return main(context);
  }

  Widget inputForm() {
    return FormBuilder(
      key: controller.verificationFormKey,
      initialValue: const {
        'verification': '',
      },
      child: Column(
        children: [
          Obx(
            () => Container(
              padding: EdgeInsets.only(top: IrisScreenUtil.dWidth(20)),
              child: IrisCodeInputForm(
                name: 'verification',
                codeLength: 6,
                error: controller.verificationError$.value,
                onChange: controller.listenInputChange,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget main(BuildContext context) {
    return GetX<MfaContactVerifyCodeController>(
      init: MfaContactVerifyCodeController(),
      builder: (controller) => Container(
        alignment: Alignment.topCenter,
        child: IrisInstructionForm(
          actionButton: Obx(
            () => ActionButton(
              text: 'Next',
              height: 60,
              fontSize: 16,
              textColor: Colors.white,
              disabled: controller.verifyDisabled$.value,
              onPressed: () {
                controller.verifyCode(action, mfaContact).then((data) {
                  if (data != null) onVerifyCallback(data);
                });
                // debugPrint('called onverifycallback');
                // MfaContact newContact = mfaContact!.copyWith(verifiedAt: DateTime.now());
                // onVerifyCallback(newContact);
              },
            ),
          ),
          scrollPhysics: null,
          fontSize: 28,
          title: 'Verify ${controller.formatNumber(mfaContact)}',
          content: Container(
              padding: EdgeInsets.only(
                  left: IrisScreenUtil.dWidth(10),
                  right: IrisScreenUtil.dWidth(10)),
              child: Column(
                children: [
                  inputForm(),
                  if (controller.incorrectData)
                    resend(
                      resendPrefixText: 'Incorrect Code ',
                      resendText: 'Resend',
                      color: IrisColor.sellColor,
                    )
                  else
                    resend(
                      resendPrefixText: 'Still don\'t see it? ',
                      resendText: 'Resend',
                      color: context.theme.colorScheme.secondary,
                    )
                ],
              )),
        ),
      ),
    );
  }

  Widget resend({
    required String resendText,
    String? resendPrefixText,
    Color? color,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 4, top: 8),
      child: Row(
        children: [
          if (resendPrefixText != null)
            Text(
              resendPrefixText,
              style: TextStyle(color: color, fontSize: 14),
            ),
          GestureDetector(
            onTap: () async {
              final data = await controller.resend(action, mfaContact);
              if (data != null) {
                onVerifyCallback(
                    mfaContact!.copyWith(challengeId: data.challengeId));
              }
            },
            child: Text(
              resendText,
              style: const TextStyle(
                color: IrisColor.primaryColor,
                fontSize: 14,
                decoration: TextDecoration.underline,
              ),
            ),
          )
        ],
      ),
    );
  }
}
