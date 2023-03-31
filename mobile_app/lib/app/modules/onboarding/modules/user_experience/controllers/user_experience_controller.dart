import 'package:get/get.dart';

import '../../../../../routes/pages.dart';

class UserExperienceController extends GetxController {
  UserExperienceController({required this.userService});
  final UserService userService;

  void setExperienceLevel(EXPERIENCE_LEVEL lvl) {
    userService.userEdit(experienceLevel: lvl);
    Get.toNamed(Paths.OnboardingFinal);
  }
}
