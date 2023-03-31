import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/pages.dart';

class ApScreenItemInput {
  final int index;
  final String title;
  final String description;
  final String imgPath;
  final String imgPathLight;
  final double imgWidth;
  final double imgHeight;
  const ApScreenItemInput(
      {required this.index,
      required this.title,
      required this.description,
      required this.imgPath,
      required this.imgPathLight,
      required this.imgWidth,
      required this.imgHeight});
}

class AutoPilotController extends GetxController
    with StateMixin<List<Rx<TextModel>>> {
  final IAuthUserService authUserStore;
  final scrollController = ScrollController();

  final CarouselController carouselController = CarouselController();
  Rx<int> currentIndex = 0.obs;
  List<ApScreenItemInput> apScreensList = [
    const ApScreenItemInput(
      index: 0,
      title: 'Let proven investors trade for you!',
      description:
          'Automatically copy the trades of Pelosi, Ackman, Buffett or a friend, in your own broker.',
      imgPath: Images.autopilotTradeForYou,
      imgPathLight: Images.autopilotTradeForYouLight,
      imgWidth: 250,
      imgHeight: 260,
    ),
    const ApScreenItemInput(
      index: 1,
      title: 'Invest with minimal effort.',
      description:
          'Let others identify great companies for you and invest in them automatically.',
      imgPath: Images.autopilotMinimalEffort,
      imgPathLight: Images.autopilotMinimalEffortLight,
      imgWidth: 214,
      imgHeight: 225,
    ),
    const ApScreenItemInput(
      index: 2,
      title: 'How does it work?',
      description:
          'Pick a Pilot, decide how much money you want to Autopilot, and watch your portfolio copy your Pilot\'s trades automatically.',
      imgPath: Images.autopilotHowItWorks,
      imgPathLight: Images.autopilotHowItWorksLight,
      imgWidth: 198,
      imgHeight: 200,
    ),
    const ApScreenItemInput(
      index: 3,
      title: 'All in your broker.',
      description:
          'None of your current holdings will be affected by Autopilot trades and your money NEVER leaves your brokerage. ',
      imgPath: Images.autopilotAllInBroker,
      imgPathLight: Images.autopilotAllInBrokerLight,
      imgWidth: 164,
      imgHeight: 186,
    ),
  ];

  AutoPilotController({
    required this.authUserStore,
  });

  int? get loggedUserKey {
    return authUserStore.loggedUser?.userKey;
  }
}
