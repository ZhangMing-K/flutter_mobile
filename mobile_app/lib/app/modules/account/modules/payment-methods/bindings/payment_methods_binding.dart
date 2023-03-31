import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/account/modules/payment-methods/controllers/payment_methods_controller.dart';

class PaymentMethodsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IPaymentMethodRepository>(PaymentMethodRepository(
        remoteProvider: Get.find(), repository: Get.find()));

    Get.put(PaymentMethodsController(
      authUserStore: Get.find(),
      profileRepository: Get.find(),
      paymentMethodRepository: Get.find(),
    ));
  }
}
