import 'package:collection/collection.dart';

class InstitutionConnectSelectChallenge {
  final int? institutionKey;
  final String? challengeId;
  final String? challengeOptionSelected;
  const InstitutionConnectSelectChallenge(
      {required this.institutionKey,
      required this.challengeId,
      required this.challengeOptionSelected});
  InstitutionConnectSelectChallenge copyWith(
      {int? institutionKey,
      String? challengeId,
      String? challengeOptionSelected}) {
    return InstitutionConnectSelectChallenge(
      institutionKey: institutionKey ?? this.institutionKey,
      challengeId: challengeId ?? this.challengeId,
      challengeOptionSelected:
          challengeOptionSelected ?? this.challengeOptionSelected,
    );
  }

  factory InstitutionConnectSelectChallenge.fromJson(
      Map<String, dynamic> json) {
    return InstitutionConnectSelectChallenge(
      institutionKey: json['institutionKey'],
      challengeId: json['challengeId'],
      challengeOptionSelected: json['challengeOptionSelected'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['institutionKey'] = institutionKey;
    data['challengeId'] = challengeId;
    data['challengeOptionSelected'] = challengeOptionSelected;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is InstitutionConnectSelectChallenge &&
            (identical(other.institutionKey, institutionKey) ||
                const DeepCollectionEquality()
                    .equals(other.institutionKey, institutionKey)) &&
            (identical(other.challengeId, challengeId) ||
                const DeepCollectionEquality()
                    .equals(other.challengeId, challengeId)) &&
            (identical(
                    other.challengeOptionSelected, challengeOptionSelected) ||
                const DeepCollectionEquality().equals(
                    other.challengeOptionSelected, challengeOptionSelected)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(institutionKey) ^
        const DeepCollectionEquality().hash(challengeId) ^
        const DeepCollectionEquality().hash(challengeOptionSelected);
  }

  @override
  String toString() => 'InstitutionConnectSelectChallenge(${toJson()})';
}
