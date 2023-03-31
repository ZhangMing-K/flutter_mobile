import 'package:iris_common/data/models/output/user_subscription.dart';
import 'package:collection/collection.dart';

class SubscriptionUpdateResponse {
  final UserSubscription? subscription;
  const SubscriptionUpdateResponse({this.subscription});
  SubscriptionUpdateResponse copyWith({UserSubscription? subscription}) {
    return SubscriptionUpdateResponse(
      subscription: subscription ?? this.subscription,
    );
  }

  factory SubscriptionUpdateResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionUpdateResponse(
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
        (other is SubscriptionUpdateResponse &&
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
  String toString() => 'SubscriptionUpdateResponse(${toJson()})';
}
