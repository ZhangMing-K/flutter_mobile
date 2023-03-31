import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/auto_pilot_controller.dart';
import 'views/auto_pilot_mobile.dart';
import 'views/auto_pilot_web.dart';

class AutoPilotScreen extends GetView<AutoPilotController> {
  const AutoPilotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? const AutoPilotScreenWeb() : const AutoPilotScreenMobile();
  }
}
