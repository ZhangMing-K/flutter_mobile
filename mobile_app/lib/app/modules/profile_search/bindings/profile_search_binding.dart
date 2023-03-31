import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../profile/shared/profile_utils.dart';
import '../controllers/profile_search_controller.dart';
import '../modules/followers/controllers/followers_controller.dart';
import '../modules/following/controllers/following_controller.dart';
import '../modules/portfolios_following/controllers/portfolios_following_controller.dart';

class ProfileSearchBinding extends Bindings {
  @override
  void dependencies() {
    final profileUtils = ProfileUtils(authUserStore: Get.find());

    Get.put<IProfileSearchRepository>(ProfileSearchRepository(
      remoteProvider: Get.find(),
    ));
    Get.create(() => FollowersController(
          repository: Get.find(),
          profileUserKey: profileUtils.getProfileKey,
        ));
    Get.create(() => FollowingController(
          repository: Get.find(),
          profileUserKey: profileUtils.getProfileKey,
        ));
    Get.create(() => PortfoliosFollowingController(
          repository: Get.find<IProfileSearchRepository>(),
          profileUserKey: profileUtils.getProfileKey,
        ));
    Get.create(() => ProfileSearchController(
          followersController: Get.find(),
          followingController: Get.find(),
          portfoliosFollowingController: Get.find(),
          profileUserKey: profileUtils.getProfileKey,
          irisEvent: Get.find(),
        ));
  }
}
