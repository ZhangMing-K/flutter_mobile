import 'package:iris_common/data/models/output/order_flow.dart';
import 'package:collection/collection.dart';

class OrderFlowResponse {
  final List<OrderFlow>? orderFlows;
  final String? nextCursor;
  const OrderFlowResponse({this.orderFlows, this.nextCursor});
  OrderFlowResponse copyWith(
      {List<OrderFlow>? orderFlows, String? nextCursor}) {
    return OrderFlowResponse(
      orderFlows: orderFlows ?? this.orderFlows,
      nextCursor: nextCursor ?? this.nextCursor,
    );
  }

  factory OrderFlowResponse.fromJson(Map<String, dynamic> json) {
    return OrderFlowResponse(
      orderFlows: json['orderFlows']
          ?.map<OrderFlow>((o) => OrderFlow.fromJson(o))
          .toList(),
      nextCursor: json['nextCursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['orderFlows'] = orderFlows?.map((item) => item.toJson()).toList();
    data['nextCursor'] = nextCursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is OrderFlowResponse &&
            (identical(other.orderFlows, orderFlows) ||
                const DeepCollectionEquality()
                    .equals(other.orderFlows, orderFlows)) &&
            (identical(other.nextCursor, nextCursor) ||
                const DeepCollectionEquality()
                    .equals(other.nextCursor, nextCursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(orderFlows) ^
        const DeepCollectionEquality().hash(nextCursor);
  }

  @override
  String toString() => 'OrderFlowResponse(${toJson()})';
}
