import 'package:get/instance_manager.dart';

import '../controllers/enter_useremail_controller.dart';

class EnterUseremailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EnterUseremailController(
      authUserStore: Get.find(),
      storageService: Get.find(),
      userService: Get.find(),
      authService: Get.find(),
    ));
  }
}
