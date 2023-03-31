import 'package:iris_common/data/models/output/slave_auto_pilot_portfolio.dart';
import 'package:collection/collection.dart';

class SlaveAutoPilotPortfoliosGetResponse {
  final List<SlaveAutoPilotPortfolio>? slaveAutoPilotPortfolios;
  final double? totalValue;
  final double? totalReturn;
  final double? totalProfitLoss;
  const SlaveAutoPilotPortfoliosGetResponse(
      {required this.slaveAutoPilotPortfolios,
      required this.totalValue,
      required this.totalReturn,
      required this.totalProfitLoss});
  SlaveAutoPilotPortfoliosGetResponse copyWith(
      {List<SlaveAutoPilotPortfolio>? slaveAutoPilotPortfolios,
      double? totalValue,
      double? totalReturn,
      double? totalProfitLoss}) {
    return SlaveAutoPilotPortfoliosGetResponse(
      slaveAutoPilotPortfolios:
          slaveAutoPilotPortfolios ?? this.slaveAutoPilotPortfolios,
      totalValue: totalValue ?? this.totalValue,
      totalReturn: totalReturn ?? this.totalReturn,
      totalProfitLoss: totalProfitLoss ?? this.totalProfitLoss,
    );
  }

  factory SlaveAutoPilotPortfoliosGetResponse.fromJson(
      Map<String, dynamic> json) {
    return SlaveAutoPilotPortfoliosGetResponse(
      slaveAutoPilotPortfolios: json['slaveAutoPilotPortfolios']
          ?.map<SlaveAutoPilotPortfolio>(
              (o) => SlaveAutoPilotPortfolio.fromJson(o))
          .toList(),
      totalValue: json['totalValue']?.toDouble(),
      totalReturn: json['totalReturn']?.toDouble(),
      totalProfitLoss: json['totalProfitLoss']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['slaveAutoPilotPortfolios'] =
        slaveAutoPilotPortfolios?.map((item) => item.toJson()).toList();
    data['totalValue'] = totalValue;
    data['totalReturn'] = totalReturn;
    data['totalProfitLoss'] = totalProfitLoss;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SlaveAutoPilotPortfoliosGetResponse &&
            (identical(
                    other.slaveAutoPilotPortfolios, slaveAutoPilotPortfolios) ||
                const DeepCollectionEquality().equals(
                    other.slaveAutoPilotPortfolios,
                    slaveAutoPilotPortfolios)) &&
            (identical(other.totalValue, totalValue) ||
                const DeepCollectionEquality()
                    .equals(other.totalValue, totalValue)) &&
            (identical(other.totalReturn, totalReturn) ||
                const DeepCollectionEquality()
                    .equals(other.totalReturn, totalReturn)) &&
            (identical(other.totalProfitLoss, totalProfitLoss) ||
                const DeepCollectionEquality()
                    .equals(other.totalProfitLoss, totalProfitLoss)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(slaveAutoPilotPortfolios) ^
        const DeepCollectionEquality().hash(totalValue) ^
        const DeepCollectionEquality().hash(totalReturn) ^
        const DeepCollectionEquality().hash(totalProfitLoss);
  }

  @override
  String toString() => 'SlaveAutoPilotPortfoliosGetResponse(${toJson()})';
}
