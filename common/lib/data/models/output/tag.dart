import 'package:iris_common/data/models/enums/tag_entity_type.dart';
import 'package:collection/collection.dart';

class Tag {
  final TAG_ENTITY_TYPE? entityType;
  final int? entityKey;
  final String? value;
  final String? tagSymbol;
  final String? fullName;
  final String? pictureUrl;
  const Tag(
      {this.entityType,
      this.entityKey,
      this.value,
      this.tagSymbol,
      this.fullName,
      this.pictureUrl});
  Tag copyWith(
      {TAG_ENTITY_TYPE? entityType,
      int? entityKey,
      String? value,
      String? tagSymbol,
      String? fullName,
      String? pictureUrl}) {
    return Tag(
      entityType: entityType ?? this.entityType,
      entityKey: entityKey ?? this.entityKey,
      value: value ?? this.value,
      tagSymbol: tagSymbol ?? this.tagSymbol,
      fullName: fullName ?? this.fullName,
      pictureUrl: pictureUrl ?? this.pictureUrl,
    );
  }

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      entityType: json['entityType'] != null
          ? TAG_ENTITY_TYPE.values.byName(json['entityType'])
          : null,
      entityKey: json['entityKey'],
      value: json['value'],
      tagSymbol: json['tagSymbol'],
      fullName: json['fullName'],
      pictureUrl: json['pictureUrl'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['entityType'] = entityType?.name;
    data['entityKey'] = entityKey;
    data['value'] = value;
    data['tagSymbol'] = tagSymbol;
    data['fullName'] = fullName;
    data['pictureUrl'] = pictureUrl;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Tag &&
            (identical(other.entityType, entityType) ||
                const DeepCollectionEquality()
                    .equals(other.entityType, entityType)) &&
            (identical(other.entityKey, entityKey) ||
                const DeepCollectionEquality()
                    .equals(other.entityKey, entityKey)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.tagSymbol, tagSymbol) ||
                const DeepCollectionEquality()
                    .equals(other.tagSymbol, tagSymbol)) &&
            (identical(other.fullName, fullName) ||
                const DeepCollectionEquality()
                    .equals(other.fullName, fullName)) &&
            (identical(other.pictureUrl, pictureUrl) ||
                const DeepCollectionEquality()
                    .equals(other.pictureUrl, pictureUrl)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(entityType) ^
        const DeepCollectionEquality().hash(entityKey) ^
        const DeepCollectionEquality().hash(value) ^
        const DeepCollectionEquality().hash(tagSymbol) ^
        const DeepCollectionEquality().hash(fullName) ^
        const DeepCollectionEquality().hash(pictureUrl);
  }

  @override
  String toString() => 'Tag(${toJson()})';
}
