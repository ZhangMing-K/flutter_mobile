import 'package:collection/collection.dart';

class CollectionOrdersInput {
  final List<int>? userKeys;
  final List<int>? exludedUserKeys;
  final List<int>? assetKeys;
  final int? limit;
  final String? cursor;
  const CollectionOrdersInput(
      {this.userKeys,
      this.exludedUserKeys,
      this.assetKeys,
      required this.limit,
      this.cursor});
  CollectionOrdersInput copyWith(
      {List<int>? userKeys,
      List<int>? exludedUserKeys,
      List<int>? assetKeys,
      int? limit,
      String? cursor}) {
    return CollectionOrdersInput(
      userKeys: userKeys ?? this.userKeys,
      exludedUserKeys: exludedUserKeys ?? this.exludedUserKeys,
      assetKeys: assetKeys ?? this.assetKeys,
      limit: limit ?? this.limit,
      cursor: cursor ?? this.cursor,
    );
  }

  factory CollectionOrdersInput.fromJson(Map<String, dynamic> json) {
    return CollectionOrdersInput(
      userKeys: json['userKeys']?.map<int>((o) => (o as int)).toList(),
      exludedUserKeys:
          json['exludedUserKeys']?.map<int>((o) => (o as int)).toList(),
      assetKeys: json['assetKeys']?.map<int>((o) => (o as int)).toList(),
      limit: json['limit'],
      cursor: json['cursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKeys'] = userKeys;
    data['exludedUserKeys'] = exludedUserKeys;
    data['assetKeys'] = assetKeys;
    data['limit'] = limit;
    data['cursor'] = cursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CollectionOrdersInput &&
            (identical(other.userKeys, userKeys) ||
                const DeepCollectionEquality()
                    .equals(other.userKeys, userKeys)) &&
            (identical(other.exludedUserKeys, exludedUserKeys) ||
                const DeepCollectionEquality()
                    .equals(other.exludedUserKeys, exludedUserKeys)) &&
            (identical(other.assetKeys, assetKeys) ||
                const DeepCollectionEquality()
                    .equals(other.assetKeys, assetKeys)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.cursor, cursor) ||
                const DeepCollectionEquality().equals(other.cursor, cursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userKeys) ^
        const DeepCollectionEquality().hash(exludedUserKeys) ^
        const DeepCollectionEquality().hash(assetKeys) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(cursor);
  }

  @override
  String toString() => 'CollectionOrdersInput(${toJson()})';
}
