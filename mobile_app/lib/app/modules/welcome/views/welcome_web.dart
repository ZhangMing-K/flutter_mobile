import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/pages.dart';
import '../../onboarding/components/by_continuing.dart';
import '../../onboarding/components/supported_brokers.dart';
import '../controllers/welcome_controller.dart';

const kPrivacyPolicyUrl = 'https://www.iris.finance/privacy-policy';
const kTermsOfServiceUrl = 'https://www.iris.finance/terms-and-conditions';

class LoginCard extends StatelessWidget {
  const LoginCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Get.height / 20),
      decoration: BoxDecoration(
        color: context.theme.backgroundColor,
        borderRadius: BorderRadius.circular(40),
      ),
      constraints: BoxConstraints(
        maxWidth: Get.width * 0.7,
        //minWidth: context.width,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  SizedBox(
                    child: Hero(
                        tag: 'irislogo',
                        child: Image.asset(Images.irisWhiteLogo)),
                    height: 90,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Invest together.',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   height: 50,
                  //   width: ScreenUtil().setWidth(331),
                  //   child: ElevatedButton(
                  //     child: Text(
                  //       'Sign up',
                  //       style: TextStyle(
                  //           color: context.theme.colorScheme.secondary,
                  //           fontSize: 20),
                  //     ),
                  //     onPressed: () {
                  //       Get.toNamed(Paths.Onboarding);
                  //     },
                  //   ),
                  // ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 50,
                    width: ScreenUtil().setWidth(331),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: context.theme.colorScheme.secondary,
                            fontSize: 20),
                      ),
                      onPressed: () {
                        Get.toNamed(Paths.Login.createPath([true]));
                      },
                    ),
                  ),
                  const FittedBox(
                    child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: SupportedBrokers()),
                  ),
                  const FittedBox(child: ByContinuing()),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomeWebScreen extends GetView<WelcomeController> {
  const WelcomeWebScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveWrapper(
        child: LoginCard(),
      ),
    );
  }
}
