import 'package:get/instance_manager.dart';
import '../controllers/phone_number_picker_controller.dart';

class PhoneNumberPickerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PhoneNumberPickerController());
  }
}
