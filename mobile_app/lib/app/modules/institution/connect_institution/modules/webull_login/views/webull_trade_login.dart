import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:pinput/pinput.dart';

import '../controllers/webull_login_controller.dart';

class WebullTradeLogin extends GetView<WebullLoginController> {
  const WebullTradeLogin({Key? key}) : super(key: key);

  Widget content() {
    return Column(children: [header(), main(), invalidCreds()]);
  }

  Widget invalidCreds() {
    return Obx(() {
      return Container(
        height: 30,
        padding: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.centerLeft,
        child: controller.invalidTradeLogin$.value == true
            ? const Text(
                'Invalid Trade Login Code!',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 14, color: IrisColor.sellColor),
              )
            : Container(),
      );
    });
  }

  Widget header() {
    return Container(
      alignment: Alignment.centerLeft,
      child: const Text(
        'Enter trade login',
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
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
          borderRadius: BorderRadius.circular(20),
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
          controller: controller.pinCodeTradLoginController,
          onCompleted: (code) {
            controller.enterTradeLogin(code);
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

  @override
  Widget build(BuildContext context) {
    return content();
  }
}
