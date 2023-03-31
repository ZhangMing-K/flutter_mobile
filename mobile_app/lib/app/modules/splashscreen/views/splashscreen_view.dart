import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:video_player/video_player.dart';

import '../controllers/splashscreen_controller.dart';

class IrisLogoWidget extends GetView<SplashScreenController> {
  const IrisLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IrisFadeSize(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(context.width / 4),
          child: Hero(
            tag: 'irislogo',
            child: Image.asset(Images.irisWhiteLogo),
          ),
        ),
      ),
      visible: true,
    );
  }
}

class PlayingWidget extends GetView<SplashScreenController> {
  const PlayingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: controller.videoPlayerController.value.size.width,
                height: controller.videoPlayerController.value.size.height,
                child: VideoPlayer(controller.videoPlayerController),
              ),
            ),
          ),
          Positioned(
              top: 50,
              right: 20,
              child: GestureDetector(
                  onTap: () {
                    controller.navigateToLogin();
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ))),
          Positioned(
              bottom: 20,
              right: 20,
              child: Obx(() {
                return GestureDetector(
                    onTap: () {
                      controller.toggleVolume();
                    },
                    child: Container(
                      child: (controller.volumeOn.value)
                          ? const Icon(
                              CupertinoIcons.speaker_zzz,
                              color: Colors.white,
                              size: 40,
                            )
                          : const Icon(
                              CupertinoIcons.speaker_2,
                              color: Colors.white,
                              size: 40,
                            ),
                    ));
              })),
        ],
      ),
    );
  }
}

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.splashState.value) {
        case SplashState.loading:
          return const SizedBox.shrink();
        case SplashState.playing:
          return const PlayingWidget();
        case SplashState.logo:
          return const IrisLogoWidget();
      }
    });
  }
}
