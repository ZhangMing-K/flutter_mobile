import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../group_details/group_details_controller.dart';
import '../controllers/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IChatRepository>(
      ChatRepository(
          remoteProvider: Get.find(),
          repository: Get.find(),
          authUserStore: Get.find()),
    );

    Get.put<IFeedRepository>(
      FeedRepository(remoteProvider: Get.find(), repository: Get.find()),
    );

    Get.create(
      () => ChatController(
        chatRepository: Get.find(),
        inboxController: Get.find(),
        authUserStore: Get.find(),
        userService: Get.find(),
        feedController: Get.find(),
      ),
    );

    Get.create(
      () => GroupDetailsController(
        repository: Get.find<IChatRepository>(),
        inboxController: Get.find(),
        authUserStore: Get.find(),
      ),
      //  fenix: true,
    );
  }
}
