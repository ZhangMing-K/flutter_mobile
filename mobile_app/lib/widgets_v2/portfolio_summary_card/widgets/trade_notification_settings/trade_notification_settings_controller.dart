import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class TradeNotificationSettingsController extends GetxController {
  Rx<USER_RELATION_NOTIFICATION_AMOUNT> currentSetting;

  final Function onChangeAlert;
  final notificationSettings = [
    USER_RELATION_NOTIFICATION_AMOUNT.NONE,
    USER_RELATION_NOTIFICATION_AMOUNT.LARGE,
    USER_RELATION_NOTIFICATION_AMOUNT.ALL
  ];

  TradeNotificationSettingsController(
      {required this.currentSetting, required this.onChangeAlert});

  onTapItem(USER_RELATION_NOTIFICATION_AMOUNT itemClicked) {
    currentSetting.value = itemClicked;
    onChangeAlert(itemClicked);
    //  Get.back();
  }
}
