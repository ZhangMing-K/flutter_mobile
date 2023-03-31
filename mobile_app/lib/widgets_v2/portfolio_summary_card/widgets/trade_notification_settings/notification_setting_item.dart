import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class NotificationSettingItem extends StatelessWidget {
  final bool isLast;

  final USER_RELATION_NOTIFICATION_AMOUNT setting;
  final Rx<USER_RELATION_NOTIFICATION_AMOUNT> currentSetting;
  final Function onTap;
  const NotificationSettingItem({
    Key? key,
    required this.setting,
    required this.currentSetting,
    required this.isLast,
    required this.onTap,
  }) : super(key: key);

  String get settingName {
    if (setting == USER_RELATION_NOTIFICATION_AMOUNT.ALL) return 'All';
    if (setting == USER_RELATION_NOTIFICATION_AMOUNT.LARGE) {
      return 'Big winners';
    }
    return 'None';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Obx(() {
              final isSelected = currentSetting.value == setting;
              return ListTile(
                title: Text(
                  settingName,
                  style: TextStyle(
                      color: isSelected
                          ? context.theme.primaryColor
                          : context.theme.colorScheme.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  HapticFeedback.lightImpact();
                  onTap(setting);
                },
                minVerticalPadding: 0,
                trailing: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: isSelected
                            ? Colors.grey.shade800
                            : Colors.grey.shade300),
                    color:
                        isSelected ? Colors.grey.shade800 : Colors.transparent,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Icon(
                        isSelected ? Icons.check_sharp : null,
                        color: context.theme.primaryColor,
                        size: 20,
                      )),
                ),
              );
            }),
            if (!isLast) const Divider()
          ],
        ));
  }
}
