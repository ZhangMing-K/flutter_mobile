import 'package:iris_common/data/models/enums/auto_pilot_settings_status.dart';
import 'package:collection/collection.dart';

class AutoPilotSettingsInput {
  final AUTO_PILOT_SETTINGS_STATUS? status;
  final List<int>? masterUserKeys;
  const AutoPilotSettingsInput({this.status, this.masterUserKeys});
  AutoPilotSettingsInput copyWith(
      {AUTO_PILOT_SETTINGS_STATUS? status, List<int>? masterUserKeys}) {
    return AutoPilotSettingsInput(
      status: status ?? this.status,
      masterUserKeys: masterUserKeys ?? this.masterUserKeys,
    );
  }

  factory AutoPilotSettingsInput.fromJson(Map<String, dynamic> json) {
    return AutoPilotSettingsInput(
      status: json['status'] != null
          ? AUTO_PILOT_SETTINGS_STATUS.values.byName(json['status'])
          : null,
      masterUserKeys:
          json['masterUserKeys']?.map<int>((o) => (o as int)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['status'] = status?.name;
    data['masterUserKeys'] = masterUserKeys;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotSettingsInput &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.masterUserKeys, masterUserKeys) ||
                const DeepCollectionEquality()
                    .equals(other.masterUserKeys, masterUserKeys)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(status) ^
        const DeepCollectionEquality().hash(masterUserKeys);
  }

  @override
  String toString() => 'AutoPilotSettingsInput(${toJson()})';
}
