import 'package:get/get.dart';
import '../controllers/select_institution_controller.dart';

class SelectInstitutionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SelectInstitutionController(authUserStore: Get.find()));
  }
}
