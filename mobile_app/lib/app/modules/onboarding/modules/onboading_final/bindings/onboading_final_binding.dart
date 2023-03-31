import 'package:get/get.dart';
import '../controllers/onboarding_final_controller.dart';

class OnboardingFinalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OnboardingFinalController(
      authUserStore: Get.find(),
      pushNotificationService: Get.find(),
    ));
  }
}
