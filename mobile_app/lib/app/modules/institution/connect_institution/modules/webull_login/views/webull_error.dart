import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/webull_login_controller.dart';

class WebullError extends GetWidget<WebullLoginController> {
  const WebullError({this.titleText, this.bodyText, Key? key})
      : super(key: key);

  final String? titleText;
  final String? bodyText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
    );
  }
}
