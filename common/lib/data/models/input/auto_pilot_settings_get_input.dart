import 'package:iris_common/data/models/enums/setup_status.dart';
import 'package:collection/collection.dart';

class AutoPilotSettingsGetInput {
  final List<int>? autoPilotSettingsKeys;
  final List<SETUP_STATUS>? setupStatuses;
  const AutoPilotSettingsGetInput(
      {this.autoPilotSettingsKeys, this.setupStatuses});
  AutoPilotSettingsGetInput copyWith(
      {List<int>? autoPilotSettingsKeys, List<SETUP_STATUS>? setupStatuses}) {
    return AutoPilotSettingsGetInput(
      autoPilotSettingsKeys:
          autoPilotSettingsKeys ?? this.autoPilotSettingsKeys,
      setupStatuses: setupStatuses ?? this.setupStatuses,
    );
  }

  factory AutoPilotSettingsGetInput.fromJson(Map<String, dynamic> json) {
    return AutoPilotSettingsGetInput(
      autoPilotSettingsKeys:
          json['autoPilotSettingsKeys']?.map<int>((o) => (o as int)).toList(),
      setupStatuses: json['setupStatuses']
          ?.map<SETUP_STATUS>((o) => SETUP_STATUS.values.byName(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotSettingsKeys'] = autoPilotSettingsKeys;
    data['setupStatuses'] = setupStatuses?.map((item) => item.name).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotSettingsGetInput &&
            (identical(other.autoPilotSettingsKeys, autoPilotSettingsKeys) ||
                const DeepCollectionEquality().equals(
                    other.autoPilotSettingsKeys, autoPilotSettingsKeys)) &&
            (identical(other.setupStatuses, setupStatuses) ||
                const DeepCollectionEquality()
                    .equals(other.setupStatuses, setupStatuses)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(autoPilotSettingsKeys) ^
        const DeepCollectionEquality().hash(setupStatuses);
  }

  @override
  String toString() => 'AutoPilotSettingsGetInput(${toJson()})';
}
