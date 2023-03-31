import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'notification_setting_item.dart';
import 'trade_notification_settings_controller.dart';

class TradeNotificationSettings extends StatelessWidget {
  const TradeNotificationSettings(
      {Key? key,
      required this.controller,
      required this.scrollController,
      this.header})
      : super(key: key);

  final TradeNotificationSettingsController controller;
  final ScrollController scrollController;
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: context.theme.backgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          header ??
              const Text('Trade notifications',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
          const SizedBox(height: 20),
          Expanded(
              child: IrisListView(
            itemCount: controller.notificationSettings.length,
            controller: scrollController,
            builder: (BuildContext context, int index) {
              return NotificationSettingItem(
                  setting: controller.notificationSettings[index],
                  currentSetting: controller.currentSetting,
                  isLast: index == controller.notificationSettings.length - 1,
                  onTap: controller.onTapItem);
            },
          )),
        ],
      ),
    );
  }
}
