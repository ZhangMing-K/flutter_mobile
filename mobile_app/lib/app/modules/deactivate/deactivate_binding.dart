import 'package:get/get.dart';

import 'deactivate_controller.dart';

class DeactivateBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DeactivateController());
  }
}
