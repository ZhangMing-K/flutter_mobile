import 'package:iris_common/data/models/output/order.dart';
import 'package:collection/collection.dart';

class OrderFlow {
  final Order? order;
  final double? percentile;
  final double? tradeAccuracy;
  final bool? isTopTrader;
  final double? transactionAmount;
  const OrderFlow(
      {this.order,
      this.percentile,
      this.tradeAccuracy,
      this.isTopTrader,
      this.transactionAmount});
  OrderFlow copyWith(
      {Order? order,
      double? percentile,
      double? tradeAccuracy,
      bool? isTopTrader,
      double? transactionAmount}) {
    return OrderFlow(
      order: order ?? this.order,
      percentile: percentile ?? this.percentile,
      tradeAccuracy: tradeAccuracy ?? this.tradeAccuracy,
      isTopTrader: isTopTrader ?? this.isTopTrader,
      transactionAmount: transactionAmount ?? this.transactionAmount,
    );
  }

  factory OrderFlow.fromJson(Map<String, dynamic> json) {
    return OrderFlow(
      order: json['order'] != null ? Order.fromJson(json['order']) : null,
      percentile: json['percentile']?.toDouble(),
      tradeAccuracy: json['tradeAccuracy']?.toDouble(),
      isTopTrader: json['isTopTrader'],
      transactionAmount: json['transactionAmount']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['order'] = order?.toJson();
    data['percentile'] = percentile;
    data['tradeAccuracy'] = tradeAccuracy;
    data['isTopTrader'] = isTopTrader;
    data['transactionAmount'] = transactionAmount;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is OrderFlow &&
            (identical(other.order, order) ||
                const DeepCollectionEquality().equals(other.order, order)) &&
            (identical(other.percentile, percentile) ||
                const DeepCollectionEquality()
                    .equals(other.percentile, percentile)) &&
            (identical(other.tradeAccuracy, tradeAccuracy) ||
                const DeepCollectionEquality()
                    .equals(other.tradeAccuracy, tradeAccuracy)) &&
            (identical(other.isTopTrader, isTopTrader) ||
                const DeepCollectionEquality()
                    .equals(other.isTopTrader, isTopTrader)) &&
            (identical(other.transactionAmount, transactionAmount) ||
                const DeepCollectionEquality()
                    .equals(other.transactionAmount, transactionAmount)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(order) ^
        const DeepCollectionEquality().hash(percentile) ^
        const DeepCollectionEquality().hash(tradeAccuracy) ^
        const DeepCollectionEquality().hash(isTopTrader) ^
        const DeepCollectionEquality().hash(transactionAmount);
  }

  @override
  String toString() => 'OrderFlow(${toJson()})';
}
