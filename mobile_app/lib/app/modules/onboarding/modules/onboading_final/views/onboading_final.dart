import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../../components/onboarding_wrapper.dart';
import '../controllers/onboarding_final_controller.dart';

class OnboardingFinalScreen extends GetView<OnboardingFinalController> {
  const OnboardingFinalScreen({Key? key}) : super(key: key);

  Widget allowNotifications() {
    return Container(
      width: double.infinity,
      height: IrisScreenUtil.dWidth(60),
      padding: EdgeInsets.only(
        left: IrisScreenUtil.dWidth(16),
        right: IrisScreenUtil.dWidth(16),
      ),
      child: ElevatedButton(
        child: const Text('Allow Notifications'),
        onPressed: controller.initNotifications,
      ),
    );
  }

  Widget body() {
    final id = uuid.v4();
    final id2 = uuid.v4();
    return Container(
        padding: EdgeInsets.only(
            top: IrisScreenUtil.dWidth(63),
            bottom: IrisScreenUtil.dWidth(177),
            left: IrisScreenUtil.dWidth(8),
            right: IrisScreenUtil.dWidth(8)),
        child: Column(
          children: [
            userCard(
                Images.girl2,
                BROKER_NAME.ROBINHOOD,
                'Ashley Johnson',
                const Asset(
                    pictureUrl:
                        'https://storage.googleapis.com/iris-main-prod/assets/symbol-pictures/spce.jpg',
                    symbol: 'SPCE'),
                id,
                ' bought 50% more SPCE at \$19.84!',
                '1'),
            SizedBox(height: IrisScreenUtil.dWidth(24)),
            userCard(
                Images.guy1,
                BROKER_NAME.WEBULL,
                'Jake Smith',
                const Asset(
                    pictureUrl:
                        'https://storage.googleapis.com/iex/api/logos/TSLA.png',
                    symbol: 'TSLA'),
                id2,
                ' sold 50% of their TSLA and made 42%!',
                '5'),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingWrapper(
      onSkip: controller.goToFeed,
      horizontalPadding: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.only(
                  top: IrisScreenUtil.dWidth(15),
                  right: IrisScreenUtil.dWidth(21),
                  left: IrisScreenUtil.dWidth(21)),
              child: Text(
                  'Timing is everything! Never miss an investment opportunity again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: IrisScreenUtil.dFontSize(21),
                      fontWeight: FontWeight.w700))),
          SizedBox(height: IrisScreenUtil.dWidth(8)),
          SizedBox(
              width: IrisScreenUtil.dWidth(318),
              child: Text(
                'Allow notifications to see your friend\'s trades in real time and messages to you.',
                style: TextStyle(
                    color: context.theme.colorScheme.secondary.withOpacity(0.6),
                    fontSize: IrisScreenUtil.dFontSize(14),
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              )),
          body(),
          allowNotifications()
        ],
      ),
    );
  }

  Widget routeSelect(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DefaultTextTitle(
          textTitle: 'What would you like to see first?',
          fontSize: ScreenUtil().setSp(TextUnit.small),
          fontWeight: FontWeight.w500,
          color: context.theme.colorScheme.secondary,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IrisDescriptionCard(
            title: 'Posts',
            description: 'See what the community is talking about.',
            image: Images.onboardingPosts,
            onTap: () {
              controller.goToFeed();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IrisDescriptionCard(
            title: 'Analytics',
            description:
                'Gain insights from the trades of other retail investors.',
            image: Images.onboardingAnalytics,
            onTap: () {
              controller.goToTrendings();
            },
          ),
        ),
      ],
    );
  }

  Widget userCard(String imagePath, BROKER_NAME brokerName, String fullName,
      Asset asset, id, String text, String nbrMin) {
    return Builder(
      builder: (context) => ListTile(
        contentPadding: EdgeInsets.symmetric(
            vertical: IrisScreenUtil.dWidth(10),
            horizontal: IrisScreenUtil.dWidth(8)),
        tileColor: context.theme.backgroundColor,
        leading: AbsorbPointer(
            child: ProfileImage(
          radius: 25,
          networkImage: false,
          url: imagePath,
          uuid: id,
        )),
        trailing: AbsorbPointer(child: AppAssetImage(asset: asset)),
        title: SizedBox(
          width: IrisScreenUtil.dWidth(300),
          child: Wrap(
            children: [
              RichText(
                textScaleFactor: context.textScaleFactor,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: IrisScreenUtil.dFontSize(15.0),
                    color: context.theme.colorScheme.secondary,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: fullName,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: text,
                    ),
                    TextSpan(
                        text: ' $nbrMin min',
                        style: TextStyle(
                            color: context.theme.colorScheme.secondary
                                .withOpacity(0.6))),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
