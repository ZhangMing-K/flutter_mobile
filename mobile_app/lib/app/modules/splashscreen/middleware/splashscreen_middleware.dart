import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import 'package:iris_mobile/app/shared/consts/app_config.dart';

import '../../../routes/pages.dart';

class SplashScreenMiddleware extends GetMiddleware {
  final IStorage storage = Get.find();
  final IAuthUserService authUserStore = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    /// uncomment to show onboarding again
    // storage.secure.delete(key: kVideoShowOnboarding);

    ///Or to bypass
    //storage.secure.write(key: kVideoShowOnboarding, value: '');
    final isLoggedUser = authUserStore.loggedIn;

    final hasOnboarding = authUserStore.onboadingDisplayed;

    if (hasOnboarding || isLoggedUser || GetPlatform.isWeb) {
      const feed = RouteSettings(name: Paths.Feed);
      final welcome = RouteSettings(name: Paths.Welcome.createPath([true]));
      return isLoggedUser ? feed : welcome;
    } else {
      return null;
    }
  }
}
