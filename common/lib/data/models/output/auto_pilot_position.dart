import 'package:collection/collection.dart';

class AutoPilotPosition {
  final String? symbol;
  final String? name;
  final String? pictureUrl;
  final double? quantity;
  final double? percentOfPortfolio;
  final double? marketValue;
  final double? currentPrice;
  final double? unrealizedProfitLoss;
  final double? unrealizedReturn;
  const AutoPilotPosition(
      {required this.symbol,
      required this.name,
      required this.pictureUrl,
      required this.quantity,
      this.percentOfPortfolio,
      this.marketValue,
      this.currentPrice,
      this.unrealizedProfitLoss,
      this.unrealizedReturn});
  AutoPilotPosition copyWith(
      {String? symbol,
      String? name,
      String? pictureUrl,
      double? quantity,
      double? percentOfPortfolio,
      double? marketValue,
      double? currentPrice,
      double? unrealizedProfitLoss,
      double? unrealizedReturn}) {
    return AutoPilotPosition(
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      quantity: quantity ?? this.quantity,
      percentOfPortfolio: percentOfPortfolio ?? this.percentOfPortfolio,
      marketValue: marketValue ?? this.marketValue,
      currentPrice: currentPrice ?? this.currentPrice,
      unrealizedProfitLoss: unrealizedProfitLoss ?? this.unrealizedProfitLoss,
      unrealizedReturn: unrealizedReturn ?? this.unrealizedReturn,
    );
  }

  factory AutoPilotPosition.fromJson(Map<String, dynamic> json) {
    return AutoPilotPosition(
      symbol: json['symbol'],
      name: json['name'],
      pictureUrl: json['pictureUrl'],
      quantity: json['quantity']?.toDouble(),
      percentOfPortfolio: json['percentOfPortfolio']?.toDouble(),
      marketValue: json['marketValue']?.toDouble(),
      currentPrice: json['currentPrice']?.toDouble(),
      unrealizedProfitLoss: json['unrealizedProfitLoss']?.toDouble(),
      unrealizedReturn: json['unrealizedReturn']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['name'] = name;
    data['pictureUrl'] = pictureUrl;
    data['quantity'] = quantity;
    data['percentOfPortfolio'] = percentOfPortfolio;
    data['marketValue'] = marketValue;
    data['currentPrice'] = currentPrice;
    data['unrealizedProfitLoss'] = unrealizedProfitLoss;
    data['unrealizedReturn'] = unrealizedReturn;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotPosition &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.pictureUrl, pictureUrl) ||
                const DeepCollectionEquality()
                    .equals(other.pictureUrl, pictureUrl)) &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality()
                    .equals(other.quantity, quantity)) &&
            (identical(other.percentOfPortfolio, percentOfPortfolio) ||
                const DeepCollectionEquality()
                    .equals(other.percentOfPortfolio, percentOfPortfolio)) &&
            (identical(other.marketValue, marketValue) ||
                const DeepCollectionEquality()
                    .equals(other.marketValue, marketValue)) &&
            (identical(other.currentPrice, currentPrice) ||
                const DeepCollectionEquality()
                    .equals(other.currentPrice, currentPrice)) &&
            (identical(other.unrealizedProfitLoss, unrealizedProfitLoss) ||
                const DeepCollectionEquality().equals(
                    other.unrealizedProfitLoss, unrealizedProfitLoss)) &&
            (identical(other.unrealizedReturn, unrealizedReturn) ||
                const DeepCollectionEquality()
                    .equals(other.unrealizedReturn, unrealizedReturn)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(symbol) ^
        const DeepCollectionEquality().hash(name) ^
        const DeepCollectionEquality().hash(pictureUrl) ^
        const DeepCollectionEquality().hash(quantity) ^
        const DeepCollectionEquality().hash(percentOfPortfolio) ^
        const DeepCollectionEquality().hash(marketValue) ^
        const DeepCollectionEquality().hash(currentPrice) ^
        const DeepCollectionEquality().hash(unrealizedProfitLoss) ^
        const DeepCollectionEquality().hash(unrealizedReturn);
  }

  @override
  String toString() => 'AutoPilotPosition(${toJson()})';
}
