import 'package:collection/collection.dart';

class SubscriptionSetPaymentMethodToUserDefaultInput {
  final int? subscriptionKey;
  final int? userKey;
  const SubscriptionSetPaymentMethodToUserDefaultInput(
      {required this.subscriptionKey, required this.userKey});
  SubscriptionSetPaymentMethodToUserDefaultInput copyWith(
      {int? subscriptionKey, int? userKey}) {
    return SubscriptionSetPaymentMethodToUserDefaultInput(
      subscriptionKey: subscriptionKey ?? this.subscriptionKey,
      userKey: userKey ?? this.userKey,
    );
  }

  factory SubscriptionSetPaymentMethodToUserDefaultInput.fromJson(
      Map<String, dynamic> json) {
    return SubscriptionSetPaymentMethodToUserDefaultInput(
      subscriptionKey: json['subscriptionKey'],
      userKey: json['userKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['subscriptionKey'] = subscriptionKey;
    data['userKey'] = userKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SubscriptionSetPaymentMethodToUserDefaultInput &&
            (identical(other.subscriptionKey, subscriptionKey) ||
                const DeepCollectionEquality()
                    .equals(other.subscriptionKey, subscriptionKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality().equals(other.userKey, userKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(subscriptionKey) ^
        const DeepCollectionEquality().hash(userKey);
  }

  @override
  String toString() =>
      'SubscriptionSetPaymentMethodToUserDefaultInput(${toJson()})';
}
