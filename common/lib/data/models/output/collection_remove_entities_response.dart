import 'package:iris_common/data/models/output/collection.dart';
import 'package:iris_common/data/models/output/collection_request.dart';
import 'package:collection/collection.dart';

class CollectionRemoveEntitiesResponse {
  final Collection? collection;
  final List<CollectionRequest>? collectionRequests;
  const CollectionRemoveEntitiesResponse(
      {this.collection, this.collectionRequests});
  CollectionRemoveEntitiesResponse copyWith(
      {Collection? collection, List<CollectionRequest>? collectionRequests}) {
    return CollectionRemoveEntitiesResponse(
      collection: collection ?? this.collection,
      collectionRequests: collectionRequests ?? this.collectionRequests,
    );
  }

  factory CollectionRemoveEntitiesResponse.fromJson(Map<String, dynamic> json) {
    return CollectionRemoveEntitiesResponse(
      collection: json['collection'] != null
          ? Collection.fromJson(json['collection'])
          : null,
      collectionRequests: json['collectionRequests']
          ?.map<CollectionRequest>((o) => CollectionRequest.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['collection'] = collection?.toJson();
    data['collectionRequests'] =
        collectionRequests?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CollectionRemoveEntitiesResponse &&
            (identical(other.collection, collection) ||
                const DeepCollectionEquality()
                    .equals(other.collection, collection)) &&
            (identical(other.collectionRequests, collectionRequests) ||
                const DeepCollectionEquality()
                    .equals(other.collectionRequests, collectionRequests)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(collection) ^
        const DeepCollectionEquality().hash(collectionRequests);
  }

  @override
  String toString() => 'CollectionRemoveEntitiesResponse(${toJson()})';
}
