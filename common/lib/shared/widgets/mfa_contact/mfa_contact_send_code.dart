import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:get/get.dart';

import '../../../iris_common.dart';

class MfaContactSendCode extends GetView<MfaContactSendCodeController> {
  final String? title;

  final String? subtitle;
  final ValueChanged<MFAContact?> onSendCodeCallback;
  final MFA_VERIFY_ACTION action;

  const MfaContactSendCode({
    Key? key,
    required this.onSendCodeCallback,
    required this.action,
    this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return main(context);
  }

  Widget inputForm(BuildContext context, bool looksGood) {
    return Container(
        padding: EdgeInsets.only(
            top: IrisScreenUtil.dWidth(20),
            left: IrisScreenUtil.dWidth(10),
            right: IrisScreenUtil.dWidth(10)),
        child: FormBuilder(
          key: controller.numberFormKey,
          initialValue: const {
            'phoneNumber': '',
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              phoneNumberField(),
              SizedBox(height: IrisScreenUtil.dWidth(16)),
              if (looksGood)
                Text(
                  'Looks good!',
                  style: TextStyle(
                      fontSize: IrisScreenUtil.dFontSize(14),
                      fontWeight: FontWeight.w300,
                      color: context.theme.colorScheme.secondary),
                )
            ],
          ),
        ));
  }

  Widget main(BuildContext context) {
    return GetBuilder<MfaContactSendCodeController>(
      init: MfaContactSendCodeController(),
      builder: (controller) {
        return Container(
          alignment: Alignment.topCenter,
          child: IrisInstructionForm(
            fontSize: 28,
            actionButton: Obx(() => ActionButton(
                  height: 60,
                  fontSize: 16,
                  text: 'Verify',
                  textColor: Colors.white,
                  onPressed: () {
                    controller
                        .sendCode(action)
                        .then((_) => onSendCodeCallback(_));
                  },
                  disabled: controller.submitDisabled$.value,
                )),
            scrollPhysics: null,
            title: title ?? 'Enter your phone number',
            content: Obx(
                () => inputForm(context, !controller.submitDisabled$.value)),
          ),
        );
      },
    );
  }

  Widget phoneNumberField() {
    return Obx(() {
      final errorValue = controller.sendCodeError$.value;
      return Builder(builder: (context) {
        return IrisPhoneNumberInputForm(
          customFormatter: LibPhonenumberTextFormatter(
              country: controller.currentCountryCode,
              phoneNumberFormat: PhoneNumberFormat.international),
          name: 'phoneNumber',
          style: TextStyle(color: context.theme.colorScheme.secondary),
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              )),
          onDialCodeChange: (countryCode) {
            controller.dialCode$.value = countryCode.dialCode!;
            controller.countryCode$.value = countryCode.code!;
          },
          error: errorValue,
          onChange: controller.listenTextChanges,
        );
      });
    });
  }
}
