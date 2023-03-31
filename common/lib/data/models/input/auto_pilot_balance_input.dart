import 'package:collection/collection.dart';

class AutoPilotBalanceInput {
  final int? autoPilotSettingsKey;
  final String? idempotencyKey;
  final bool? testEnv;
  const AutoPilotBalanceInput(
      {required this.autoPilotSettingsKey,
      required this.idempotencyKey,
      this.testEnv});
  AutoPilotBalanceInput copyWith(
      {int? autoPilotSettingsKey, String? idempotencyKey, bool? testEnv}) {
    return AutoPilotBalanceInput(
      autoPilotSettingsKey: autoPilotSettingsKey ?? this.autoPilotSettingsKey,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      testEnv: testEnv ?? this.testEnv,
    );
  }

  factory AutoPilotBalanceInput.fromJson(Map<String, dynamic> json) {
    return AutoPilotBalanceInput(
      autoPilotSettingsKey: json['autoPilotSettingsKey'],
      idempotencyKey: json['idempotencyKey'],
      testEnv: json['testEnv'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotSettingsKey'] = autoPilotSettingsKey;
    data['idempotencyKey'] = idempotencyKey;
    data['testEnv'] = testEnv;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotBalanceInput &&
            (identical(other.autoPilotSettingsKey, autoPilotSettingsKey) ||
                const DeepCollectionEquality().equals(
                    other.autoPilotSettingsKey, autoPilotSettingsKey)) &&
            (identical(other.idempotencyKey, idempotencyKey) ||
                const DeepCollectionEquality()
                    .equals(other.idempotencyKey, idempotencyKey)) &&
            (identical(other.testEnv, testEnv) ||
                const DeepCollectionEquality().equals(other.testEnv, testEnv)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(autoPilotSettingsKey) ^
        const DeepCollectionEquality().hash(idempotencyKey) ^
        const DeepCollectionEquality().hash(testEnv);
  }

  @override
  String toString() => 'AutoPilotBalanceInput(${toJson()})';
}
