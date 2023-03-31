import 'package:iris_common/data/models/enums/flag_entity_type.dart';
import 'package:iris_common/data/models/enums/flag_reason_type.dart';
import 'package:collection/collection.dart';

class FlagCreateInput {
  final FLAG_ENTITY_TYPE? flagEntityType;
  final FLAG_REASON_TYPE? flagType;
  final int? flagEntityKey;
  final String? reason;
  const FlagCreateInput(
      {required this.flagEntityType,
      required this.flagType,
      required this.flagEntityKey,
      this.reason});
  FlagCreateInput copyWith(
      {FLAG_ENTITY_TYPE? flagEntityType,
      FLAG_REASON_TYPE? flagType,
      int? flagEntityKey,
      String? reason}) {
    return FlagCreateInput(
      flagEntityType: flagEntityType ?? this.flagEntityType,
      flagType: flagType ?? this.flagType,
      flagEntityKey: flagEntityKey ?? this.flagEntityKey,
      reason: reason ?? this.reason,
    );
  }

  factory FlagCreateInput.fromJson(Map<String, dynamic> json) {
    return FlagCreateInput(
      flagEntityType: json['flagEntityType'] != null
          ? FLAG_ENTITY_TYPE.values.byName(json['flagEntityType'])
          : null,
      flagType: json['flagType'] != null
          ? FLAG_REASON_TYPE.values.byName(json['flagType'])
          : null,
      flagEntityKey: json['flagEntityKey'],
      reason: json['reason'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['flagEntityType'] = flagEntityType?.name;
    data['flagType'] = flagType?.name;
    data['flagEntityKey'] = flagEntityKey;
    data['reason'] = reason;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FlagCreateInput &&
            (identical(other.flagEntityType, flagEntityType) ||
                const DeepCollectionEquality()
                    .equals(other.flagEntityType, flagEntityType)) &&
            (identical(other.flagType, flagType) ||
                const DeepCollectionEquality()
                    .equals(other.flagType, flagType)) &&
            (identical(other.flagEntityKey, flagEntityKey) ||
                const DeepCollectionEquality()
                    .equals(other.flagEntityKey, flagEntityKey)) &&
            (identical(other.reason, reason) ||
                const DeepCollectionEquality().equals(other.reason, reason)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(flagEntityType) ^
        const DeepCollectionEquality().hash(flagType) ^
        const DeepCollectionEquality().hash(flagEntityKey) ^
        const DeepCollectionEquality().hash(reason);
  }

  @override
  String toString() => 'FlagCreateInput(${toJson()})';
}
