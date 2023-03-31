import 'package:iris_common/data/models/enums/mfa_verify_action.dart';
import 'package:iris_common/data/models/enums/app_client_type.dart';
import 'package:collection/collection.dart';

class MFAContactVerifyInput {
  final String? challengeId;
  final String? code;
  final MFA_VERIFY_ACTION? action;
  final APP_CLIENT_TYPE? appClientType;
  const MFAContactVerifyInput(
      {required this.challengeId,
      required this.code,
      this.action,
      this.appClientType});
  MFAContactVerifyInput copyWith(
      {String? challengeId,
      String? code,
      MFA_VERIFY_ACTION? action,
      APP_CLIENT_TYPE? appClientType}) {
    return MFAContactVerifyInput(
      challengeId: challengeId ?? this.challengeId,
      code: code ?? this.code,
      action: action ?? this.action,
      appClientType: appClientType ?? this.appClientType,
    );
  }

  factory MFAContactVerifyInput.fromJson(Map<String, dynamic> json) {
    return MFAContactVerifyInput(
      challengeId: json['challengeId'],
      code: json['code'],
      action: json['action'] != null
          ? MFA_VERIFY_ACTION.values.byName(json['action'])
          : null,
      appClientType: json['appClientType'] != null
          ? APP_CLIENT_TYPE.values.byName(json['appClientType'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['challengeId'] = challengeId;
    data['code'] = code;
    data['action'] = action?.name;
    data['appClientType'] = appClientType?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MFAContactVerifyInput &&
            (identical(other.challengeId, challengeId) ||
                const DeepCollectionEquality()
                    .equals(other.challengeId, challengeId)) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.action, action) ||
                const DeepCollectionEquality().equals(other.action, action)) &&
            (identical(other.appClientType, appClientType) ||
                const DeepCollectionEquality()
                    .equals(other.appClientType, appClientType)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(challengeId) ^
        const DeepCollectionEquality().hash(code) ^
        const DeepCollectionEquality().hash(action) ^
        const DeepCollectionEquality().hash(appClientType);
  }

  @override
  String toString() => 'MFAContactVerifyInput(${toJson()})';
}
