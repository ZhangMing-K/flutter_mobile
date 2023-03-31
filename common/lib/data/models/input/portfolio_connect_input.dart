import 'package:iris_common/data/models/enums/broker_name.dart';
import 'package:iris_common/data/models/enums/challenge_type.dart';
import 'package:collection/collection.dart';

class PortfolioConnectInput {
  final BROKER_NAME? brokerName;
  final String? username;
  final String? password;
  final String? oAuthKey;
  final String? accountId;
  final CHALLENGE_TYPE? challengeType;
  const PortfolioConnectInput(
      {required this.brokerName,
      this.username,
      this.password,
      this.oAuthKey,
      this.accountId,
      this.challengeType});
  PortfolioConnectInput copyWith(
      {BROKER_NAME? brokerName,
      String? username,
      String? password,
      String? oAuthKey,
      String? accountId,
      CHALLENGE_TYPE? challengeType}) {
    return PortfolioConnectInput(
      brokerName: brokerName ?? this.brokerName,
      username: username ?? this.username,
      password: password ?? this.password,
      oAuthKey: oAuthKey ?? this.oAuthKey,
      accountId: accountId ?? this.accountId,
      challengeType: challengeType ?? this.challengeType,
    );
  }

  factory PortfolioConnectInput.fromJson(Map<String, dynamic> json) {
    return PortfolioConnectInput(
      brokerName: json['brokerName'] != null
          ? BROKER_NAME.values.byName(json['brokerName'])
          : null,
      username: json['username'],
      password: json['password'],
      oAuthKey: json['oAuthKey'],
      accountId: json['accountId'],
      challengeType: json['challengeType'] != null
          ? CHALLENGE_TYPE.values.byName(json['challengeType'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['brokerName'] = brokerName?.name;
    data['username'] = username;
    data['password'] = password;
    data['oAuthKey'] = oAuthKey;
    data['accountId'] = accountId;
    data['challengeType'] = challengeType?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PortfolioConnectInput &&
            (identical(other.brokerName, brokerName) ||
                const DeepCollectionEquality()
                    .equals(other.brokerName, brokerName)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)) &&
            (identical(other.oAuthKey, oAuthKey) ||
                const DeepCollectionEquality()
                    .equals(other.oAuthKey, oAuthKey)) &&
            (identical(other.accountId, accountId) ||
                const DeepCollectionEquality()
                    .equals(other.accountId, accountId)) &&
            (identical(other.challengeType, challengeType) ||
                const DeepCollectionEquality()
                    .equals(other.challengeType, challengeType)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(brokerName) ^
        const DeepCollectionEquality().hash(username) ^
        const DeepCollectionEquality().hash(password) ^
        const DeepCollectionEquality().hash(oAuthKey) ^
        const DeepCollectionEquality().hash(accountId) ^
        const DeepCollectionEquality().hash(challengeType);
  }

  @override
  String toString() => 'PortfolioConnectInput(${toJson()})';
}
