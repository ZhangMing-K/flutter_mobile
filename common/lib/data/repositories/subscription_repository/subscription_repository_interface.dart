import '../../../iris_common.dart';

abstract class ISubscriptionRepository {
  Future<UserSubscription?> subscriptionUpdate({
    required int subscriptionKey,
    bool? autoRenew,
    required Function(dynamic error) onError,
  });
}
