import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class AppController extends GetxController {
  static AppController get to => Get.find();

  final IStorage storage;
  final IAuthUserService authUserStore;
  final PushNotificationService pushNotificationService;

  AppController(
      {required this.storage,
      required this.authUserStore,
      required this.pushNotificationService});

  @override
  void onInit() {
    try {
      final IAuthUserService authUserStore = Get.find();
      // NOTE(Taro): errors are handled gracefully
      // in identifyInPosthog and identifyInSmartlook
      identifyInPosthog(authUserStore.loggedUser);
      // identifyInSmartlook(authUserStore.loggedUser);
    } catch (err) {
      debugPrint('MyApp: $err');
    }

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    // Get.changeThemeMode(ThemeMode.system);
    Get.window.onPlatformBrightnessChanged = () {
      setStatusBarIconsColor();
      update();
    };
    setStatusBarIconsColor();

    super.onInit();
  }

  @override
  void onReady() {
    IrisConnectivity.to.isConnected.listen((connected) {
      if (connected && authUserStore.loggedIn && !authUserStore.authUserIsSet) {
        setAuthUser();
      }
    });

    super.onReady();
  }

  Future<void> setAuthUser() async {
    final user = await pushNotificationService.getAuthUserNotifications();
    if (user != null) authUserStore.editUserData(user);
  }

  void setStatusBarIconsColor() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      SystemChrome.setSystemUIOverlayStyle(Get.isPlatformDarkMode
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark
              .copyWith(statusBarColor: Colors.transparent));
    });
  }
}
