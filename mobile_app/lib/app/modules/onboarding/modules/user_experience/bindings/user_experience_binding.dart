import 'package:get/get.dart';

import '../controllers/user_experience_controller.dart';

class UserExperienceBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserExperienceController(userService: Get.find()));
  }
}
