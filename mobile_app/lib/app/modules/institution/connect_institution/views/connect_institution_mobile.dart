import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/institution/connect_institution/modules/etrade/etrade_login.dart';

import '../controllers/connect_institution_controller.dart';
import '../modules/fidelity/fidelity_login.dart';
import '../modules/robinhood/robinood_login.dart';
import '../modules/schwab/schwab_login.dart';
import '../modules/td_ameritrade/td_ameritrade_login.dart';
import '../modules/webull_login/webull_login.dart';

class ConnectInstitutionMobile extends GetView<ConnectInstitutionController> {
  const ConnectInstitutionMobile({Key? key}) : super(key: key);

  Widget main() {
    if (controller.institutionName == INSTITUTION_NAME.WEBULL) {
      return const WebullLogin();
    } else if (controller.institutionName == INSTITUTION_NAME.ROBINHOOD) {
      return const RobinhoodLogin();
    } else if (controller.institutionName == INSTITUTION_NAME.TD_AMERITRADE) {
      return const TDAmeritradeLogin();
    } else if (controller.institutionName == INSTITUTION_NAME.FIDELITY) {
      return const FidelityLogin();
    } else if (controller.institutionName == INSTITUTION_NAME.ETRADE) {
      return const EtradeLogin();
    } else if (controller.institutionName == INSTITUTION_NAME.SCHWAB) {
      return const SchwabLogin();
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        title: const Text('Connect Broker'),
      ),
      body: main(),
    );
  }
}
