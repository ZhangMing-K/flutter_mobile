import 'package:collection/collection.dart';

class AutoPilotPortfoliosGetCurrentHoldings {
  final String? symbol;
  final String? name;
  final String? pictureUrl;
  final double? percentOfPortfolio;
  const AutoPilotPortfoliosGetCurrentHoldings(
      {required this.symbol,
      required this.name,
      required this.pictureUrl,
      required this.percentOfPortfolio});
  AutoPilotPortfoliosGetCurrentHoldings copyWith(
      {String? symbol,
      String? name,
      String? pictureUrl,
      double? percentOfPortfolio}) {
    return AutoPilotPortfoliosGetCurrentHoldings(
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      percentOfPortfolio: percentOfPortfolio ?? this.percentOfPortfolio,
    );
  }

  factory AutoPilotPortfoliosGetCurrentHoldings.fromJson(
      Map<String, dynamic> json) {
    return AutoPilotPortfoliosGetCurrentHoldings(
      symbol: json['symbol'],
      name: json['name'],
      pictureUrl: json['pictureUrl'],
      percentOfPortfolio: json['percentOfPortfolio']?.toDouble(),
    );
  }

  Map toJson() {
    Map _data = {};
    _data['symbol'] = symbol;
    _data['name'] = name;
    _data['pictureUrl'] = pictureUrl;
    _data['percentOfPortfolio'] = percentOfPortfolio;
    return _data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotPortfoliosGetCurrentHoldings &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.pictureUrl, pictureUrl) ||
                const DeepCollectionEquality()
                    .equals(other.pictureUrl, pictureUrl)) &&
            (identical(other.percentOfPortfolio, percentOfPortfolio) ||
                const DeepCollectionEquality()
                    .equals(other.percentOfPortfolio, percentOfPortfolio)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(symbol) ^
        const DeepCollectionEquality().hash(name) ^
        const DeepCollectionEquality().hash(pictureUrl) ^
        const DeepCollectionEquality().hash(percentOfPortfolio);
  }
}
