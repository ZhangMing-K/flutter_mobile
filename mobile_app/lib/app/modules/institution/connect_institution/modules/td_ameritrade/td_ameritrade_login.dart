import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../views/institution_image.dart';
import 'controllers/td_ameritrade_login_controller.dart';
import 'views/td_ameritrade_add_accounts.dart';
import 'views/td_ameritrade_oauth.dart';

class TDAmeritradeLogin extends GetWidget<TDAmeritradeLoginController> {
  const TDAmeritradeLogin({Key? key}) : super(key: key);

  Widget body() {
    return Column(
      children: const [TDAmeritradeOauth()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: content());
  }

  Widget content() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [indexedContent()],
      ),
    );
  }

  Widget header() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        SizedBox(
          height: 40,
        ),
        InstitutionImage(
          institionName: INSTITUTION_NAME.TD_AMERITRADE,
        ),
        SizedBox(
          height: 40,
        ),
      ],
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
            children: [body(), const TDAmeritradeAddAccounts()],
          ));
    });
  }
}
