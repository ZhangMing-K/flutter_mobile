import 'package:collection/collection.dart';

class AutoPilotSettingsPauseInput {
  final int? autoPilotSettingsKey;
  const AutoPilotSettingsPauseInput({required this.autoPilotSettingsKey});
  AutoPilotSettingsPauseInput copyWith({int? autoPilotSettingsKey}) {
    return AutoPilotSettingsPauseInput(
      autoPilotSettingsKey: autoPilotSettingsKey ?? this.autoPilotSettingsKey,
    );
  }

  factory AutoPilotSettingsPauseInput.fromJson(Map<String, dynamic> json) {
    return AutoPilotSettingsPauseInput(
      autoPilotSettingsKey: json['autoPilotSettingsKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotSettingsKey'] = autoPilotSettingsKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotSettingsPauseInput &&
            (identical(other.autoPilotSettingsKey, autoPilotSettingsKey) ||
                const DeepCollectionEquality()
                    .equals(other.autoPilotSettingsKey, autoPilotSettingsKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(autoPilotSettingsKey);
  }

  @override
  String toString() => 'AutoPilotSettingsPauseInput(${toJson()})';
}
