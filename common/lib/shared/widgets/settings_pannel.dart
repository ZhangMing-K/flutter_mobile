import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../iris_common.dart';

contactUs() async {
  final Email email = Email(
    body: '',
    subject: 'Contact Us',
    recipients: ['contact@iris.finance'],
    isHTML: false,
  );

  String platformResponse;
  try {
    await FlutterEmailSender.send(email);
    platformResponse = 'success';
  } catch (error) {
    platformResponse = error.toString();
    Get.snackbar(
      'Not available',
      platformResponse, //?? 'No email clients found',
      colorText: Colors.red,
      shouldIconPulse: true,
      barBlur: 20,
      isDismissible: true,
      duration: const Duration(seconds: 5),
    );
  }
  debugPrint(platformResponse);
}

void openSettingsPanel() {
  Get.bottomSheet(
      IrisBottomSheetSingleScroll(
        initialChildSize: .75,
        // minChildSize: .75,
        maxChildSize: .75,
        child: Builder(builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PannelTile(
                leading: Icon(
                  Icons.notifications,
                  color: context.theme.colorScheme.secondary,
                ),
                textAlignment: Alignment.centerLeft,
                color: context.theme.colorScheme.secondary,
                text: 'Notification Settings',
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(Paths.NotificationSettings, id: 1);
                },
              ),
              // PannelTile(
              //   leading: Icon(
              //     UniconsLine.watch,
              //     color: context.theme.colorScheme.secondary,
              //   ),
              //   textAlignment: Alignment.centerLeft,
              //   color: context.theme.colorScheme.secondary,
              //   text: 'Watchlist',
              //   onTap: () {
              //     Get.back();
              //     Get.toNamed(Paths.WatchList.createPath([true]));
              //   },
              // ),

              // PannelTile(
              //   leading: Padding(
              //       padding: const EdgeInsets.only(left: 2.0),
              //       child: Image.asset(
              //         context.isDarkMode
              //             ? Images.analyticGold
              //             : Images.analyticGoldLight,
              //         height: 20,
              //       )),
              //   textAlignment: Alignment.centerLeft,
              //   color: context.theme.colorScheme.secondary,
              //   text: 'Iris Gold Settings',
              //   onTap: () async {
              //     Get.back();
              //     await Get.toNamed(Paths.IrisGoldOptionsOverview);
              //     Future(() {
              //       SystemChrome.setSystemUIOverlayStyle(Get.isPlatformDarkMode
              //           ? SystemUiOverlayStyle.light
              //           : SystemUiOverlayStyle.dark);
              //     });
              //   },
              // ),
              PannelTile(
                leading: Icon(
                  UniconsLine.save,
                  color: context.theme.colorScheme.secondary,
                ),
                textAlignment: Alignment.centerLeft,
                color: context.theme.colorScheme.secondary,
                text: 'Saved',
                onTap: () {
                  Get.back();
                  Get.toNamed(Paths.SavedFeed);
                }, //icon(path: IconPath.logout)
              ),
              PannelTile(
                leading: Icon(
                  UniconsLine.comment_alt,
                  color: context.theme.colorScheme.secondary,
                ),
                textAlignment: Alignment.centerLeft,
                color: context.theme.colorScheme.secondary,
                text: 'Contact Us',
                onTap: () {
                  Get.back();
                  contactUs();
                },
              ),
              PannelTile(
                leading: Icon(
                  UniconsLine.setting,
                  color: context.theme.colorScheme.secondary,
                ),
                textAlignment: Alignment.centerLeft,
                color: context.theme.colorScheme.secondary,
                text: 'Settings',
                onTap: () {
                  Get.back();
                  Get.toNamed(Paths.Settings);
                }, //icon(path: IconPath.logout)
              ),
              // PannelTile(
              //   leading: Icon(UniconsLine.bill),
              //   textAlignment: Alignment.centerLeft,
              //   color: context.theme.colorScheme.secondary,
              //   text: 'Subscriptions',
              //   onTap: () {
              //     Get.back();
              //     Get.toNamed(Routes.Subscriptions);
              //   }, //icon(path: IconPath.logout)
              // ),
              PannelTile(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Image.asset(
                    context.isDarkMode
                        ? IconPath.inviteStar
                        : IconPath.inviteStarLight,
                    height: 20,
                    // color: context.isDarkMode ? Colors.white : Colors.black.withOpacity(0.6),
                  ),
                ),
                textAlignment: Alignment.centerLeft,
                color: context.theme.colorScheme.secondary,
                text: 'Invite Friends',
                onTap: () {
                  ///copied from LogoAppBar implementation
                  final IAuthUserService authUserStore = Get.find();
                  final authUser = authUserStore.loggedUser;
                  final bool syncedNumber = authUser?.phoneNumber != null &&
                      authUser!.phoneNumber!.isNotEmpty;
                  Get.back();
                  if (!syncedNumber) {
                    Get.toNamed(Paths.MfaContactConnect);
                  } else {
                    Get.toNamed(Paths.ExploreFriends);
                  }
                },
              ),
              PannelTile(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Image.asset(
                    Images.autopilotIcon,
                    width: 23,
                  ),
                ),
                textAlignment: Alignment.centerLeft,
                color: context.theme.colorScheme.secondary,
                text: 'Autopilot club',
                onTap: () {
                  Get.back();
                  Get.toNamed(Paths.PaymentMethods);
                }, //icon(path: IconPath.logout)
              ),

              PannelTile(
                leading: Image.asset(
                  IconPath.discord,
                  width: 23,
                  // color: context.isDarkMode ? Colors.white : Colors.black,
                ),
                textAlignment: Alignment.centerLeft,
                color: context.theme.colorScheme.secondary,
                text: 'Discord Bot',
                onTap: () {
                  Get.back();
                  Get.toNamed(Paths.Workspaces.createPath(
                      [describeEnum(WORKSPACE_SOURCE.DISCORD)]));
                },
              ),
              PannelTile(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Image.asset(
                    IconPath.logout,
                    width: 20,
                  ),
                ),
                textAlignment: Alignment.centerLeft,
                color: context.theme.colorScheme.secondary,
                text: 'Logout',
                onTap: () async {
                  final IAuthUserService authUserStore = Get.find();
                  Navigator.pop(Get.context!);
                  if (Get.context == null) {
                    return;
                  }
                  await authUserStore.logout(
                      isAutoLogout: false, description: 'manually logged out');
                }, //icon(path: IconPath.logout)
              )
            ],
          );
        }),
      ),
      // barrierColor: context.theme.backgroundColor,
      enableDrag: true,
      isScrollControlled: true);
}
