import 'package:iris_common/data/models/output/asset.dart';
import 'package:iris_common/data/models/enums/order_side.dart';
import 'package:iris_common/data/models/enums/position_type.dart';
import 'package:iris_common/data/models/enums/position_effect.dart';
import 'package:iris_common/data/models/enums/sentiment_type.dart';
import 'package:iris_common/data/models/enums/auto_pilot_order_status.dart';
import 'package:iris_common/data/models/enums/order_state.dart';
import 'package:iris_common/data/models/output/order.dart';
import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class AutoPilotOrder {
  final int? autoPilotOrderKey;
  final int? autoPilotSettingsKey;
  final double? averagePrice;
  final DateTime? placedAt;
  final DateTime? fullfilledAt;
  final DateTime? createdAt;
  final int? assetKey;
  final Asset? asset;
  final String? symbol;
  final String? reason;
  final ORDER_SIDE? orderSide;
  final POSITION_TYPE? positionType;
  final double? strikePrice;
  final double? quantity;
  final double? profitLoss;
  final double? profitLossPercent;
  final POSITION_EFFECT? positionEffect;
  final DateTime? closedAt;
  final DateTime? openedAt;
  final SENTIMENT_TYPE? sentimentType;
  final double? transactionAmount;
  final AUTO_PILOT_ORDER_STATUS? orderStatus;
  final ORDER_STATE? orderState;
  final int? slaveOrderKey;
  final int? slaveUserKey;
  final int? masterUserKey;
  final int? slavePortfolioKey;
  final int? masterPortfolioKey;
  final Order? masterOrder;
  final Portfolio? slavePortfolio;
  final User? masterUser;
  final Portfolio? masterPortfolio;
  final User? slaveUser;
  final Order? slaveOrder;
  const AutoPilotOrder(
      {required this.autoPilotOrderKey,
      required this.autoPilotSettingsKey,
      required this.averagePrice,
      this.placedAt,
      this.fullfilledAt,
      this.createdAt,
      required this.assetKey,
      required this.asset,
      required this.symbol,
      this.reason,
      required this.orderSide,
      required this.positionType,
      this.strikePrice,
      this.quantity,
      this.profitLoss,
      this.profitLossPercent,
      required this.positionEffect,
      this.closedAt,
      this.openedAt,
      required this.sentimentType,
      this.transactionAmount,
      required this.orderStatus,
      this.orderState,
      this.slaveOrderKey,
      required this.slaveUserKey,
      required this.masterUserKey,
      required this.slavePortfolioKey,
      required this.masterPortfolioKey,
      this.masterOrder,
      required this.slavePortfolio,
      required this.masterUser,
      this.masterPortfolio,
      this.slaveUser,
      this.slaveOrder});
  AutoPilotOrder copyWith(
      {int? autoPilotOrderKey,
      int? autoPilotSettingsKey,
      double? averagePrice,
      DateTime? placedAt,
      DateTime? fullfilledAt,
      DateTime? createdAt,
      int? assetKey,
      Asset? asset,
      String? symbol,
      String? reason,
      ORDER_SIDE? orderSide,
      POSITION_TYPE? positionType,
      double? strikePrice,
      double? quantity,
      double? profitLoss,
      double? profitLossPercent,
      POSITION_EFFECT? positionEffect,
      DateTime? closedAt,
      DateTime? openedAt,
      SENTIMENT_TYPE? sentimentType,
      double? transactionAmount,
      AUTO_PILOT_ORDER_STATUS? orderStatus,
      ORDER_STATE? orderState,
      int? slaveOrderKey,
      int? slaveUserKey,
      int? masterUserKey,
      int? slavePortfolioKey,
      int? masterPortfolioKey,
      Order? masterOrder,
      Portfolio? slavePortfolio,
      User? masterUser,
      Portfolio? masterPortfolio,
      User? slaveUser,
      Order? slaveOrder}) {
    return AutoPilotOrder(
      autoPilotOrderKey: autoPilotOrderKey ?? this.autoPilotOrderKey,
      autoPilotSettingsKey: autoPilotSettingsKey ?? this.autoPilotSettingsKey,
      averagePrice: averagePrice ?? this.averagePrice,
      placedAt: placedAt ?? this.placedAt,
      fullfilledAt: fullfilledAt ?? this.fullfilledAt,
      createdAt: createdAt ?? this.createdAt,
      assetKey: assetKey ?? this.assetKey,
      asset: asset ?? this.asset,
      symbol: symbol ?? this.symbol,
      reason: reason ?? this.reason,
      orderSide: orderSide ?? this.orderSide,
      positionType: positionType ?? this.positionType,
      strikePrice: strikePrice ?? this.strikePrice,
      quantity: quantity ?? this.quantity,
      profitLoss: profitLoss ?? this.profitLoss,
      profitLossPercent: profitLossPercent ?? this.profitLossPercent,
      positionEffect: positionEffect ?? this.positionEffect,
      closedAt: closedAt ?? this.closedAt,
      openedAt: openedAt ?? this.openedAt,
      sentimentType: sentimentType ?? this.sentimentType,
      transactionAmount: transactionAmount ?? this.transactionAmount,
      orderStatus: orderStatus ?? this.orderStatus,
      orderState: orderState ?? this.orderState,
      slaveOrderKey: slaveOrderKey ?? this.slaveOrderKey,
      slaveUserKey: slaveUserKey ?? this.slaveUserKey,
      masterUserKey: masterUserKey ?? this.masterUserKey,
      slavePortfolioKey: slavePortfolioKey ?? this.slavePortfolioKey,
      masterPortfolioKey: masterPortfolioKey ?? this.masterPortfolioKey,
      masterOrder: masterOrder ?? this.masterOrder,
      slavePortfolio: slavePortfolio ?? this.slavePortfolio,
      masterUser: masterUser ?? this.masterUser,
      masterPortfolio: masterPortfolio ?? this.masterPortfolio,
      slaveUser: slaveUser ?? this.slaveUser,
      slaveOrder: slaveOrder ?? this.slaveOrder,
    );
  }

  factory AutoPilotOrder.fromJson(Map<String, dynamic> json) {
    return AutoPilotOrder(
      autoPilotOrderKey: json['autoPilotOrderKey'],
      autoPilotSettingsKey: json['autoPilotSettingsKey'],
      averagePrice: json['averagePrice']?.toDouble(),
      placedAt:
          json['placedAt'] != null ? DateTime.parse(json['placedAt']) : null,
      fullfilledAt: json['fullfilledAt'] != null
          ? DateTime.parse(json['fullfilledAt'])
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      assetKey: json['assetKey'],
      asset: json['asset'] != null ? Asset.fromJson(json['asset']) : null,
      symbol: json['symbol'],
      reason: json['reason'],
      orderSide: json['orderSide'] != null
          ? ORDER_SIDE.values.byName(json['orderSide'])
          : null,
      positionType: json['positionType'] != null
          ? POSITION_TYPE.values.byName(json['positionType'])
          : null,
      strikePrice: json['strikePrice']?.toDouble(),
      quantity: json['quantity']?.toDouble(),
      profitLoss: json['profitLoss']?.toDouble(),
      profitLossPercent: json['profitLossPercent']?.toDouble(),
      positionEffect: json['positionEffect'] != null
          ? POSITION_EFFECT.values.byName(json['positionEffect'])
          : null,
      closedAt:
          json['closedAt'] != null ? DateTime.parse(json['closedAt']) : null,
      openedAt:
          json['openedAt'] != null ? DateTime.parse(json['openedAt']) : null,
      sentimentType: json['sentimentType'] != null
          ? SENTIMENT_TYPE.values.byName(json['sentimentType'])
          : null,
      transactionAmount: json['transactionAmount']?.toDouble(),
      orderStatus: json['orderStatus'] != null
          ? AUTO_PILOT_ORDER_STATUS.values.byName(json['orderStatus'])
          : null,
      orderState: json['orderState'] != null
          ? ORDER_STATE.values.byName(json['orderState'])
          : null,
      slaveOrderKey: json['slaveOrderKey'],
      slaveUserKey: json['slaveUserKey'],
      masterUserKey: json['masterUserKey'],
      slavePortfolioKey: json['slavePortfolioKey'],
      masterPortfolioKey: json['masterPortfolioKey'],
      masterOrder: json['masterOrder'] != null
          ? Order.fromJson(json['masterOrder'])
          : null,
      slavePortfolio: json['slavePortfolio'] != null
          ? Portfolio.fromJson(json['slavePortfolio'])
          : null,
      masterUser:
          json['masterUser'] != null ? User.fromJson(json['masterUser']) : null,
      masterPortfolio: json['masterPortfolio'] != null
          ? Portfolio.fromJson(json['masterPortfolio'])
          : null,
      slaveUser:
          json['slaveUser'] != null ? User.fromJson(json['slaveUser']) : null,
      slaveOrder: json['slaveOrder'] != null
          ? Order.fromJson(json['slaveOrder'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotOrderKey'] = autoPilotOrderKey;
    data['autoPilotSettingsKey'] = autoPilotSettingsKey;
    data['averagePrice'] = averagePrice;
    data['placedAt'] = placedAt?.toString();
    data['fullfilledAt'] = fullfilledAt?.toString();
    data['createdAt'] = createdAt?.toString();
    data['assetKey'] = assetKey;
    data['asset'] = asset?.toJson();
    data['symbol'] = symbol;
    data['reason'] = reason;
    data['orderSide'] = orderSide?.name;
    data['positionType'] = positionType?.name;
    data['strikePrice'] = strikePrice;
    data['quantity'] = quantity;
    data['profitLoss'] = profitLoss;
    data['profitLossPercent'] = profitLossPercent;
    data['positionEffect'] = positionEffect?.name;
    data['closedAt'] = closedAt?.toString();
    data['openedAt'] = openedAt?.toString();
    data['sentimentType'] = sentimentType?.name;
    data['transactionAmount'] = transactionAmount;
    data['orderStatus'] = orderStatus?.name;
    data['orderState'] = orderState?.name;
    data['slaveOrderKey'] = slaveOrderKey;
    data['slaveUserKey'] = slaveUserKey;
    data['masterUserKey'] = masterUserKey;
    data['slavePortfolioKey'] = slavePortfolioKey;
    data['masterPortfolioKey'] = masterPortfolioKey;
    data['masterOrder'] = masterOrder?.toJson();
    data['slavePortfolio'] = slavePortfolio?.toJson();
    data['masterUser'] = masterUser?.toJson();
    data['masterPortfolio'] = masterPortfolio?.toJson();
    data['slaveUser'] = slaveUser?.toJson();
    data['slaveOrder'] = slaveOrder?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotOrder &&
            (identical(other.autoPilotOrderKey, autoPilotOrderKey) ||
                const DeepCollectionEquality()
                    .equals(other.autoPilotOrderKey, autoPilotOrderKey)) &&
            (identical(other.autoPilotSettingsKey, autoPilotSettingsKey) ||
                const DeepCollectionEquality().equals(
                    other.autoPilotSettingsKey, autoPilotSettingsKey)) &&
            (identical(other.averagePrice, averagePrice) ||
                const DeepCollectionEquality()
                    .equals(other.averagePrice, averagePrice)) &&
            (identical(other.placedAt, placedAt) ||
                const DeepCollectionEquality()
                    .equals(other.placedAt, placedAt)) &&
            (identical(other.fullfilledAt, fullfilledAt) ||
                const DeepCollectionEquality()
                    .equals(other.fullfilledAt, fullfilledAt)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.assetKey, assetKey) ||
                const DeepCollectionEquality()
                    .equals(other.assetKey, assetKey)) &&
            (identical(other.asset, asset) ||
                const DeepCollectionEquality().equals(other.asset, asset)) &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.reason, reason) ||
                const DeepCollectionEquality().equals(other.reason, reason)) &&
            (identical(other.orderSide, orderSide) ||
                const DeepCollectionEquality()
                    .equals(other.orderSide, orderSide)) &&
            (identical(other.positionType, positionType) ||
                const DeepCollectionEquality()
                    .equals(other.positionType, positionType)) &&
            (identical(other.strikePrice, strikePrice) ||
                const DeepCollectionEquality()
                    .equals(other.strikePrice, strikePrice)) &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality()
                    .equals(other.quantity, quantity)) &&
            (identical(other.profitLoss, profitLoss) ||
                const DeepCollectionEquality()
                    .equals(other.profitLoss, profitLoss)) &&
            (identical(other.profitLossPercent, profitLossPercent) ||
                const DeepCollectionEquality()
                    .equals(other.profitLossPercent, profitLossPercent)) &&
            (identical(other.positionEffect, positionEffect) ||
                const DeepCollectionEquality()
                    .equals(other.positionEffect, positionEffect)) &&
            (identical(other.closedAt, closedAt) ||
                const DeepCollectionEquality()
                    .equals(other.closedAt, closedAt)) &&
            (identical(other.openedAt, openedAt) ||
                const DeepCollectionEquality()
                    .equals(other.openedAt, openedAt)) &&
            (identical(other.sentimentType, sentimentType) ||
                const DeepCollectionEquality()
                    .equals(other.sentimentType, sentimentType)) &&
            (identical(other.transactionAmount, transactionAmount) ||
                const DeepCollectionEquality()
                    .equals(other.transactionAmount, transactionAmount)) &&
            (identical(other.orderStatus, orderStatus) ||
                const DeepCollectionEquality()
                    .equals(other.orderStatus, orderStatus)) &&
            (identical(other.orderState, orderState) ||
                const DeepCollectionEquality()
                    .equals(other.orderState, orderState)) &&
            (identical(other.slaveOrderKey, slaveOrderKey) || const DeepCollectionEquality().equals(other.slaveOrderKey, slaveOrderKey)) &&
            (identical(other.slaveUserKey, slaveUserKey) || const DeepCollectionEquality().equals(other.slaveUserKey, slaveUserKey)) &&
            (identical(other.masterUserKey, masterUserKey) || const DeepCollectionEquality().equals(other.masterUserKey, masterUserKey)) &&
            (identical(other.slavePortfolioKey, slavePortfolioKey) || const DeepCollectionEquality().equals(other.slavePortfolioKey, slavePortfolioKey)) &&
            (identical(other.masterPortfolioKey, masterPortfolioKey) || const DeepCollectionEquality().equals(other.masterPortfolioKey, masterPortfolioKey)) &&
            (identical(other.masterOrder, masterOrder) || const DeepCollectionEquality().equals(other.masterOrder, masterOrder)) &&
            (identical(other.slavePortfolio, slavePortfolio) || const DeepCollectionEquality().equals(other.slavePortfolio, slavePortfolio)) &&
            (identical(other.masterUser, masterUser) || const DeepCollectionEquality().equals(other.masterUser, masterUser)) &&
            (identical(other.masterPortfolio, masterPortfolio) || const DeepCollectionEquality().equals(other.masterPortfolio, masterPortfolio)) &&
            (identical(other.slaveUser, slaveUser) || const DeepCollectionEquality().equals(other.slaveUser, slaveUser)) &&
            (identical(other.slaveOrder, slaveOrder) || const DeepCollectionEquality().equals(other.slaveOrder, slaveOrder)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(autoPilotOrderKey) ^
        const DeepCollectionEquality().hash(autoPilotSettingsKey) ^
        const DeepCollectionEquality().hash(averagePrice) ^
        const DeepCollectionEquality().hash(placedAt) ^
        const DeepCollectionEquality().hash(fullfilledAt) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(assetKey) ^
        const DeepCollectionEquality().hash(asset) ^
        const DeepCollectionEquality().hash(symbol) ^
        const DeepCollectionEquality().hash(reason) ^
        const DeepCollectionEquality().hash(orderSide) ^
        const DeepCollectionEquality().hash(positionType) ^
        const DeepCollectionEquality().hash(strikePrice) ^
        const DeepCollectionEquality().hash(quantity) ^
        const DeepCollectionEquality().hash(profitLoss) ^
        const DeepCollectionEquality().hash(profitLossPercent) ^
        const DeepCollectionEquality().hash(positionEffect) ^
        const DeepCollectionEquality().hash(closedAt) ^
        const DeepCollectionEquality().hash(openedAt) ^
        const DeepCollectionEquality().hash(sentimentType) ^
        const DeepCollectionEquality().hash(transactionAmount) ^
        const DeepCollectionEquality().hash(orderStatus) ^
        const DeepCollectionEquality().hash(orderState) ^
        const DeepCollectionEquality().hash(slaveOrderKey) ^
        const DeepCollectionEquality().hash(slaveUserKey) ^
        const DeepCollectionEquality().hash(masterUserKey) ^
        const DeepCollectionEquality().hash(slavePortfolioKey) ^
        const DeepCollectionEquality().hash(masterPortfolioKey) ^
        const DeepCollectionEquality().hash(masterOrder) ^
        const DeepCollectionEquality().hash(slavePortfolio) ^
        const DeepCollectionEquality().hash(masterUser) ^
        const DeepCollectionEquality().hash(masterPortfolio) ^
        const DeepCollectionEquality().hash(slaveUser) ^
        const DeepCollectionEquality().hash(slaveOrder);
  }

  @override
  String toString() => 'AutoPilotOrder(${toJson()})';
}
