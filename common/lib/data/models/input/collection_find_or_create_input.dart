import 'package:collection/collection.dart';

class CollectionFindOrCreateInput {
  final int? userKey;
  const CollectionFindOrCreateInput({required this.userKey});
  CollectionFindOrCreateInput copyWith({int? userKey}) {
    return CollectionFindOrCreateInput(
      userKey: userKey ?? this.userKey,
    );
  }

  factory CollectionFindOrCreateInput.fromJson(Map<String, dynamic> json) {
    return CollectionFindOrCreateInput(
      userKey: json['userKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKey'] = userKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CollectionFindOrCreateInput &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality().equals(other.userKey, userKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(userKey);
  }

  @override
  String toString() => 'CollectionFindOrCreateInput(${toJson()})';
}
