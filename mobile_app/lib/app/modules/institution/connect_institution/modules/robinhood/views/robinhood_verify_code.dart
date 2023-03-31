import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:pinput/pinput.dart';

import '../controllers/robinhood_login_controller.dart';

class RobinhoodVerifyCode extends GetView<RobinhoodLoginController> {
  const RobinhoodVerifyCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.isKeyboardOpen;
    return Obx(() {
      return Column(children: [
        header(),
        main(),
        if (!controller.isApp)
          resend(
              color: controller.timeExpired$.value == true
                  ? IrisColor.sellColor
                  : context.theme.hintColor,
              resendPrefixText: "Still don't see it?",
              resendText: 'Resend'),
        error(),
      ]);
    });
  }

  Widget error() {
    return Obx(() {
      final error = controller.institutionConnectErrorText$.value.isNotEmpty
          ? controller.institutionConnectErrorText$.value
          : controller.errorText$.value;
      return Container(
        height: 60,
        padding: const EdgeInsets.only(
          top: 10,
        ),
        alignment: Alignment.centerLeft,
        child: error.isNotEmpty
            ? Text(
                error,
                textAlign: TextAlign.start,
                style:
                    const TextStyle(fontSize: 14, color: IrisColor.sellColor),
              )
            : Container(),
      );
    });
  }

  Widget header() {
    return controller.connectResponse$.value != null
        ? Column(
            children: [
              instructions(),
            ],
          )
        : Container();
  }

  Widget instructions() {
    final String challengeInstructions = controller.isApp
        ? 'Please enter the 6-digit code of the app used to authenticate your Robinhood account'
        : 'A verification code was just sent to you';
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        challengeInstructions,
        style: const TextStyle(fontSize: 18),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget main() {
    return Builder(builder: (context) {
      final Color boxColor = context.theme.brightness == Brightness.dark
          ? const Color(0xff333333)
          : IrisColor.cloudyBlue;

      final defaultPinTheme = PinTheme(
        height: 48,
        width: 49,
        textStyle: TextStyle(color: context.theme.colorScheme.secondary),
        decoration: BoxDecoration(
          color: boxColor,
          border: Border.all(color: IrisColor.irisBlueDark, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
      );

      final focusedPinTheme = defaultPinTheme.copyDecorationWith(
        border: Border.all(color: IrisColor.irisBlueLight, width: 1),
        borderRadius: BorderRadius.circular(8),
      );

      final submittedPinTheme = defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration?.copyWith(
          border: Border.all(color: boxColor, width: 1),
        ),
      );

      return Container(
        padding: const EdgeInsets.only(top: 30),
        child: Pinput(
          length: 6,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          focusNode: controller.pinFocusNode,
          pinAnimationType: PinAnimationType.fade,
          animationDuration: const Duration(milliseconds: 300),
          showCursor: true,
          //errorAnimationController: c.pinCodeErrorController,
          controller: controller.pinCodeController,
          onCompleted: (code) async {
            await controller
                .verifyCode(controller.pinCodeController.value.text);
          },
          onChanged: (value) {
            // c.onCompletedPinCode(value: value);
          },
          // beforeTextPaste: (text) {
          //   //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //   //but you can show anything you want here, like your pop up saying wrong paste format or etc
          //   return true;
          // },
        ),
      );
    });
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
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () async {
              await controller.resendCode();
            },
            child: Text(
              resendText,
              style: TextStyle(
                color: color,
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
