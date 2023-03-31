import 'package:iris_common/data/models/enums/position_effect.dart';
import 'package:iris_common/data/models/enums/order_side.dart';
import 'package:iris_common/data/models/output/asset.dart';
import 'package:collection/collection.dart';

class AutoPilotOrderPreview {
  final double? price;
  final double? quantity;
  final POSITION_EFFECT? positionEffect;
  final double? transactionAmount;
  final ORDER_SIDE? orderSide;
  final double? allocationPercent;
  final String? symbol;
  final int? assetKey;
  final Asset? asset;
  final bool? fractionalsAvailable;
  const AutoPilotOrderPreview(
      {required this.price,
      required this.quantity,
      required this.positionEffect,
      required this.transactionAmount,
      required this.orderSide,
      required this.allocationPercent,
      required this.symbol,
      this.assetKey,
      this.asset,
      required this.fractionalsAvailable});
  AutoPilotOrderPreview copyWith(
      {double? price,
      double? quantity,
      POSITION_EFFECT? positionEffect,
      double? transactionAmount,
      ORDER_SIDE? orderSide,
      double? allocationPercent,
      String? symbol,
      int? assetKey,
      Asset? asset,
      bool? fractionalsAvailable}) {
    return AutoPilotOrderPreview(
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      positionEffect: positionEffect ?? this.positionEffect,
      transactionAmount: transactionAmount ?? this.transactionAmount,
      orderSide: orderSide ?? this.orderSide,
      allocationPercent: allocationPercent ?? this.allocationPercent,
      symbol: symbol ?? this.symbol,
      assetKey: assetKey ?? this.assetKey,
      asset: asset ?? this.asset,
      fractionalsAvailable: fractionalsAvailable ?? this.fractionalsAvailable,
    );
  }

  factory AutoPilotOrderPreview.fromJson(Map<String, dynamic> json) {
    return AutoPilotOrderPreview(
      price: json['price']?.toDouble(),
      quantity: json['quantity']?.toDouble(),
      positionEffect: json['positionEffect'] != null
          ? POSITION_EFFECT.values.byName(json['positionEffect'])
          : null,
      transactionAmount: json['transactionAmount']?.toDouble(),
      orderSide: json['orderSide'] != null
          ? ORDER_SIDE.values.byName(json['orderSide'])
          : null,
      allocationPercent: json['allocationPercent']?.toDouble(),
      symbol: json['symbol'],
      assetKey: json['assetKey'],
      asset: json['asset'] != null ? Asset.fromJson(json['asset']) : null,
      fractionalsAvailable: json['fractionalsAvailable'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['price'] = price;
    data['quantity'] = quantity;
    data['positionEffect'] = positionEffect?.name;
    data['transactionAmount'] = transactionAmount;
    data['orderSide'] = orderSide?.name;
    data['allocationPercent'] = allocationPercent;
    data['symbol'] = symbol;
    data['assetKey'] = assetKey;
    data['asset'] = asset?.toJson();
    data['fractionalsAvailable'] = fractionalsAvailable;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotOrderPreview &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality()
                    .equals(other.quantity, quantity)) &&
            (identical(other.positionEffect, positionEffect) ||
                const DeepCollectionEquality()
                    .equals(other.positionEffect, positionEffect)) &&
            (identical(other.transactionAmount, transactionAmount) ||
                const DeepCollectionEquality()
                    .equals(other.transactionAmount, transactionAmount)) &&
            (identical(other.orderSide, orderSide) ||
                const DeepCollectionEquality()
                    .equals(other.orderSide, orderSide)) &&
            (identical(other.allocationPercent, allocationPercent) ||
                const DeepCollectionEquality()
                    .equals(other.allocationPercent, allocationPercent)) &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.assetKey, assetKey) ||
                const DeepCollectionEquality()
                    .equals(other.assetKey, assetKey)) &&
            (identical(other.asset, asset) ||
                const DeepCollectionEquality().equals(other.asset, asset)) &&
            (identical(other.fractionalsAvailable, fractionalsAvailable) ||
                const DeepCollectionEquality()
                    .equals(other.fractionalsAvailable, fractionalsAvailable)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(price) ^
        const DeepCollectionEquality().hash(quantity) ^
        const DeepCollectionEquality().hash(positionEffect) ^
        const DeepCollectionEquality().hash(transactionAmount) ^
        const DeepCollectionEquality().hash(orderSide) ^
        const DeepCollectionEquality().hash(allocationPercent) ^
        const DeepCollectionEquality().hash(symbol) ^
        const DeepCollectionEquality().hash(assetKey) ^
        const DeepCollectionEquality().hash(asset) ^
        const DeepCollectionEquality().hash(fractionalsAvailable);
  }

  @override
  String toString() => 'AutoPilotOrderPreview(${toJson()})';
}
