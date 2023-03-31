import 'package:collection/collection.dart';

class TradeStatistics {
  final List<double>? userKeys;
  final List<double>? portfolioKeys;
  final double? totalTrades;
  final double? weeksActive;
  final double? tradesPerWeek;
  final double? percentWinningTrades;
  final double? percentWinningPositions;
  final double? averagePositiveDollarReturn;
  final double? averageNegativeDollarReturn;
  final double? equityProfitLoss;
  final double? optionProfitLoss;
  final double? equityPositions;
  final double? optionPositions;
  final double? averagePositivePctReturn;
  final double? averageNegativePctReturn;
  final double? equityAveragePositivePctReturn;
  final double? equityAverageNegativePctReturn;
  final double? optionAveragePositivePctReturn;
  final double? optionAverageNegativePctReturn;
  final double? numberPositiveTrades;
  final double? numberNegativeTrades;
  final double? numberPositiveEquityTrades;
  final double? numberNegativeEquityTrades;
  final double? numberNegativeOptionTrades;
  final double? numberPositiveEquityPositions;
  final double? numberNegativeEquityPositions;
  final double? numberPositiveOptionPositions;
  final double? numberNegativeOptionPositions;
  const TradeStatistics(
      {this.userKeys,
      this.portfolioKeys,
      this.totalTrades,
      this.weeksActive,
      this.tradesPerWeek,
      this.percentWinningTrades,
      this.percentWinningPositions,
      this.averagePositiveDollarReturn,
      this.averageNegativeDollarReturn,
      this.equityProfitLoss,
      this.optionProfitLoss,
      this.equityPositions,
      this.optionPositions,
      this.averagePositivePctReturn,
      this.averageNegativePctReturn,
      this.equityAveragePositivePctReturn,
      this.equityAverageNegativePctReturn,
      this.optionAveragePositivePctReturn,
      this.optionAverageNegativePctReturn,
      this.numberPositiveTrades,
      this.numberNegativeTrades,
      this.numberPositiveEquityTrades,
      this.numberNegativeEquityTrades,
      this.numberNegativeOptionTrades,
      this.numberPositiveEquityPositions,
      this.numberNegativeEquityPositions,
      this.numberPositiveOptionPositions,
      this.numberNegativeOptionPositions});
  TradeStatistics copyWith(
      {List<double>? userKeys,
      List<double>? portfolioKeys,
      double? totalTrades,
      double? weeksActive,
      double? tradesPerWeek,
      double? percentWinningTrades,
      double? percentWinningPositions,
      double? averagePositiveDollarReturn,
      double? averageNegativeDollarReturn,
      double? equityProfitLoss,
      double? optionProfitLoss,
      double? equityPositions,
      double? optionPositions,
      double? averagePositivePctReturn,
      double? averageNegativePctReturn,
      double? equityAveragePositivePctReturn,
      double? equityAverageNegativePctReturn,
      double? optionAveragePositivePctReturn,
      double? optionAverageNegativePctReturn,
      double? numberPositiveTrades,
      double? numberNegativeTrades,
      double? numberPositiveEquityTrades,
      double? numberNegativeEquityTrades,
      double? numberNegativeOptionTrades,
      double? numberPositiveEquityPositions,
      double? numberNegativeEquityPositions,
      double? numberPositiveOptionPositions,
      double? numberNegativeOptionPositions}) {
    return TradeStatistics(
      userKeys: userKeys ?? this.userKeys,
      portfolioKeys: portfolioKeys ?? this.portfolioKeys,
      totalTrades: totalTrades ?? this.totalTrades,
      weeksActive: weeksActive ?? this.weeksActive,
      tradesPerWeek: tradesPerWeek ?? this.tradesPerWeek,
      percentWinningTrades: percentWinningTrades ?? this.percentWinningTrades,
      percentWinningPositions:
          percentWinningPositions ?? this.percentWinningPositions,
      averagePositiveDollarReturn:
          averagePositiveDollarReturn ?? this.averagePositiveDollarReturn,
      averageNegativeDollarReturn:
          averageNegativeDollarReturn ?? this.averageNegativeDollarReturn,
      equityProfitLoss: equityProfitLoss ?? this.equityProfitLoss,
      optionProfitLoss: optionProfitLoss ?? this.optionProfitLoss,
      equityPositions: equityPositions ?? this.equityPositions,
      optionPositions: optionPositions ?? this.optionPositions,
      averagePositivePctReturn:
          averagePositivePctReturn ?? this.averagePositivePctReturn,
      averageNegativePctReturn:
          averageNegativePctReturn ?? this.averageNegativePctReturn,
      equityAveragePositivePctReturn:
          equityAveragePositivePctReturn ?? this.equityAveragePositivePctReturn,
      equityAverageNegativePctReturn:
          equityAverageNegativePctReturn ?? this.equityAverageNegativePctReturn,
      optionAveragePositivePctReturn:
          optionAveragePositivePctReturn ?? this.optionAveragePositivePctReturn,
      optionAverageNegativePctReturn:
          optionAverageNegativePctReturn ?? this.optionAverageNegativePctReturn,
      numberPositiveTrades: numberPositiveTrades ?? this.numberPositiveTrades,
      numberNegativeTrades: numberNegativeTrades ?? this.numberNegativeTrades,
      numberPositiveEquityTrades:
          numberPositiveEquityTrades ?? this.numberPositiveEquityTrades,
      numberNegativeEquityTrades:
          numberNegativeEquityTrades ?? this.numberNegativeEquityTrades,
      numberNegativeOptionTrades:
          numberNegativeOptionTrades ?? this.numberNegativeOptionTrades,
      numberPositiveEquityPositions:
          numberPositiveEquityPositions ?? this.numberPositiveEquityPositions,
      numberNegativeEquityPositions:
          numberNegativeEquityPositions ?? this.numberNegativeEquityPositions,
      numberPositiveOptionPositions:
          numberPositiveOptionPositions ?? this.numberPositiveOptionPositions,
      numberNegativeOptionPositions:
          numberNegativeOptionPositions ?? this.numberNegativeOptionPositions,
    );
  }

  factory TradeStatistics.fromJson(Map<String, dynamic> json) {
    return TradeStatistics(
      userKeys: json['userKeys']?.map<double>((o) => o.todouble()).toList(),
      portfolioKeys:
          json['portfolioKeys']?.map<double>((o) => o.todouble()).toList(),
      totalTrades: json['totalTrades']?.toDouble(),
      weeksActive: json['weeksActive']?.toDouble(),
      tradesPerWeek: json['tradesPerWeek']?.toDouble(),
      percentWinningTrades: json['percentWinningTrades']?.toDouble(),
      percentWinningPositions: json['percentWinningPositions']?.toDouble(),
      averagePositiveDollarReturn:
          json['averagePositiveDollarReturn']?.toDouble(),
      averageNegativeDollarReturn:
          json['averageNegativeDollarReturn']?.toDouble(),
      equityProfitLoss: json['equityProfitLoss']?.toDouble(),
      optionProfitLoss: json['optionProfitLoss']?.toDouble(),
      equityPositions: json['equityPositions']?.toDouble(),
      optionPositions: json['optionPositions']?.toDouble(),
      averagePositivePctReturn: json['averagePositivePctReturn']?.toDouble(),
      averageNegativePctReturn: json['averageNegativePctReturn']?.toDouble(),
      equityAveragePositivePctReturn:
          json['equityAveragePositivePctReturn']?.toDouble(),
      equityAverageNegativePctReturn:
          json['equityAverageNegativePctReturn']?.toDouble(),
      optionAveragePositivePctReturn:
          json['optionAveragePositivePctReturn']?.toDouble(),
      optionAverageNegativePctReturn:
          json['optionAverageNegativePctReturn']?.toDouble(),
      numberPositiveTrades: json['numberPositiveTrades']?.toDouble(),
      numberNegativeTrades: json['numberNegativeTrades']?.toDouble(),
      numberPositiveEquityTrades:
          json['numberPositiveEquityTrades']?.toDouble(),
      numberNegativeEquityTrades:
          json['numberNegativeEquityTrades']?.toDouble(),
      numberNegativeOptionTrades:
          json['numberNegativeOptionTrades']?.toDouble(),
      numberPositiveEquityPositions:
          json['numberPositiveEquityPositions']?.toDouble(),
      numberNegativeEquityPositions:
          json['numberNegativeEquityPositions']?.toDouble(),
      numberPositiveOptionPositions:
          json['numberPositiveOptionPositions']?.toDouble(),
      numberNegativeOptionPositions:
          json['numberNegativeOptionPositions']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKeys'] = userKeys;
    data['portfolioKeys'] = portfolioKeys;
    data['totalTrades'] = totalTrades;
    data['weeksActive'] = weeksActive;
    data['tradesPerWeek'] = tradesPerWeek;
    data['percentWinningTrades'] = percentWinningTrades;
    data['percentWinningPositions'] = percentWinningPositions;
    data['averagePositiveDollarReturn'] = averagePositiveDollarReturn;
    data['averageNegativeDollarReturn'] = averageNegativeDollarReturn;
    data['equityProfitLoss'] = equityProfitLoss;
    data['optionProfitLoss'] = optionProfitLoss;
    data['equityPositions'] = equityPositions;
    data['optionPositions'] = optionPositions;
    data['averagePositivePctReturn'] = averagePositivePctReturn;
    data['averageNegativePctReturn'] = averageNegativePctReturn;
    data['equityAveragePositivePctReturn'] = equityAveragePositivePctReturn;
    data['equityAverageNegativePctReturn'] = equityAverageNegativePctReturn;
    data['optionAveragePositivePctReturn'] = optionAveragePositivePctReturn;
    data['optionAverageNegativePctReturn'] = optionAverageNegativePctReturn;
    data['numberPositiveTrades'] = numberPositiveTrades;
    data['numberNegativeTrades'] = numberNegativeTrades;
    data['numberPositiveEquityTrades'] = numberPositiveEquityTrades;
    data['numberNegativeEquityTrades'] = numberNegativeEquityTrades;
    data['numberNegativeOptionTrades'] = numberNegativeOptionTrades;
    data['numberPositiveEquityPositions'] = numberPositiveEquityPositions;
    data['numberNegativeEquityPositions'] = numberNegativeEquityPositions;
    data['numberPositiveOptionPositions'] = numberPositiveOptionPositions;
    data['numberNegativeOptionPositions'] = numberNegativeOptionPositions;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TradeStatistics &&
            (identical(other.userKeys, userKeys) ||
                const DeepCollectionEquality()
                    .equals(other.userKeys, userKeys)) &&
            (identical(other.portfolioKeys, portfolioKeys) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKeys, portfolioKeys)) &&
            (identical(other.totalTrades, totalTrades) ||
                const DeepCollectionEquality()
                    .equals(other.totalTrades, totalTrades)) &&
            (identical(other.weeksActive, weeksActive) ||
                const DeepCollectionEquality()
                    .equals(other.weeksActive, weeksActive)) &&
            (identical(other.tradesPerWeek, tradesPerWeek) ||
                const DeepCollectionEquality()
                    .equals(other.tradesPerWeek, tradesPerWeek)) &&
            (identical(other.percentWinningTrades, percentWinningTrades) ||
                const DeepCollectionEquality().equals(
                    other.percentWinningTrades, percentWinningTrades)) &&
            (identical(other.percentWinningPositions, percentWinningPositions) ||
                const DeepCollectionEquality().equals(
                    other.percentWinningPositions, percentWinningPositions)) &&
            (identical(other.averagePositiveDollarReturn, averagePositiveDollarReturn) ||
                const DeepCollectionEquality().equals(
                    other.averagePositiveDollarReturn,
                    averagePositiveDollarReturn)) &&
            (identical(other.averageNegativeDollarReturn, averageNegativeDollarReturn) ||
                const DeepCollectionEquality().equals(
                    other.averageNegativeDollarReturn,
                    averageNegativeDollarReturn)) &&
            (identical(other.equityProfitLoss, equityProfitLoss) ||
                const DeepCollectionEquality()
                    .equals(other.equityProfitLoss, equityProfitLoss)) &&
            (identical(other.optionProfitLoss, optionProfitLoss) ||
                const DeepCollectionEquality()
                    .equals(other.optionProfitLoss, optionProfitLoss)) &&
            (identical(other.equityPositions, equityPositions) ||
                const DeepCollectionEquality()
                    .equals(other.equityPositions, equityPositions)) &&
            (identical(other.optionPositions, optionPositions) ||
                const DeepCollectionEquality()
                    .equals(other.optionPositions, optionPositions)) &&
            (identical(other.averagePositivePctReturn, averagePositivePctReturn) ||
                const DeepCollectionEquality().equals(
                    other.averagePositivePctReturn,
                    averagePositivePctReturn)) &&
            (identical(other.averageNegativePctReturn, averageNegativePctReturn) || const DeepCollectionEquality().equals(other.averageNegativePctReturn, averageNegativePctReturn)) &&
            (identical(other.equityAveragePositivePctReturn, equityAveragePositivePctReturn) || const DeepCollectionEquality().equals(other.equityAveragePositivePctReturn, equityAveragePositivePctReturn)) &&
            (identical(other.equityAverageNegativePctReturn, equityAverageNegativePctReturn) || const DeepCollectionEquality().equals(other.equityAverageNegativePctReturn, equityAverageNegativePctReturn)) &&
            (identical(other.optionAveragePositivePctReturn, optionAveragePositivePctReturn) || const DeepCollectionEquality().equals(other.optionAveragePositivePctReturn, optionAveragePositivePctReturn)) &&
            (identical(other.optionAverageNegativePctReturn, optionAverageNegativePctReturn) || const DeepCollectionEquality().equals(other.optionAverageNegativePctReturn, optionAverageNegativePctReturn)) &&
            (identical(other.numberPositiveTrades, numberPositiveTrades) || const DeepCollectionEquality().equals(other.numberPositiveTrades, numberPositiveTrades)) &&
            (identical(other.numberNegativeTrades, numberNegativeTrades) || const DeepCollectionEquality().equals(other.numberNegativeTrades, numberNegativeTrades)) &&
            (identical(other.numberPositiveEquityTrades, numberPositiveEquityTrades) || const DeepCollectionEquality().equals(other.numberPositiveEquityTrades, numberPositiveEquityTrades)) &&
            (identical(other.numberNegativeEquityTrades, numberNegativeEquityTrades) || const DeepCollectionEquality().equals(other.numberNegativeEquityTrades, numberNegativeEquityTrades)) &&
            (identical(other.numberNegativeOptionTrades, numberNegativeOptionTrades) || const DeepCollectionEquality().equals(other.numberNegativeOptionTrades, numberNegativeOptionTrades)) &&
            (identical(other.numberPositiveEquityPositions, numberPositiveEquityPositions) || const DeepCollectionEquality().equals(other.numberPositiveEquityPositions, numberPositiveEquityPositions)) &&
            (identical(other.numberNegativeEquityPositions, numberNegativeEquityPositions) || const DeepCollectionEquality().equals(other.numberNegativeEquityPositions, numberNegativeEquityPositions)) &&
            (identical(other.numberPositiveOptionPositions, numberPositiveOptionPositions) || const DeepCollectionEquality().equals(other.numberPositiveOptionPositions, numberPositiveOptionPositions)) &&
            (identical(other.numberNegativeOptionPositions, numberNegativeOptionPositions) || const DeepCollectionEquality().equals(other.numberNegativeOptionPositions, numberNegativeOptionPositions)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userKeys) ^
        const DeepCollectionEquality().hash(portfolioKeys) ^
        const DeepCollectionEquality().hash(totalTrades) ^
        const DeepCollectionEquality().hash(weeksActive) ^
        const DeepCollectionEquality().hash(tradesPerWeek) ^
        const DeepCollectionEquality().hash(percentWinningTrades) ^
        const DeepCollectionEquality().hash(percentWinningPositions) ^
        const DeepCollectionEquality().hash(averagePositiveDollarReturn) ^
        const DeepCollectionEquality().hash(averageNegativeDollarReturn) ^
        const DeepCollectionEquality().hash(equityProfitLoss) ^
        const DeepCollectionEquality().hash(optionProfitLoss) ^
        const DeepCollectionEquality().hash(equityPositions) ^
        const DeepCollectionEquality().hash(optionPositions) ^
        const DeepCollectionEquality().hash(averagePositivePctReturn) ^
        const DeepCollectionEquality().hash(averageNegativePctReturn) ^
        const DeepCollectionEquality().hash(equityAveragePositivePctReturn) ^
        const DeepCollectionEquality().hash(equityAverageNegativePctReturn) ^
        const DeepCollectionEquality().hash(optionAveragePositivePctReturn) ^
        const DeepCollectionEquality().hash(optionAverageNegativePctReturn) ^
        const DeepCollectionEquality().hash(numberPositiveTrades) ^
        const DeepCollectionEquality().hash(numberNegativeTrades) ^
        const DeepCollectionEquality().hash(numberPositiveEquityTrades) ^
        const DeepCollectionEquality().hash(numberNegativeEquityTrades) ^
        const DeepCollectionEquality().hash(numberNegativeOptionTrades) ^
        const DeepCollectionEquality().hash(numberPositiveEquityPositions) ^
        const DeepCollectionEquality().hash(numberNegativeEquityPositions) ^
        const DeepCollectionEquality().hash(numberPositiveOptionPositions) ^
        const DeepCollectionEquality().hash(numberNegativeOptionPositions);
  }

  @override
  String toString() => 'TradeStatistics(${toJson()})';
}
