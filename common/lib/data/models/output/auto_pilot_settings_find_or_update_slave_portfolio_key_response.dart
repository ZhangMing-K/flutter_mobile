import 'package:iris_common/data/models/output/auto_pilot_settings.dart';
import 'package:collection/collection.dart';

class AutoPilotSettingsFindOrUpdateSlavePortfolioKeyResponse {
  final AutoPilotSettings? autoPilotSettings;
  final int? nbrUpdated;
  const AutoPilotSettingsFindOrUpdateSlavePortfolioKeyResponse(
      {this.autoPilotSettings, this.nbrUpdated});
  AutoPilotSettingsFindOrUpdateSlavePortfolioKeyResponse copyWith(
      {AutoPilotSettings? autoPilotSettings, int? nbrUpdated}) {
    return AutoPilotSettingsFindOrUpdateSlavePortfolioKeyResponse(
      autoPilotSettings: autoPilotSettings ?? this.autoPilotSettings,
      nbrUpdated: nbrUpdated ?? this.nbrUpdated,
    );
  }

  factory AutoPilotSettingsFindOrUpdateSlavePortfolioKeyResponse.fromJson(
      Map<String, dynamic> json) {
    return AutoPilotSettingsFindOrUpdateSlavePortfolioKeyResponse(
      autoPilotSettings: json['autoPilotSettings'] != null
          ? AutoPilotSettings.fromJson(json['autoPilotSettings'])
          : null,
      nbrUpdated: json['nbrUpdated'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotSettings'] = autoPilotSettings?.toJson();
    data['nbrUpdated'] = nbrUpdated;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotSettingsFindOrUpdateSlavePortfolioKeyResponse &&
            (identical(other.autoPilotSettings, autoPilotSettings) ||
                const DeepCollectionEquality()
                    .equals(other.autoPilotSettings, autoPilotSettings)) &&
            (identical(other.nbrUpdated, nbrUpdated) ||
                const DeepCollectionEquality()
                    .equals(other.nbrUpdated, nbrUpdated)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(autoPilotSettings) ^
        const DeepCollectionEquality().hash(nbrUpdated);
  }

  @override
  String toString() =>
      'AutoPilotSettingsFindOrUpdateSlavePortfolioKeyResponse(${toJson()})';
}
