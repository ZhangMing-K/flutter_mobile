import 'package:get/get.dart';
import '../controllers/institution_connect_landing_controller.dart';

class InstitutionConnectLandingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InstitutionConnectLandingController(authUserStore: Get.find()));
  }
}
