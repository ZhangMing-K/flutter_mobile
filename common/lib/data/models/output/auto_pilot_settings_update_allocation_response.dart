import 'package:iris_common/data/models/output/auto_pilot_settings.dart';
import 'package:collection/collection.dart';

class AutoPilotSettingsUpdateAllocationResponse {
  final AutoPilotSettings? autoPilotSettings;
  const AutoPilotSettingsUpdateAllocationResponse({this.autoPilotSettings});
  AutoPilotSettingsUpdateAllocationResponse copyWith(
      {AutoPilotSettings? autoPilotSettings}) {
    return AutoPilotSettingsUpdateAllocationResponse(
      autoPilotSettings: autoPilotSettings ?? this.autoPilotSettings,
    );
  }

  factory AutoPilotSettingsUpdateAllocationResponse.fromJson(
      Map<String, dynamic> json) {
    return AutoPilotSettingsUpdateAllocationResponse(
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
        (other is AutoPilotSettingsUpdateAllocationResponse &&
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
  String toString() => 'AutoPilotSettingsUpdateAllocationResponse(${toJson()})';
}
