import 'package:iris_common/data/models/enums/flag_reason_type.dart';
import 'package:collection/collection.dart';

class FlagChildrenInput {
  final List<FLAG_REASON_TYPE>? flagTypes;
  final int? limit;
  final int? offset;
  const FlagChildrenInput({this.flagTypes, this.limit, this.offset});
  FlagChildrenInput copyWith(
      {List<FLAG_REASON_TYPE>? flagTypes, int? limit, int? offset}) {
    return FlagChildrenInput(
      flagTypes: flagTypes ?? this.flagTypes,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory FlagChildrenInput.fromJson(Map<String, dynamic> json) {
    return FlagChildrenInput(
      flagTypes: json['flagTypes']
          ?.map<FLAG_REASON_TYPE>((o) => FLAG_REASON_TYPE.values.byName(o))
          .toList(),
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['flagTypes'] = flagTypes?.map((item) => item.name).toList();
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FlagChildrenInput &&
            (identical(other.flagTypes, flagTypes) ||
                const DeepCollectionEquality()
                    .equals(other.flagTypes, flagTypes)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(flagTypes) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'FlagChildrenInput(${toJson()})';
}
