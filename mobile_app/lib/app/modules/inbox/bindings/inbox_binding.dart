import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/inbox_controller.dart';

class InboxBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IInboxRepository>(
      InboxRepository(remoteProvider: Get.find(), repository: Get.find()),
    );

    Get.put<IChatRepository>(ChatRepository(
        remoteProvider: Get.find(),
        repository: Get.find(),
        authUserStore: Get.find()));

    Get.put(InboxController(
      authUserStore: Get.find(),
      repository: Get.find(),
      chatRepository: Get.find(),
      feedController: Get.find(),
    ));

    Get.lazyPut<IProfileRepository>(
      () => ProfileRepository(
        remoteProvider: Get.find(),
        //  repository: Get.find(),
      ),
      fenix: true,
    );
  }
}
