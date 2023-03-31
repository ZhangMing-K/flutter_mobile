import 'package:iris_common/data/models/enums/option_type.dart';
import 'package:iris_common/data/models/enums/position_type.dart';
import 'package:iris_common/data/models/output/position_effect_count.dart';
import 'package:iris_common/data/models/output/order.dart';
import 'package:iris_common/data/models/output/asset.dart';
import 'package:collection/collection.dart';

class PositionAnalysis {
  final String? symbol;
  final List<int>? userKeys;
  final List<int>? portfolioKeys;
  final double? usersHolding;
  final OPTION_TYPE? optionType;
  final POSITION_TYPE? positionType;
  final List<POSITION_TYPE>? positionTypes;
  final List<OPTION_TYPE>? optionTypes;
  final List<String>? orderGroupUUIDS;
  final double? totalAmountOpen;
  final double? portfolioAllocation;
  final double? profitLossTotal;
  final double? totalCost;
  final double? totalQuantity;
  final double? averageBuyPrice;
  final double? averageOptionStrike;
  final double? averageOptionDTE;
  final List<DateTime>? expirationDates;
  final List<double>? strikePrices;
  final double? profitLossPercentTotal;
  final int? transactionCount;
  final String? orderStrategies;
  final DateTime? openedAt;
  final PositionEffectCount? positionEffects;
  final List<Order>? orders;
  final Asset? asset;
  const PositionAnalysis(
      {this.symbol,
      this.userKeys,
      this.portfolioKeys,
      this.usersHolding,
      this.optionType,
      this.positionType,
      this.positionTypes,
      this.optionTypes,
      this.orderGroupUUIDS,
      this.totalAmountOpen,
      this.portfolioAllocation,
      this.profitLossTotal,
      this.totalCost,
      this.totalQuantity,
      this.averageBuyPrice,
      this.averageOptionStrike,
      this.averageOptionDTE,
      this.expirationDates,
      this.strikePrices,
      this.profitLossPercentTotal,
      this.transactionCount,
      this.orderStrategies,
      this.openedAt,
      this.positionEffects,
      this.orders,
      this.asset});
  PositionAnalysis copyWith(
      {String? symbol,
      List<int>? userKeys,
      List<int>? portfolioKeys,
      double? usersHolding,
      OPTION_TYPE? optionType,
      POSITION_TYPE? positionType,
      List<POSITION_TYPE>? positionTypes,
      List<OPTION_TYPE>? optionTypes,
      List<String>? orderGroupUUIDS,
      double? totalAmountOpen,
      double? portfolioAllocation,
      double? profitLossTotal,
      double? totalCost,
      double? totalQuantity,
      double? averageBuyPrice,
      double? averageOptionStrike,
      double? averageOptionDTE,
      List<DateTime>? expirationDates,
      List<double>? strikePrices,
      double? profitLossPercentTotal,
      int? transactionCount,
      String? orderStrategies,
      DateTime? openedAt,
      PositionEffectCount? positionEffects,
      List<Order>? orders,
      Asset? asset}) {
    return PositionAnalysis(
      symbol: symbol ?? this.symbol,
      userKeys: userKeys ?? this.userKeys,
      portfolioKeys: portfolioKeys ?? this.portfolioKeys,
      usersHolding: usersHolding ?? this.usersHolding,
      optionType: optionType ?? this.optionType,
      positionType: positionType ?? this.positionType,
      positionTypes: positionTypes ?? this.positionTypes,
      optionTypes: optionTypes ?? this.optionTypes,
      orderGroupUUIDS: orderGroupUUIDS ?? this.orderGroupUUIDS,
      totalAmountOpen: totalAmountOpen ?? this.totalAmountOpen,
      portfolioAllocation: portfolioAllocation ?? this.portfolioAllocation,
      profitLossTotal: profitLossTotal ?? this.profitLossTotal,
      totalCost: totalCost ?? this.totalCost,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      averageBuyPrice: averageBuyPrice ?? this.averageBuyPrice,
      averageOptionStrike: averageOptionStrike ?? this.averageOptionStrike,
      averageOptionDTE: averageOptionDTE ?? this.averageOptionDTE,
      expirationDates: expirationDates ?? this.expirationDates,
      strikePrices: strikePrices ?? this.strikePrices,
      profitLossPercentTotal:
          profitLossPercentTotal ?? this.profitLossPercentTotal,
      transactionCount: transactionCount ?? this.transactionCount,
      orderStrategies: orderStrategies ?? this.orderStrategies,
      openedAt: openedAt ?? this.openedAt,
      positionEffects: positionEffects ?? this.positionEffects,
      orders: orders ?? this.orders,
      asset: asset ?? this.asset,
    );
  }

  factory PositionAnalysis.fromJson(Map<String, dynamic> json) {
    return PositionAnalysis(
      symbol: json['symbol'],
      userKeys: json['userKeys']?.map<int>((o) => (o as int)).toList(),
      portfolioKeys:
          json['portfolioKeys']?.map<int>((o) => (o as int)).toList(),
      usersHolding: json['usersHolding']?.toDouble(),
      optionType: json['optionType'] != null
          ? OPTION_TYPE.values.byName(json['optionType'])
          : null,
      positionType: json['positionType'] != null
          ? POSITION_TYPE.values.byName(json['positionType'])
          : null,
      positionTypes: json['positionTypes']
          ?.map<POSITION_TYPE>((o) => POSITION_TYPE.values.byName(o))
          .toList(),
      optionTypes: json['optionTypes']
          ?.map<OPTION_TYPE>((o) => OPTION_TYPE.values.byName(o))
          .toList(),
      orderGroupUUIDS:
          json['orderGroupUUIDS']?.map<String>((o) => o.toString()).toList(),
      totalAmountOpen: json['totalAmountOpen']?.toDouble(),
      portfolioAllocation: json['portfolioAllocation']?.toDouble(),
      profitLossTotal: json['profitLossTotal']?.toDouble(),
      totalCost: json['totalCost']?.toDouble(),
      totalQuantity: json['totalQuantity']?.toDouble(),
      averageBuyPrice: json['averageBuyPrice']?.toDouble(),
      averageOptionStrike: json['averageOptionStrike']?.toDouble(),
      averageOptionDTE: json['averageOptionDTE']?.toDouble(),
      expirationDates: json['expirationDates']
          ?.map<DateTime>((o) => DateTime.parse(o))
          .toList(),
      strikePrices:
          json['strikePrices']?.map<double>((o) => o.todouble()).toList(),
      profitLossPercentTotal: json['profitLossPercentTotal']?.toDouble(),
      transactionCount: json['transactionCount'],
      orderStrategies: json['orderStrategies'],
      openedAt:
          json['openedAt'] != null ? DateTime.parse(json['openedAt']) : null,
      positionEffects: json['positionEffects'] != null
          ? PositionEffectCount.fromJson(json['positionEffects'])
          : null,
      orders: json['orders']?.map<Order>((o) => Order.fromJson(o)).toList(),
      asset: json['asset'] != null ? Asset.fromJson(json['asset']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['userKeys'] = userKeys;
    data['portfolioKeys'] = portfolioKeys;
    data['usersHolding'] = usersHolding;
    data['optionType'] = optionType?.name;
    data['positionType'] = positionType?.name;
    data['positionTypes'] = positionTypes?.map((item) => item.name).toList();
    data['optionTypes'] = optionTypes?.map((item) => item.name).toList();
    data['orderGroupUUIDS'] = orderGroupUUIDS;
    data['totalAmountOpen'] = totalAmountOpen;
    data['portfolioAllocation'] = portfolioAllocation;
    data['profitLossTotal'] = profitLossTotal;
    data['totalCost'] = totalCost;
    data['totalQuantity'] = totalQuantity;
    data['averageBuyPrice'] = averageBuyPrice;
    data['averageOptionStrike'] = averageOptionStrike;
    data['averageOptionDTE'] = averageOptionDTE;
    data['expirationDates'] =
        expirationDates?.map((item) => item.toString()).toList();
    data['strikePrices'] = strikePrices;
    data['profitLossPercentTotal'] = profitLossPercentTotal;
    data['transactionCount'] = transactionCount;
    data['orderStrategies'] = orderStrategies;
    data['openedAt'] = openedAt?.toString();
    data['positionEffects'] = positionEffects?.toJson();
    data['orders'] = orders?.map((item) => item.toJson()).toList();
    data['asset'] = asset?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PositionAnalysis &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.userKeys, userKeys) ||
                const DeepCollectionEquality()
                    .equals(other.userKeys, userKeys)) &&
            (identical(other.portfolioKeys, portfolioKeys) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKeys, portfolioKeys)) &&
            (identical(other.usersHolding, usersHolding) ||
                const DeepCollectionEquality()
                    .equals(other.usersHolding, usersHolding)) &&
            (identical(other.optionType, optionType) ||
                const DeepCollectionEquality()
                    .equals(other.optionType, optionType)) &&
            (identical(other.positionType, positionType) ||
                const DeepCollectionEquality()
                    .equals(other.positionType, positionType)) &&
            (identical(other.positionTypes, positionTypes) ||
                const DeepCollectionEquality()
                    .equals(other.positionTypes, positionTypes)) &&
            (identical(other.optionTypes, optionTypes) ||
                const DeepCollectionEquality()
                    .equals(other.optionTypes, optionTypes)) &&
            (identical(other.orderGroupUUIDS, orderGroupUUIDS) ||
                const DeepCollectionEquality()
                    .equals(other.orderGroupUUIDS, orderGroupUUIDS)) &&
            (identical(other.totalAmountOpen, totalAmountOpen) ||
                const DeepCollectionEquality()
                    .equals(other.totalAmountOpen, totalAmountOpen)) &&
            (identical(other.portfolioAllocation, portfolioAllocation) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioAllocation, portfolioAllocation)) &&
            (identical(other.profitLossTotal, profitLossTotal) ||
                const DeepCollectionEquality()
                    .equals(other.profitLossTotal, profitLossTotal)) &&
            (identical(other.totalCost, totalCost) ||
                const DeepCollectionEquality()
                    .equals(other.totalCost, totalCost)) &&
            (identical(other.totalQuantity, totalQuantity) ||
                const DeepCollectionEquality()
                    .equals(other.totalQuantity, totalQuantity)) &&
            (identical(other.averageBuyPrice, averageBuyPrice) ||
                const DeepCollectionEquality()
                    .equals(other.averageBuyPrice, averageBuyPrice)) &&
            (identical(other.averageOptionStrike, averageOptionStrike) ||
                const DeepCollectionEquality()
                    .equals(other.averageOptionStrike, averageOptionStrike)) &&
            (identical(other.averageOptionDTE, averageOptionDTE) ||
                const DeepCollectionEquality()
                    .equals(other.averageOptionDTE, averageOptionDTE)) &&
            (identical(other.expirationDates, expirationDates) ||
                const DeepCollectionEquality()
                    .equals(other.expirationDates, expirationDates)) &&
            (identical(other.strikePrices, strikePrices) ||
                const DeepCollectionEquality()
                    .equals(other.strikePrices, strikePrices)) &&
            (identical(other.profitLossPercentTotal, profitLossPercentTotal) ||
                const DeepCollectionEquality().equals(
                    other.profitLossPercentTotal, profitLossPercentTotal)) &&
            (identical(other.transactionCount, transactionCount) ||
                const DeepCollectionEquality()
                    .equals(other.transactionCount, transactionCount)) &&
            (identical(other.orderStrategies, orderStrategies) ||
                const DeepCollectionEquality()
                    .equals(other.orderStrategies, orderStrategies)) &&
            (identical(other.openedAt, openedAt) || const DeepCollectionEquality().equals(other.openedAt, openedAt)) &&
            (identical(other.positionEffects, positionEffects) || const DeepCollectionEquality().equals(other.positionEffects, positionEffects)) &&
            (identical(other.orders, orders) || const DeepCollectionEquality().equals(other.orders, orders)) &&
            (identical(other.asset, asset) || const DeepCollectionEquality().equals(other.asset, asset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(symbol) ^
        const DeepCollectionEquality().hash(userKeys) ^
        const DeepCollectionEquality().hash(portfolioKeys) ^
        const DeepCollectionEquality().hash(usersHolding) ^
        const DeepCollectionEquality().hash(optionType) ^
        const DeepCollectionEquality().hash(positionType) ^
        const DeepCollectionEquality().hash(positionTypes) ^
        const DeepCollectionEquality().hash(optionTypes) ^
        const DeepCollectionEquality().hash(orderGroupUUIDS) ^
        const DeepCollectionEquality().hash(totalAmountOpen) ^
        const DeepCollectionEquality().hash(portfolioAllocation) ^
        const DeepCollectionEquality().hash(profitLossTotal) ^
        const DeepCollectionEquality().hash(totalCost) ^
        const DeepCollectionEquality().hash(totalQuantity) ^
        const DeepCollectionEquality().hash(averageBuyPrice) ^
        const DeepCollectionEquality().hash(averageOptionStrike) ^
        const DeepCollectionEquality().hash(averageOptionDTE) ^
        const DeepCollectionEquality().hash(expirationDates) ^
        const DeepCollectionEquality().hash(strikePrices) ^
        const DeepCollectionEquality().hash(profitLossPercentTotal) ^
        const DeepCollectionEquality().hash(transactionCount) ^
        const DeepCollectionEquality().hash(orderStrategies) ^
        const DeepCollectionEquality().hash(openedAt) ^
        const DeepCollectionEquality().hash(positionEffects) ^
        const DeepCollectionEquality().hash(orders) ^
        const DeepCollectionEquality().hash(asset);
  }

  @override
  String toString() => 'PositionAnalysis(${toJson()})';
}
