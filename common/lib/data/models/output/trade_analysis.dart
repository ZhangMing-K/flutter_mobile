import 'package:iris_common/data/models/output/position_effect_count.dart';
import 'package:iris_common/data/models/output/order.dart';
import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/output/asset.dart';
import 'package:iris_common/data/models/enums/option_type.dart';
import 'package:iris_common/data/models/enums/position_type.dart';
import 'package:collection/collection.dart';

class TradeAnalysis {
  final String? symbol;
  final List<int>? userKeys;
  final List<int>? portfolioKeys;
  final double? profitLossTotal;
  final double? profitLossPercentRelative;
  final double? profitLossPercentPortfolio;
  final double? profitLossPercentTotal;
  final int? transactionCount;
  final DateTime? closedAt;
  final DateTime? openedAt;
  final List<String>? orderStrategies;
  final List<String>? positionTypes;
  final List<String>? orderGroupUUIDS;
  final PositionEffectCount? positionEffects;
  final List<Order>? orders;
  final List<Portfolio>? portfolios;
  final Asset? asset;
  final OPTION_TYPE? optionType;
  final POSITION_TYPE? positionType;
  final String? orderStrategy;
  final double? averageDurationMinutes;
  final double? averageInvestment;
  final double? averageRelativeInvestment;
  final double? gainPercentAverageInvestment;
  final bool? positionClosed;
  final double? uniqueUsersPositionsOpenedCount;
  final double? totalAmountOpen;
  final double? bullishAmountOpen;
  final double? bearishAmountOpen;
  final double? totalAmountClose;
  final double? bullishAmountClose;
  final double? bearishAmountClose;
  final double? positionsOpenedCount;
  final double? totalTransactionCount;
  final double? totalTransactionAmount;
  final double? bullishTransactionAmount;
  final double? bearishTransactionAmount;
  final double? bullishTransactionQuantity;
  final double? bearishTransactionQuantity;
  final double? averageEquityBuyPrice;
  final double? averageEquitySellPrice;
  final double? totalPutStrike;
  final double? totalPutQuantity;
  final double? totalCallStrike;
  final double? totalCallQuantity;
  final double? callOpenOrderCount;
  final double? uniqueUserCallOpened;
  final double? putOpenOrderCount;
  final double? uniqueUserPutOpened;
  final double? equityOpenOrderCount;
  final double? uniqueUserEquityOpened;
  final double? callCloseOrderCount;
  final double? putCloseOrderCount;
  final double? equityCloseOrderCount;
  final double? uniqueUserEquityClosed;
  final double? callAmountOpen;
  final double? putAmountOpen;
  final double? equityAmountOpen;
  final double? callAmountClosed;
  final double? putAmountClosed;
  final double? equityAmountClosed;
  final double? totalCost;
  final double? averageBuyPrice;
  final double? averagePutStrike;
  final double? averageCallStrike;
  final double? bullishPositionsOpenedCount;
  final double? bearishPositionsOpenedCount;
  final double? bullishTransactionCount;
  final double? bearishTransactionCount;
  final double? bullishUserPositionsOpened;
  final double? bearishUserPositionsOpened;
  final double? usersHoldingBull;
  final double? usersHoldingBear;
  final double? positionsClosedCount;
  final double? bullishPositionsClosedCount;
  final double? bearishPositionsClosedCount;
  final double? averageCallDTE;
  final double? averagePutDTE;
  const TradeAnalysis(
      {this.symbol,
      this.userKeys,
      this.portfolioKeys,
      this.profitLossTotal,
      this.profitLossPercentRelative,
      this.profitLossPercentPortfolio,
      this.profitLossPercentTotal,
      this.transactionCount,
      this.closedAt,
      this.openedAt,
      this.orderStrategies,
      this.positionTypes,
      this.orderGroupUUIDS,
      this.positionEffects,
      this.orders,
      this.portfolios,
      this.asset,
      this.optionType,
      this.positionType,
      this.orderStrategy,
      this.averageDurationMinutes,
      this.averageInvestment,
      this.averageRelativeInvestment,
      this.gainPercentAverageInvestment,
      this.positionClosed,
      this.uniqueUsersPositionsOpenedCount,
      this.totalAmountOpen,
      this.bullishAmountOpen,
      this.bearishAmountOpen,
      this.totalAmountClose,
      this.bullishAmountClose,
      this.bearishAmountClose,
      this.positionsOpenedCount,
      this.totalTransactionCount,
      this.totalTransactionAmount,
      this.bullishTransactionAmount,
      this.bearishTransactionAmount,
      this.bullishTransactionQuantity,
      this.bearishTransactionQuantity,
      this.averageEquityBuyPrice,
      this.averageEquitySellPrice,
      this.totalPutStrike,
      this.totalPutQuantity,
      this.totalCallStrike,
      this.totalCallQuantity,
      this.callOpenOrderCount,
      this.uniqueUserCallOpened,
      this.putOpenOrderCount,
      this.uniqueUserPutOpened,
      this.equityOpenOrderCount,
      this.uniqueUserEquityOpened,
      this.callCloseOrderCount,
      this.putCloseOrderCount,
      this.equityCloseOrderCount,
      this.uniqueUserEquityClosed,
      this.callAmountOpen,
      this.putAmountOpen,
      this.equityAmountOpen,
      this.callAmountClosed,
      this.putAmountClosed,
      this.equityAmountClosed,
      this.totalCost,
      this.averageBuyPrice,
      this.averagePutStrike,
      this.averageCallStrike,
      this.bullishPositionsOpenedCount,
      this.bearishPositionsOpenedCount,
      this.bullishTransactionCount,
      this.bearishTransactionCount,
      this.bullishUserPositionsOpened,
      this.bearishUserPositionsOpened,
      this.usersHoldingBull,
      this.usersHoldingBear,
      this.positionsClosedCount,
      this.bullishPositionsClosedCount,
      this.bearishPositionsClosedCount,
      this.averageCallDTE,
      this.averagePutDTE});
  TradeAnalysis copyWith(
      {String? symbol,
      List<int>? userKeys,
      List<int>? portfolioKeys,
      double? profitLossTotal,
      double? profitLossPercentRelative,
      double? profitLossPercentPortfolio,
      double? profitLossPercentTotal,
      int? transactionCount,
      DateTime? closedAt,
      DateTime? openedAt,
      List<String>? orderStrategies,
      List<String>? positionTypes,
      List<String>? orderGroupUUIDS,
      PositionEffectCount? positionEffects,
      List<Order>? orders,
      List<Portfolio>? portfolios,
      Asset? asset,
      OPTION_TYPE? optionType,
      POSITION_TYPE? positionType,
      String? orderStrategy,
      double? averageDurationMinutes,
      double? averageInvestment,
      double? averageRelativeInvestment,
      double? gainPercentAverageInvestment,
      bool? positionClosed,
      double? uniqueUsersPositionsOpenedCount,
      double? totalAmountOpen,
      double? bullishAmountOpen,
      double? bearishAmountOpen,
      double? totalAmountClose,
      double? bullishAmountClose,
      double? bearishAmountClose,
      double? positionsOpenedCount,
      double? totalTransactionCount,
      double? totalTransactionAmount,
      double? bullishTransactionAmount,
      double? bearishTransactionAmount,
      double? bullishTransactionQuantity,
      double? bearishTransactionQuantity,
      double? averageEquityBuyPrice,
      double? averageEquitySellPrice,
      double? totalPutStrike,
      double? totalPutQuantity,
      double? totalCallStrike,
      double? totalCallQuantity,
      double? callOpenOrderCount,
      double? uniqueUserCallOpened,
      double? putOpenOrderCount,
      double? uniqueUserPutOpened,
      double? equityOpenOrderCount,
      double? uniqueUserEquityOpened,
      double? callCloseOrderCount,
      double? putCloseOrderCount,
      double? equityCloseOrderCount,
      double? uniqueUserEquityClosed,
      double? callAmountOpen,
      double? putAmountOpen,
      double? equityAmountOpen,
      double? callAmountClosed,
      double? putAmountClosed,
      double? equityAmountClosed,
      double? totalCost,
      double? averageBuyPrice,
      double? averagePutStrike,
      double? averageCallStrike,
      double? bullishPositionsOpenedCount,
      double? bearishPositionsOpenedCount,
      double? bullishTransactionCount,
      double? bearishTransactionCount,
      double? bullishUserPositionsOpened,
      double? bearishUserPositionsOpened,
      double? usersHoldingBull,
      double? usersHoldingBear,
      double? positionsClosedCount,
      double? bullishPositionsClosedCount,
      double? bearishPositionsClosedCount,
      double? averageCallDTE,
      double? averagePutDTE}) {
    return TradeAnalysis(
      symbol: symbol ?? this.symbol,
      userKeys: userKeys ?? this.userKeys,
      portfolioKeys: portfolioKeys ?? this.portfolioKeys,
      profitLossTotal: profitLossTotal ?? this.profitLossTotal,
      profitLossPercentRelative:
          profitLossPercentRelative ?? this.profitLossPercentRelative,
      profitLossPercentPortfolio:
          profitLossPercentPortfolio ?? this.profitLossPercentPortfolio,
      profitLossPercentTotal:
          profitLossPercentTotal ?? this.profitLossPercentTotal,
      transactionCount: transactionCount ?? this.transactionCount,
      closedAt: closedAt ?? this.closedAt,
      openedAt: openedAt ?? this.openedAt,
      orderStrategies: orderStrategies ?? this.orderStrategies,
      positionTypes: positionTypes ?? this.positionTypes,
      orderGroupUUIDS: orderGroupUUIDS ?? this.orderGroupUUIDS,
      positionEffects: positionEffects ?? this.positionEffects,
      orders: orders ?? this.orders,
      portfolios: portfolios ?? this.portfolios,
      asset: asset ?? this.asset,
      optionType: optionType ?? this.optionType,
      positionType: positionType ?? this.positionType,
      orderStrategy: orderStrategy ?? this.orderStrategy,
      averageDurationMinutes:
          averageDurationMinutes ?? this.averageDurationMinutes,
      averageInvestment: averageInvestment ?? this.averageInvestment,
      averageRelativeInvestment:
          averageRelativeInvestment ?? this.averageRelativeInvestment,
      gainPercentAverageInvestment:
          gainPercentAverageInvestment ?? this.gainPercentAverageInvestment,
      positionClosed: positionClosed ?? this.positionClosed,
      uniqueUsersPositionsOpenedCount: uniqueUsersPositionsOpenedCount ??
          this.uniqueUsersPositionsOpenedCount,
      totalAmountOpen: totalAmountOpen ?? this.totalAmountOpen,
      bullishAmountOpen: bullishAmountOpen ?? this.bullishAmountOpen,
      bearishAmountOpen: bearishAmountOpen ?? this.bearishAmountOpen,
      totalAmountClose: totalAmountClose ?? this.totalAmountClose,
      bullishAmountClose: bullishAmountClose ?? this.bullishAmountClose,
      bearishAmountClose: bearishAmountClose ?? this.bearishAmountClose,
      positionsOpenedCount: positionsOpenedCount ?? this.positionsOpenedCount,
      totalTransactionCount:
          totalTransactionCount ?? this.totalTransactionCount,
      totalTransactionAmount:
          totalTransactionAmount ?? this.totalTransactionAmount,
      bullishTransactionAmount:
          bullishTransactionAmount ?? this.bullishTransactionAmount,
      bearishTransactionAmount:
          bearishTransactionAmount ?? this.bearishTransactionAmount,
      bullishTransactionQuantity:
          bullishTransactionQuantity ?? this.bullishTransactionQuantity,
      bearishTransactionQuantity:
          bearishTransactionQuantity ?? this.bearishTransactionQuantity,
      averageEquityBuyPrice:
          averageEquityBuyPrice ?? this.averageEquityBuyPrice,
      averageEquitySellPrice:
          averageEquitySellPrice ?? this.averageEquitySellPrice,
      totalPutStrike: totalPutStrike ?? this.totalPutStrike,
      totalPutQuantity: totalPutQuantity ?? this.totalPutQuantity,
      totalCallStrike: totalCallStrike ?? this.totalCallStrike,
      totalCallQuantity: totalCallQuantity ?? this.totalCallQuantity,
      callOpenOrderCount: callOpenOrderCount ?? this.callOpenOrderCount,
      uniqueUserCallOpened: uniqueUserCallOpened ?? this.uniqueUserCallOpened,
      putOpenOrderCount: putOpenOrderCount ?? this.putOpenOrderCount,
      uniqueUserPutOpened: uniqueUserPutOpened ?? this.uniqueUserPutOpened,
      equityOpenOrderCount: equityOpenOrderCount ?? this.equityOpenOrderCount,
      uniqueUserEquityOpened:
          uniqueUserEquityOpened ?? this.uniqueUserEquityOpened,
      callCloseOrderCount: callCloseOrderCount ?? this.callCloseOrderCount,
      putCloseOrderCount: putCloseOrderCount ?? this.putCloseOrderCount,
      equityCloseOrderCount:
          equityCloseOrderCount ?? this.equityCloseOrderCount,
      uniqueUserEquityClosed:
          uniqueUserEquityClosed ?? this.uniqueUserEquityClosed,
      callAmountOpen: callAmountOpen ?? this.callAmountOpen,
      putAmountOpen: putAmountOpen ?? this.putAmountOpen,
      equityAmountOpen: equityAmountOpen ?? this.equityAmountOpen,
      callAmountClosed: callAmountClosed ?? this.callAmountClosed,
      putAmountClosed: putAmountClosed ?? this.putAmountClosed,
      equityAmountClosed: equityAmountClosed ?? this.equityAmountClosed,
      totalCost: totalCost ?? this.totalCost,
      averageBuyPrice: averageBuyPrice ?? this.averageBuyPrice,
      averagePutStrike: averagePutStrike ?? this.averagePutStrike,
      averageCallStrike: averageCallStrike ?? this.averageCallStrike,
      bullishPositionsOpenedCount:
          bullishPositionsOpenedCount ?? this.bullishPositionsOpenedCount,
      bearishPositionsOpenedCount:
          bearishPositionsOpenedCount ?? this.bearishPositionsOpenedCount,
      bullishTransactionCount:
          bullishTransactionCount ?? this.bullishTransactionCount,
      bearishTransactionCount:
          bearishTransactionCount ?? this.bearishTransactionCount,
      bullishUserPositionsOpened:
          bullishUserPositionsOpened ?? this.bullishUserPositionsOpened,
      bearishUserPositionsOpened:
          bearishUserPositionsOpened ?? this.bearishUserPositionsOpened,
      usersHoldingBull: usersHoldingBull ?? this.usersHoldingBull,
      usersHoldingBear: usersHoldingBear ?? this.usersHoldingBear,
      positionsClosedCount: positionsClosedCount ?? this.positionsClosedCount,
      bullishPositionsClosedCount:
          bullishPositionsClosedCount ?? this.bullishPositionsClosedCount,
      bearishPositionsClosedCount:
          bearishPositionsClosedCount ?? this.bearishPositionsClosedCount,
      averageCallDTE: averageCallDTE ?? this.averageCallDTE,
      averagePutDTE: averagePutDTE ?? this.averagePutDTE,
    );
  }

  factory TradeAnalysis.fromJson(Map<String, dynamic> json) {
    return TradeAnalysis(
      symbol: json['symbol'],
      userKeys: json['userKeys']?.map<int>((o) => (o as int)).toList(),
      portfolioKeys:
          json['portfolioKeys']?.map<int>((o) => (o as int)).toList(),
      profitLossTotal: json['profitLossTotal']?.toDouble(),
      profitLossPercentRelative: json['profitLossPercentRelative']?.toDouble(),
      profitLossPercentPortfolio:
          json['profitLossPercentPortfolio']?.toDouble(),
      profitLossPercentTotal: json['profitLossPercentTotal']?.toDouble(),
      transactionCount: json['transactionCount'],
      closedAt:
          json['closedAt'] != null ? DateTime.parse(json['closedAt']) : null,
      openedAt:
          json['openedAt'] != null ? DateTime.parse(json['openedAt']) : null,
      orderStrategies:
          json['orderStrategies']?.map<String>((o) => o.toString()).toList(),
      positionTypes:
          json['positionTypes']?.map<String>((o) => o.toString()).toList(),
      orderGroupUUIDS:
          json['orderGroupUUIDS']?.map<String>((o) => o.toString()).toList(),
      positionEffects: json['positionEffects'] != null
          ? PositionEffectCount.fromJson(json['positionEffects'])
          : null,
      orders: json['orders']?.map<Order>((o) => Order.fromJson(o)).toList(),
      portfolios: json['portfolios']
          ?.map<Portfolio>((o) => Portfolio.fromJson(o))
          .toList(),
      asset: json['asset'] != null ? Asset.fromJson(json['asset']) : null,
      optionType: json['optionType'] != null
          ? OPTION_TYPE.values.byName(json['optionType'])
          : null,
      positionType: json['positionType'] != null
          ? POSITION_TYPE.values.byName(json['positionType'])
          : null,
      orderStrategy: json['orderStrategy'],
      averageDurationMinutes: json['averageDurationMinutes']?.toDouble(),
      averageInvestment: json['averageInvestment']?.toDouble(),
      averageRelativeInvestment: json['averageRelativeInvestment']?.toDouble(),
      gainPercentAverageInvestment:
          json['gainPercentAverageInvestment']?.toDouble(),
      positionClosed: json['positionClosed'],
      uniqueUsersPositionsOpenedCount:
          json['uniqueUsersPositionsOpenedCount']?.toDouble(),
      totalAmountOpen: json['totalAmountOpen']?.toDouble(),
      bullishAmountOpen: json['bullishAmountOpen']?.toDouble(),
      bearishAmountOpen: json['bearishAmountOpen']?.toDouble(),
      totalAmountClose: json['totalAmountClose']?.toDouble(),
      bullishAmountClose: json['bullishAmountClose']?.toDouble(),
      bearishAmountClose: json['bearishAmountClose']?.toDouble(),
      positionsOpenedCount: json['positionsOpenedCount']?.toDouble(),
      totalTransactionCount: json['totalTransactionCount']?.toDouble(),
      totalTransactionAmount: json['totalTransactionAmount']?.toDouble(),
      bullishTransactionAmount: json['bullishTransactionAmount']?.toDouble(),
      bearishTransactionAmount: json['bearishTransactionAmount']?.toDouble(),
      bullishTransactionQuantity:
          json['bullishTransactionQuantity']?.toDouble(),
      bearishTransactionQuantity:
          json['bearishTransactionQuantity']?.toDouble(),
      averageEquityBuyPrice: json['averageEquityBuyPrice']?.toDouble(),
      averageEquitySellPrice: json['averageEquitySellPrice']?.toDouble(),
      totalPutStrike: json['totalPutStrike']?.toDouble(),
      totalPutQuantity: json['totalPutQuantity']?.toDouble(),
      totalCallStrike: json['totalCallStrike']?.toDouble(),
      totalCallQuantity: json['totalCallQuantity']?.toDouble(),
      callOpenOrderCount: json['callOpenOrderCount']?.toDouble(),
      uniqueUserCallOpened: json['uniqueUserCallOpened']?.toDouble(),
      putOpenOrderCount: json['putOpenOrderCount']?.toDouble(),
      uniqueUserPutOpened: json['uniqueUserPutOpened']?.toDouble(),
      equityOpenOrderCount: json['equityOpenOrderCount']?.toDouble(),
      uniqueUserEquityOpened: json['uniqueUserEquityOpened']?.toDouble(),
      callCloseOrderCount: json['callCloseOrderCount']?.toDouble(),
      putCloseOrderCount: json['putCloseOrderCount']?.toDouble(),
      equityCloseOrderCount: json['equityCloseOrderCount']?.toDouble(),
      uniqueUserEquityClosed: json['uniqueUserEquityClosed']?.toDouble(),
      callAmountOpen: json['callAmountOpen']?.toDouble(),
      putAmountOpen: json['putAmountOpen']?.toDouble(),
      equityAmountOpen: json['equityAmountOpen']?.toDouble(),
      callAmountClosed: json['callAmountClosed']?.toDouble(),
      putAmountClosed: json['putAmountClosed']?.toDouble(),
      equityAmountClosed: json['equityAmountClosed']?.toDouble(),
      totalCost: json['totalCost']?.toDouble(),
      averageBuyPrice: json['averageBuyPrice']?.toDouble(),
      averagePutStrike: json['averagePutStrike']?.toDouble(),
      averageCallStrike: json['averageCallStrike']?.toDouble(),
      bullishPositionsOpenedCount:
          json['bullishPositionsOpenedCount']?.toDouble(),
      bearishPositionsOpenedCount:
          json['bearishPositionsOpenedCount']?.toDouble(),
      bullishTransactionCount: json['bullishTransactionCount']?.toDouble(),
      bearishTransactionCount: json['bearishTransactionCount']?.toDouble(),
      bullishUserPositionsOpened:
          json['bullishUserPositionsOpened']?.toDouble(),
      bearishUserPositionsOpened:
          json['bearishUserPositionsOpened']?.toDouble(),
      usersHoldingBull: json['usersHoldingBull']?.toDouble(),
      usersHoldingBear: json['usersHoldingBear']?.toDouble(),
      positionsClosedCount: json['positionsClosedCount']?.toDouble(),
      bullishPositionsClosedCount:
          json['bullishPositionsClosedCount']?.toDouble(),
      bearishPositionsClosedCount:
          json['bearishPositionsClosedCount']?.toDouble(),
      averageCallDTE: json['averageCallDTE']?.toDouble(),
      averagePutDTE: json['averagePutDTE']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['userKeys'] = userKeys;
    data['portfolioKeys'] = portfolioKeys;
    data['profitLossTotal'] = profitLossTotal;
    data['profitLossPercentRelative'] = profitLossPercentRelative;
    data['profitLossPercentPortfolio'] = profitLossPercentPortfolio;
    data['profitLossPercentTotal'] = profitLossPercentTotal;
    data['transactionCount'] = transactionCount;
    data['closedAt'] = closedAt?.toString();
    data['openedAt'] = openedAt?.toString();
    data['orderStrategies'] = orderStrategies;
    data['positionTypes'] = positionTypes;
    data['orderGroupUUIDS'] = orderGroupUUIDS;
    data['positionEffects'] = positionEffects?.toJson();
    data['orders'] = orders?.map((item) => item.toJson()).toList();
    data['portfolios'] = portfolios?.map((item) => item.toJson()).toList();
    data['asset'] = asset?.toJson();
    data['optionType'] = optionType?.name;
    data['positionType'] = positionType?.name;
    data['orderStrategy'] = orderStrategy;
    data['averageDurationMinutes'] = averageDurationMinutes;
    data['averageInvestment'] = averageInvestment;
    data['averageRelativeInvestment'] = averageRelativeInvestment;
    data['gainPercentAverageInvestment'] = gainPercentAverageInvestment;
    data['positionClosed'] = positionClosed;
    data['uniqueUsersPositionsOpenedCount'] = uniqueUsersPositionsOpenedCount;
    data['totalAmountOpen'] = totalAmountOpen;
    data['bullishAmountOpen'] = bullishAmountOpen;
    data['bearishAmountOpen'] = bearishAmountOpen;
    data['totalAmountClose'] = totalAmountClose;
    data['bullishAmountClose'] = bullishAmountClose;
    data['bearishAmountClose'] = bearishAmountClose;
    data['positionsOpenedCount'] = positionsOpenedCount;
    data['totalTransactionCount'] = totalTransactionCount;
    data['totalTransactionAmount'] = totalTransactionAmount;
    data['bullishTransactionAmount'] = bullishTransactionAmount;
    data['bearishTransactionAmount'] = bearishTransactionAmount;
    data['bullishTransactionQuantity'] = bullishTransactionQuantity;
    data['bearishTransactionQuantity'] = bearishTransactionQuantity;
    data['averageEquityBuyPrice'] = averageEquityBuyPrice;
    data['averageEquitySellPrice'] = averageEquitySellPrice;
    data['totalPutStrike'] = totalPutStrike;
    data['totalPutQuantity'] = totalPutQuantity;
    data['totalCallStrike'] = totalCallStrike;
    data['totalCallQuantity'] = totalCallQuantity;
    data['callOpenOrderCount'] = callOpenOrderCount;
    data['uniqueUserCallOpened'] = uniqueUserCallOpened;
    data['putOpenOrderCount'] = putOpenOrderCount;
    data['uniqueUserPutOpened'] = uniqueUserPutOpened;
    data['equityOpenOrderCount'] = equityOpenOrderCount;
    data['uniqueUserEquityOpened'] = uniqueUserEquityOpened;
    data['callCloseOrderCount'] = callCloseOrderCount;
    data['putCloseOrderCount'] = putCloseOrderCount;
    data['equityCloseOrderCount'] = equityCloseOrderCount;
    data['uniqueUserEquityClosed'] = uniqueUserEquityClosed;
    data['callAmountOpen'] = callAmountOpen;
    data['putAmountOpen'] = putAmountOpen;
    data['equityAmountOpen'] = equityAmountOpen;
    data['callAmountClosed'] = callAmountClosed;
    data['putAmountClosed'] = putAmountClosed;
    data['equityAmountClosed'] = equityAmountClosed;
    data['totalCost'] = totalCost;
    data['averageBuyPrice'] = averageBuyPrice;
    data['averagePutStrike'] = averagePutStrike;
    data['averageCallStrike'] = averageCallStrike;
    data['bullishPositionsOpenedCount'] = bullishPositionsOpenedCount;
    data['bearishPositionsOpenedCount'] = bearishPositionsOpenedCount;
    data['bullishTransactionCount'] = bullishTransactionCount;
    data['bearishTransactionCount'] = bearishTransactionCount;
    data['bullishUserPositionsOpened'] = bullishUserPositionsOpened;
    data['bearishUserPositionsOpened'] = bearishUserPositionsOpened;
    data['usersHoldingBull'] = usersHoldingBull;
    data['usersHoldingBear'] = usersHoldingBear;
    data['positionsClosedCount'] = positionsClosedCount;
    data['bullishPositionsClosedCount'] = bullishPositionsClosedCount;
    data['bearishPositionsClosedCount'] = bearishPositionsClosedCount;
    data['averageCallDTE'] = averageCallDTE;
    data['averagePutDTE'] = averagePutDTE;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TradeAnalysis &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.userKeys, userKeys) ||
                const DeepCollectionEquality()
                    .equals(other.userKeys, userKeys)) &&
            (identical(other.portfolioKeys, portfolioKeys) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKeys, portfolioKeys)) &&
            (identical(other.profitLossTotal, profitLossTotal) ||
                const DeepCollectionEquality()
                    .equals(other.profitLossTotal, profitLossTotal)) &&
            (identical(other.profitLossPercentRelative, profitLossPercentRelative) ||
                const DeepCollectionEquality().equals(
                    other.profitLossPercentRelative,
                    profitLossPercentRelative)) &&
            (identical(other.profitLossPercentPortfolio, profitLossPercentPortfolio) ||
                const DeepCollectionEquality().equals(
                    other.profitLossPercentPortfolio,
                    profitLossPercentPortfolio)) &&
            (identical(other.profitLossPercentTotal, profitLossPercentTotal) ||
                const DeepCollectionEquality().equals(
                    other.profitLossPercentTotal, profitLossPercentTotal)) &&
            (identical(other.transactionCount, transactionCount) ||
                const DeepCollectionEquality()
                    .equals(other.transactionCount, transactionCount)) &&
            (identical(other.closedAt, closedAt) ||
                const DeepCollectionEquality()
                    .equals(other.closedAt, closedAt)) &&
            (identical(other.openedAt, openedAt) ||
                const DeepCollectionEquality()
                    .equals(other.openedAt, openedAt)) &&
            (identical(other.orderStrategies, orderStrategies) ||
                const DeepCollectionEquality()
                    .equals(other.orderStrategies, orderStrategies)) &&
            (identical(other.positionTypes, positionTypes) ||
                const DeepCollectionEquality()
                    .equals(other.positionTypes, positionTypes)) &&
            (identical(other.orderGroupUUIDS, orderGroupUUIDS) ||
                const DeepCollectionEquality()
                    .equals(other.orderGroupUUIDS, orderGroupUUIDS)) &&
            (identical(other.positionEffects, positionEffects) ||
                const DeepCollectionEquality()
                    .equals(other.positionEffects, positionEffects)) &&
            (identical(other.orders, orders) || const DeepCollectionEquality().equals(other.orders, orders)) &&
            (identical(other.portfolios, portfolios) || const DeepCollectionEquality().equals(other.portfolios, portfolios)) &&
            (identical(other.asset, asset) || const DeepCollectionEquality().equals(other.asset, asset)) &&
            (identical(other.optionType, optionType) || const DeepCollectionEquality().equals(other.optionType, optionType)) &&
            (identical(other.positionType, positionType) || const DeepCollectionEquality().equals(other.positionType, positionType)) &&
            (identical(other.orderStrategy, orderStrategy) || const DeepCollectionEquality().equals(other.orderStrategy, orderStrategy)) &&
            (identical(other.averageDurationMinutes, averageDurationMinutes) || const DeepCollectionEquality().equals(other.averageDurationMinutes, averageDurationMinutes)) &&
            (identical(other.averageInvestment, averageInvestment) || const DeepCollectionEquality().equals(other.averageInvestment, averageInvestment)) &&
            (identical(other.averageRelativeInvestment, averageRelativeInvestment) || const DeepCollectionEquality().equals(other.averageRelativeInvestment, averageRelativeInvestment)) &&
            (identical(other.gainPercentAverageInvestment, gainPercentAverageInvestment) || const DeepCollectionEquality().equals(other.gainPercentAverageInvestment, gainPercentAverageInvestment)) &&
            (identical(other.positionClosed, positionClosed) || const DeepCollectionEquality().equals(other.positionClosed, positionClosed)) &&
            (identical(other.uniqueUsersPositionsOpenedCount, uniqueUsersPositionsOpenedCount) || const DeepCollectionEquality().equals(other.uniqueUsersPositionsOpenedCount, uniqueUsersPositionsOpenedCount)) &&
            (identical(other.totalAmountOpen, totalAmountOpen) || const DeepCollectionEquality().equals(other.totalAmountOpen, totalAmountOpen)) &&
            (identical(other.bullishAmountOpen, bullishAmountOpen) || const DeepCollectionEquality().equals(other.bullishAmountOpen, bullishAmountOpen)) &&
            (identical(other.bearishAmountOpen, bearishAmountOpen) || const DeepCollectionEquality().equals(other.bearishAmountOpen, bearishAmountOpen)) &&
            (identical(other.totalAmountClose, totalAmountClose) || const DeepCollectionEquality().equals(other.totalAmountClose, totalAmountClose)) &&
            (identical(other.bullishAmountClose, bullishAmountClose) || const DeepCollectionEquality().equals(other.bullishAmountClose, bullishAmountClose)) &&
            (identical(other.bearishAmountClose, bearishAmountClose) || const DeepCollectionEquality().equals(other.bearishAmountClose, bearishAmountClose)) &&
            (identical(other.positionsOpenedCount, positionsOpenedCount) || const DeepCollectionEquality().equals(other.positionsOpenedCount, positionsOpenedCount)) &&
            (identical(other.totalTransactionCount, totalTransactionCount) || const DeepCollectionEquality().equals(other.totalTransactionCount, totalTransactionCount)) &&
            (identical(other.totalTransactionAmount, totalTransactionAmount) || const DeepCollectionEquality().equals(other.totalTransactionAmount, totalTransactionAmount)) &&
            (identical(other.bullishTransactionAmount, bullishTransactionAmount) || const DeepCollectionEquality().equals(other.bullishTransactionAmount, bullishTransactionAmount)) &&
            (identical(other.bearishTransactionAmount, bearishTransactionAmount) || const DeepCollectionEquality().equals(other.bearishTransactionAmount, bearishTransactionAmount)) &&
            (identical(other.bullishTransactionQuantity, bullishTransactionQuantity) || const DeepCollectionEquality().equals(other.bullishTransactionQuantity, bullishTransactionQuantity)) &&
            (identical(other.bearishTransactionQuantity, bearishTransactionQuantity) || const DeepCollectionEquality().equals(other.bearishTransactionQuantity, bearishTransactionQuantity)) &&
            (identical(other.averageEquityBuyPrice, averageEquityBuyPrice) || const DeepCollectionEquality().equals(other.averageEquityBuyPrice, averageEquityBuyPrice)) &&
            (identical(other.averageEquitySellPrice, averageEquitySellPrice) || const DeepCollectionEquality().equals(other.averageEquitySellPrice, averageEquitySellPrice)) &&
            (identical(other.totalPutStrike, totalPutStrike) || const DeepCollectionEquality().equals(other.totalPutStrike, totalPutStrike)) &&
            (identical(other.totalPutQuantity, totalPutQuantity) || const DeepCollectionEquality().equals(other.totalPutQuantity, totalPutQuantity)) &&
            (identical(other.totalCallStrike, totalCallStrike) || const DeepCollectionEquality().equals(other.totalCallStrike, totalCallStrike)) &&
            (identical(other.totalCallQuantity, totalCallQuantity) || const DeepCollectionEquality().equals(other.totalCallQuantity, totalCallQuantity)) &&
            (identical(other.callOpenOrderCount, callOpenOrderCount) || const DeepCollectionEquality().equals(other.callOpenOrderCount, callOpenOrderCount)) &&
            (identical(other.uniqueUserCallOpened, uniqueUserCallOpened) || const DeepCollectionEquality().equals(other.uniqueUserCallOpened, uniqueUserCallOpened)) &&
            (identical(other.putOpenOrderCount, putOpenOrderCount) || const DeepCollectionEquality().equals(other.putOpenOrderCount, putOpenOrderCount)) &&
            (identical(other.uniqueUserPutOpened, uniqueUserPutOpened) || const DeepCollectionEquality().equals(other.uniqueUserPutOpened, uniqueUserPutOpened)) &&
            (identical(other.equityOpenOrderCount, equityOpenOrderCount) || const DeepCollectionEquality().equals(other.equityOpenOrderCount, equityOpenOrderCount)) &&
            (identical(other.uniqueUserEquityOpened, uniqueUserEquityOpened) || const DeepCollectionEquality().equals(other.uniqueUserEquityOpened, uniqueUserEquityOpened)) &&
            (identical(other.callCloseOrderCount, callCloseOrderCount) || const DeepCollectionEquality().equals(other.callCloseOrderCount, callCloseOrderCount)) &&
            (identical(other.putCloseOrderCount, putCloseOrderCount) || const DeepCollectionEquality().equals(other.putCloseOrderCount, putCloseOrderCount)) &&
            (identical(other.equityCloseOrderCount, equityCloseOrderCount) || const DeepCollectionEquality().equals(other.equityCloseOrderCount, equityCloseOrderCount)) &&
            (identical(other.uniqueUserEquityClosed, uniqueUserEquityClosed) || const DeepCollectionEquality().equals(other.uniqueUserEquityClosed, uniqueUserEquityClosed)) &&
            (identical(other.callAmountOpen, callAmountOpen) || const DeepCollectionEquality().equals(other.callAmountOpen, callAmountOpen)) &&
            (identical(other.putAmountOpen, putAmountOpen) || const DeepCollectionEquality().equals(other.putAmountOpen, putAmountOpen)) &&
            (identical(other.equityAmountOpen, equityAmountOpen) || const DeepCollectionEquality().equals(other.equityAmountOpen, equityAmountOpen)) &&
            (identical(other.callAmountClosed, callAmountClosed) || const DeepCollectionEquality().equals(other.callAmountClosed, callAmountClosed)) &&
            (identical(other.putAmountClosed, putAmountClosed) || const DeepCollectionEquality().equals(other.putAmountClosed, putAmountClosed)) &&
            (identical(other.equityAmountClosed, equityAmountClosed) || const DeepCollectionEquality().equals(other.equityAmountClosed, equityAmountClosed)) &&
            (identical(other.totalCost, totalCost) || const DeepCollectionEquality().equals(other.totalCost, totalCost)) &&
            (identical(other.averageBuyPrice, averageBuyPrice) || const DeepCollectionEquality().equals(other.averageBuyPrice, averageBuyPrice)) &&
            (identical(other.averagePutStrike, averagePutStrike) || const DeepCollectionEquality().equals(other.averagePutStrike, averagePutStrike)) &&
            (identical(other.averageCallStrike, averageCallStrike) || const DeepCollectionEquality().equals(other.averageCallStrike, averageCallStrike)) &&
            (identical(other.bullishPositionsOpenedCount, bullishPositionsOpenedCount) || const DeepCollectionEquality().equals(other.bullishPositionsOpenedCount, bullishPositionsOpenedCount)) &&
            (identical(other.bearishPositionsOpenedCount, bearishPositionsOpenedCount) || const DeepCollectionEquality().equals(other.bearishPositionsOpenedCount, bearishPositionsOpenedCount)) &&
            (identical(other.bullishTransactionCount, bullishTransactionCount) || const DeepCollectionEquality().equals(other.bullishTransactionCount, bullishTransactionCount)) &&
            (identical(other.bearishTransactionCount, bearishTransactionCount) || const DeepCollectionEquality().equals(other.bearishTransactionCount, bearishTransactionCount)) &&
            (identical(other.bullishUserPositionsOpened, bullishUserPositionsOpened) || const DeepCollectionEquality().equals(other.bullishUserPositionsOpened, bullishUserPositionsOpened)) &&
            (identical(other.bearishUserPositionsOpened, bearishUserPositionsOpened) || const DeepCollectionEquality().equals(other.bearishUserPositionsOpened, bearishUserPositionsOpened)) &&
            (identical(other.usersHoldingBull, usersHoldingBull) || const DeepCollectionEquality().equals(other.usersHoldingBull, usersHoldingBull)) &&
            (identical(other.usersHoldingBear, usersHoldingBear) || const DeepCollectionEquality().equals(other.usersHoldingBear, usersHoldingBear)) &&
            (identical(other.positionsClosedCount, positionsClosedCount) || const DeepCollectionEquality().equals(other.positionsClosedCount, positionsClosedCount)) &&
            (identical(other.bullishPositionsClosedCount, bullishPositionsClosedCount) || const DeepCollectionEquality().equals(other.bullishPositionsClosedCount, bullishPositionsClosedCount)) &&
            (identical(other.bearishPositionsClosedCount, bearishPositionsClosedCount) || const DeepCollectionEquality().equals(other.bearishPositionsClosedCount, bearishPositionsClosedCount)) &&
            (identical(other.averageCallDTE, averageCallDTE) || const DeepCollectionEquality().equals(other.averageCallDTE, averageCallDTE)) &&
            (identical(other.averagePutDTE, averagePutDTE) || const DeepCollectionEquality().equals(other.averagePutDTE, averagePutDTE)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(symbol) ^
        const DeepCollectionEquality().hash(userKeys) ^
        const DeepCollectionEquality().hash(portfolioKeys) ^
        const DeepCollectionEquality().hash(profitLossTotal) ^
        const DeepCollectionEquality().hash(profitLossPercentRelative) ^
        const DeepCollectionEquality().hash(profitLossPercentPortfolio) ^
        const DeepCollectionEquality().hash(profitLossPercentTotal) ^
        const DeepCollectionEquality().hash(transactionCount) ^
        const DeepCollectionEquality().hash(closedAt) ^
        const DeepCollectionEquality().hash(openedAt) ^
        const DeepCollectionEquality().hash(orderStrategies) ^
        const DeepCollectionEquality().hash(positionTypes) ^
        const DeepCollectionEquality().hash(orderGroupUUIDS) ^
        const DeepCollectionEquality().hash(positionEffects) ^
        const DeepCollectionEquality().hash(orders) ^
        const DeepCollectionEquality().hash(portfolios) ^
        const DeepCollectionEquality().hash(asset) ^
        const DeepCollectionEquality().hash(optionType) ^
        const DeepCollectionEquality().hash(positionType) ^
        const DeepCollectionEquality().hash(orderStrategy) ^
        const DeepCollectionEquality().hash(averageDurationMinutes) ^
        const DeepCollectionEquality().hash(averageInvestment) ^
        const DeepCollectionEquality().hash(averageRelativeInvestment) ^
        const DeepCollectionEquality().hash(gainPercentAverageInvestment) ^
        const DeepCollectionEquality().hash(positionClosed) ^
        const DeepCollectionEquality().hash(uniqueUsersPositionsOpenedCount) ^
        const DeepCollectionEquality().hash(totalAmountOpen) ^
        const DeepCollectionEquality().hash(bullishAmountOpen) ^
        const DeepCollectionEquality().hash(bearishAmountOpen) ^
        const DeepCollectionEquality().hash(totalAmountClose) ^
        const DeepCollectionEquality().hash(bullishAmountClose) ^
        const DeepCollectionEquality().hash(bearishAmountClose) ^
        const DeepCollectionEquality().hash(positionsOpenedCount) ^
        const DeepCollectionEquality().hash(totalTransactionCount) ^
        const DeepCollectionEquality().hash(totalTransactionAmount) ^
        const DeepCollectionEquality().hash(bullishTransactionAmount) ^
        const DeepCollectionEquality().hash(bearishTransactionAmount) ^
        const DeepCollectionEquality().hash(bullishTransactionQuantity) ^
        const DeepCollectionEquality().hash(bearishTransactionQuantity) ^
        const DeepCollectionEquality().hash(averageEquityBuyPrice) ^
        const DeepCollectionEquality().hash(averageEquitySellPrice) ^
        const DeepCollectionEquality().hash(totalPutStrike) ^
        const DeepCollectionEquality().hash(totalPutQuantity) ^
        const DeepCollectionEquality().hash(totalCallStrike) ^
        const DeepCollectionEquality().hash(totalCallQuantity) ^
        const DeepCollectionEquality().hash(callOpenOrderCount) ^
        const DeepCollectionEquality().hash(uniqueUserCallOpened) ^
        const DeepCollectionEquality().hash(putOpenOrderCount) ^
        const DeepCollectionEquality().hash(uniqueUserPutOpened) ^
        const DeepCollectionEquality().hash(equityOpenOrderCount) ^
        const DeepCollectionEquality().hash(uniqueUserEquityOpened) ^
        const DeepCollectionEquality().hash(callCloseOrderCount) ^
        const DeepCollectionEquality().hash(putCloseOrderCount) ^
        const DeepCollectionEquality().hash(equityCloseOrderCount) ^
        const DeepCollectionEquality().hash(uniqueUserEquityClosed) ^
        const DeepCollectionEquality().hash(callAmountOpen) ^
        const DeepCollectionEquality().hash(putAmountOpen) ^
        const DeepCollectionEquality().hash(equityAmountOpen) ^
        const DeepCollectionEquality().hash(callAmountClosed) ^
        const DeepCollectionEquality().hash(putAmountClosed) ^
        const DeepCollectionEquality().hash(equityAmountClosed) ^
        const DeepCollectionEquality().hash(totalCost) ^
        const DeepCollectionEquality().hash(averageBuyPrice) ^
        const DeepCollectionEquality().hash(averagePutStrike) ^
        const DeepCollectionEquality().hash(averageCallStrike) ^
        const DeepCollectionEquality().hash(bullishPositionsOpenedCount) ^
        const DeepCollectionEquality().hash(bearishPositionsOpenedCount) ^
        const DeepCollectionEquality().hash(bullishTransactionCount) ^
        const DeepCollectionEquality().hash(bearishTransactionCount) ^
        const DeepCollectionEquality().hash(bullishUserPositionsOpened) ^
        const DeepCollectionEquality().hash(bearishUserPositionsOpened) ^
        const DeepCollectionEquality().hash(usersHoldingBull) ^
        const DeepCollectionEquality().hash(usersHoldingBear) ^
        const DeepCollectionEquality().hash(positionsClosedCount) ^
        const DeepCollectionEquality().hash(bullishPositionsClosedCount) ^
        const DeepCollectionEquality().hash(bearishPositionsClosedCount) ^
        const DeepCollectionEquality().hash(averageCallDTE) ^
        const DeepCollectionEquality().hash(averagePutDTE);
  }

  @override
  String toString() => 'TradeAnalysis(${toJson()})';
}
