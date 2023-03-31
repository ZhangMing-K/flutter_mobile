import 'package:iris_common/data/models/enums/segment_type.dart';
import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:collection/collection.dart';

class TradePerformance {
  final int? portfolioKey;
  final int? userKey;
  final SEGMENT_TYPE? segmentType;
  final User? user;
  final Portfolio? portfolio;
  final double? averageAmountReturnPerOpenTrade;
  final double? averageAmountCostPerOpenTrade;
  final double? profitLoss;
  final double? totalCost;
  final double? numberWinningTrades;
  final double? numberLosingTrades;
  final double? monthsTrading;
  final int? totalTrades;
  final int? totalOpenEffectTrades;
  final int? totalCloseEffectTrades;
  final double? averageHoldTimeInterval;
  final double? tradeAccuracy;
  final double? tradesPerMonth;
  final double? openTradesPerMonth;
  final double? totalReturnByTotalCost;
  final double? averageHoldTimeDays;
  final double? percentNormalizedTRTC;
  final double? percentNormalizedAvg;
  final double? percentileTradeAccuracy;
  final double? betaAvg;
  final double? peAvg;
  final double? avgPercentChangePerMonth;
  final double? averagePercentReturnPerOpenTrade;
  final double? percentWinners;
  const TradePerformance(
      {this.portfolioKey,
      this.userKey,
      this.segmentType,
      this.user,
      this.portfolio,
      this.averageAmountReturnPerOpenTrade,
      this.averageAmountCostPerOpenTrade,
      this.profitLoss,
      this.totalCost,
      this.numberWinningTrades,
      this.numberLosingTrades,
      this.monthsTrading,
      this.totalTrades,
      this.totalOpenEffectTrades,
      this.totalCloseEffectTrades,
      this.averageHoldTimeInterval,
      this.tradeAccuracy,
      this.tradesPerMonth,
      this.openTradesPerMonth,
      this.totalReturnByTotalCost,
      this.averageHoldTimeDays,
      this.percentNormalizedTRTC,
      this.percentNormalizedAvg,
      this.percentileTradeAccuracy,
      this.betaAvg,
      this.peAvg,
      this.avgPercentChangePerMonth,
      this.averagePercentReturnPerOpenTrade,
      this.percentWinners});
  TradePerformance copyWith(
      {int? portfolioKey,
      int? userKey,
      SEGMENT_TYPE? segmentType,
      User? user,
      Portfolio? portfolio,
      double? averageAmountReturnPerOpenTrade,
      double? averageAmountCostPerOpenTrade,
      double? profitLoss,
      double? totalCost,
      double? numberWinningTrades,
      double? numberLosingTrades,
      double? monthsTrading,
      int? totalTrades,
      int? totalOpenEffectTrades,
      int? totalCloseEffectTrades,
      double? averageHoldTimeInterval,
      double? tradeAccuracy,
      double? tradesPerMonth,
      double? openTradesPerMonth,
      double? totalReturnByTotalCost,
      double? averageHoldTimeDays,
      double? percentNormalizedTRTC,
      double? percentNormalizedAvg,
      double? percentileTradeAccuracy,
      double? betaAvg,
      double? peAvg,
      double? avgPercentChangePerMonth,
      double? averagePercentReturnPerOpenTrade,
      double? percentWinners}) {
    return TradePerformance(
      portfolioKey: portfolioKey ?? this.portfolioKey,
      userKey: userKey ?? this.userKey,
      segmentType: segmentType ?? this.segmentType,
      user: user ?? this.user,
      portfolio: portfolio ?? this.portfolio,
      averageAmountReturnPerOpenTrade: averageAmountReturnPerOpenTrade ??
          this.averageAmountReturnPerOpenTrade,
      averageAmountCostPerOpenTrade:
          averageAmountCostPerOpenTrade ?? this.averageAmountCostPerOpenTrade,
      profitLoss: profitLoss ?? this.profitLoss,
      totalCost: totalCost ?? this.totalCost,
      numberWinningTrades: numberWinningTrades ?? this.numberWinningTrades,
      numberLosingTrades: numberLosingTrades ?? this.numberLosingTrades,
      monthsTrading: monthsTrading ?? this.monthsTrading,
      totalTrades: totalTrades ?? this.totalTrades,
      totalOpenEffectTrades:
          totalOpenEffectTrades ?? this.totalOpenEffectTrades,
      totalCloseEffectTrades:
          totalCloseEffectTrades ?? this.totalCloseEffectTrades,
      averageHoldTimeInterval:
          averageHoldTimeInterval ?? this.averageHoldTimeInterval,
      tradeAccuracy: tradeAccuracy ?? this.tradeAccuracy,
      tradesPerMonth: tradesPerMonth ?? this.tradesPerMonth,
      openTradesPerMonth: openTradesPerMonth ?? this.openTradesPerMonth,
      totalReturnByTotalCost:
          totalReturnByTotalCost ?? this.totalReturnByTotalCost,
      averageHoldTimeDays: averageHoldTimeDays ?? this.averageHoldTimeDays,
      percentNormalizedTRTC:
          percentNormalizedTRTC ?? this.percentNormalizedTRTC,
      percentNormalizedAvg: percentNormalizedAvg ?? this.percentNormalizedAvg,
      percentileTradeAccuracy:
          percentileTradeAccuracy ?? this.percentileTradeAccuracy,
      betaAvg: betaAvg ?? this.betaAvg,
      peAvg: peAvg ?? this.peAvg,
      avgPercentChangePerMonth:
          avgPercentChangePerMonth ?? this.avgPercentChangePerMonth,
      averagePercentReturnPerOpenTrade: averagePercentReturnPerOpenTrade ??
          this.averagePercentReturnPerOpenTrade,
      percentWinners: percentWinners ?? this.percentWinners,
    );
  }

  factory TradePerformance.fromJson(Map<String, dynamic> json) {
    return TradePerformance(
      portfolioKey: json['portfolioKey'],
      userKey: json['userKey'],
      segmentType: json['segmentType'] != null
          ? SEGMENT_TYPE.values.byName(json['segmentType'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      portfolio: json['portfolio'] != null
          ? Portfolio.fromJson(json['portfolio'])
          : null,
      averageAmountReturnPerOpenTrade:
          json['averageAmountReturnPerOpenTrade']?.toDouble(),
      averageAmountCostPerOpenTrade:
          json['averageAmountCostPerOpenTrade']?.toDouble(),
      profitLoss: json['profitLoss']?.toDouble(),
      totalCost: json['totalCost']?.toDouble(),
      numberWinningTrades: json['numberWinningTrades']?.toDouble(),
      numberLosingTrades: json['numberLosingTrades']?.toDouble(),
      monthsTrading: json['monthsTrading']?.toDouble(),
      totalTrades: json['totalTrades'],
      totalOpenEffectTrades: json['totalOpenEffectTrades'],
      totalCloseEffectTrades: json['totalCloseEffectTrades'],
      averageHoldTimeInterval: json['averageHoldTimeInterval']?.toDouble(),
      tradeAccuracy: json['tradeAccuracy']?.toDouble(),
      tradesPerMonth: json['tradesPerMonth']?.toDouble(),
      openTradesPerMonth: json['openTradesPerMonth']?.toDouble(),
      totalReturnByTotalCost: json['totalReturnByTotalCost']?.toDouble(),
      averageHoldTimeDays: json['averageHoldTimeDays']?.toDouble(),
      percentNormalizedTRTC: json['percentNormalizedTRTC']?.toDouble(),
      percentNormalizedAvg: json['percentNormalizedAvg']?.toDouble(),
      percentileTradeAccuracy: json['percentileTradeAccuracy']?.toDouble(),
      betaAvg: json['betaAvg']?.toDouble(),
      peAvg: json['peAvg']?.toDouble(),
      avgPercentChangePerMonth: json['avgPercentChangePerMonth']?.toDouble(),
      averagePercentReturnPerOpenTrade:
          json['averagePercentReturnPerOpenTrade']?.toDouble(),
      percentWinners: json['percentWinners']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['portfolioKey'] = portfolioKey;
    data['userKey'] = userKey;
    data['segmentType'] = segmentType?.name;
    data['user'] = user?.toJson();
    data['portfolio'] = portfolio?.toJson();
    data['averageAmountReturnPerOpenTrade'] = averageAmountReturnPerOpenTrade;
    data['averageAmountCostPerOpenTrade'] = averageAmountCostPerOpenTrade;
    data['profitLoss'] = profitLoss;
    data['totalCost'] = totalCost;
    data['numberWinningTrades'] = numberWinningTrades;
    data['numberLosingTrades'] = numberLosingTrades;
    data['monthsTrading'] = monthsTrading;
    data['totalTrades'] = totalTrades;
    data['totalOpenEffectTrades'] = totalOpenEffectTrades;
    data['totalCloseEffectTrades'] = totalCloseEffectTrades;
    data['averageHoldTimeInterval'] = averageHoldTimeInterval;
    data['tradeAccuracy'] = tradeAccuracy;
    data['tradesPerMonth'] = tradesPerMonth;
    data['openTradesPerMonth'] = openTradesPerMonth;
    data['totalReturnByTotalCost'] = totalReturnByTotalCost;
    data['averageHoldTimeDays'] = averageHoldTimeDays;
    data['percentNormalizedTRTC'] = percentNormalizedTRTC;
    data['percentNormalizedAvg'] = percentNormalizedAvg;
    data['percentileTradeAccuracy'] = percentileTradeAccuracy;
    data['betaAvg'] = betaAvg;
    data['peAvg'] = peAvg;
    data['avgPercentChangePerMonth'] = avgPercentChangePerMonth;
    data['averagePercentReturnPerOpenTrade'] = averagePercentReturnPerOpenTrade;
    data['percentWinners'] = percentWinners;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TradePerformance &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.segmentType, segmentType) ||
                const DeepCollectionEquality()
                    .equals(other.segmentType, segmentType)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.portfolio, portfolio) ||
                const DeepCollectionEquality()
                    .equals(other.portfolio, portfolio)) &&
            (identical(other.averageAmountReturnPerOpenTrade, averageAmountReturnPerOpenTrade) ||
                const DeepCollectionEquality().equals(
                    other.averageAmountReturnPerOpenTrade,
                    averageAmountReturnPerOpenTrade)) &&
            (identical(other.averageAmountCostPerOpenTrade, averageAmountCostPerOpenTrade) ||
                const DeepCollectionEquality().equals(
                    other.averageAmountCostPerOpenTrade,
                    averageAmountCostPerOpenTrade)) &&
            (identical(other.profitLoss, profitLoss) ||
                const DeepCollectionEquality()
                    .equals(other.profitLoss, profitLoss)) &&
            (identical(other.totalCost, totalCost) ||
                const DeepCollectionEquality()
                    .equals(other.totalCost, totalCost)) &&
            (identical(other.numberWinningTrades, numberWinningTrades) ||
                const DeepCollectionEquality()
                    .equals(other.numberWinningTrades, numberWinningTrades)) &&
            (identical(other.numberLosingTrades, numberLosingTrades) ||
                const DeepCollectionEquality()
                    .equals(other.numberLosingTrades, numberLosingTrades)) &&
            (identical(other.monthsTrading, monthsTrading) ||
                const DeepCollectionEquality()
                    .equals(other.monthsTrading, monthsTrading)) &&
            (identical(other.totalTrades, totalTrades) ||
                const DeepCollectionEquality()
                    .equals(other.totalTrades, totalTrades)) &&
            (identical(other.totalOpenEffectTrades, totalOpenEffectTrades) ||
                const DeepCollectionEquality().equals(
                    other.totalOpenEffectTrades, totalOpenEffectTrades)) &&
            (identical(other.totalCloseEffectTrades, totalCloseEffectTrades) ||
                const DeepCollectionEquality()
                    .equals(other.totalCloseEffectTrades, totalCloseEffectTrades)) &&
            (identical(other.averageHoldTimeInterval, averageHoldTimeInterval) || const DeepCollectionEquality().equals(other.averageHoldTimeInterval, averageHoldTimeInterval)) &&
            (identical(other.tradeAccuracy, tradeAccuracy) || const DeepCollectionEquality().equals(other.tradeAccuracy, tradeAccuracy)) &&
            (identical(other.tradesPerMonth, tradesPerMonth) || const DeepCollectionEquality().equals(other.tradesPerMonth, tradesPerMonth)) &&
            (identical(other.openTradesPerMonth, openTradesPerMonth) || const DeepCollectionEquality().equals(other.openTradesPerMonth, openTradesPerMonth)) &&
            (identical(other.totalReturnByTotalCost, totalReturnByTotalCost) || const DeepCollectionEquality().equals(other.totalReturnByTotalCost, totalReturnByTotalCost)) &&
            (identical(other.averageHoldTimeDays, averageHoldTimeDays) || const DeepCollectionEquality().equals(other.averageHoldTimeDays, averageHoldTimeDays)) &&
            (identical(other.percentNormalizedTRTC, percentNormalizedTRTC) || const DeepCollectionEquality().equals(other.percentNormalizedTRTC, percentNormalizedTRTC)) &&
            (identical(other.percentNormalizedAvg, percentNormalizedAvg) || const DeepCollectionEquality().equals(other.percentNormalizedAvg, percentNormalizedAvg)) &&
            (identical(other.percentileTradeAccuracy, percentileTradeAccuracy) || const DeepCollectionEquality().equals(other.percentileTradeAccuracy, percentileTradeAccuracy)) &&
            (identical(other.betaAvg, betaAvg) || const DeepCollectionEquality().equals(other.betaAvg, betaAvg)) &&
            (identical(other.peAvg, peAvg) || const DeepCollectionEquality().equals(other.peAvg, peAvg)) &&
            (identical(other.avgPercentChangePerMonth, avgPercentChangePerMonth) || const DeepCollectionEquality().equals(other.avgPercentChangePerMonth, avgPercentChangePerMonth)) &&
            (identical(other.averagePercentReturnPerOpenTrade, averagePercentReturnPerOpenTrade) || const DeepCollectionEquality().equals(other.averagePercentReturnPerOpenTrade, averagePercentReturnPerOpenTrade)) &&
            (identical(other.percentWinners, percentWinners) || const DeepCollectionEquality().equals(other.percentWinners, percentWinners)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(segmentType) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(portfolio) ^
        const DeepCollectionEquality().hash(averageAmountReturnPerOpenTrade) ^
        const DeepCollectionEquality().hash(averageAmountCostPerOpenTrade) ^
        const DeepCollectionEquality().hash(profitLoss) ^
        const DeepCollectionEquality().hash(totalCost) ^
        const DeepCollectionEquality().hash(numberWinningTrades) ^
        const DeepCollectionEquality().hash(numberLosingTrades) ^
        const DeepCollectionEquality().hash(monthsTrading) ^
        const DeepCollectionEquality().hash(totalTrades) ^
        const DeepCollectionEquality().hash(totalOpenEffectTrades) ^
        const DeepCollectionEquality().hash(totalCloseEffectTrades) ^
        const DeepCollectionEquality().hash(averageHoldTimeInterval) ^
        const DeepCollectionEquality().hash(tradeAccuracy) ^
        const DeepCollectionEquality().hash(tradesPerMonth) ^
        const DeepCollectionEquality().hash(openTradesPerMonth) ^
        const DeepCollectionEquality().hash(totalReturnByTotalCost) ^
        const DeepCollectionEquality().hash(averageHoldTimeDays) ^
        const DeepCollectionEquality().hash(percentNormalizedTRTC) ^
        const DeepCollectionEquality().hash(percentNormalizedAvg) ^
        const DeepCollectionEquality().hash(percentileTradeAccuracy) ^
        const DeepCollectionEquality().hash(betaAvg) ^
        const DeepCollectionEquality().hash(peAvg) ^
        const DeepCollectionEquality().hash(avgPercentChangePerMonth) ^
        const DeepCollectionEquality().hash(averagePercentReturnPerOpenTrade) ^
        const DeepCollectionEquality().hash(percentWinners);
  }

  @override
  String toString() => 'TradePerformance(${toJson()})';
}
