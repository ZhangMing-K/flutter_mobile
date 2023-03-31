import 'package:iris_common/data/models/output/user_subscription.dart';
import 'package:collection/collection.dart';

class SubscriptionSetPaymentMethodToUserDefaultResponse {
  final UserSubscription? subscription;
  const SubscriptionSetPaymentMethodToUserDefaultResponse({this.subscription});
  SubscriptionSetPaymentMethodToUserDefaultResponse copyWith(
      {UserSubscription? subscription}) {
    return SubscriptionSetPaymentMethodToUserDefaultResponse(
      subscription: subscription ?? this.subscription,
    );
  }

  factory SubscriptionSetPaymentMethodToUserDefaultResponse.fromJson(
      Map<String, dynamic> json) {
    return SubscriptionSetPaymentMethodToUserDefaultResponse(
      subscription: json['subscription'] != null
          ? UserSubscription.fromJson(json['subscription'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['subscription'] = subscription?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SubscriptionSetPaymentMethodToUserDefaultResponse &&
            (identical(other.subscription, subscription) ||
                const DeepCollectionEquality()
                    .equals(other.subscription, subscription)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(subscription);
  }

  @override
  String toString() =>
      'SubscriptionSetPaymentMethodToUserDefaultResponse(${toJson()})';
}
