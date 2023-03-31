import 'package:iris_common/data/models/output/auto_pilot_settings.dart';
import 'package:collection/collection.dart';

class AutoPilotSettingsDeleteResponse {
  final AutoPilotSettings? autoPilotSettings;
  const AutoPilotSettingsDeleteResponse({this.autoPilotSettings});
  AutoPilotSettingsDeleteResponse copyWith(
      {AutoPilotSettings? autoPilotSettings}) {
    return AutoPilotSettingsDeleteResponse(
      autoPilotSettings: autoPilotSettings ?? this.autoPilotSettings,
    );
  }

  factory AutoPilotSettingsDeleteResponse.fromJson(Map<String, dynamic> json) {
    return AutoPilotSettingsDeleteResponse(
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
        (other is AutoPilotSettingsDeleteResponse &&
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
  String toString() => 'AutoPilotSettingsDeleteResponse(${toJson()})';
}
