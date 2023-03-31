import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/build_your_community_controller.dart';

class BuildYourCommunityBinding extends Bindings {
  @override
  void dependencies() {
    final buildYourCommunityController = Get.put(
      BuildYourCommunityController(
          userContactService: Get.find(),
          permissionController: Get.find(),
          pictureAndFullNameController: Get.find()),
    );
    Get.put(FindFriendsController(
      onNextCallBack: buildYourCommunityController.goToOnboadingFinal,
      selectAllByDefault: true,
    ));
  }
}
