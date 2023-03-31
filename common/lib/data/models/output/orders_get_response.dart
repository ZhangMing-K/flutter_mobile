import 'package:iris_common/data/models/output/order.dart';
import 'package:collection/collection.dart';

class OrdersGetResponse {
  final List<Order>? orders;
  final String? nextCursor;
  const OrdersGetResponse({this.orders, this.nextCursor});
  OrdersGetResponse copyWith({List<Order>? orders, String? nextCursor}) {
    return OrdersGetResponse(
      orders: orders ?? this.orders,
      nextCursor: nextCursor ?? this.nextCursor,
    );
  }

  factory OrdersGetResponse.fromJson(Map<String, dynamic> json) {
    return OrdersGetResponse(
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
        (other is OrdersGetResponse &&
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
  String toString() => 'OrdersGetResponse(${toJson()})';
}
