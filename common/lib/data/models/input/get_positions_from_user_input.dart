import 'package:iris_common/data/models/enums/position_order_by.dart';
import 'package:collection/collection.dart';

class GetPositionsFromUserInput {
  final POSITION_ORDER_BY? orderBy;
  final int? assetKey;
  final String? symbol;
  final String? cursor;
  const GetPositionsFromUserInput(
      {this.orderBy, this.assetKey, this.symbol, this.cursor});
  GetPositionsFromUserInput copyWith(
      {POSITION_ORDER_BY? orderBy,
      int? assetKey,
      String? symbol,
      String? cursor}) {
    return GetPositionsFromUserInput(
      orderBy: orderBy ?? this.orderBy,
      assetKey: assetKey ?? this.assetKey,
      symbol: symbol ?? this.symbol,
      cursor: cursor ?? this.cursor,
    );
  }

  factory GetPositionsFromUserInput.fromJson(Map<String, dynamic> json) {
    return GetPositionsFromUserInput(
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
    data['orderBy'] = orderBy?.name;
    data['assetKey'] = assetKey;
    data['symbol'] = symbol;
    data['cursor'] = cursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetPositionsFromUserInput &&
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
        const DeepCollectionEquality().hash(orderBy) ^
        const DeepCollectionEquality().hash(assetKey) ^
        const DeepCollectionEquality().hash(symbol) ^
        const DeepCollectionEquality().hash(cursor);
  }

  @override
  String toString() => 'GetPositionsFromUserInput(${toJson()})';
}
