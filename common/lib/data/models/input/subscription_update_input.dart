import 'package:collection/collection.dart';

class SubscriptionUpdateInput {
  final int? subscriptionKey;
  final bool? autoRenew;
  const SubscriptionUpdateInput(
      {required this.subscriptionKey, this.autoRenew});
  SubscriptionUpdateInput copyWith({int? subscriptionKey, bool? autoRenew}) {
    return SubscriptionUpdateInput(
      subscriptionKey: subscriptionKey ?? this.subscriptionKey,
      autoRenew: autoRenew ?? this.autoRenew,
    );
  }

  factory SubscriptionUpdateInput.fromJson(Map<String, dynamic> json) {
    return SubscriptionUpdateInput(
      subscriptionKey: json['subscriptionKey'],
      autoRenew: json['autoRenew'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['subscriptionKey'] = subscriptionKey;
    data['autoRenew'] = autoRenew;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SubscriptionUpdateInput &&
            (identical(other.subscriptionKey, subscriptionKey) ||
                const DeepCollectionEquality()
                    .equals(other.subscriptionKey, subscriptionKey)) &&
            (identical(other.autoRenew, autoRenew) ||
                const DeepCollectionEquality()
                    .equals(other.autoRenew, autoRenew)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(subscriptionKey) ^
        const DeepCollectionEquality().hash(autoRenew);
  }

  @override
  String toString() => 'SubscriptionUpdateInput(${toJson()})';
}
