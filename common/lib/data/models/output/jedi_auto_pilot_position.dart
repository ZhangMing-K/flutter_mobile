import 'package:collection/collection.dart';

class JediAutoPilotPosition {
  final String? symbol;
  final double? netQuantity;
  final double? cumulativeRealizedProfitLoss;
  final double? averageUnitCostBasis;
  final DateTime? openedAt;
  const JediAutoPilotPosition(
      {required this.symbol,
      required this.netQuantity,
      required this.cumulativeRealizedProfitLoss,
      required this.averageUnitCostBasis,
      required this.openedAt});
  JediAutoPilotPosition copyWith(
      {String? symbol,
      double? netQuantity,
      double? cumulativeRealizedProfitLoss,
      double? averageUnitCostBasis,
      DateTime? openedAt}) {
    return JediAutoPilotPosition(
      symbol: symbol ?? this.symbol,
      netQuantity: netQuantity ?? this.netQuantity,
      cumulativeRealizedProfitLoss:
          cumulativeRealizedProfitLoss ?? this.cumulativeRealizedProfitLoss,
      averageUnitCostBasis: averageUnitCostBasis ?? this.averageUnitCostBasis,
      openedAt: openedAt ?? this.openedAt,
    );
  }

  factory JediAutoPilotPosition.fromJson(Map<String, dynamic> json) {
    return JediAutoPilotPosition(
      symbol: json['symbol'],
      netQuantity: json['netQuantity']?.toDouble(),
      cumulativeRealizedProfitLoss:
          json['cumulativeRealizedProfitLoss']?.toDouble(),
      averageUnitCostBasis: json['averageUnitCostBasis']?.toDouble(),
      openedAt:
          json['openedAt'] != null ? DateTime.parse(json['openedAt']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['netQuantity'] = netQuantity;
    data['cumulativeRealizedProfitLoss'] = cumulativeRealizedProfitLoss;
    data['averageUnitCostBasis'] = averageUnitCostBasis;
    data['openedAt'] = openedAt?.toString();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediAutoPilotPosition &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.netQuantity, netQuantity) ||
                const DeepCollectionEquality()
                    .equals(other.netQuantity, netQuantity)) &&
            (identical(other.cumulativeRealizedProfitLoss,
                    cumulativeRealizedProfitLoss) ||
                const DeepCollectionEquality().equals(
                    other.cumulativeRealizedProfitLoss,
                    cumulativeRealizedProfitLoss)) &&
            (identical(other.averageUnitCostBasis, averageUnitCostBasis) ||
                const DeepCollectionEquality().equals(
                    other.averageUnitCostBasis, averageUnitCostBasis)) &&
            (identical(other.openedAt, openedAt) ||
                const DeepCollectionEquality()
                    .equals(other.openedAt, openedAt)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(symbol) ^
        const DeepCollectionEquality().hash(netQuantity) ^
        const DeepCollectionEquality().hash(cumulativeRealizedProfitLoss) ^
        const DeepCollectionEquality().hash(averageUnitCostBasis) ^
        const DeepCollectionEquality().hash(openedAt);
  }

  @override
  String toString() => 'JediAutoPilotPosition(${toJson()})';
}
