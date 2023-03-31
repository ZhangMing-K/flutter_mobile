import 'package:collection/collection.dart';

class AutoPilotPortfolioCurrentHolding {
  final String? symbol;
  final String? name;
  final String? pictureUrl;
  final double? percentOfPortfolio;
  final String? assetDescription;
  const AutoPilotPortfolioCurrentHolding(
      {required this.symbol,
      required this.name,
      required this.pictureUrl,
      required this.percentOfPortfolio,
      this.assetDescription});
  AutoPilotPortfolioCurrentHolding copyWith(
      {String? symbol,
      String? name,
      String? pictureUrl,
      double? percentOfPortfolio,
      String? assetDescription}) {
    return AutoPilotPortfolioCurrentHolding(
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      percentOfPortfolio: percentOfPortfolio ?? this.percentOfPortfolio,
      assetDescription: assetDescription ?? this.assetDescription,
    );
  }

  factory AutoPilotPortfolioCurrentHolding.fromJson(Map<String, dynamic> json) {
    return AutoPilotPortfolioCurrentHolding(
      symbol: json['symbol'],
      name: json['name'],
      pictureUrl: json['pictureUrl'],
      percentOfPortfolio: json['percentOfPortfolio']?.toDouble(),
      assetDescription: json['assetDescription'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['name'] = name;
    data['pictureUrl'] = pictureUrl;
    data['percentOfPortfolio'] = percentOfPortfolio;
    data['assetDescription'] = assetDescription;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotPortfolioCurrentHolding &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.pictureUrl, pictureUrl) ||
                const DeepCollectionEquality()
                    .equals(other.pictureUrl, pictureUrl)) &&
            (identical(other.percentOfPortfolio, percentOfPortfolio) ||
                const DeepCollectionEquality()
                    .equals(other.percentOfPortfolio, percentOfPortfolio)) &&
            (identical(other.assetDescription, assetDescription) ||
                const DeepCollectionEquality()
                    .equals(other.assetDescription, assetDescription)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(symbol) ^
        const DeepCollectionEquality().hash(name) ^
        const DeepCollectionEquality().hash(pictureUrl) ^
        const DeepCollectionEquality().hash(percentOfPortfolio) ^
        const DeepCollectionEquality().hash(assetDescription);
  }

  @override
  String toString() => 'AutoPilotPortfolioCurrentHolding(${toJson()})';
}
