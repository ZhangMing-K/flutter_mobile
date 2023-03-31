import 'package:iris_common/data/models/enums/flag_entity_type.dart';
import 'package:iris_common/data/models/enums/review_status.dart';
import 'package:collection/collection.dart';

class FlagSearchInput {
  final String? value;
  final List<FLAG_ENTITY_TYPE>? excludeTypes;
  final List<REVIEW_STATUS>? excludeStatuses;
  final int? limit;
  final int? offset;
  final bool? includeChildren;
  const FlagSearchInput(
      {this.value,
      this.excludeTypes,
      this.excludeStatuses,
      this.limit,
      this.offset,
      this.includeChildren});
  FlagSearchInput copyWith(
      {String? value,
      List<FLAG_ENTITY_TYPE>? excludeTypes,
      List<REVIEW_STATUS>? excludeStatuses,
      int? limit,
      int? offset,
      bool? includeChildren}) {
    return FlagSearchInput(
      value: value ?? this.value,
      excludeTypes: excludeTypes ?? this.excludeTypes,
      excludeStatuses: excludeStatuses ?? this.excludeStatuses,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      includeChildren: includeChildren ?? this.includeChildren,
    );
  }

  factory FlagSearchInput.fromJson(Map<String, dynamic> json) {
    return FlagSearchInput(
      value: json['value'],
      excludeTypes: json['excludeTypes']
          ?.map<FLAG_ENTITY_TYPE>((o) => FLAG_ENTITY_TYPE.values.byName(o))
          .toList(),
      excludeStatuses: json['excludeStatuses']
          ?.map<REVIEW_STATUS>((o) => REVIEW_STATUS.values.byName(o))
          .toList(),
      limit: json['limit'],
      offset: json['offset'],
      includeChildren: json['includeChildren'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['value'] = value;
    data['excludeTypes'] = excludeTypes?.map((item) => item.name).toList();
    data['excludeStatuses'] =
        excludeStatuses?.map((item) => item.name).toList();
    data['limit'] = limit;
    data['offset'] = offset;
    data['includeChildren'] = includeChildren;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FlagSearchInput &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.excludeTypes, excludeTypes) ||
                const DeepCollectionEquality()
                    .equals(other.excludeTypes, excludeTypes)) &&
            (identical(other.excludeStatuses, excludeStatuses) ||
                const DeepCollectionEquality()
                    .equals(other.excludeStatuses, excludeStatuses)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.includeChildren, includeChildren) ||
                const DeepCollectionEquality()
                    .equals(other.includeChildren, includeChildren)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(value) ^
        const DeepCollectionEquality().hash(excludeTypes) ^
        const DeepCollectionEquality().hash(excludeStatuses) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(includeChildren);
  }

  @override
  String toString() => 'FlagSearchInput(${toJson()})';
}
