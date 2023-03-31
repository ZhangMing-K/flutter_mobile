import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/search/controllers/search_asset_controller.dart';
import 'package:iris_mobile/app/modules/search/controllers/search_controller.dart';
import 'package:iris_mobile/app/modules/search/controllers/search_people_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ISearchRepository>(SearchRepository(
      remoteProvider: Get.find(),
      repository: Get.find(),
    ));

    Get.put(SearchPeopleController());
    Get.put(SearchAssetController());
    Get.put(SearchController(
      repository: Get.find(),
      searchAssetController: Get.find(),
      searchPeopleController: Get.find(),
      storage: Get.find(),
    ));
  }
}
