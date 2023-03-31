import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class PaymentMethodSetupResponse {
  final User? user;
  final String? clientSecret;
  const PaymentMethodSetupResponse({this.user, this.clientSecret});
  PaymentMethodSetupResponse copyWith({User? user, String? clientSecret}) {
    return PaymentMethodSetupResponse(
      user: user ?? this.user,
      clientSecret: clientSecret ?? this.clientSecret,
    );
  }

  factory PaymentMethodSetupResponse.fromJson(Map<String, dynamic> json) {
    return PaymentMethodSetupResponse(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      clientSecret: json['clientSecret'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['user'] = user?.toJson();
    data['clientSecret'] = clientSecret;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PaymentMethodSetupResponse &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.clientSecret, clientSecret) ||
                const DeepCollectionEquality()
                    .equals(other.clientSecret, clientSecret)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(clientSecret);
  }

  @override
  String toString() => 'PaymentMethodSetupResponse(${toJson()})';
}
