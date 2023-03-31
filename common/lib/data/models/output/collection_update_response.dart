import 'package:iris_common/data/models/output/collection.dart';
import 'package:collection/collection.dart';

class CollectionUpdateResponse {
  final Collection? collection;
  const CollectionUpdateResponse({this.collection});
  CollectionUpdateResponse copyWith({Collection? collection}) {
    return CollectionUpdateResponse(
      collection: collection ?? this.collection,
    );
  }

  factory CollectionUpdateResponse.fromJson(Map<String, dynamic> json) {
    return CollectionUpdateResponse(
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
        (other is CollectionUpdateResponse &&
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
  String toString() => 'CollectionUpdateResponse(${toJson()})';
}
