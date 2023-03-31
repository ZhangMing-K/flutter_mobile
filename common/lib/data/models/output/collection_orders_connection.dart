import 'package:iris_common/data/models/output/order.dart';
import 'package:collection/collection.dart';

class CollectionOrdersConnection {
  final List<Order>? orders;
  final String? nextCursor;
  const CollectionOrdersConnection({this.orders, this.nextCursor});
  CollectionOrdersConnection copyWith(
      {List<Order>? orders, String? nextCursor}) {
    return CollectionOrdersConnection(
      orders: orders ?? this.orders,
      nextCursor: nextCursor ?? this.nextCursor,
    );
  }

  factory CollectionOrdersConnection.fromJson(Map<String, dynamic> json) {
    return CollectionOrdersConnection(
      orders: json['orders']?.map<Order>((o) => Order.fromJson(o)).toList(),
      nextCursor: json['nextCursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['orders'] = orders?.map((item) => item.toJson()).toList();
    data['nextCursor'] = nextCursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CollectionOrdersConnection &&
            (identical(other.orders, orders) ||
                const DeepCollectionEquality().equals(other.orders, orders)) &&
            (identical(other.nextCursor, nextCursor) ||
                const DeepCollectionEquality()
                    .equals(other.nextCursor, nextCursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(orders) ^
        const DeepCollectionEquality().hash(nextCursor);
  }

  @override
  String toString() => 'CollectionOrdersConnection(${toJson()})';
}
