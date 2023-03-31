import 'package:collection/collection.dart';

class AbsolutePositionMetrics {
  final double? quantity;
  final double? marketValue;
  final double? totalCost;
  final double? totalProfitLoss;
  final double? todayProfitLoss;
  const AbsolutePositionMetrics(
      {required this.quantity,
      required this.marketValue,
      required this.totalCost,
      required this.totalProfitLoss,
      required this.todayProfitLoss});
  AbsolutePositionMetrics copyWith(
      {double? quantity,
      double? marketValue,
      double? totalCost,
      double? totalProfitLoss,
      double? todayProfitLoss}) {
    return AbsolutePositionMetrics(
      quantity: quantity ?? this.quantity,
      marketValue: marketValue ?? this.marketValue,
      totalCost: totalCost ?? this.totalCost,
      totalProfitLoss: totalProfitLoss ?? this.totalProfitLoss,
      todayProfitLoss: todayProfitLoss ?? this.todayProfitLoss,
    );
  }

  factory AbsolutePositionMetrics.fromJson(Map<String, dynamic> json) {
    return AbsolutePositionMetrics(
      quantity: json['quantity']?.toDouble(),
      marketValue: json['marketValue']?.toDouble(),
      totalCost: json['totalCost']?.toDouble(),
      totalProfitLoss: json['totalProfitLoss']?.toDouble(),
      todayProfitLoss: json['todayProfitLoss']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['marketValue'] = marketValue;
    data['totalCost'] = totalCost;
    data['totalProfitLoss'] = totalProfitLoss;
    data['todayProfitLoss'] = todayProfitLoss;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AbsolutePositionMetrics &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality()
                    .equals(other.quantity, quantity)) &&
            (identical(other.marketValue, marketValue) ||
                const DeepCollectionEquality()
                    .equals(other.marketValue, marketValue)) &&
            (identical(other.totalCost, totalCost) ||
                const DeepCollectionEquality()
                    .equals(other.totalCost, totalCost)) &&
            (identical(other.totalProfitLoss, totalProfitLoss) ||
                const DeepCollectionEquality()
                    .equals(other.totalProfitLoss, totalProfitLoss)) &&
            (identical(other.todayProfitLoss, todayProfitLoss) ||
                const DeepCollectionEquality()
                    .equals(other.todayProfitLoss, todayProfitLoss)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(quantity) ^
        const DeepCollectionEquality().hash(marketValue) ^
        const DeepCollectionEquality().hash(totalCost) ^
        const DeepCollectionEquality().hash(totalProfitLoss) ^
        const DeepCollectionEquality().hash(todayProfitLoss);
  }

  @override
  String toString() => 'AbsolutePositionMetrics(${toJson()})';
}
