import 'package:iris_common/data/models/enums/text_type.dart';
import 'package:collection/collection.dart';

class TextsGetInput {
  final List<int>? userKeys;
  final List<int>? assetKeys;
  final List<int>? textKeys;
  final List<int>? orderKeys;
  final List<TEXT_TYPE>? textTypes;
  final List<String>? orderGroupUUIDS;
  final String? cursor;
  final int? limit;
  const TextsGetInput(
      {this.userKeys,
      this.assetKeys,
      this.textKeys,
      this.orderKeys,
      this.textTypes,
      this.orderGroupUUIDS,
      this.cursor,
      this.limit});
  TextsGetInput copyWith(
      {List<int>? userKeys,
      List<int>? assetKeys,
      List<int>? textKeys,
      List<int>? orderKeys,
      List<TEXT_TYPE>? textTypes,
      List<String>? orderGroupUUIDS,
      String? cursor,
      int? limit}) {
    return TextsGetInput(
      userKeys: userKeys ?? this.userKeys,
      assetKeys: assetKeys ?? this.assetKeys,
      textKeys: textKeys ?? this.textKeys,
      orderKeys: orderKeys ?? this.orderKeys,
      textTypes: textTypes ?? this.textTypes,
      orderGroupUUIDS: orderGroupUUIDS ?? this.orderGroupUUIDS,
      cursor: cursor ?? this.cursor,
      limit: limit ?? this.limit,
    );
  }

  factory TextsGetInput.fromJson(Map<String, dynamic> json) {
    return TextsGetInput(
      userKeys: json['userKeys']?.map<int>((o) => (o as int)).toList(),
      assetKeys: json['assetKeys']?.map<int>((o) => (o as int)).toList(),
      textKeys: json['textKeys']?.map<int>((o) => (o as int)).toList(),
      orderKeys: json['orderKeys']?.map<int>((o) => (o as int)).toList(),
      textTypes: json['textTypes']
          ?.map<TEXT_TYPE>((o) => TEXT_TYPE.values.byName(o))
          .toList(),
      orderGroupUUIDS:
          json['orderGroupUUIDS']?.map<String>((o) => o.toString()).toList(),
      cursor: json['cursor'],
      limit: json['limit'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKeys'] = userKeys;
    data['assetKeys'] = assetKeys;
    data['textKeys'] = textKeys;
    data['orderKeys'] = orderKeys;
    data['textTypes'] = textTypes?.map((item) => item.name).toList();
    data['orderGroupUUIDS'] = orderGroupUUIDS;
    data['cursor'] = cursor;
    data['limit'] = limit;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TextsGetInput &&
            (identical(other.userKeys, userKeys) ||
                const DeepCollectionEquality()
                    .equals(other.userKeys, userKeys)) &&
            (identical(other.assetKeys, assetKeys) ||
                const DeepCollectionEquality()
                    .equals(other.assetKeys, assetKeys)) &&
            (identical(other.textKeys, textKeys) ||
                const DeepCollectionEquality()
                    .equals(other.textKeys, textKeys)) &&
            (identical(other.orderKeys, orderKeys) ||
                const DeepCollectionEquality()
                    .equals(other.orderKeys, orderKeys)) &&
            (identical(other.textTypes, textTypes) ||
                const DeepCollectionEquality()
                    .equals(other.textTypes, textTypes)) &&
            (identical(other.orderGroupUUIDS, orderGroupUUIDS) ||
                const DeepCollectionEquality()
                    .equals(other.orderGroupUUIDS, orderGroupUUIDS)) &&
            (identical(other.cursor, cursor) ||
                const DeepCollectionEquality().equals(other.cursor, cursor)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userKeys) ^
        const DeepCollectionEquality().hash(assetKeys) ^
        const DeepCollectionEquality().hash(textKeys) ^
        const DeepCollectionEquality().hash(orderKeys) ^
        const DeepCollectionEquality().hash(textTypes) ^
        const DeepCollectionEquality().hash(orderGroupUUIDS) ^
        const DeepCollectionEquality().hash(cursor) ^
        const DeepCollectionEquality().hash(limit);
  }

  @override
  String toString() => 'TextsGetInput(${toJson()})';
}
