import 'package:iris_common/data/models/output/auto_pilot_settings.dart';
import 'package:collection/collection.dart';

class AutoPilotSettingsUpdateResponse {
  final AutoPilotSettings? autoPilotSettings;
  const AutoPilotSettingsUpdateResponse({this.autoPilotSettings});
  AutoPilotSettingsUpdateResponse copyWith(
      {AutoPilotSettings? autoPilotSettings}) {
    return AutoPilotSettingsUpdateResponse(
      autoPilotSettings: autoPilotSettings ?? this.autoPilotSettings,
    );
  }

  factory AutoPilotSettingsUpdateResponse.fromJson(Map<String, dynamic> json) {
    return AutoPilotSettingsUpdateResponse(
      autoPilotSettings: json['autoPilotSettings'] != null
          ? AutoPilotSettings.fromJson(json['autoPilotSettings'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotSettings'] = autoPilotSettings?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotSettingsUpdateResponse &&
            (identical(other.autoPilotSettings, autoPilotSettings) ||
                const DeepCollectionEquality()
                    .equals(other.autoPilotSettings, autoPilotSettings)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(autoPilotSettings);
  }

  @override
  String toString() => 'AutoPilotSettingsUpdateResponse(${toJson()})';
}
