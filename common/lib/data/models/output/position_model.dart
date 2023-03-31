import 'package:iris_common/data/models/output/stock.dart';
import 'package:iris_common/data/models/enums/position_type.dart';
import 'package:iris_common/data/models/enums/option_type.dart';
import 'package:iris_common/data/models/output/historical.dart';
import 'package:iris_common/data/models/output/option_info.dart';
import 'package:iris_common/data/models/output/asset.dart';
import 'package:collection/collection.dart';

class PositionModel {
  final String? symbol;
  final String? stockName;
  final Stock? stock;
  final double? averageBuyPrice;
  final double? currentPrice;
  final double? todayReturnAmount;
  final double? todayReturnPercentage;
  final double? returnAmount;
  final double? returnPercentage;
  final int? quantity;
  final int? totalValue;
  final POSITION_TYPE? positionType;
  final OPTION_TYPE? optionType;
  final double? percentOfPortfolio;
  final double? percentOfPositions;
  final Historical? historical;
  final OptionInfo? optionInfo;
  final String? orderGroupUUID;
  final Asset? asset;
  const PositionModel(
      {this.symbol,
      this.stockName,
      this.stock,
      this.averageBuyPrice,
      this.currentPrice,
      this.todayReturnAmount,
      this.todayReturnPercentage,
      this.returnAmount,
      this.returnPercentage,
      this.quantity,
      this.totalValue,
      this.positionType,
      this.optionType,
      this.percentOfPortfolio,
      this.percentOfPositions,
      this.historical,
      this.optionInfo,
      this.orderGroupUUID,
      this.asset});
  PositionModel copyWith(
      {String? symbol,
      String? stockName,
      Stock? stock,
      double? averageBuyPrice,
      double? currentPrice,
      double? todayReturnAmount,
      double? todayReturnPercentage,
      double? returnAmount,
      double? returnPercentage,
      int? quantity,
      int? totalValue,
      POSITION_TYPE? positionType,
      OPTION_TYPE? optionType,
      double? percentOfPortfolio,
      double? percentOfPositions,
      Historical? historical,
      OptionInfo? optionInfo,
      String? orderGroupUUID,
      Asset? asset}) {
    return PositionModel(
      symbol: symbol ?? this.symbol,
      stockName: stockName ?? this.stockName,
      stock: stock ?? this.stock,
      averageBuyPrice: averageBuyPrice ?? this.averageBuyPrice,
      currentPrice: currentPrice ?? this.currentPrice,
      todayReturnAmount: todayReturnAmount ?? this.todayReturnAmount,
      todayReturnPercentage:
          todayReturnPercentage ?? this.todayReturnPercentage,
      returnAmount: returnAmount ?? this.returnAmount,
      returnPercentage: returnPercentage ?? this.returnPercentage,
      quantity: quantity ?? this.quantity,
      totalValue: totalValue ?? this.totalValue,
      positionType: positionType ?? this.positionType,
      optionType: optionType ?? this.optionType,
      percentOfPortfolio: percentOfPortfolio ?? this.percentOfPortfolio,
      percentOfPositions: percentOfPositions ?? this.percentOfPositions,
      historical: historical ?? this.historical,
      optionInfo: optionInfo ?? this.optionInfo,
      orderGroupUUID: orderGroupUUID ?? this.orderGroupUUID,
      asset: asset ?? this.asset,
    );
  }

  factory PositionModel.fromJson(Map<String, dynamic> json) {
    return PositionModel(
      symbol: json['symbol'],
      stockName: json['stockName'],
      stock: json['stock'] != null ? Stock.fromJson(json['stock']) : null,
      averageBuyPrice: json['averageBuyPrice']?.toDouble(),
      currentPrice: json['currentPrice']?.toDouble(),
      todayReturnAmount: json['todayReturnAmount']?.toDouble(),
      todayReturnPercentage: json['todayReturnPercentage']?.toDouble(),
      returnAmount: json['returnAmount']?.toDouble(),
      returnPercentage: json['returnPercentage']?.toDouble(),
      quantity: json['quantity'],
      totalValue: json['totalValue'],
      positionType: json['positionType'] != null
          ? POSITION_TYPE.values.byName(json['positionType'])
          : null,
      optionType: json['optionType'] != null
          ? OPTION_TYPE.values.byName(json['optionType'])
          : null,
      percentOfPortfolio: json['percentOfPortfolio']?.toDouble(),
      percentOfPositions: json['percentOfPositions']?.toDouble(),
      historical: json['historical'] != null
          ? Historical.fromJson(json['historical'])
          : null,
      optionInfo: json['optionInfo'] != null
          ? OptionInfo.fromJson(json['optionInfo'])
          : null,
      orderGroupUUID: json['orderGroupUUID'],
      asset: json['asset'] != null ? Asset.fromJson(json['asset']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['stockName'] = stockName;
    data['stock'] = stock?.toJson();
    data['averageBuyPrice'] = averageBuyPrice;
    data['currentPrice'] = currentPrice;
    data['todayReturnAmount'] = todayReturnAmount;
    data['todayReturnPercentage'] = todayReturnPercentage;
    data['returnAmount'] = returnAmount;
    data['returnPercentage'] = returnPercentage;
    data['quantity'] = quantity;
    data['totalValue'] = totalValue;
    data['positionType'] = positionType?.name;
    data['optionType'] = optionType?.name;
    data['percentOfPortfolio'] = percentOfPortfolio;
    data['percentOfPositions'] = percentOfPositions;
    data['historical'] = historical?.toJson();
    data['optionInfo'] = optionInfo?.toJson();
    data['orderGroupUUID'] = orderGroupUUID;
    data['asset'] = asset?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PositionModel &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.stockName, stockName) ||
                const DeepCollectionEquality()
                    .equals(other.stockName, stockName)) &&
            (identical(other.stock, stock) ||
                const DeepCollectionEquality().equals(other.stock, stock)) &&
            (identical(other.averageBuyPrice, averageBuyPrice) ||
                const DeepCollectionEquality()
                    .equals(other.averageBuyPrice, averageBuyPrice)) &&
            (identical(other.currentPrice, currentPrice) ||
                const DeepCollectionEquality()
                    .equals(other.currentPrice, currentPrice)) &&
            (identical(other.todayReturnAmount, todayReturnAmount) ||
                const DeepCollectionEquality()
                    .equals(other.todayReturnAmount, todayReturnAmount)) &&
            (identical(other.todayReturnPercentage, todayReturnPercentage) ||
                const DeepCollectionEquality().equals(
                    other.todayReturnPercentage, todayReturnPercentage)) &&
            (identical(other.returnAmount, returnAmount) ||
                const DeepCollectionEquality()
                    .equals(other.returnAmount, returnAmount)) &&
            (identical(other.returnPercentage, returnPercentage) ||
                const DeepCollectionEquality()
                    .equals(other.returnPercentage, returnPercentage)) &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality()
                    .equals(other.quantity, quantity)) &&
            (identical(other.totalValue, totalValue) ||
                const DeepCollectionEquality()
                    .equals(other.totalValue, totalValue)) &&
            (identical(other.positionType, positionType) ||
                const DeepCollectionEquality()
                    .equals(other.positionType, positionType)) &&
            (identical(other.optionType, optionType) ||
                const DeepCollectionEquality()
                    .equals(other.optionType, optionType)) &&
            (identical(other.percentOfPortfolio, percentOfPortfolio) ||
                const DeepCollectionEquality()
                    .equals(other.percentOfPortfolio, percentOfPortfolio)) &&
            (identical(other.percentOfPositions, percentOfPositions) ||
                const DeepCollectionEquality()
                    .equals(other.percentOfPositions, percentOfPositions)) &&
            (identical(other.historical, historical) ||
                const DeepCollectionEquality()
                    .equals(other.historical, historical)) &&
            (identical(other.optionInfo, optionInfo) ||
                const DeepCollectionEquality()
                    .equals(other.optionInfo, optionInfo)) &&
            (identical(other.orderGroupUUID, orderGroupUUID) ||
                const DeepCollectionEquality()
                    .equals(other.orderGroupUUID, orderGroupUUID)) &&
            (identical(other.asset, asset) ||
                const DeepCollectionEquality().equals(other.asset, asset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(symbol) ^
        const DeepCollectionEquality().hash(stockName) ^
        const DeepCollectionEquality().hash(stock) ^
        const DeepCollectionEquality().hash(averageBuyPrice) ^
        const DeepCollectionEquality().hash(currentPrice) ^
        const DeepCollectionEquality().hash(todayReturnAmount) ^
        const DeepCollectionEquality().hash(todayReturnPercentage) ^
        const DeepCollectionEquality().hash(returnAmount) ^
        const DeepCollectionEquality().hash(returnPercentage) ^
        const DeepCollectionEquality().hash(quantity) ^
        const DeepCollectionEquality().hash(totalValue) ^
        const DeepCollectionEquality().hash(positionType) ^
        const DeepCollectionEquality().hash(optionType) ^
        const DeepCollectionEquality().hash(percentOfPortfolio) ^
        const DeepCollectionEquality().hash(percentOfPositions) ^
        const DeepCollectionEquality().hash(historical) ^
        const DeepCollectionEquality().hash(optionInfo) ^
        const DeepCollectionEquality().hash(orderGroupUUID) ^
        const DeepCollectionEquality().hash(asset);
  }

  @override
  String toString() => 'PositionModel(${toJson()})';
}
