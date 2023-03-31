import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/explorer_controller.dart';
import 'views/explorer_mobile.dart';
import 'views/explorer_web.dart';

class ExplorerScreen extends GetView<ExplorerController> {
  const ExplorerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? const ExplorerScreenWeb() : const ExplorerScreenMobile();
  }
}
