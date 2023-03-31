import 'package:collection/collection.dart';

class SubscriptionCancelInput {
  final int? subscriptionKey;
  final bool? immediately;
  const SubscriptionCancelInput(
      {required this.subscriptionKey, required this.immediately});
  SubscriptionCancelInput copyWith({int? subscriptionKey, bool? immediately}) {
    return SubscriptionCancelInput(
      subscriptionKey: subscriptionKey ?? this.subscriptionKey,
      immediately: immediately ?? this.immediately,
    );
  }

  factory SubscriptionCancelInput.fromJson(Map<String, dynamic> json) {
    return SubscriptionCancelInput(
      subscriptionKey: json['subscriptionKey'],
      immediately: json['immediately'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['subscriptionKey'] = subscriptionKey;
    data['immediately'] = immediately;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SubscriptionCancelInput &&
            (identical(other.subscriptionKey, subscriptionKey) ||
                const DeepCollectionEquality()
                    .equals(other.subscriptionKey, subscriptionKey)) &&
            (identical(other.immediately, immediately) ||
                const DeepCollectionEquality()
                    .equals(other.immediately, immediately)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(subscriptionKey) ^
        const DeepCollectionEquality().hash(immediately);
  }

  @override
  String toString() => 'SubscriptionCancelInput(${toJson()})';
}
