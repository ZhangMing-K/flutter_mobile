import 'package:iris_common/data/models/output/user_subscription.dart';
import 'package:collection/collection.dart';

class SubscriptionCancelResponse {
  final UserSubscription? subscription;
  const SubscriptionCancelResponse({this.subscription});
  SubscriptionCancelResponse copyWith({UserSubscription? subscription}) {
    return SubscriptionCancelResponse(
      subscription: subscription ?? this.subscription,
    );
  }

  factory SubscriptionCancelResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionCancelResponse(
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
        (other is SubscriptionCancelResponse &&
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
  String toString() => 'SubscriptionCancelResponse(${toJson()})';
}
