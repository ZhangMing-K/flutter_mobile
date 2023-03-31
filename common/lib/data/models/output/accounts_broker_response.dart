import 'package:iris_common/data/models/output/account_from_broker.dart';
import 'package:collection/collection.dart';

class AccountsBrokerResponse {
  final List<AccountFromBroker>? brokerAccounts;
  const AccountsBrokerResponse({this.brokerAccounts});
  AccountsBrokerResponse copyWith({List<AccountFromBroker>? brokerAccounts}) {
    return AccountsBrokerResponse(
      brokerAccounts: brokerAccounts ?? this.brokerAccounts,
    );
  }

  factory AccountsBrokerResponse.fromJson(Map<String, dynamic> json) {
    return AccountsBrokerResponse(
      brokerAccounts: json['brokerAccounts']
          ?.map<AccountFromBroker>((o) => AccountFromBroker.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['brokerAccounts'] =
        brokerAccounts?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AccountsBrokerResponse &&
            (identical(other.brokerAccounts, brokerAccounts) ||
                const DeepCollectionEquality()
                    .equals(other.brokerAccounts, brokerAccounts)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(brokerAccounts);
  }

  @override
  String toString() => 'AccountsBrokerResponse(${toJson()})';
}
