import 'package:iris_common/data/models/output/collection.dart';
import 'package:iris_common/data/models/output/collection_request.dart';
import 'package:collection/collection.dart';

class CollectionAddEntitiesResponse {
  final Collection? collection;
  final List<CollectionRequest>? collectionRequests;
  const CollectionAddEntitiesResponse(
      {this.collection, this.collectionRequests});
  CollectionAddEntitiesResponse copyWith(
      {Collection? collection, List<CollectionRequest>? collectionRequests}) {
    return CollectionAddEntitiesResponse(
      collection: collection ?? this.collection,
      collectionRequests: collectionRequests ?? this.collectionRequests,
    );
  }

  factory CollectionAddEntitiesResponse.fromJson(Map<String, dynamic> json) {
    return CollectionAddEntitiesResponse(
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
        (other is CollectionAddEntitiesResponse &&
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
  String toString() => 'CollectionAddEntitiesResponse(${toJson()})';
}
