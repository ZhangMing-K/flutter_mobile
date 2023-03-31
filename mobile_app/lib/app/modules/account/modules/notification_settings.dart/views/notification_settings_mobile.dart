import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/notification_settings_controller.dart';

class NotificationSettingsMobile
    extends GetWidget<NotificationSettingsController> {
  const NotificationSettingsMobile({Key? key}) : super(key: key);

  Widget allowNotifications(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Push Notifications',
            style: TextStyle(
              fontSize: 20,
              color: context.theme.colorScheme.secondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          Obx(() {
            return Container(
              margin: const EdgeInsets.only(right: 15),
              child: CupertinoSwitch(
                value: controller.permissionGranted.value
                    ? controller.allowAllNotifications.value
                    : false,
                onChanged: (bool value) {
                  controller.setAllNotificationSetting(value);
                },
                activeColor: IrisColor.primaryColor,
              ),
            );
          }),
        ]);
  }

  Widget bottomSettingHeader(User user, BROKER_NAME brokerName) {
    final id = uuid.v4();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProfileImage(
          radius: 20,
          url: user.profilePictureUrl,
          uuid: id,
        ),
        const SizedBox(width: 15),
        const Text('Option trades',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        portfoliosListView(context),
      ],
    );
  }

  Widget notificationItemDivider() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: const Divider(),
    );
  }

  Widget portfoliosListView(BuildContext context) {
    return Obx(() {
      return Expanded(
        child: IrisListView(
          header: Column(
            children: [
              pushNotifications(context),
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(width: 15),
                  const Text('Users Trade Notifications',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                  const SizedBox(width: 5),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 1.7),
                    child: Text(
                      controller.numberUserTradesOn.value.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          color: context.theme.colorScheme.secondary
                              .withOpacity(0.8)),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.all(15),
                // color: Colors.red,
                child: CupertinoSearchTextField(
                  onChanged: (value) {
                    controller.search(value);
                  },
                  onSubmitted: (value) {
                    controller.search(value);
                  },
                  controller: controller.textEditingController,
                  prefixInsets: const EdgeInsets.all(10),
                  placeholder: 'Search following',
                  placeholderStyle: TextStyle(
                      color:
                          context.theme.colorScheme.secondary.withOpacity(0.7)),
                  style: TextStyle(
                      color:
                          context.theme.colorScheme.secondary.withOpacity(0.7)),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(15),
                child: GestureDetector(
                    onTap: () {
                      //if (controller.isMuteAllPossible) {
                      HapticFeedback.mediumImpact();
                      controller.muteAllUserTradeNotifications();
                      // }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10),
                        Icon(FeatherIcons.bellOff,
                            color: controller.isMuteAllPossible
                                ? Colors.red
                                : context.theme.colorScheme.secondary
                                    .withOpacity(0.7)),
                        const SizedBox(width: 15),
                        Flexible(
                          child: Text(
                            'Mute all trade notifications',
                            style: TextStyle(
                                color: controller.isMuteAllPossible
                                    ? Colors.red
                                    : context.theme.colorScheme.secondary
                                        .withOpacity(0.7),
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
          // onRefresh: controller.pullRefresh,
          itemCount: controller.advancedFollowingUsers$.length,
          // widgetLoader: TextCardShimmer(margin: EdgeInsets.only(top: 8)),
          widgetLoader: const CupertinoActivityIndicator(radius: 10),
          loadMore: controller.loadMore,
          apiStatus: controller.apiStatus$.value,
          builder: (BuildContext context, int index) {
            final user = controller.advancedFollowingUsers$[index];
            return userList(context, user);
          },
        ),
      );
    });
  }

  Widget pushNotifications(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: allowNotifications(context)),
        notificationItemDivider(),
        Obx(() {
          return subNotification(
              context,
              'Messaging',
              controller.permissionGranted.value
                  ? controller.allowMessaging.value
                  : false,
              controller.setSubNotificationSetting);
        }),
        notificationItemDivider(),
        Obx(() {
          return subNotification(
              context,
              'Post interactions',
              controller.permissionGranted.value
                  ? controller.allowPostInteractions.value
                  : false,
              controller.setSubNotificationSetting);
        }),
        notificationItemDivider(),
        Obx(() {
          return subNotification(
              context,
              'Follows',
              controller.permissionGranted.value
                  ? controller.allowFollows.value
                  : false,
              controller.setSubNotificationSetting);
        }),
        notificationItemDivider(),
        Obx(() {
          return subNotification(
              context,
              'Trades',
              controller.permissionGranted.value
                  ? controller.allowTrades.value
                  : false,
              controller.setSubNotificationSetting);
        }),
      ],
    );
  }

  Widget snoozeAllAlerts(BuildContext context) {
    // final title = controller.hasTradeNotifications ? 'Snooze for trades' : 'Unsnooze for trades';
    return Obx(() {
      const title = 'For all notifications';
      final hasAllNotifications = controller.profileUser$.value == null
          ? true
          : controller.profileUser$.value?.allNotificationsSnoozed == false;
      return ListTile(
          dense: true,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: context.theme.colorScheme.secondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          trailing: snoozeButton(context,
              hasNotification: hasAllNotifications,
              snoozeType: USER_SNOOZE_TYPE.ALL));
    });
  }

  Widget snoozeButton(BuildContext context,
      {bool? hasNotification, required USER_SNOOZE_TYPE snoozeType}) {
    return StatefulBuilder(builder: (_, update) {
      return IrisBounceButton(
          duration: const Duration(milliseconds: 100),
          onPressed: () {
            HapticFeedback.lightImpact();
            controller.setSnooze(update, snoozeType);
          },
          child: (!hasNotification!)
              ? const Icon(
                  Icons.bedtime,
                  color: IrisColor.imessagePurple,
                  size: 22,
                )
              : const Icon(
                  Icons.bedtime_outlined,
                  color: IrisColor.imessagePurple,
                  size: 22,
                ));
    });
  }

  Widget snoozeTradeAlerts(BuildContext context) {
    return Obx(() {
      const title = 'For trade notifications';
      final hasTradeNotifications = controller.profileUser$.value == null
          ? true
          : controller.profileUser$.value?.tradeNotificationsSnoozed == false;
      return ListTile(
          dense: true,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: context.theme.colorScheme.secondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          trailing: snoozeButton(context,
              hasNotification: hasTradeNotifications,
              snoozeType: USER_SNOOZE_TYPE.TRADE));
    });
  }

  Widget subNotification(
      BuildContext context, String text, bool value, Function? switchFunction) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 35),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: context.theme.colorScheme.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: CupertinoSwitch(
              value: value,
              onChanged: (bool _value) {
                switchFunction!(text, _value);
              },
              activeColor: IrisColor.primaryColor,
            ),
          ),
        ]);
  }

  Widget userList(BuildContext context, Rx<User> user) {
    final id = uuid.v4();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        ListTile(
          tileColor: context.theme.scaffoldBackgroundColor,
          onTap: () {},
          leading: ProfileImage(
            radius: 20,
            url: user.value.profilePictureUrl,
            uuid: id,
          ),
          title: UserName(
            user: user.value,
            fontSize: 16,
          ),
          trailing: Obx(() {
            final hasTradeNotifications =
                user.value.authUserUser?.tradeNotificationAmount ==
                    USER_TRADE_NOTIFICATION_AMOUNT.ALL;

            return IrisBounceEffect(
              duration: const Duration(milliseconds: 100),
              child: IconButton(
                  onPressed: () {
                    // if (controller.isMuteAllPossible) {
                    HapticFeedback.mediumImpact();
                    controller.onBellPressed(
                        user: user, isActive: hasTradeNotifications);
                    // }
                  },
                  icon: hasTradeNotifications
                      ? const Icon(
                          Icons.notifications,
                          color: IrisColor.irisBlueLight,
                        )
                      : const Icon(FeatherIcons.bell)),
            );
          }),
        ),
        Container(
          margin: const EdgeInsets.only(left: 60),
          child: Obx(() {
            return Column(
              children: [
                ...user.value.portfolios!
                    .map((e) => userPortfolioList(context, user, e))
              ],
            );
          }),
        )
      ],
    );
  }

  Widget userPortfolioList(
      BuildContext context, Rx<User> user, Portfolio portfolio) {
    return ListTile(
      leading: BrokerIcon(
        brokerName: portfolio.brokerName,
        height: 25,
      ),
      title: Text(portfolio.portfolioName!),
      // trailing: alertsButton(user, portfolio),
      horizontalTitleGap: 0,
    );
  }
}
