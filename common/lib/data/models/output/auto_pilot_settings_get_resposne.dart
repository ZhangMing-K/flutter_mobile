import 'package:iris_common/data/models/output/auto_pilot_settings.dart';
import 'package:collection/collection.dart';

class AutoPilotSettingsGetResposne {
  final List<AutoPilotSettings>? autoPilotSettings;
  const AutoPilotSettingsGetResposne({this.autoPilotSettings});
  AutoPilotSettingsGetResposne copyWith(
      {List<AutoPilotSettings>? autoPilotSettings}) {
    return AutoPilotSettingsGetResposne(
      autoPilotSettings: autoPilotSettings ?? this.autoPilotSettings,
    );
  }

  factory AutoPilotSettingsGetResposne.fromJson(Map<String, dynamic> json) {
    return AutoPilotSettingsGetResposne(
      autoPilotSettings: json['autoPilotSettings']
          ?.map<AutoPilotSettings>((o) => AutoPilotSettings.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotSettings'] =
        autoPilotSettings?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotSettingsGetResposne &&
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
  String toString() => 'AutoPilotSettingsGetResposne(${toJson()})';
}
