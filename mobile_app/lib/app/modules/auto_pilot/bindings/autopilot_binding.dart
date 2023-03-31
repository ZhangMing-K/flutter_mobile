import 'package:get/get.dart';
import '../controllers/auto_pilot_controller.dart';

class AutoPilotBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AutoPilotController(
      authUserStore: Get.find(),
    ));
  }
}
