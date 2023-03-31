import 'package:iris_common/data/models/enums/collection_request_entity_type.dart';
import 'package:collection/collection.dart';

class CollectionAddEntitiesInput {
  final int? collectionKey;
  final COLLECTION_REQUEST_ENTITY_TYPE? entityType;
  final List<int>? entityKeys;
  const CollectionAddEntitiesInput(
      {required this.collectionKey,
      required this.entityType,
      required this.entityKeys});
  CollectionAddEntitiesInput copyWith(
      {int? collectionKey,
      COLLECTION_REQUEST_ENTITY_TYPE? entityType,
      List<int>? entityKeys}) {
    return CollectionAddEntitiesInput(
      collectionKey: collectionKey ?? this.collectionKey,
      entityType: entityType ?? this.entityType,
      entityKeys: entityKeys ?? this.entityKeys,
    );
  }

  factory CollectionAddEntitiesInput.fromJson(Map<String, dynamic> json) {
    return CollectionAddEntitiesInput(
      collectionKey: json['collectionKey'],
      entityType: json['entityType'] != null
          ? COLLECTION_REQUEST_ENTITY_TYPE.values.byName(json['entityType'])
          : null,
      entityKeys: json['entityKeys']?.map<int>((o) => (o as int)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['collectionKey'] = collectionKey;
    data['entityType'] = entityType?.name;
    data['entityKeys'] = entityKeys;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CollectionAddEntitiesInput &&
            (identical(other.collectionKey, collectionKey) ||
                const DeepCollectionEquality()
                    .equals(other.collectionKey, collectionKey)) &&
            (identical(other.entityType, entityType) ||
                const DeepCollectionEquality()
                    .equals(other.entityType, entityType)) &&
            (identical(other.entityKeys, entityKeys) ||
                const DeepCollectionEquality()
                    .equals(other.entityKeys, entityKeys)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(collectionKey) ^
        const DeepCollectionEquality().hash(entityType) ^
        const DeepCollectionEquality().hash(entityKeys);
  }

  @override
  String toString() => 'CollectionAddEntitiesInput(${toJson()})';
}
