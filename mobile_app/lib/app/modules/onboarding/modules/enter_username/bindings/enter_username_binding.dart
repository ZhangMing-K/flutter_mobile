import 'package:get/instance_manager.dart';
import '../controllers/enter_username_controller.dart';

class EnterUsernameBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EnterUsernameController(
      authUserStore: Get.find(),
      pictureAndFullNameController: Get.find(),
    ));
  }
}
