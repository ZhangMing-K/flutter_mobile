import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../feed/modules/text/text_controller.dart';
import '../controllers/focused_feed_controller.dart';

class FocusedFeedBinding extends Bindings {
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
    Get.put(FocusedFeedController(repository: Get.find()));

    Get.create(() => TextController());
  }
}
