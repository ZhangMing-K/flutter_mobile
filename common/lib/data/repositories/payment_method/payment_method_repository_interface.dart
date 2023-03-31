import '../../../iris_common.dart';

abstract class IPaymentMethodRepository {
  Future<PaymentMethodSetupResponse?> paymentMethodSetup({
    required int userKey,
    required Function(dynamic error) onError,
  });

  Future<SubscriptionSetPaymentMethodToUserDefaultResponse?>
      setPaymentMethodToUserDefault({
    required int userKey,
    required int subscriptionKey,
    required Function(dynamic error) onError,
  });
}
