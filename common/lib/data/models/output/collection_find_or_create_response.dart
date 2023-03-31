import 'package:iris_common/data/models/output/collection.dart';
import 'package:collection/collection.dart';

class CollectionFindOrCreateResponse {
  final Collection? collection;
  final bool? new_;
  const CollectionFindOrCreateResponse({this.collection, this.new_});
  CollectionFindOrCreateResponse copyWith(
      {Collection? collection, bool? new_}) {
    return CollectionFindOrCreateResponse(
      collection: collection ?? this.collection,
      new_: new_ ?? this.new_,
    );
  }

  factory CollectionFindOrCreateResponse.fromJson(Map<String, dynamic> json) {
    return CollectionFindOrCreateResponse(
      collection: json['collection'] != null
          ? Collection.fromJson(json['collection'])
          : null,
      new_: json['new_'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['collection'] = collection?.toJson();
    data['new_'] = new_;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CollectionFindOrCreateResponse &&
            (identical(other.collection, collection) ||
                const DeepCollectionEquality()
                    .equals(other.collection, collection)) &&
            (identical(other.new_, new_) ||
                const DeepCollectionEquality().equals(other.new_, new_)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(collection) ^
        const DeepCollectionEquality().hash(new_);
  }

  @override
  String toString() => 'CollectionFindOrCreateResponse(${toJson()})';
}
