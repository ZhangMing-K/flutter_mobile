import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/notification_settings_controller.dart';

class NotificationSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IFeedRepository>(FeedRepository(
      remoteProvider: Get.find(),
      repository: Get.find(),
    ));
    Get.put<INotificationRepository>(NotificationRepository(
      remoteProvider: Get.find(),
      repository: Get.find(),
    ));
    Get.put(NotificationSettingsController(
      authUserStore: Get.find(),
      feedRepository: Get.find(),
      notificationRepository: Get.find(),
      userService: Get.find(),
    ));
  }
}
