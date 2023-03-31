import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-order-flow/controllers/analytics_order_flow_controller.dart';

class AnalyticsOrderFlowBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IAnalyticsOrderFlowRepository>(AnalyticsOrderFlowRepository(
        remoteProvider: Get.find(), repository: Get.find()));

    Get.put(AnalyticsOrderFlowController(
      repository: Get.find(),
      authUserStore: Get.find(),
      searchRepository: Get.find(),
    ));
  }
}
