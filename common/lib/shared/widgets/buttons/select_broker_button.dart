import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../iris_common.dart';

class SelectBrokerButton extends StatelessWidget {
  final BROKER_NAME brokerName;
  final bool comingSoon;
  final bool isBeta;

  const SelectBrokerButton({
    Key? key,
    required this.brokerName,
    this.comingSoon = false,
    this.isBeta = false,
  }) : super(key: key);

  // final SelectBrokerController c = Get.put(
  //     SelectBrokerController()); //creates 1 instance of brokerController if it doesnt already exist

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: InkWell(
        onTap: () {
          if (comingSoon) {
            Get.dialog(
              IrisDialog(
                title: 'Coming soon',
                subtitle:
                    'Coinbase is next on our list! We are excited to bring more crypto integrations to our platform.',
                onConfirm: () => Get.back(),
              ),
            );
          } else {
            routeTo();
          }
        },
        child: isBeta || comingSoon
            ? ClipRect(
                child: Banner(
                  location: BannerLocation.topEnd,
                  message: isBeta ? 'BETA' : 'COMING SOON',
                  color: Theme.of(context).primaryColor,
                  textStyle: const TextStyle(fontSize: 8.5),
                  child: _BrokerButtonContent(
                    brokerName: brokerName,
                    comingSoon: comingSoon,
                  ),
                ),
              )
            : _BrokerButtonContent(
                brokerName: brokerName,
                comingSoon: comingSoon,
              ),
      ),
    );
  }

  routeTo() {
    if (brokerName == BROKER_NAME.WEBULL ||
        brokerName == BROKER_NAME.ROBINHOOD ||
        brokerName == BROKER_NAME.TD_AMERITRADE ||
        brokerName == BROKER_NAME.FIDELITY ||
        brokerName == BROKER_NAME.SCHWAB ||
        brokerName == BROKER_NAME.ETRADE) {
      Get.toNamed(
          Paths.ConnectInstitution.createPath([describeEnum(brokerName)]),
          arguments: Get.arguments);
      return;
    }
    Get.toNamed(Paths.ConnectInstitution.createPath([describeEnum(brokerName)]),
        arguments: Get.arguments);
  }
}

class _BrokerButtonContent extends StatelessWidget {
  const _BrokerButtonContent({
    Key? key,
    required this.brokerName,
    required this.comingSoon,
  }) : super(key: key);
  final BROKER_NAME brokerName;
  final bool comingSoon;

  String mapBrokerNameToText() {
    if (brokerName == BROKER_NAME.ROBINHOOD) {
      return 'Robinhood';
    } else if (brokerName == BROKER_NAME.TD_AMERITRADE) {
      return 'TD Ameritrade';
    } else if (brokerName == BROKER_NAME.FIDELITY) {
      return 'Fidelity';
    } else if (brokerName == BROKER_NAME.WEBULL) {
      return 'Webull';
    } else if (brokerName == BROKER_NAME.SCHWAB) {
      return 'Schwab';
    } else if (brokerName == BROKER_NAME.ETRADE) {
      return 'E*TRADE';
    } else if (brokerName == BROKER_NAME.COINBASE) {
      return 'Coinbase';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          // height: ScreenUtil().setHeight(92),
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(10),
              horizontal: ScreenUtil().setHeight(10)),
          decoration: BoxDecoration(
            color: context.theme.brightness == Brightness.dark
                ? IrisColor.brokerCardOnDarkBG
                : IrisColor.brokerCardOnLightBG,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BrokerIcon(
                brokerName: brokerName,
                height: ScreenUtil().setHeight(60),
              ),
              SizedBox(width: ScreenUtil().setWidth(28)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextTitle(
                    textTitle: mapBrokerNameToText(),
                    color: context.theme.colorScheme.secondary,
                    fontSize: ScreenUtil().setSp(24),
                    align: TextAlign.center,
                  ),
                  // if (comingSoon)
                  //   Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         'Coming soon',
                  //         style: TextStyle(color: Colors.grey.shade500),
                  //       )
                  //     ],
                  //   )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
