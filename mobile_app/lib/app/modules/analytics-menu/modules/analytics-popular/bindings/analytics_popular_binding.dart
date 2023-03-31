import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-popular/controllers/analytics_popular_controller.dart';

class AnalyticsPopularBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IAnalyticsPopularRepository>(AnalyticsPopularRepository(
        remoteProvider: Get.find(), repository: Get.find()));
    Get.put(AnalyticsPopularController(
      repository: Get.find(),
      authUserStore: Get.find(),
    ));
  }
}
