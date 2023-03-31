import 'package:iris_common/data/models/output/institution.dart';
import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/enums/institution_connect_challenge_type.dart';
import 'package:iris_common/data/models/enums/institution_connect_step.dart';
import 'package:collection/collection.dart';

class InstitutionConnectResponse {
  final Institution? institution;
  final Portfolio? portfolio;
  final String? challengeId;
  final INSTITUTION_CONNECT_CHALLENGE_TYPE? challengeType;
  final List<String>? challengeOptions;
  final String? selectedChallengeValue;
  final INSTITUTION_CONNECT_STEP? connectStep;
  const InstitutionConnectResponse(
      {this.institution,
      this.portfolio,
      this.challengeId,
      this.challengeType,
      this.challengeOptions,
      this.selectedChallengeValue,
      this.connectStep});
  InstitutionConnectResponse copyWith(
      {Institution? institution,
      Portfolio? portfolio,
      String? challengeId,
      INSTITUTION_CONNECT_CHALLENGE_TYPE? challengeType,
      List<String>? challengeOptions,
      String? selectedChallengeValue,
      INSTITUTION_CONNECT_STEP? connectStep}) {
    return InstitutionConnectResponse(
      institution: institution ?? this.institution,
      portfolio: portfolio ?? this.portfolio,
      challengeId: challengeId ?? this.challengeId,
      challengeType: challengeType ?? this.challengeType,
      challengeOptions: challengeOptions ?? this.challengeOptions,
      selectedChallengeValue:
          selectedChallengeValue ?? this.selectedChallengeValue,
      connectStep: connectStep ?? this.connectStep,
    );
  }

  factory InstitutionConnectResponse.fromJson(Map<String, dynamic> json) {
    return InstitutionConnectResponse(
      institution: json['institution'] != null
          ? Institution.fromJson(json['institution'])
          : null,
      portfolio: json['portfolio'] != null
          ? Portfolio.fromJson(json['portfolio'])
          : null,
      challengeId: json['challengeId'],
      challengeType: json['challengeType'] != null
          ? INSTITUTION_CONNECT_CHALLENGE_TYPE.values
              .byName(json['challengeType'])
          : null,
      challengeOptions:
          json['challengeOptions']?.map<String>((o) => o.toString()).toList(),
      selectedChallengeValue: json['selectedChallengeValue'],
      connectStep: json['connectStep'] != null
          ? INSTITUTION_CONNECT_STEP.values.byName(json['connectStep'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['institution'] = institution?.toJson();
    data['portfolio'] = portfolio?.toJson();
    data['challengeId'] = challengeId;
    data['challengeType'] = challengeType?.name;
    data['challengeOptions'] = challengeOptions;
    data['selectedChallengeValue'] = selectedChallengeValue;
    data['connectStep'] = connectStep?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is InstitutionConnectResponse &&
            (identical(other.institution, institution) ||
                const DeepCollectionEquality()
                    .equals(other.institution, institution)) &&
            (identical(other.portfolio, portfolio) ||
                const DeepCollectionEquality()
                    .equals(other.portfolio, portfolio)) &&
            (identical(other.challengeId, challengeId) ||
                const DeepCollectionEquality()
                    .equals(other.challengeId, challengeId)) &&
            (identical(other.challengeType, challengeType) ||
                const DeepCollectionEquality()
                    .equals(other.challengeType, challengeType)) &&
            (identical(other.challengeOptions, challengeOptions) ||
                const DeepCollectionEquality()
                    .equals(other.challengeOptions, challengeOptions)) &&
            (identical(other.selectedChallengeValue, selectedChallengeValue) ||
                const DeepCollectionEquality().equals(
                    other.selectedChallengeValue, selectedChallengeValue)) &&
            (identical(other.connectStep, connectStep) ||
                const DeepCollectionEquality()
                    .equals(other.connectStep, connectStep)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(institution) ^
        const DeepCollectionEquality().hash(portfolio) ^
        const DeepCollectionEquality().hash(challengeId) ^
        const DeepCollectionEquality().hash(challengeType) ^
        const DeepCollectionEquality().hash(challengeOptions) ^
        const DeepCollectionEquality().hash(selectedChallengeValue) ^
        const DeepCollectionEquality().hash(connectStep);
  }

  @override
  String toString() => 'InstitutionConnectResponse(${toJson()})';
}
