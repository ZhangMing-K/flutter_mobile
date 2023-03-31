import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/portfolio_search_controller.dart';
import '../modules/users/controllers/users_controller.dart';

class PortfolioSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IPortfolioSearchRepository>(PortfolioSearchRepository(
      //localProvider: Get.find(),
      remoteProvider: Get.find(),
    ));
    Get.put(PortfolioUsersController(
      repository: Get.find(),
    ));
    Get.put(PortfolioSearchController(
      usersController: Get.find(),
      irisEvent: Get.find(),
    ));
  }
}
