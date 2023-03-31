import 'package:collection/collection.dart';

class AutoPilotSettingsFindOrUpdateSlavePortfolioKeyInput {
  final int? autoPilotSettingsKey;
  final int? slavePortfolioKey;
  const AutoPilotSettingsFindOrUpdateSlavePortfolioKeyInput(
      {required this.autoPilotSettingsKey, required this.slavePortfolioKey});
  AutoPilotSettingsFindOrUpdateSlavePortfolioKeyInput copyWith(
      {int? autoPilotSettingsKey, int? slavePortfolioKey}) {
    return AutoPilotSettingsFindOrUpdateSlavePortfolioKeyInput(
      autoPilotSettingsKey: autoPilotSettingsKey ?? this.autoPilotSettingsKey,
      slavePortfolioKey: slavePortfolioKey ?? this.slavePortfolioKey,
    );
  }

  factory AutoPilotSettingsFindOrUpdateSlavePortfolioKeyInput.fromJson(
      Map<String, dynamic> json) {
    return AutoPilotSettingsFindOrUpdateSlavePortfolioKeyInput(
      autoPilotSettingsKey: json['autoPilotSettingsKey'],
      slavePortfolioKey: json['slavePortfolioKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotSettingsKey'] = autoPilotSettingsKey;
    data['slavePortfolioKey'] = slavePortfolioKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotSettingsFindOrUpdateSlavePortfolioKeyInput &&
            (identical(other.autoPilotSettingsKey, autoPilotSettingsKey) ||
                const DeepCollectionEquality().equals(
                    other.autoPilotSettingsKey, autoPilotSettingsKey)) &&
            (identical(other.slavePortfolioKey, slavePortfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.slavePortfolioKey, slavePortfolioKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(autoPilotSettingsKey) ^
        const DeepCollectionEquality().hash(slavePortfolioKey);
  }

  @override
  String toString() =>
      'AutoPilotSettingsFindOrUpdateSlavePortfolioKeyInput(${toJson()})';
}
