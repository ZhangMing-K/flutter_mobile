import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/select_institution_controller.dart';

class SelectInstitutionScreen extends GetView<SelectInstitutionController> {
  const SelectInstitutionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        title: const Text('Connect broker'),
      ),
      body: main(context),
    );
  }

  main(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Please select your broker',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(25),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          const SelectBrokerButton(
            brokerName: BROKER_NAME.ROBINHOOD,
          ),
          const SelectBrokerButton(
            brokerName: BROKER_NAME.WEBULL,
          ),
          const SelectBrokerButton(
            brokerName: BROKER_NAME.TD_AMERITRADE,
          ),
          const SelectBrokerButton(
            brokerName: BROKER_NAME.FIDELITY,
          ),
          const SelectBrokerButton(
            brokerName: BROKER_NAME.ETRADE,
            isBeta: true,
          ),
          const SelectBrokerButton(
            brokerName: BROKER_NAME.SCHWAB,
            isBeta: true,
          ),
          const SelectBrokerButton(
            brokerName: BROKER_NAME.COINBASE,
            comingSoon: true,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          ElevatedButton(
              child: const Text(
                'Don\'t see your broker?',
                style: TextStyle(
                  color: Colors.white,
                  // color: context.theme.colorScheme.secondary,
                ),
              ),
              onPressed: () async {
                String? feedbackUrl = ENV.NO_BROKER_REDIRECT_URL;
                if (feedbackUrl == null || !await launch(feedbackUrl)) {
                  Get.dialog(
                    IrisDialog(
                      title: 'From Team Iris:',
                      subtitle:
                          'We are working hard to integrate with as many brokers as possible. We will let you know as more brokers are added \n💸',
                      onConfirm: () => Get.back(),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
