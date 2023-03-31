import 'package:iris_common/data/models/output/auto_pilot_settings.dart';
import 'package:iris_common/data/models/enums/auto_pilot_onboarding_step.dart';
import 'package:collection/collection.dart';

class AutoPilotOnboardingConnection {
  final List<AutoPilotSettings>? autoPilotSettings;
  final List<AUTO_PILOT_ONBOARDING_STEP>? missingSteps;
  const AutoPilotOnboardingConnection(
      {this.autoPilotSettings, this.missingSteps});
  AutoPilotOnboardingConnection copyWith(
      {List<AutoPilotSettings>? autoPilotSettings,
      List<AUTO_PILOT_ONBOARDING_STEP>? missingSteps}) {
    return AutoPilotOnboardingConnection(
      autoPilotSettings: autoPilotSettings ?? this.autoPilotSettings,
      missingSteps: missingSteps ?? this.missingSteps,
    );
  }

  factory AutoPilotOnboardingConnection.fromJson(Map<String, dynamic> json) {
    return AutoPilotOnboardingConnection(
      autoPilotSettings: json['autoPilotSettings']
          ?.map<AutoPilotSettings>((o) => AutoPilotSettings.fromJson(o))
          .toList(),
      missingSteps: json['missingSteps']
          ?.map<AUTO_PILOT_ONBOARDING_STEP>(
              (o) => AUTO_PILOT_ONBOARDING_STEP.values.byName(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotSettings'] =
        autoPilotSettings?.map((item) => item.toJson()).toList();
    data['missingSteps'] = missingSteps?.map((item) => item.name).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotOnboardingConnection &&
            (identical(other.autoPilotSettings, autoPilotSettings) ||
                const DeepCollectionEquality()
                    .equals(other.autoPilotSettings, autoPilotSettings)) &&
            (identical(other.missingSteps, missingSteps) ||
                const DeepCollectionEquality()
                    .equals(other.missingSteps, missingSteps)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(autoPilotSettings) ^
        const DeepCollectionEquality().hash(missingSteps);
  }

  @override
  String toString() => 'AutoPilotOnboardingConnection(${toJson()})';
}
