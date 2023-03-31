import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../routes/pages.dart';

class SplashScreenController extends GetxController {
  late final VideoPlayerController videoPlayerController;
  final ISecureStorage storage = Get.find();
  final IAuthUserService authUser = Get.find();

  final splashState = SplashState.loading.obs;

  RxBool volumeOn = false.obs;

  Future<void> navigateToLogin() async {
    splashState(SplashState.logo);
    await storage.write(key: kVideoShowOnboarding, value: 'true');
    await Future.delayed(const Duration(seconds: 1));

    Get.toNamed(
        authUser.loggedIn ? Paths.Feed : Paths.Welcome.createPath([true]));
    // videoPlayerController.dispose();
  }

  // @override
  // void onClose() {
  //   videoPlayerController.removeListener(_listener);
  //   super.onClose();
  // }

  @override
  void onInit() {
    super.onInit();
    navigateToLogin();
    // videoPlayerController = VideoPlayerController.asset('assets/onboarding.mp4')
    //   ..initialize().then((value) {
    //     splashState(SplashState.playing);
    //     videoPlayerController.addListener(_listener);
    //     videoPlayerController.setLooping(false);
    //     videoPlayerController.setVolume(0.0);
    //     videoPlayerController.play();
    //   });
  }

  void toggleVolume() {
    HapticFeedback.mediumImpact();
    if (volumeOn.value) {
      volumeOn.value = false;
      videoPlayerController.setVolume(0.0);
    } else {
      volumeOn.value = true;
      videoPlayerController.setVolume(100.0);
    }
  }

  // void _listener() {
  //   if (!videoPlayerController.value.isPlaying &&
  //       videoPlayerController.value.isInitialized &&
  //       (videoPlayerController.value.duration ==
  //           videoPlayerController.value.position)) {
  //     //checking the duration and position every time
  //     //Video Completed//
  //     navigateToLogin();
  //   }
  // }
}

enum SplashState {
  loading,
  playing,
  logo,
}
