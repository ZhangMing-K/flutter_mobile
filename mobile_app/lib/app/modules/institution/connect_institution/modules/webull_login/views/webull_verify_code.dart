import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:pinput/pinput.dart';

import '../controllers/webull_login_controller.dart';

class WebullVerifyCode extends GetView<WebullLoginController> {
  const WebullVerifyCode({Key? key}) : super(key: key);

  Widget instructions() {
    return Obx(() {
      final String challengeInstructions =
          controller.connectResponse$.value?.challengeType ==
                  INSTITUTION_CONNECT_CHALLENGE_TYPE.EMAIL
              ? 'A verification code was just sent to your email'
              : 'A verification code was just texted to you';
      return Container(
        padding: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.centerLeft,
        child: Text(
          challengeInstructions,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.start,
        ),
      );
    });
  }

  Widget error() {
    return Obx(() {
      return Container(
        height: 60,
        padding: const EdgeInsets.only(
          top: 10,
        ),
        alignment: Alignment.centerLeft,
        child: controller.institutionConnectErrorText$.value.isNotEmpty
            ? Text(
                controller.institutionConnectErrorText$.value,
                textAlign: TextAlign.start,
                style:
                    const TextStyle(fontSize: 14, color: IrisColor.sellColor),
              )
            : Container(),
      );
    });
  }

  Widget header() {
    return Obx(
      () {
        return controller.connectResponse$.value != null
            ? Column(
                children: [
                  instructions(),
                ],
              )
            : Container();
      },
    );
  }

  Widget resend({
    required String resendText,
    String? resendPrefixText,
  }) {
    return Obx(() {
      final expire = controller.timeExpired$.value;
      return Builder(builder: (context) {
        final color = expire ? IrisColor.sellColor : context.theme.hintColor;
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
      });
    });
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
          border: Border.all(color: Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
      );

      final focusedPinTheme = defaultPinTheme.copyDecorationWith(
        border: Border.all(color: IrisColor.irisBlueLight, width: 2),
        borderRadius: BorderRadius.circular(8),
      );

      final submittedPinTheme = defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration?.copyWith(
          border: Border.all(color: boxColor, width: 2),
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
          controller: controller.pinCodeController,
          onCompleted: (code) async {
            await controller
                .verifyCode(controller.pinCodeController.value.text);
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

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(children: [
        header(),
        main(),
        resend(resendPrefixText: "Still don't see it?", resendText: 'Resend'),
        error(),
      ]);
    });
  }
}
