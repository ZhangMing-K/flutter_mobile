import 'package:collection/collection.dart';

class PaymentMethodSetupInput {
  final int? userKey;
  const PaymentMethodSetupInput({required this.userKey});
  PaymentMethodSetupInput copyWith({int? userKey}) {
    return PaymentMethodSetupInput(
      userKey: userKey ?? this.userKey,
    );
  }

  factory PaymentMethodSetupInput.fromJson(Map<String, dynamic> json) {
    return PaymentMethodSetupInput(
      userKey: json['userKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKey'] = userKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PaymentMethodSetupInput &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality().equals(other.userKey, userKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(userKey);
  }

  @override
  String toString() => 'PaymentMethodSetupInput(${toJson()})';
}
