import 'package:get/instance_manager.dart';
import '../controllers/phone_number_verify_controller.dart';

class PhoneNumberVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PhoneNumberVerifyController());
  }
}
