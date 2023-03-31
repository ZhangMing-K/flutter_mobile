import 'package:collection/collection.dart';

class PortfolioConnectRespondToChallengeInput {
  final String? challengeId;
  final String? deviceToken;
  final String? verificationNumber;
  final String? username;
  final String? password;
  const PortfolioConnectRespondToChallengeInput(
      {this.challengeId,
      required this.deviceToken,
      required this.verificationNumber,
      required this.username,
      required this.password});
  PortfolioConnectRespondToChallengeInput copyWith(
      {String? challengeId,
      String? deviceToken,
      String? verificationNumber,
      String? username,
      String? password}) {
    return PortfolioConnectRespondToChallengeInput(
      challengeId: challengeId ?? this.challengeId,
      deviceToken: deviceToken ?? this.deviceToken,
      verificationNumber: verificationNumber ?? this.verificationNumber,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  factory PortfolioConnectRespondToChallengeInput.fromJson(
      Map<String, dynamic> json) {
    return PortfolioConnectRespondToChallengeInput(
      challengeId: json['challengeId'],
      deviceToken: json['deviceToken'],
      verificationNumber: json['verificationNumber'],
      username: json['username'],
      password: json['password'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['challengeId'] = challengeId;
    data['deviceToken'] = deviceToken;
    data['verificationNumber'] = verificationNumber;
    data['username'] = username;
    data['password'] = password;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PortfolioConnectRespondToChallengeInput &&
            (identical(other.challengeId, challengeId) ||
                const DeepCollectionEquality()
                    .equals(other.challengeId, challengeId)) &&
            (identical(other.deviceToken, deviceToken) ||
                const DeepCollectionEquality()
                    .equals(other.deviceToken, deviceToken)) &&
            (identical(other.verificationNumber, verificationNumber) ||
                const DeepCollectionEquality()
                    .equals(other.verificationNumber, verificationNumber)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(challengeId) ^
        const DeepCollectionEquality().hash(deviceToken) ^
        const DeepCollectionEquality().hash(verificationNumber) ^
        const DeepCollectionEquality().hash(username) ^
        const DeepCollectionEquality().hash(password);
  }

  @override
  String toString() => 'PortfolioConnectRespondToChallengeInput(${toJson()})';
}
