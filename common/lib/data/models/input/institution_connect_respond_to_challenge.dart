import 'package:collection/collection.dart';

class InstitutionConnectRespondToChallenge {
  final int? institutionKey;
  final String? challengeId;
  final String? challengeResponseValue;
  final bool? autoAddAllAccounts;
  const InstitutionConnectRespondToChallenge(
      {required this.institutionKey,
      required this.challengeId,
      required this.challengeResponseValue,
      this.autoAddAllAccounts});
  InstitutionConnectRespondToChallenge copyWith(
      {int? institutionKey,
      String? challengeId,
      String? challengeResponseValue,
      bool? autoAddAllAccounts}) {
    return InstitutionConnectRespondToChallenge(
      institutionKey: institutionKey ?? this.institutionKey,
      challengeId: challengeId ?? this.challengeId,
      challengeResponseValue:
          challengeResponseValue ?? this.challengeResponseValue,
      autoAddAllAccounts: autoAddAllAccounts ?? this.autoAddAllAccounts,
    );
  }

  factory InstitutionConnectRespondToChallenge.fromJson(
      Map<String, dynamic> json) {
    return InstitutionConnectRespondToChallenge(
      institutionKey: json['institutionKey'],
      challengeId: json['challengeId'],
      challengeResponseValue: json['challengeResponseValue'],
      autoAddAllAccounts: json['autoAddAllAccounts'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['institutionKey'] = institutionKey;
    data['challengeId'] = challengeId;
    data['challengeResponseValue'] = challengeResponseValue;
    data['autoAddAllAccounts'] = autoAddAllAccounts;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is InstitutionConnectRespondToChallenge &&
            (identical(other.institutionKey, institutionKey) ||
                const DeepCollectionEquality()
                    .equals(other.institutionKey, institutionKey)) &&
            (identical(other.challengeId, challengeId) ||
                const DeepCollectionEquality()
                    .equals(other.challengeId, challengeId)) &&
            (identical(other.challengeResponseValue, challengeResponseValue) ||
                const DeepCollectionEquality().equals(
                    other.challengeResponseValue, challengeResponseValue)) &&
            (identical(other.autoAddAllAccounts, autoAddAllAccounts) ||
                const DeepCollectionEquality()
                    .equals(other.autoAddAllAccounts, autoAddAllAccounts)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(institutionKey) ^
        const DeepCollectionEquality().hash(challengeId) ^
        const DeepCollectionEquality().hash(challengeResponseValue) ^
        const DeepCollectionEquality().hash(autoAddAllAccounts);
  }

  @override
  String toString() => 'InstitutionConnectRespondToChallenge(${toJson()})';
}
