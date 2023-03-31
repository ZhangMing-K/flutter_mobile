import 'package:collection/collection.dart';

class PositionsSummaryGetInput {
  final int? userKey;
  final int? portfolioKey;
  final int? limit;
  final int? assetKey;
  final String? symbol;
  const PositionsSummaryGetInput(
      {this.userKey,
      this.portfolioKey,
      this.limit,
      this.assetKey,
      this.symbol});
  PositionsSummaryGetInput copyWith(
      {int? userKey,
      int? portfolioKey,
      int? limit,
      int? assetKey,
      String? symbol}) {
    return PositionsSummaryGetInput(
      userKey: userKey ?? this.userKey,
      portfolioKey: portfolioKey ?? this.portfolioKey,
      limit: limit ?? this.limit,
      assetKey: assetKey ?? this.assetKey,
      symbol: symbol ?? this.symbol,
    );
  }

  factory PositionsSummaryGetInput.fromJson(Map<String, dynamic> json) {
    return PositionsSummaryGetInput(
      userKey: json['userKey'],
      portfolioKey: json['portfolioKey'],
      limit: json['limit'],
      assetKey: json['assetKey'],
      symbol: json['symbol'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKey'] = userKey;
    data['portfolioKey'] = portfolioKey;
    data['limit'] = limit;
    data['assetKey'] = assetKey;
    data['symbol'] = symbol;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PositionsSummaryGetInput &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
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
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(assetKey) ^
        const DeepCollectionEquality().hash(symbol);
  }

  @override
  String toString() => 'PositionsSummaryGetInput(${toJson()})';
}
