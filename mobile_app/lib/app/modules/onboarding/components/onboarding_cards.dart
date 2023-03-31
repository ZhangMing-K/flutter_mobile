import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

class OnboardingCards extends StatelessWidget {
  const OnboardingCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: IrisScreenUtil.dWidth(281),
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 0,
                child: SizedBox(
                    height: IrisScreenUtil.dWidth(252),
                    child: Image.asset(
                      Images.onboardingPerformanceCard,
                    ))),
            Positioned(
                bottom: 0,
                right: 0,
                child: SizedBox(
                    height: IrisScreenUtil.dWidth(110),
                    child: Image.asset(
                      Images.onboardingPluginCard,
                    ))),
          ],
        ));
  }
}
