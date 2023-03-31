import 'package:get/get.dart';

import '../controllers/mfa_contact_connect_controller.dart';

class MfaContactConnectBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MfaContactConnectController(mfaContactService: Get.find()));
  }
}
