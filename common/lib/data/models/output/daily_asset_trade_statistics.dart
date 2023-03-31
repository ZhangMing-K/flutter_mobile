import 'package:collection/collection.dart';

class DailyAssetTradeStatistics {
  final int? nbrTrades;
  final int? nbrOptionTrades;
  final int? nbrEquityTrades;
  final double? putAmount;
  final double? callAmount;
  final double? totalBullishAmount;
  final double? totalBearishAmount;
  final double? avgDte;
  const DailyAssetTradeStatistics(
      {this.nbrTrades,
      this.nbrOptionTrades,
      this.nbrEquityTrades,
      this.putAmount,
      this.callAmount,
      this.totalBullishAmount,
      this.totalBearishAmount,
      this.avgDte});
  DailyAssetTradeStatistics copyWith(
      {int? nbrTrades,
      int? nbrOptionTrades,
      int? nbrEquityTrades,
      double? putAmount,
      double? callAmount,
      double? totalBullishAmount,
      double? totalBearishAmount,
      double? avgDte}) {
    return DailyAssetTradeStatistics(
      nbrTrades: nbrTrades ?? this.nbrTrades,
      nbrOptionTrades: nbrOptionTrades ?? this.nbrOptionTrades,
      nbrEquityTrades: nbrEquityTrades ?? this.nbrEquityTrades,
      putAmount: putAmount ?? this.putAmount,
      callAmount: callAmount ?? this.callAmount,
      totalBullishAmount: totalBullishAmount ?? this.totalBullishAmount,
      totalBearishAmount: totalBearishAmount ?? this.totalBearishAmount,
      avgDte: avgDte ?? this.avgDte,
    );
  }

  factory DailyAssetTradeStatistics.fromJson(Map<String, dynamic> json) {
    return DailyAssetTradeStatistics(
      nbrTrades: json['nbrTrades'],
      nbrOptionTrades: json['nbrOptionTrades'],
      nbrEquityTrades: json['nbrEquityTrades'],
      putAmount: json['putAmount']?.toDouble(),
      callAmount: json['callAmount']?.toDouble(),
      totalBullishAmount: json['totalBullishAmount']?.toDouble(),
      totalBearishAmount: json['totalBearishAmount']?.toDouble(),
      avgDte: json['avgDte']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['nbrTrades'] = nbrTrades;
    data['nbrOptionTrades'] = nbrOptionTrades;
    data['nbrEquityTrades'] = nbrEquityTrades;
    data['putAmount'] = putAmount;
    data['callAmount'] = callAmount;
    data['totalBullishAmount'] = totalBullishAmount;
    data['totalBearishAmount'] = totalBearishAmount;
    data['avgDte'] = avgDte;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DailyAssetTradeStatistics &&
            (identical(other.nbrTrades, nbrTrades) ||
                const DeepCollectionEquality()
                    .equals(other.nbrTrades, nbrTrades)) &&
            (identical(other.nbrOptionTrades, nbrOptionTrades) ||
                const DeepCollectionEquality()
                    .equals(other.nbrOptionTrades, nbrOptionTrades)) &&
            (identical(other.nbrEquityTrades, nbrEquityTrades) ||
                const DeepCollectionEquality()
                    .equals(other.nbrEquityTrades, nbrEquityTrades)) &&
            (identical(other.putAmount, putAmount) ||
                const DeepCollectionEquality()
                    .equals(other.putAmount, putAmount)) &&
            (identical(other.callAmount, callAmount) ||
                const DeepCollectionEquality()
                    .equals(other.callAmount, callAmount)) &&
            (identical(other.totalBullishAmount, totalBullishAmount) ||
                const DeepCollectionEquality()
                    .equals(other.totalBullishAmount, totalBullishAmount)) &&
            (identical(other.totalBearishAmount, totalBearishAmount) ||
                const DeepCollectionEquality()
                    .equals(other.totalBearishAmount, totalBearishAmount)) &&
            (identical(other.avgDte, avgDte) ||
                const DeepCollectionEquality().equals(other.avgDte, avgDte)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(nbrTrades) ^
        const DeepCollectionEquality().hash(nbrOptionTrades) ^
        const DeepCollectionEquality().hash(nbrEquityTrades) ^
        const DeepCollectionEquality().hash(putAmount) ^
        const DeepCollectionEquality().hash(callAmount) ^
        const DeepCollectionEquality().hash(totalBullishAmount) ^
        const DeepCollectionEquality().hash(totalBearishAmount) ^
        const DeepCollectionEquality().hash(avgDte);
  }

  @override
  String toString() => 'DailyAssetTradeStatistics(${toJson()})';
}
