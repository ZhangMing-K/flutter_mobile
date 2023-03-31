import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/td_ameritrade_login_controller.dart';

class TDAmeritradeOauth extends GetWidget<TDAmeritradeLoginController> {
  const TDAmeritradeOauth({Key? key}) : super(key: key);

  oauthBroker(BuildContext context) {
    final containerHeight = MediaQuery.of(context).size.height;
    return Container(
        height: containerHeight / 1.5,
        alignment: Alignment.center,
        child: const Text('Redirecting...',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)));
  }

  @override
  Widget build(BuildContext context) {
    return oauthBroker(context);
  }
}
