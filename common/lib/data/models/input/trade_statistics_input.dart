import 'package:iris_common/data/models/enums/trade_stats_group_by.dart';
import 'package:iris_common/data/models/enums/trade_stats_order_by.dart';
import 'package:collection/collection.dart';

class TradeStatisticsInput {
  final List<int>? userKeys;
  final List<int>? portfolioKeys;
  final TRADE_STATS_GROUP_BY? groupBy;
  final TRADE_STATS_ORDER_BY? orderBy;
  final int? limit;
  final int? offset;
  const TradeStatisticsInput(
      {this.userKeys,
      this.portfolioKeys,
      required this.groupBy,
      this.orderBy,
      this.limit,
      this.offset});
  TradeStatisticsInput copyWith(
      {List<int>? userKeys,
      List<int>? portfolioKeys,
      TRADE_STATS_GROUP_BY? groupBy,
      TRADE_STATS_ORDER_BY? orderBy,
      int? limit,
      int? offset}) {
    return TradeStatisticsInput(
      userKeys: userKeys ?? this.userKeys,
      portfolioKeys: portfolioKeys ?? this.portfolioKeys,
      groupBy: groupBy ?? this.groupBy,
      orderBy: orderBy ?? this.orderBy,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory TradeStatisticsInput.fromJson(Map<String, dynamic> json) {
    return TradeStatisticsInput(
      userKeys: json['userKeys']?.map<int>((o) => (o as int)).toList(),
      portfolioKeys:
          json['portfolioKeys']?.map<int>((o) => (o as int)).toList(),
      groupBy: json['groupBy'] != null
          ? TRADE_STATS_GROUP_BY.values.byName(json['groupBy'])
          : null,
      orderBy: json['orderBy'] != null
          ? TRADE_STATS_ORDER_BY.values.byName(json['orderBy'])
          : null,
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKeys'] = userKeys;
    data['portfolioKeys'] = portfolioKeys;
    data['groupBy'] = groupBy?.name;
    data['orderBy'] = orderBy?.name;
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TradeStatisticsInput &&
            (identical(other.userKeys, userKeys) ||
                const DeepCollectionEquality()
                    .equals(other.userKeys, userKeys)) &&
            (identical(other.portfolioKeys, portfolioKeys) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKeys, portfolioKeys)) &&
            (identical(other.groupBy, groupBy) ||
                const DeepCollectionEquality()
                    .equals(other.groupBy, groupBy)) &&
            (identical(other.orderBy, orderBy) ||
                const DeepCollectionEquality()
                    .equals(other.orderBy, orderBy)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userKeys) ^
        const DeepCollectionEquality().hash(portfolioKeys) ^
        const DeepCollectionEquality().hash(groupBy) ^
        const DeepCollectionEquality().hash(orderBy) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'TradeStatisticsInput(${toJson()})';
}
