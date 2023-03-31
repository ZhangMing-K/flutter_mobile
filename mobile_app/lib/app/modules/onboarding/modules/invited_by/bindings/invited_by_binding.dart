import 'package:get/instance_manager.dart';
import '../controllers/invited_by_controller.dart';

class InvitedByBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InvitedByController(userContactService: Get.find()));
  }
}
