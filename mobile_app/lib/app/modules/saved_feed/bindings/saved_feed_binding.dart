import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/saved_feed_controller.dart';

class SavedFeedBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<INotificationRepository>(NotificationRepository(
      remoteProvider: Get.find(),
      repository: Get.find(),
    ));
    Get.put<IFeedRepository>(FeedRepository(
      remoteProvider: Get.find(),
      repository: Get.find(),
    ));
    Get.put(SavedFeedController(repository: Get.find()));
  }
}
