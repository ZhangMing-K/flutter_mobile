import 'package:iris_common/data/models/output/auto_pilot_settings.dart';
import 'package:collection/collection.dart';

class AutoPilotSettingsCreateResponse {
  final AutoPilotSettings? autoPilotSettings;
  const AutoPilotSettingsCreateResponse({this.autoPilotSettings});
  AutoPilotSettingsCreateResponse copyWith(
      {AutoPilotSettings? autoPilotSettings}) {
    return AutoPilotSettingsCreateResponse(
      autoPilotSettings: autoPilotSettings ?? this.autoPilotSettings,
    );
  }

  factory AutoPilotSettingsCreateResponse.fromJson(Map<String, dynamic> json) {
    return AutoPilotSettingsCreateResponse(
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
        (other is AutoPilotSettingsCreateResponse &&
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
  String toString() => 'AutoPilotSettingsCreateResponse(${toJson()})';
}
