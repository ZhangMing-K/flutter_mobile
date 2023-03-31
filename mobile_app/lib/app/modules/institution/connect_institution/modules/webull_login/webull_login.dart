import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'controllers/webull_login_controller.dart';
import 'views/webull_add_accounts.dart';
import 'views/webull_email_login.dart';
import 'views/webull_header.dart';
import 'views/webull_mobile_login.dart';
import 'views/webull_security_question.dart';
import 'views/webull_trade_login.dart';
import 'views/webull_verify_code.dart';

class WebullLogin extends GetView<WebullLoginController> {
  const WebullLogin({Key? key}) : super(key: key);

  Widget header() {
    return Container(
        padding: const EdgeInsets.only(top: 40, bottom: 20),
        child: const WebullHeader());
  }

  Widget loginBody() {
    return Obx(() {
      final initialIndex = controller.activeTab$.value;
      return Container(
          height: 255,
          padding: const EdgeInsets.only(top: 30),
          child: Builder(builder: (context) {
            return IrisTabView(
              keyboardHidesTabbar: false,
              backgroundColor: context.theme.scaffoldBackgroundColor,
              initialIndex: initialIndex,
              indicatorColor: IrisColor.irisBlueLight,
              labelColor: context.isDarkMode
                  ? context.theme.colorScheme.secondary
                  : IrisColor.irisBlueLight,
              tabs: const [
                IrisTab(
                    text: 'Email Login',
                    body: WebullEmailLogin(
                      key: Key('0'),
                    )),
                IrisTab(
                    text: 'Mobile Login',
                    body: WebullMobileLogin(
                      key: Key('1'),
                    )),
              ],
              onTabChange: (int index) async {
                controller.activeTab$.value = index;
                controller.invalidCreds$.value = false;
              },
            );
          }));
    });
  }

  Widget connect() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          await controller.connect();
        },
        child: const Text(
          'Connect',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white, //context.theme.colorScheme.secondary,
          ),
        ),
      ),
    );
  }

  Widget welcome() {
    return Container(
      alignment: Alignment.centerLeft,
      child: const Text(
        'Enter your credentials',
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
      ),
    );
  }

  Widget invalidCreds() {
    return Obx(() {
      return Container(
        height: 30,
        padding: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.centerLeft,
        child: controller.invalidCreds$.value == true
            ? const Text(
                'Invalid Creds!',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 14, color: IrisColor.sellColor),
              )
            : Container(),
      );
    });
  }

  Widget body() {
    return Column(
      children: [welcome(), loginBody(), invalidCreds(), connect()],
    );
  }

  Widget indexedContent() {
    return Obx(() {
      return PageTransitionSwitcher(
          reverse: false,
          transitionBuilder: (Widget child, Animation<double> primaryAnimation,
              Animation<double> secondaryAnimation) {
            return SharedAxisTransition(
              fillColor: Colors.transparent,
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },
          child: IndexedStack(
            index: controller.currentStep$.value,
            children: [
              body(),
              const WebullVerifyCode(),
              const WebullSecurityQuestion(),
              const WebullTradeLogin(),
              const WebullAddAccounts()
            ],
          ));
    });
  }

  Widget content() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [header(), indexedContent()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: content());
  }
}
