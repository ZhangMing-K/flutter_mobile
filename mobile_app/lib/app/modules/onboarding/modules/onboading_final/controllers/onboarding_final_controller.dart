import 'package:get/get.dart';

import '../../../../../routes/pages.dart';

class OnboardingFinalController extends GetxController {
  OnboardingFinalController(
      {required this.authUserStore, required this.pushNotificationService});

  final IAuthUserService authUserStore;
  final PushNotificationService pushNotificationService;

  Future<void> initNotifications() async {
    goToFeed();
  }

  void goToFeed() {
    Get.offAllNamed(Paths.Feed);
  }

  void goToTrendings() {
    Get.offAllNamed(Paths.Trending);
  }
}
