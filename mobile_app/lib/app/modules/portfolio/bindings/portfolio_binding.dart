import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/portfolio_controller.dart';
import '../modules/orders/controllers/orders_controller.dart';
import '../modules/overview/controllers/overview_controller.dart';
import '../modules/position/controllers/position_controller.dart';

class PortfolioBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IPortfolioRepository>(PortfolioRepository(
      //localProvider: Get.find(),
      remoteProvider: Get.find(),
    ));
    Get.put(OverviewController(repository: Get.find()));
    Get.put(PositionController(repository: Get.find()));
    Get.put(PortfolioOrdersController(
        repository: Get.find<IPortfolioRepository>(),
        portfolioService: Get.find<PortfolioService>(),
        textService: Get.find<TextService>()));
    Get.put(PortfolioController(
      // overviewController: Get.find(),
      positionController: Get.find(),
      ordersController: Get.find(),
      repository: Get.find(),
      authUserStore: Get.find(),
      portfolioService: Get.find<PortfolioService>(),
      irisEvent: Get.find(),
    ));
  }
}
