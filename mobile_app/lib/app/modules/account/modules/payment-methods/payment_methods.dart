import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'controllers/payment_methods_controller.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(
            color: context.theme.colorScheme.secondary,
          ),
        ),
      ),
      // body: const PaymentMethodsMobile(),
      body: const AutoPilotScreenMobile(),
    );
  }
}

class AutoPilotScreenMobile extends GetView<PaymentMethodsController> {
  const AutoPilotScreenMobile({Key? key}) : super(key: key);

  Widget header() {
    return Builder(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Images.autopilotIcon,
            height: IrisScreenUtil.dHeight(69),
            width: IrisScreenUtil.dHeight(69),
          ),
          const SizedBox(width: 5),
          Text('Autopilot',
              textScaleFactor: 1,
              style: TextStyle(
                  fontSize: IrisScreenUtil.dFontSize(40),
                  fontWeight: FontWeight.w900)),
          const SizedBox(width: 5),
          Text(
            'by iris',
            textScaleFactor: 1,
            style: TextStyle(
                color: context.theme.colorScheme.secondary.withOpacity(0.6),
                fontSize: IrisScreenUtil.dFontSize(12),
                fontWeight: FontWeight.w500,
                height:
                    2.5 // to adjust the bottom line with autopilot text (40 / 16)
                ),
          ),
        ],
      );
    });
  }

  BoxDecoration kGradientBoxDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff47E9FF),
            Color(0xffC82CFF),
          ],
          stops: [0.0, 1],
          transform: GradientRotation(1),
          tileMode: TileMode.clamp),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: IrisTabView.expanded(
        hideTab: true,
        tabs: [
          IrisTab(
            text: '',
            body: Container(
              padding: EdgeInsets.only(
                // top: IrisScreenUtil.dHeight(20),
                bottom: IrisScreenUtil.dHeight(20),
                left: IrisScreenUtil.dHeight(20),
                right: IrisScreenUtil.dHeight(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        child: header(),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'Add a payment method and join the Autopilot Club! Members get access to exclusive perks, events and giveaways.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff9e9e9e),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '✓  Access to exclusive events',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        '✓  AutoPilot merchandise',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        '✓  Access to Autopilot services',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    // margin: const EdgeInsets.symmetric(horizontal: 40),
                    height: IrisScreenUtil.dHeight(51),
                    child: InkWell(
                      onTap: () {
                        controller.updatePaymentMethod(context);
                      },
                      child: Container(
                        decoration: kGradientBoxDecoration(),
                        child: Center(
                          child: Obx(() {
                            if (controller.loadingPaymentInfo.value) {
                              return Container(
                                  alignment: Alignment.bottomLeft,
                                  child: const CupertinoActivityIndicator(
                                    radius: 8,
                                  ));
                            } else if (controller
                                .paymentMethodPreview.isEmpty) {
                              return Text(
                                "Join the club",
                                style: TextStyle(
                                  fontSize: IrisScreenUtil.dFontSize(16),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return Text(
                                controller.paymentMethodPreview,
                                style: TextStyle(
                                  fontSize: IrisScreenUtil.dFontSize(16),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              );
                            }
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        backgroundColor: context.theme.scaffoldBackgroundColor,
      ),
    );
  }
}
