import 'package:get/get.dart';
import '../controllers/login_phone_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(() => LoginPhoneController());
  }
}
