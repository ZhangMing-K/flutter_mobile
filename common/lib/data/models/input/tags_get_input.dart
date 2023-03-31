import 'package:iris_common/data/models/enums/tag_entity_type.dart';
import 'package:collection/collection.dart';

class TagsGetInput {
  final String? searchValue;
  final TAG_ENTITY_TYPE? entityType;
  final int? limit;
  final int? offset;
  const TagsGetInput(
      {this.searchValue, this.entityType, this.limit, this.offset});
  TagsGetInput copyWith(
      {String? searchValue,
      TAG_ENTITY_TYPE? entityType,
      int? limit,
      int? offset}) {
    return TagsGetInput(
      searchValue: searchValue ?? this.searchValue,
      entityType: entityType ?? this.entityType,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory TagsGetInput.fromJson(Map<String, dynamic> json) {
    return TagsGetInput(
      searchValue: json['searchValue'],
      entityType: json['entityType'] != null
          ? TAG_ENTITY_TYPE.values.byName(json['entityType'])
          : null,
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['searchValue'] = searchValue;
    data['entityType'] = entityType?.name;
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TagsGetInput &&
            (identical(other.searchValue, searchValue) ||
                const DeepCollectionEquality()
                    .equals(other.searchValue, searchValue)) &&
            (identical(other.entityType, entityType) ||
                const DeepCollectionEquality()
                    .equals(other.entityType, entityType)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(searchValue) ^
        const DeepCollectionEquality().hash(entityType) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'TagsGetInput(${toJson()})';
}
