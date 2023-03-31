import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/iris_gold/controllers/iris_gold_controller.dart';

class IrisGoldSettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IIrisGoldRepository>(
        IrisGoldRepository(remoteProvider: Get.find(), repository: Get.find()));
    Get.put<IPurchaseItemRepository>(PurcahseItemRepository(
        remoteProvider: Get.find(), repository: Get.find()));
    Get.put(IrisGoldSettingsController(
      irisGoldRepository: Get.find(),
      purchaseItemRepository: Get.find(),
      authUserStore: Get.find(),
      profileRepository: Get.find(),
    ));
  }
}
