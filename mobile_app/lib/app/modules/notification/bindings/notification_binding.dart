import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/notification_controller.dart';
import '../modules/follow_requests/controllers/follow_requests_controller.dart';
import '../modules/notifications/controllers/notifications_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<INotificationRepository>(NotificationRepository(
      //localProvider: Get.find(),
      repository: Get.find(),
      remoteProvider: Get.find(),
    ));
    Get.put(NotificationsController(
      repository: Get.find(),
      authUserStore: Get.find(),
      feedController: Get.find(),
    ));
    Get.put(FollowRequestsController(
      repository: Get.find(),
    ));
    Get.put(NotificationController(
      notificationsController: Get.find(),
      followRequestsController: Get.find(),
      irisEvent: Get.find(),
    ));
    //Get.create(() => TextCardController());
  }
}
