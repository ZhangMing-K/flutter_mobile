import 'package:collection/collection.dart';

class CollectionsGetInput {
  final List<int>? collectionKeys;
  const CollectionsGetInput({required this.collectionKeys});
  CollectionsGetInput copyWith({List<int>? collectionKeys}) {
    return CollectionsGetInput(
      collectionKeys: collectionKeys ?? this.collectionKeys,
    );
  }

  factory CollectionsGetInput.fromJson(Map<String, dynamic> json) {
    return CollectionsGetInput(
      collectionKeys:
          json['collectionKeys']?.map<int>((o) => (o as int)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['collectionKeys'] = collectionKeys;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CollectionsGetInput &&
            (identical(other.collectionKeys, collectionKeys) ||
                const DeepCollectionEquality()
                    .equals(other.collectionKeys, collectionKeys)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(collectionKeys);
  }

  @override
  String toString() => 'CollectionsGetInput(${toJson()})';
}
