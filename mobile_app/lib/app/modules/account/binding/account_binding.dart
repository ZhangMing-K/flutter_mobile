import 'package:get/get.dart';

import '../account_controller.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      AccountController(
        workspaceService: Get.find(),
        authUserStore: Get.find(),
      ),
    );
  }
}
