import 'package:iris_common/data/models/enums/position_order_by.dart';
import 'package:collection/collection.dart';

class GetPositionsFromPortfolioInput {
  final POSITION_ORDER_BY? orderBy;
  final int? assetKey;
  final int? autoPilotMasterPortfolioKey;
  final String? symbol;
  final String? cursor;
  const GetPositionsFromPortfolioInput(
      {this.orderBy,
      this.assetKey,
      this.autoPilotMasterPortfolioKey,
      this.symbol,
      this.cursor});
  GetPositionsFromPortfolioInput copyWith(
      {POSITION_ORDER_BY? orderBy,
      int? assetKey,
      int? autoPilotMasterPortfolioKey,
      String? symbol,
      String? cursor}) {
    return GetPositionsFromPortfolioInput(
      orderBy: orderBy ?? this.orderBy,
      assetKey: assetKey ?? this.assetKey,
      autoPilotMasterPortfolioKey:
          autoPilotMasterPortfolioKey ?? this.autoPilotMasterPortfolioKey,
      symbol: symbol ?? this.symbol,
      cursor: cursor ?? this.cursor,
    );
  }

  factory GetPositionsFromPortfolioInput.fromJson(Map<String, dynamic> json) {
    return GetPositionsFromPortfolioInput(
      orderBy: json['orderBy'] != null
          ? POSITION_ORDER_BY.values.byName(json['orderBy'])
          : null,
      assetKey: json['assetKey'],
      autoPilotMasterPortfolioKey: json['autoPilotMasterPortfolioKey'],
      symbol: json['symbol'],
      cursor: json['cursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['orderBy'] = orderBy?.name;
    data['assetKey'] = assetKey;
    data['autoPilotMasterPortfolioKey'] = autoPilotMasterPortfolioKey;
    data['symbol'] = symbol;
    data['cursor'] = cursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetPositionsFromPortfolioInput &&
            (identical(other.orderBy, orderBy) ||
                const DeepCollectionEquality()
                    .equals(other.orderBy, orderBy)) &&
            (identical(other.assetKey, assetKey) ||
                const DeepCollectionEquality()
                    .equals(other.assetKey, assetKey)) &&
            (identical(other.autoPilotMasterPortfolioKey,
                    autoPilotMasterPortfolioKey) ||
                const DeepCollectionEquality().equals(
                    other.autoPilotMasterPortfolioKey,
                    autoPilotMasterPortfolioKey)) &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.cursor, cursor) ||
                const DeepCollectionEquality().equals(other.cursor, cursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(orderBy) ^
        const DeepCollectionEquality().hash(assetKey) ^
        const DeepCollectionEquality().hash(autoPilotMasterPortfolioKey) ^
        const DeepCollectionEquality().hash(symbol) ^
        const DeepCollectionEquality().hash(cursor);
  }

  @override
  String toString() => 'GetPositionsFromPortfolioInput(${toJson()})';
}
