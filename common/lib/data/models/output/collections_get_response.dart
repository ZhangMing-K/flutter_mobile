import 'package:iris_common/data/models/output/collection.dart';
import 'package:collection/collection.dart';

class CollectionsGetResponse {
  final List<Collection>? collections;
  const CollectionsGetResponse({this.collections});
  CollectionsGetResponse copyWith({List<Collection>? collections}) {
    return CollectionsGetResponse(
      collections: collections ?? this.collections,
    );
  }

  factory CollectionsGetResponse.fromJson(Map<String, dynamic> json) {
    return CollectionsGetResponse(
      collections: json['collections']
          ?.map<Collection>((o) => Collection.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['collections'] = collections?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CollectionsGetResponse &&
            (identical(other.collections, collections) ||
                const DeepCollectionEquality()
                    .equals(other.collections, collections)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(collections);
  }

  @override
  String toString() => 'CollectionsGetResponse(${toJson()})';
}
