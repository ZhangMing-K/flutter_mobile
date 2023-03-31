import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/output/asset.dart';
import 'package:iris_common/data/models/enums/order_side.dart';
import 'package:iris_common/data/models/enums/order_type.dart';
import 'package:iris_common/data/models/enums/option_type.dart';
import 'package:iris_common/data/models/enums/position_type.dart';
import 'package:iris_common/data/models/output/text_model.dart';
import 'package:iris_common/data/models/enums/position_effect.dart';
import 'package:iris_common/data/models/output/auto_pilot_order.dart';
import 'package:iris_common/data/models/enums/sentiment_type.dart';
import 'package:iris_common/data/models/output/daily_asset_trade_statistics.dart';
import 'package:collection/collection.dart';

class Order {
  final int? orderKey;
  final int? userKey;
  final User? user;
  final int? portfolioKey;
  final Portfolio? portfolio;
  final double? averagePrice;
  final double? averageBuyPrice;
  final double? averageSellPrice;
  final DateTime? placedAt;
  final DateTime? fullfilledAt;
  final DateTime? fullfulledAt;
  final int? assetKey;
  final Asset? asset;
  final String? symbol;
  final ORDER_SIDE? orderSide;
  final ORDER_TYPE? orderType;
  final OPTION_TYPE? optionType;
  final POSITION_TYPE? positionType;
  final DateTime? expirationDate;
  final double? strikePrice;
  final TextModel? text;
  final double? profitLoss;
  final double? profitLossPercent;
  final double? portfolioAllocation;
  final String? orderStrategy;
  final String? strategyType;
  final String? optionLegGroupId;
  final POSITION_EFFECT? positionEffect;
  final String? orderGroupUUID;
  final DateTime? closedAt;
  final DateTime? openedAt;
  final AutoPilotOrder? autoPilotOrder;
  final int? autoPilotOrderKey;
  final int? nbrAutoPiloted;
  final SENTIMENT_TYPE? sentimentType;
  final double? transactionAmount;
  final int? linkedTradesCount;
  final DailyAssetTradeStatistics? dailyAssetTradeStatistics;
  const Order(
      {this.orderKey,
      this.userKey,
      this.user,
      this.portfolioKey,
      this.portfolio,
      this.averagePrice,
      this.averageBuyPrice,
      this.averageSellPrice,
      this.placedAt,
      this.fullfilledAt,
      this.fullfulledAt,
      this.assetKey,
      this.asset,
      this.symbol,
      this.orderSide,
      this.orderType,
      this.optionType,
      this.positionType,
      this.expirationDate,
      this.strikePrice,
      this.text,
      this.profitLoss,
      this.profitLossPercent,
      this.portfolioAllocation,
      this.orderStrategy,
      this.strategyType,
      this.optionLegGroupId,
      this.positionEffect,
      this.orderGroupUUID,
      this.closedAt,
      this.openedAt,
      this.autoPilotOrder,
      this.autoPilotOrderKey,
      this.nbrAutoPiloted,
      this.sentimentType,
      this.transactionAmount,
      this.linkedTradesCount,
      this.dailyAssetTradeStatistics});
  Order copyWith(
      {int? orderKey,
      int? userKey,
      User? user,
      int? portfolioKey,
      Portfolio? portfolio,
      double? averagePrice,
      double? averageBuyPrice,
      double? averageSellPrice,
      DateTime? placedAt,
      DateTime? fullfilledAt,
      DateTime? fullfulledAt,
      int? assetKey,
      Asset? asset,
      String? symbol,
      ORDER_SIDE? orderSide,
      ORDER_TYPE? orderType,
      OPTION_TYPE? optionType,
      POSITION_TYPE? positionType,
      DateTime? expirationDate,
      double? strikePrice,
      TextModel? text,
      double? profitLoss,
      double? profitLossPercent,
      double? portfolioAllocation,
      String? orderStrategy,
      String? strategyType,
      String? optionLegGroupId,
      POSITION_EFFECT? positionEffect,
      String? orderGroupUUID,
      DateTime? closedAt,
      DateTime? openedAt,
      AutoPilotOrder? autoPilotOrder,
      int? autoPilotOrderKey,
      int? nbrAutoPiloted,
      SENTIMENT_TYPE? sentimentType,
      double? transactionAmount,
      int? linkedTradesCount,
      DailyAssetTradeStatistics? dailyAssetTradeStatistics}) {
    return Order(
      orderKey: orderKey ?? this.orderKey,
      userKey: userKey ?? this.userKey,
      user: user ?? this.user,
      portfolioKey: portfolioKey ?? this.portfolioKey,
      portfolio: portfolio ?? this.portfolio,
      averagePrice: averagePrice ?? this.averagePrice,
      averageBuyPrice: averageBuyPrice ?? this.averageBuyPrice,
      averageSellPrice: averageSellPrice ?? this.averageSellPrice,
      placedAt: placedAt ?? this.placedAt,
      fullfilledAt: fullfilledAt ?? this.fullfilledAt,
      fullfulledAt: fullfulledAt ?? this.fullfulledAt,
      assetKey: assetKey ?? this.assetKey,
      asset: asset ?? this.asset,
      symbol: symbol ?? this.symbol,
      orderSide: orderSide ?? this.orderSide,
      orderType: orderType ?? this.orderType,
      optionType: optionType ?? this.optionType,
      positionType: positionType ?? this.positionType,
      expirationDate: expirationDate ?? this.expirationDate,
      strikePrice: strikePrice ?? this.strikePrice,
      text: text ?? this.text,
      profitLoss: profitLoss ?? this.profitLoss,
      profitLossPercent: profitLossPercent ?? this.profitLossPercent,
      portfolioAllocation: portfolioAllocation ?? this.portfolioAllocation,
      orderStrategy: orderStrategy ?? this.orderStrategy,
      strategyType: strategyType ?? this.strategyType,
      optionLegGroupId: optionLegGroupId ?? this.optionLegGroupId,
      positionEffect: positionEffect ?? this.positionEffect,
      orderGroupUUID: orderGroupUUID ?? this.orderGroupUUID,
      closedAt: closedAt ?? this.closedAt,
      openedAt: openedAt ?? this.openedAt,
      autoPilotOrder: autoPilotOrder ?? this.autoPilotOrder,
      autoPilotOrderKey: autoPilotOrderKey ?? this.autoPilotOrderKey,
      nbrAutoPiloted: nbrAutoPiloted ?? this.nbrAutoPiloted,
      sentimentType: sentimentType ?? this.sentimentType,
      transactionAmount: transactionAmount ?? this.transactionAmount,
      linkedTradesCount: linkedTradesCount ?? this.linkedTradesCount,
      dailyAssetTradeStatistics:
          dailyAssetTradeStatistics ?? this.dailyAssetTradeStatistics,
    );
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderKey: json['orderKey'],
      userKey: json['userKey'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      portfolioKey: json['portfolioKey'],
      portfolio: json['portfolio'] != null
          ? Portfolio.fromJson(json['portfolio'])
          : null,
      averagePrice: json['averagePrice']?.toDouble(),
      averageBuyPrice: json['averageBuyPrice']?.toDouble(),
      averageSellPrice: json['averageSellPrice']?.toDouble(),
      placedAt:
          json['placedAt'] != null ? DateTime.parse(json['placedAt']) : null,
      fullfilledAt: json['fullfilledAt'] != null
          ? DateTime.parse(json['fullfilledAt'])
          : null,
      fullfulledAt: json['fullfulledAt'] != null
          ? DateTime.parse(json['fullfulledAt'])
          : null,
      assetKey: json['assetKey'],
      asset: json['asset'] != null ? Asset.fromJson(json['asset']) : null,
      symbol: json['symbol'],
      orderSide: json['orderSide'] != null
          ? ORDER_SIDE.values.byName(json['orderSide'])
          : null,
      orderType: json['orderType'] != null
          ? ORDER_TYPE.values.byName(json['orderType'])
          : null,
      optionType: json['optionType'] != null
          ? OPTION_TYPE.values.byName(json['optionType'])
          : null,
      positionType: json['positionType'] != null
          ? POSITION_TYPE.values.byName(json['positionType'])
          : null,
      expirationDate: json['expirationDate'] != null
          ? DateTime.parse(json['expirationDate'])
          : null,
      strikePrice: json['strikePrice']?.toDouble(),
      text: json['text'] != null ? TextModel.fromJson(json['text']) : null,
      profitLoss: json['profitLoss']?.toDouble(),
      profitLossPercent: json['profitLossPercent']?.toDouble(),
      portfolioAllocation: json['portfolioAllocation']?.toDouble(),
      orderStrategy: json['orderStrategy'],
      strategyType: json['strategyType'],
      optionLegGroupId: json['optionLegGroupId'],
      positionEffect: json['positionEffect'] != null
          ? POSITION_EFFECT.values.byName(json['positionEffect'])
          : null,
      orderGroupUUID: json['orderGroupUUID'],
      closedAt:
          json['closedAt'] != null ? DateTime.parse(json['closedAt']) : null,
      openedAt:
          json['openedAt'] != null ? DateTime.parse(json['openedAt']) : null,
      autoPilotOrder: json['autoPilotOrder'] != null
          ? AutoPilotOrder.fromJson(json['autoPilotOrder'])
          : null,
      autoPilotOrderKey: json['autoPilotOrderKey'],
      nbrAutoPiloted: json['nbrAutoPiloted'],
      sentimentType: json['sentimentType'] != null
          ? SENTIMENT_TYPE.values.byName(json['sentimentType'])
          : null,
      transactionAmount: json['transactionAmount']?.toDouble(),
      linkedTradesCount: json['linkedTradesCount'],
      dailyAssetTradeStatistics: json['dailyAssetTradeStatistics'] != null
          ? DailyAssetTradeStatistics.fromJson(
              json['dailyAssetTradeStatistics'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['orderKey'] = orderKey;
    data['userKey'] = userKey;
    data['user'] = user?.toJson();
    data['portfolioKey'] = portfolioKey;
    data['portfolio'] = portfolio?.toJson();
    data['averagePrice'] = averagePrice;
    data['averageBuyPrice'] = averageBuyPrice;
    data['averageSellPrice'] = averageSellPrice;
    data['placedAt'] = placedAt?.toString();
    data['fullfilledAt'] = fullfilledAt?.toString();
    data['fullfulledAt'] = fullfulledAt?.toString();
    data['assetKey'] = assetKey;
    data['asset'] = asset?.toJson();
    data['symbol'] = symbol;
    data['orderSide'] = orderSide?.name;
    data['orderType'] = orderType?.name;
    data['optionType'] = optionType?.name;
    data['positionType'] = positionType?.name;
    data['expirationDate'] = expirationDate?.toString();
    data['strikePrice'] = strikePrice;
    data['text'] = text?.toJson();
    data['profitLoss'] = profitLoss;
    data['profitLossPercent'] = profitLossPercent;
    data['portfolioAllocation'] = portfolioAllocation;
    data['orderStrategy'] = orderStrategy;
    data['strategyType'] = strategyType;
    data['optionLegGroupId'] = optionLegGroupId;
    data['positionEffect'] = positionEffect?.name;
    data['orderGroupUUID'] = orderGroupUUID;
    data['closedAt'] = closedAt?.toString();
    data['openedAt'] = openedAt?.toString();
    data['autoPilotOrder'] = autoPilotOrder?.toJson();
    data['autoPilotOrderKey'] = autoPilotOrderKey;
    data['nbrAutoPiloted'] = nbrAutoPiloted;
    data['sentimentType'] = sentimentType?.name;
    data['transactionAmount'] = transactionAmount;
    data['linkedTradesCount'] = linkedTradesCount;
    data['dailyAssetTradeStatistics'] = dailyAssetTradeStatistics?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Order &&
            (identical(other.orderKey, orderKey) ||
                const DeepCollectionEquality()
                    .equals(other.orderKey, orderKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.portfolio, portfolio) ||
                const DeepCollectionEquality()
                    .equals(other.portfolio, portfolio)) &&
            (identical(other.averagePrice, averagePrice) ||
                const DeepCollectionEquality()
                    .equals(other.averagePrice, averagePrice)) &&
            (identical(other.averageBuyPrice, averageBuyPrice) ||
                const DeepCollectionEquality()
                    .equals(other.averageBuyPrice, averageBuyPrice)) &&
            (identical(other.averageSellPrice, averageSellPrice) ||
                const DeepCollectionEquality()
                    .equals(other.averageSellPrice, averageSellPrice)) &&
            (identical(other.placedAt, placedAt) ||
                const DeepCollectionEquality()
                    .equals(other.placedAt, placedAt)) &&
            (identical(other.fullfilledAt, fullfilledAt) ||
                const DeepCollectionEquality()
                    .equals(other.fullfilledAt, fullfilledAt)) &&
            (identical(other.fullfulledAt, fullfulledAt) ||
                const DeepCollectionEquality()
                    .equals(other.fullfulledAt, fullfulledAt)) &&
            (identical(other.assetKey, assetKey) ||
                const DeepCollectionEquality()
                    .equals(other.assetKey, assetKey)) &&
            (identical(other.asset, asset) ||
                const DeepCollectionEquality().equals(other.asset, asset)) &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.orderSide, orderSide) ||
                const DeepCollectionEquality()
                    .equals(other.orderSide, orderSide)) &&
            (identical(other.orderType, orderType) ||
                const DeepCollectionEquality()
                    .equals(other.orderType, orderType)) &&
            (identical(other.optionType, optionType) ||
                const DeepCollectionEquality()
                    .equals(other.optionType, optionType)) &&
            (identical(other.positionType, positionType) ||
                const DeepCollectionEquality()
                    .equals(other.positionType, positionType)) &&
            (identical(other.expirationDate, expirationDate) ||
                const DeepCollectionEquality()
                    .equals(other.expirationDate, expirationDate)) &&
            (identical(other.strikePrice, strikePrice) ||
                const DeepCollectionEquality()
                    .equals(other.strikePrice, strikePrice)) &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)) &&
            (identical(other.profitLoss, profitLoss) ||
                const DeepCollectionEquality()
                    .equals(other.profitLoss, profitLoss)) &&
            (identical(other.profitLossPercent, profitLossPercent) ||
                const DeepCollectionEquality()
                    .equals(other.profitLossPercent, profitLossPercent)) &&
            (identical(other.portfolioAllocation, portfolioAllocation) ||
                const DeepCollectionEquality().equals(other.portfolioAllocation, portfolioAllocation)) &&
            (identical(other.orderStrategy, orderStrategy) || const DeepCollectionEquality().equals(other.orderStrategy, orderStrategy)) &&
            (identical(other.strategyType, strategyType) || const DeepCollectionEquality().equals(other.strategyType, strategyType)) &&
            (identical(other.optionLegGroupId, optionLegGroupId) || const DeepCollectionEquality().equals(other.optionLegGroupId, optionLegGroupId)) &&
            (identical(other.positionEffect, positionEffect) || const DeepCollectionEquality().equals(other.positionEffect, positionEffect)) &&
            (identical(other.orderGroupUUID, orderGroupUUID) || const DeepCollectionEquality().equals(other.orderGroupUUID, orderGroupUUID)) &&
            (identical(other.closedAt, closedAt) || const DeepCollectionEquality().equals(other.closedAt, closedAt)) &&
            (identical(other.openedAt, openedAt) || const DeepCollectionEquality().equals(other.openedAt, openedAt)) &&
            (identical(other.autoPilotOrder, autoPilotOrder) || const DeepCollectionEquality().equals(other.autoPilotOrder, autoPilotOrder)) &&
            (identical(other.autoPilotOrderKey, autoPilotOrderKey) || const DeepCollectionEquality().equals(other.autoPilotOrderKey, autoPilotOrderKey)) &&
            (identical(other.nbrAutoPiloted, nbrAutoPiloted) || const DeepCollectionEquality().equals(other.nbrAutoPiloted, nbrAutoPiloted)) &&
            (identical(other.sentimentType, sentimentType) || const DeepCollectionEquality().equals(other.sentimentType, sentimentType)) &&
            (identical(other.transactionAmount, transactionAmount) || const DeepCollectionEquality().equals(other.transactionAmount, transactionAmount)) &&
            (identical(other.linkedTradesCount, linkedTradesCount) || const DeepCollectionEquality().equals(other.linkedTradesCount, linkedTradesCount)) &&
            (identical(other.dailyAssetTradeStatistics, dailyAssetTradeStatistics) || const DeepCollectionEquality().equals(other.dailyAssetTradeStatistics, dailyAssetTradeStatistics)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(orderKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(portfolio) ^
        const DeepCollectionEquality().hash(averagePrice) ^
        const DeepCollectionEquality().hash(averageBuyPrice) ^
        const DeepCollectionEquality().hash(averageSellPrice) ^
        const DeepCollectionEquality().hash(placedAt) ^
        const DeepCollectionEquality().hash(fullfilledAt) ^
        const DeepCollectionEquality().hash(fullfulledAt) ^
        const DeepCollectionEquality().hash(assetKey) ^
        const DeepCollectionEquality().hash(asset) ^
        const DeepCollectionEquality().hash(symbol) ^
        const DeepCollectionEquality().hash(orderSide) ^
        const DeepCollectionEquality().hash(orderType) ^
        const DeepCollectionEquality().hash(optionType) ^
        const DeepCollectionEquality().hash(positionType) ^
        const DeepCollectionEquality().hash(expirationDate) ^
        const DeepCollectionEquality().hash(strikePrice) ^
        const DeepCollectionEquality().hash(text) ^
        const DeepCollectionEquality().hash(profitLoss) ^
        const DeepCollectionEquality().hash(profitLossPercent) ^
        const DeepCollectionEquality().hash(portfolioAllocation) ^
        const DeepCollectionEquality().hash(orderStrategy) ^
        const DeepCollectionEquality().hash(strategyType) ^
        const DeepCollectionEquality().hash(optionLegGroupId) ^
        const DeepCollectionEquality().hash(positionEffect) ^
        const DeepCollectionEquality().hash(orderGroupUUID) ^
        const DeepCollectionEquality().hash(closedAt) ^
        const DeepCollectionEquality().hash(openedAt) ^
        const DeepCollectionEquality().hash(autoPilotOrder) ^
        const DeepCollectionEquality().hash(autoPilotOrderKey) ^
        const DeepCollectionEquality().hash(nbrAutoPiloted) ^
        const DeepCollectionEquality().hash(sentimentType) ^
        const DeepCollectionEquality().hash(transactionAmount) ^
        const DeepCollectionEquality().hash(linkedTradesCount) ^
        const DeepCollectionEquality().hash(dailyAssetTradeStatistics);
  }

  @override
  String toString() => 'Order(${toJson()})';
}
