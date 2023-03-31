import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../modules/user_stories/controllers/user_stories_stories_controller.dart';

class UserStoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IProfileRepository>(ProfileRepository(remoteProvider: Get.find()));

    Get.put(UserStoriesStoriesController(
      repository: Get.find(),
    ));
  }
}
