import 'package:collection/collection.dart';

class AccountFromBroker {
  final String? accountId;
  final String? accountName;
  final bool? connected;
  const AccountFromBroker({this.accountId, this.accountName, this.connected});
  AccountFromBroker copyWith(
      {String? accountId, String? accountName, bool? connected}) {
    return AccountFromBroker(
      accountId: accountId ?? this.accountId,
      accountName: accountName ?? this.accountName,
      connected: connected ?? this.connected,
    );
  }

  factory AccountFromBroker.fromJson(Map<String, dynamic> json) {
    return AccountFromBroker(
      accountId: json['accountId'],
      accountName: json['accountName'],
      connected: json['connected'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['accountId'] = accountId;
    data['accountName'] = accountName;
    data['connected'] = connected;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AccountFromBroker &&
            (identical(other.accountId, accountId) ||
                const DeepCollectionEquality()
                    .equals(other.accountId, accountId)) &&
            (identical(other.accountName, accountName) ||
                const DeepCollectionEquality()
                    .equals(other.accountName, accountName)) &&
            (identical(other.connected, connected) ||
                const DeepCollectionEquality()
                    .equals(other.connected, connected)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(accountId) ^
        const DeepCollectionEquality().hash(accountName) ^
        const DeepCollectionEquality().hash(connected);
  }

  @override
  String toString() => 'AccountFromBroker(${toJson()})';
}
