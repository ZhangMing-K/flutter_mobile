import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/profile_controller.dart';
import '../modules/posts/controllers/profile_posts_controller.dart';
import '../modules/summary/notifiers/profile_summary_notifier.dart';
import '../shared/profile_utils.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    final profileUtils = ProfileUtils(authUserStore: Get.find());

    Get.lazyPut<IProfileRepository>(
      () => ProfileRepository(
        remoteProvider: Get.find(),
      ),
      fenix: true,
    );

    Get.lazyPut<IFeedRepository>(
      () => FeedRepository(remoteProvider: Get.find(), repository: Get.find()),
    );

    Get.create(
      () => ProfilePostsController(
        repository: Get.find<IProfileRepository>(),
        profileUserKey: profileUtils.getProfileKey,
      ),
    );

    Get.create(
      () => ProfileSummaryController(
        repository: Get.find<IProfileRepository>(),
        profileUserKey: profileUtils.getProfileKey,
        authUserStore: Get.find(),
      ),
    );

    Get.create(
      () => ProfileController(
        profileUserKey: profileUtils.getProfileKey,
        repository: Get.find(),
        profileSummaryController: Get.find(),
        profilePostsController: Get.find(),
        authUserStore: Get.find(),
        irisEvent: Get.find(),
        userService: Get.find(),
        feedRepository: Get.find(),
      ),
    );
  }
}
