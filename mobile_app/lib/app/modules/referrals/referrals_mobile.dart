import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'referrals_controller.dart';

class ReferralsMobileScreen extends StatelessWidget {
  final ReferralsController controller;
  const ReferralsMobileScreen({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO(Taro): Remember that you removed padding within the FullScreenDialog
    // and now you need to add padding where FullScreenDialog has been used!
    return FullScreenDialog(
      canGoBack: true,
      replaceTitleWithLogo: true,
      children: [
        Center(child: title()),
        Container(
            child: Center(child: subtitle()),
            width: HorizontalUnit.extraLarge,
            margin: const EdgeInsets.only(top: SpaceUnit.small)),
        content(),
        //customizeInvitation(context),
        const Spacer(),
        buttonGroup(context),
      ],
    );
  }

  Widget buttonGroup(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: SafeArea(
            child: Container(
                margin: const EdgeInsets.only(
                    left: SpaceUnit.extraSmall, right: SpaceUnit.extraSmall),
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: OutlinedButton(
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all(
                                        context.theme.primaryColor),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            vertical: SpaceUnit.extraSmall))),
                                child: const Text('Copy Invite Link',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: TextUnit.medium,
                                        fontWeight: FontWeight.w500)),
                                onPressed: controller.copy))
                      ],
                    ),
                    const SizedBox(
                      height: SpaceUnit.medium,
                    ),
                    Row(children: [
                      Expanded(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          vertical: SpaceUnit.extraSmall))),
                              child: const Text('Invite a Friend!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: TextUnit.medium,
                                      fontWeight: FontWeight.w500)),
                              onPressed: controller.share))
                    ]),
                    const SizedBox(
                      height: SpaceUnit.medium,
                    ),
                  ],
                ))));
  }

  Widget callToAction({bool? isEnabled}) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: SafeArea(
            child: Container(
                margin: const EdgeInsets.only(
                    bottom: SpaceUnit.extraSmall,
                    left: SpaceUnit.extraSmall,
                    right: SpaceUnit.extraSmall),
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                vertical: SpaceUnit.extraSmall))),
                    child: const Text('Invite a Friend!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: TextUnit.medium,
                            fontWeight: FontWeight.w500)),
                    onPressed: controller.share))));
  }

  Widget content() {
    return GetBuilder<ReferralsController>(builder: (c) {
      if (c.isLoading) return loader();
      return Column(children: [
        Center(
          child: progress(),
        ),
        if (c.progress >= 1) success(),
      ]);
    });
  }

  Widget loader() {
    return Container(
      margin: const EdgeInsets.only(top: 60),
      height: 200,
      child: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Builder(builder: (context) {
            return CircularProgressIndicator(
              strokeWidth: 12,
              //value: max(c.progress, 0.02),
              valueColor:
                  AlwaysStoppedAnimation<Color>(context.theme.primaryColor),
              backgroundColor: Colors.blueGrey.withOpacity(0.1),
            );
          }),
        ),
      ),
    );
  }

  Widget progress() {
    return GetBuilder<ReferralsController>(builder: (c) {
      final double diameter = c.progress >= 1 ? 120 : 200;
      return Container(
        margin: const EdgeInsets.only(top: 60),
        height: diameter,
        child: Stack(
          children: <Widget>[
            Center(
              child: SizedBox(
                width: diameter,
                height: diameter,
                child: Builder(builder: (context) {
                  return CircularProgressIndicator(
                    strokeWidth: 12,
                    value: max(c.progress, 0.02),
                    valueColor: AlwaysStoppedAnimation<Color>(
                        context.theme.primaryColor),
                    backgroundColor: Colors.blueGrey.withOpacity(0.1),
                  );
                }),
              ),
            ),
            if (c.progress >= 1)
              Column(children: [
                const Spacer(),
                Expanded(
                  child: Center(
                      child: Text(c.progressFractionString,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 24,
                              fontWeight: FontWeight.w800))),
                ),
                Center(
                    child: Icon(
                  Icons.check,
                  color: Colors.black.withOpacity(0.5),
                )),
                const Spacer()
              ])
            else
              Center(
                child: Text(
                  c.progressFractionString,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      // color: Colors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.w800),
                ),
              )
          ],
        ),
      );
    });
  }

  Widget subtitle() {
    return const Text(
        'Invite 10 friends and enjoy special perks as an Iris Ambassador.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: TextUnit.small,
          fontWeight: FontWeight.w300,
        ));
  }

  Widget success() {
    return GetBuilder<ReferralsController>(builder: (c) {
      return Container(
        margin: const EdgeInsets.only(top: 40),
        //height: DIAMETER,
        child: Center(
            child: Text(
                "Nicely done! We'll be in touch shortly.\n\nYou have ${c.numSuccessfulInvitations} successful referrals.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    //color: context.theme.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500))),
      );
    });
  }

  Widget title() {
    return const DefaultTextTitle(
      align: TextAlign.center,
      bottom: SpaceUnit.small,
      top: SpaceUnit.extraLarge,
      textTitle: 'Get more out of Iris',
      fontSize: TextUnit.large,
      fontWeight: FontWeight.w600,
    );
  }
}

class FullScreenDialog extends StatelessWidget {
  final List<Widget> children;

  final Widget? bottomWidget;
  final Widget? nextScreen;
  final Widget? alternativeAction;
  final bool canGoBack;
  final String? title;
  final bool replaceTitleWithLogo;
  // Todo: Figure out a better interface or approach to the boolean below.
  const FullScreenDialog(
      {Key? key,
      required this.children,
      this.bottomWidget,
      this.nextScreen,
      this.alternativeAction,
      this.canGoBack = true,
      this.title,
      this.replaceTitleWithLogo = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        title: replaceTitleWithLogo
            ? Image.asset(
                Images.irisWhiteLogo,
                color: context.theme.colorScheme.secondary,
                width: ScreenUtil().setWidth(55.5),
                height: ScreenUtil().setHeight(30),
              )
            : title != null
                ? Text(title!,
                    style: const TextStyle(fontSize: TextUnit.medium))
                : null,
        leading: canGoBack
            ? const BackButton(
                // color: context.textTheme.subtitle1!.color,
                )
            : null,
        actions: alternativeAction != null ? [alternativeAction!] : null,
        elevation: 0.0,
        // backgroundColor: Colors.white,
        // brightness: Brightness.light,
      ),
      bottomNavigationBar: bottomWidget,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                      minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                        mainAxisSize: MainAxisSize.max, children: children),
                  )));
        },
      ),
    );
  }
}
