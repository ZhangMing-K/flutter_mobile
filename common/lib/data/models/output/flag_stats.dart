import 'package:iris_common/data/models/enums/flag_reason_type.dart';
import 'package:collection/collection.dart';

class FlagStats {
  final int? numberOfFlags;
  final FLAG_REASON_TYPE? flagType;
  const FlagStats({this.numberOfFlags, this.flagType});
  FlagStats copyWith({int? numberOfFlags, FLAG_REASON_TYPE? flagType}) {
    return FlagStats(
      numberOfFlags: numberOfFlags ?? this.numberOfFlags,
      flagType: flagType ?? this.flagType,
    );
  }

  factory FlagStats.fromJson(Map<String, dynamic> json) {
    return FlagStats(
      numberOfFlags: json['numberOfFlags'],
      flagType: json['flagType'] != null
          ? FLAG_REASON_TYPE.values.byName(json['flagType'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['numberOfFlags'] = numberOfFlags;
    data['flagType'] = flagType?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FlagStats &&
            (identical(other.numberOfFlags, numberOfFlags) ||
                const DeepCollectionEquality()
                    .equals(other.numberOfFlags, numberOfFlags)) &&
            (identical(other.flagType, flagType) ||
                const DeepCollectionEquality()
                    .equals(other.flagType, flagType)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(numberOfFlags) ^
        const DeepCollectionEquality().hash(flagType);
  }

  @override
  String toString() => 'FlagStats(${toJson()})';
}
