import 'package:collection/collection.dart';

class CollectionTypingInput {
  final int? collectionKey;
  const CollectionTypingInput({required this.collectionKey});
  CollectionTypingInput copyWith({int? collectionKey}) {
    return CollectionTypingInput(
      collectionKey: collectionKey ?? this.collectionKey,
    );
  }

  factory CollectionTypingInput.fromJson(Map<String, dynamic> json) {
    return CollectionTypingInput(
      collectionKey: json['collectionKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['collectionKey'] = collectionKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CollectionTypingInput &&
            (identical(other.collectionKey, collectionKey) ||
                const DeepCollectionEquality()
                    .equals(other.collectionKey, collectionKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(collectionKey);
  }

  @override
  String toString() => 'CollectionTypingInput(${toJson()})';
}
