import 'package:get/get.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileController(
          authUserStore: Get.find(),
          pushNotificationService: Get.find(),
          storageService: Get.find(),
          userService: Get.find(),
        ));
  }
}
