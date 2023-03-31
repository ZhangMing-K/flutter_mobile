import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_mobile/app/modules/onboarding/components/onboarding_cards.dart';

import '../../../routes/pages.dart';
import '../../onboarding/components/by_continuing.dart';
import '../controllers/welcome_controller.dart';

class WelcomeMobileScreen extends GetView<WelcomeController> {
  const WelcomeMobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: IrisScreenUtil.dWidth(24.0),
                  vertical: IrisScreenUtil.dWidth(32)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: IrisScreenUtil.dWidth(40),
                        ),
                        SizedBox(
                          child: Hero(
                              tag: 'irislogo',
                              child: Image.asset(
                                Images.irisWhiteLogo,
                                color: context.theme.colorScheme.secondary,
                              )),
                          height: IrisScreenUtil.dWidth(80),
                        ),
                        SizedBox(
                          height: IrisScreenUtil.dWidth(10),
                        ),
                        AutoSizeText(
                          'Invest with the best.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: IrisScreenUtil.dFontSize(26),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    //  const ChartSample(),
                    const OnboardingCards(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: IrisScreenUtil.dWidth(44),
                          width: context.width,
                          child: ElevatedButton(
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: IrisScreenUtil.dFontSize(16)),
                            ),
                            onPressed: () {
                              Get.toNamed(Paths.PhoneNumberPicker);
                            },
                          ),
                        ),
                        SizedBox(height: IrisScreenUtil.dWidth(16)),
                        SizedBox(
                          height: IrisScreenUtil.dWidth(44),
                          width: context.width,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.grey)),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: IrisScreenUtil.dFontSize(16)),
                            ),
                            onPressed: () {
                              Get.toNamed(Paths.LoginPhone);
                              // Get.toNamed(Paths.Login.createPath([true]));
                            },
                          ),
                        ),

                        const ByContinuing(),
                        // const SizedBox(
                        //   height: 30,
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
