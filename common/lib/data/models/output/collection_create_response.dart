import 'package:iris_common/data/models/output/collection.dart';
import 'package:collection/collection.dart';

class CollectionCreateResponse {
  final Collection? collection;
  const CollectionCreateResponse({this.collection});
  CollectionCreateResponse copyWith({Collection? collection}) {
    return CollectionCreateResponse(
      collection: collection ?? this.collection,
    );
  }

  factory CollectionCreateResponse.fromJson(Map<String, dynamic> json) {
    return CollectionCreateResponse(
      collection: json['collection'] != null
          ? Collection.fromJson(json['collection'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['collection'] = collection?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CollectionCreateResponse &&
            (identical(other.collection, collection) ||
                const DeepCollectionEquality()
                    .equals(other.collection, collection)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(collection);
  }

  @override
  String toString() => 'CollectionCreateResponse(${toJson()})';
}
