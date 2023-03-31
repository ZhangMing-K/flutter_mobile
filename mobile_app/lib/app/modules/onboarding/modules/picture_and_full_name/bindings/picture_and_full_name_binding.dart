import 'package:get/instance_manager.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/picture_and_full_name_controller.dart';

class PictureAndFullNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ISearchRepository>(SearchRepository(
      remoteProvider: Get.find(),
      repository: Get.find(),
    ));
    Get.put(PictureAndFullNameController(
      authUserStore: Get.find(),
      searchRepository: Get.find(),
      storageService: Get.find(),
      userService: Get.find(),
      authService: Get.find(),
    ));
  }
}
