import 'package:iris_common/data/models/enums/collection_event_type.dart';
import 'package:collection/collection.dart';

class CollectionEventInput {
  final List<int>? collectionKeys;
  final List<COLLECTION_EVENT_TYPE>? eventTypes;
  const CollectionEventInput({this.collectionKeys, this.eventTypes});
  CollectionEventInput copyWith(
      {List<int>? collectionKeys, List<COLLECTION_EVENT_TYPE>? eventTypes}) {
    return CollectionEventInput(
      collectionKeys: collectionKeys ?? this.collectionKeys,
      eventTypes: eventTypes ?? this.eventTypes,
    );
  }

  factory CollectionEventInput.fromJson(Map<String, dynamic> json) {
    return CollectionEventInput(
      collectionKeys:
          json['collectionKeys']?.map<int>((o) => (o as int)).toList(),
      eventTypes: json['eventTypes']
          ?.map<COLLECTION_EVENT_TYPE>(
              (o) => COLLECTION_EVENT_TYPE.values.byName(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['collectionKeys'] = collectionKeys;
    data['eventTypes'] = eventTypes?.map((item) => item.name).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CollectionEventInput &&
            (identical(other.collectionKeys, collectionKeys) ||
                const DeepCollectionEquality()
                    .equals(other.collectionKeys, collectionKeys)) &&
            (identical(other.eventTypes, eventTypes) ||
                const DeepCollectionEquality()
                    .equals(other.eventTypes, eventTypes)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(collectionKeys) ^
        const DeepCollectionEquality().hash(eventTypes);
  }

  @override
  String toString() => 'CollectionEventInput(${toJson()})';
}
