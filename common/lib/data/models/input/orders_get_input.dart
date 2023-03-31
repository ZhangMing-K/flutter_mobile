import 'package:collection/collection.dart';

class OrdersGetInput {
  final List<int>? orderKeys;
  final List<String>? orderGroupUUIDS;
  final int? limit;
  final String? cursor;
  const OrdersGetInput(
      {this.orderKeys, this.orderGroupUUIDS, this.limit, this.cursor});
  OrdersGetInput copyWith(
      {List<int>? orderKeys,
      List<String>? orderGroupUUIDS,
      int? limit,
      String? cursor}) {
    return OrdersGetInput(
      orderKeys: orderKeys ?? this.orderKeys,
      orderGroupUUIDS: orderGroupUUIDS ?? this.orderGroupUUIDS,
      limit: limit ?? this.limit,
      cursor: cursor ?? this.cursor,
    );
  }

  factory OrdersGetInput.fromJson(Map<String, dynamic> json) {
    return OrdersGetInput(
      orderKeys: json['orderKeys']?.map<int>((o) => (o as int)).toList(),
      orderGroupUUIDS:
          json['orderGroupUUIDS']?.map<String>((o) => o.toString()).toList(),
      limit: json['limit'],
      cursor: json['cursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['orderKeys'] = orderKeys;
    data['orderGroupUUIDS'] = orderGroupUUIDS;
    data['limit'] = limit;
    data['cursor'] = cursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is OrdersGetInput &&
            (identical(other.orderKeys, orderKeys) ||
                const DeepCollectionEquality()
                    .equals(other.orderKeys, orderKeys)) &&
            (identical(other.orderGroupUUIDS, orderGroupUUIDS) ||
                const DeepCollectionEquality()
                    .equals(other.orderGroupUUIDS, orderGroupUUIDS)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.cursor, cursor) ||
                const DeepCollectionEquality().equals(other.cursor, cursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(orderKeys) ^
        const DeepCollectionEquality().hash(orderGroupUUIDS) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(cursor);
  }

  @override
  String toString() => 'OrdersGetInput(${toJson()})';
}
