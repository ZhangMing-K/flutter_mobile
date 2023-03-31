import 'package:iris_common/data/models/enums/update_allocation_action.dart';
import 'package:collection/collection.dart';

class AutoPilotSettingsUpdateAllocationInput {
  final int? autoPilotSettingsKey;
  final double? value;
  final UPDATE_ALLOCATION_ACTION? action;
  const AutoPilotSettingsUpdateAllocationInput(
      {required this.autoPilotSettingsKey,
      required this.value,
      required this.action});
  AutoPilotSettingsUpdateAllocationInput copyWith(
      {int? autoPilotSettingsKey,
      double? value,
      UPDATE_ALLOCATION_ACTION? action}) {
    return AutoPilotSettingsUpdateAllocationInput(
      autoPilotSettingsKey: autoPilotSettingsKey ?? this.autoPilotSettingsKey,
      value: value ?? this.value,
      action: action ?? this.action,
    );
  }

  factory AutoPilotSettingsUpdateAllocationInput.fromJson(
      Map<String, dynamic> json) {
    return AutoPilotSettingsUpdateAllocationInput(
      autoPilotSettingsKey: json['autoPilotSettingsKey'],
      value: json['value']?.toDouble(),
      action: json['action'] != null
          ? UPDATE_ALLOCATION_ACTION.values.byName(json['action'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotSettingsKey'] = autoPilotSettingsKey;
    data['value'] = value;
    data['action'] = action?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotSettingsUpdateAllocationInput &&
            (identical(other.autoPilotSettingsKey, autoPilotSettingsKey) ||
                const DeepCollectionEquality().equals(
                    other.autoPilotSettingsKey, autoPilotSettingsKey)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.action, action) ||
                const DeepCollectionEquality().equals(other.action, action)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(autoPilotSettingsKey) ^
        const DeepCollectionEquality().hash(value) ^
        const DeepCollectionEquality().hash(action);
  }

  @override
  String toString() => 'AutoPilotSettingsUpdateAllocationInput(${toJson()})';
}
