import 'package:collection/collection.dart';

class PositionTypeSummaryGetInput {
  final int? userKey;
  final int? portfolioKey;
  final int? assetKey;
  final String? symbol;
  const PositionTypeSummaryGetInput(
      {this.userKey, this.portfolioKey, this.assetKey, this.symbol});
  PositionTypeSummaryGetInput copyWith(
      {int? userKey, int? portfolioKey, int? assetKey, String? symbol}) {
    return PositionTypeSummaryGetInput(
      userKey: userKey ?? this.userKey,
      portfolioKey: portfolioKey ?? this.portfolioKey,
      assetKey: assetKey ?? this.assetKey,
      symbol: symbol ?? this.symbol,
    );
  }

  factory PositionTypeSummaryGetInput.fromJson(Map<String, dynamic> json) {
    return PositionTypeSummaryGetInput(
      userKey: json['userKey'],
      portfolioKey: json['portfolioKey'],
      assetKey: json['assetKey'],
      symbol: json['symbol'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKey'] = userKey;
    data['portfolioKey'] = portfolioKey;
    data['assetKey'] = assetKey;
    data['symbol'] = symbol;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PositionTypeSummaryGetInput &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.assetKey, assetKey) ||
                const DeepCollectionEquality()
                    .equals(other.assetKey, assetKey)) &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(assetKey) ^
        const DeepCollectionEquality().hash(symbol);
  }

  @override
  String toString() => 'PositionTypeSummaryGetInput(${toJson()})';
}
