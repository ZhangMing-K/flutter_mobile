import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class SupportedBrokers extends StatelessWidget {
  const SupportedBrokers({Key? key}) : super(key: key);

  Widget brokerImage(String image, {required bool blend}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        image,
        height: 45,
        color: blend ? Colors.black38 : null,
        colorBlendMode: blend ? BlendMode.multiply : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textScale = context.textScaleFactor;
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextTitle(
                  textTitle: ' Supported brokers', fontSize: 15 * textScale),
              const SizedBox(height: 16),
              supportedBrokers(),
            ],
          ),
        ],
      ),
    );
  }

  Widget comingSoon() {
    return SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          brokerImage(Images.coinbaseIcon, blend: false),
        ],
      ),
    );
  }

  Widget supportedBrokers() {
    return SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          brokerImage(Images.robinhoodLogo, blend: false),
          const SizedBox(width: 6),
          brokerImage(Images.tdAmeritradeLogo, blend: false),
          const SizedBox(width: 6),
          brokerImage(Images.fidelityLogo, blend: false),
          const SizedBox(width: 6),
          brokerImage(Images.webullLogo, blend: false),
          const SizedBox(width: 6),
          brokerImage(Images.etradeLogo, blend: false),
        ],
      ),
    );
  }
}
