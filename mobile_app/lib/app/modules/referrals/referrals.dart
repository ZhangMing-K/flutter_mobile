import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'referrals_controller.dart';
import 'referrals_mobile.dart';

//TODO: MOVE TO BINDINGS
class ReferralsScreen extends GetView<ReferralsController> {
  @override
  final controller = Get.put(ReferralsController());

  ReferralsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReferralsMobileScreen(
      controller: controller,
    );
  }

  static String routeName() {
    return '/referrals';
  }
}
