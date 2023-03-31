import 'package:iris_common/data/models/enums/position_order_by.dart';
import 'package:collection/collection.dart';

class PositionsGetInput {
  final int? userKey;
  final int? portfolioKey;
  final POSITION_ORDER_BY? orderBy;
  final int? assetKey;
  final String? symbol;
  final String? cursor;
  const PositionsGetInput(
      {this.userKey,
      this.portfolioKey,
      this.orderBy,
      this.assetKey,
      this.symbol,
      this.cursor});
  PositionsGetInput copyWith(
      {int? userKey,
      int? portfolioKey,
      POSITION_ORDER_BY? orderBy,
      int? assetKey,
      String? symbol,
      String? cursor}) {
    return PositionsGetInput(
      userKey: userKey ?? this.userKey,
      portfolioKey: portfolioKey ?? this.portfolioKey,
      orderBy: orderBy ?? this.orderBy,
      assetKey: assetKey ?? this.assetKey,
      symbol: symbol ?? this.symbol,
      cursor: cursor ?? this.cursor,
    );
  }

  factory PositionsGetInput.fromJson(Map<String, dynamic> json) {
    return PositionsGetInput(
      userKey: json['userKey'],
      portfolioKey: json['portfolioKey'],
      orderBy: json['orderBy'] != null
          ? POSITION_ORDER_BY.values.byName(json['orderBy'])
          : null,
      assetKey: json['assetKey'],
      symbol: json['symbol'],
      cursor: json['cursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKey'] = userKey;
    data['portfolioKey'] = portfolioKey;
    data['orderBy'] = orderBy?.name;
    data['assetKey'] = assetKey;
    data['symbol'] = symbol;
    data['cursor'] = cursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PositionsGetInput &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.orderBy, orderBy) ||
                const DeepCollectionEquality()
                    .equals(other.orderBy, orderBy)) &&
            (identical(other.assetKey, assetKey) ||
                const DeepCollectionEquality()
                    .equals(other.assetKey, assetKey)) &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.cursor, cursor) ||
                const DeepCollectionEquality().equals(other.cursor, cursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(orderBy) ^
        const DeepCollectionEquality().hash(assetKey) ^
        const DeepCollectionEquality().hash(symbol) ^
        const DeepCollectionEquality().hash(cursor);
  }

  @override
  String toString() => 'PositionsGetInput(${toJson()})';
}
