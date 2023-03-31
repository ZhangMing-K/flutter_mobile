import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../../../routes/pages.dart';
import '../../../onboarding/components/onboarding_wrapper.dart';
import '../../connect_institution/views/diagonal_line.dart';
import '../controllers/institution_connect_landing_controller.dart';

class InstitutionConnectLandingScreen
    extends GetView<InstitutionConnectLandingController> {
  const InstitutionConnectLandingScreen({Key? key}) : super(key: key);

  Widget brokersSection(BuildContext context) {
    return Center(
        child: SizedBox(
      height: ScreenUtil().setHeight(170),
      width: ScreenUtil().setHeight(226),
      child: Stack(
        children: <Widget>[
          Positioned(
              left: 0,
              bottom: ScreenUtil().setHeight(37),
              child: SizedBox(
                  height: ScreenUtil().setHeight(40),
                  width: ScreenUtil().setHeight(56),
                  child: Row(
                    children: [
                      SizedBox(
                          width: ScreenUtil().setHeight(40),
                          height: ScreenUtil().setHeight(40),
                          child: const BrokerIcon(
                            brokerName: BROKER_NAME.WEBULL,
                            useAltLogo: true,
                          )),
                      Container(
                        width: ScreenUtil().setHeight(16),
                        height: ScreenUtil().setHeight(2),
                        color: IrisColor.irisGrey,
                      )
                    ],
                  ))),
          Positioned(
              left: ScreenUtil().setHeight(23),
              top: ScreenUtil().setHeight(26),
              width: ScreenUtil().setHeight(56),
              height: ScreenUtil().setHeight(56),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      bottom: ScreenUtil().setHeight(3),
                      right: ScreenUtil().setHeight(5),
                      child: const DiagonalLine(
                        direction: 'left',
                      )),
                  Positioned(
                    child: SizedBox(
                        width: ScreenUtil().setHeight(40),
                        height: ScreenUtil().setHeight(40),
                        child: const BrokerIcon(
                            brokerName: BROKER_NAME.TD_AMERITRADE)),
                  ),
                ],
              )),
          Positioned(
              left: ScreenUtil().setHeight(93),
              top: 0,
              child: Column(
                children: [
                  SizedBox(
                      width: ScreenUtil().setHeight(40),
                      height: ScreenUtil().setHeight(40),
                      child:
                          const BrokerIcon(brokerName: BROKER_NAME.ROBINHOOD)),
                  Container(
                    width: ScreenUtil().setHeight(2),
                    height: ScreenUtil().setHeight(16),
                    color: IrisColor.irisGrey,
                  )
                ],
              )),
          Positioned(
              right: ScreenUtil().setHeight(23),
              top: ScreenUtil().setHeight(26),
              width: ScreenUtil().setHeight(56),
              height: ScreenUtil().setHeight(56),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      bottom: ScreenUtil().setHeight(3),
                      left: ScreenUtil().setHeight(5),
                      child: const DiagonalLine(
                        direction: 'right',
                      )),
                  Positioned(
                    left: ScreenUtil().setHeight(12),
                    top: 0,
                    child: SizedBox(
                        width: ScreenUtil().setHeight(40),
                        height: ScreenUtil().setHeight(40),
                        child:
                            const BrokerIcon(brokerName: BROKER_NAME.FIDELITY)),
                  ),
                ],
              )),
          Positioned(
              right: 0,
              bottom: ScreenUtil().setHeight(37),
              child: SizedBox(
                  height: ScreenUtil().setHeight(40),
                  width: ScreenUtil().setHeight(56),
                  child: Row(
                    children: [
                      Container(
                          width: ScreenUtil().setHeight(16),
                          height: ScreenUtil().setHeight(2),
                          color: IrisColor.irisGrey),
                      SizedBox(
                          width: ScreenUtil().setHeight(40),
                          height: ScreenUtil().setHeight(40),
                          child:
                              const BrokerIcon(brokerName: BROKER_NAME.ETRADE)),
                    ],
                  ))),
          Positioned(
            left: ScreenUtil().setHeight(56),
            bottom: 0,
            child: SizedBox(
              width: ScreenUtil().setHeight(114),
              height: ScreenUtil().setHeight(114),
              child: CircleAvatar(
                backgroundColor: context.theme.backgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Images.irisWhiteLogo,
                        color: context.theme.colorScheme.secondary,
                        width: ScreenUtil().setWidth(82)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return controller.isOnboarding
        ? OnboardingWrapper(
            child: layout('Connect your portfolio'),
            title: '',
            onSkip: controller.onNext,
          )
        : Scaffold(
            appBar: AppBar(
              foregroundColor: Theme.of(context).colorScheme.onBackground,
              title: const Text('Connect your portfolio'),
            ),
            body: layout(null),
          );
  }

  Widget continueButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: ScreenUtil().setHeight(40), right: 15, left: 15),
      child: Builder(builder: (context) {
        return SizedBox(
          width: context.width - IrisScreenUtil.dWidth(32),
          height: ScreenUtil().setHeight(58),
          child: ElevatedButton(
            onPressed: () {
              Get.toNamed(Paths.SelectInstitution,
                  arguments: Get.arguments); //pass on arguemtns
            },
            child: Text(
              controller.isOnboarding ? 'Connect' : 'Continue',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget insightSection(BuildContext context) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const <Widget>[Icon(UniconsLine.chart_line)],
      ),
      title: Text('Community',
          style: TextStyle(
              color: context.theme.colorScheme.secondary,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(18))),
      subtitle: Text(
          // 'Learn insights about your portfolio like trading accuracy and profit breakdowns along with qualifying for the interactive leaderboards.',
          'Join our community of 15,000+ connected portfolios and \$300 Million+ of connected assets.',
          style: TextStyle(
              color: context.theme.colorScheme.secondary,
              fontSize: ScreenUtil().setSp(14),
              fontWeight: FontWeight.w300)),
    );
  }

  Widget layout(String? title) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: viewportConstraints.maxHeight,
          ),
          child: main(context, title),
        ),
      );
    });
  }

  Widget main(BuildContext context, String? title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? '',
          style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: context.theme.colorScheme.secondary,
              fontWeight: FontWeight.w700),
        ),
        brokersSection(context),
        Column(
          children: [
            secureSection(context),
            const SizedBox(height: 24),
            privateSection(context),
            const SizedBox(height: 24),
            insightSection(context),
          ],
        ),
        continueButton(context)
      ],
    );
  }

  Widget privateSection(BuildContext context) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const <Widget>[Icon(UniconsLine.lock)],
      ),
      title: Text('Private',
          style: TextStyle(
              color: context.theme.colorScheme.secondary,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(18))),
      subtitle: Text(
          'Choose between making your portfolio private or public, with no dollar amounts ever shown.',
          style: TextStyle(
              color: context.theme.colorScheme.secondary,
              fontSize: ScreenUtil().setSp(14),
              fontWeight: FontWeight.w300)),
    );
  }

  Widget secureSection(BuildContext context) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const <Widget>[Icon(IrisIcon.secure)],
      ),
      title: Text('Secure',
          style: TextStyle(
              color: context.theme.colorScheme.secondary,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(18))),
      subtitle: Text(
          'Bank level security with full encryption for your financial data.',
          style: TextStyle(
              color: context.theme.colorScheme.secondary,
              fontSize: ScreenUtil().setSp(14),
              fontWeight: FontWeight.w300)),
    );
  }
}
