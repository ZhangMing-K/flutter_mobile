import 'package:iris_common/data/models/enums/position_type.dart';
import 'package:collection/collection.dart';

class OrderFlowInput {
  final List<int>? assetKeys;
  final double? minCost;
  final double? minPortfolioAllocation;
  final double? limit;
  final String? cursor;
  final bool? onlyTopTraders;
  final POSITION_TYPE? positionType;
  const OrderFlowInput(
      {this.assetKeys,
      this.minCost,
      this.minPortfolioAllocation,
      this.limit,
      this.cursor,
      this.onlyTopTraders,
      this.positionType});
  OrderFlowInput copyWith(
      {List<int>? assetKeys,
      double? minCost,
      double? minPortfolioAllocation,
      double? limit,
      String? cursor,
      bool? onlyTopTraders,
      POSITION_TYPE? positionType}) {
    return OrderFlowInput(
      assetKeys: assetKeys ?? this.assetKeys,
      minCost: minCost ?? this.minCost,
      minPortfolioAllocation:
          minPortfolioAllocation ?? this.minPortfolioAllocation,
      limit: limit ?? this.limit,
      cursor: cursor ?? this.cursor,
      onlyTopTraders: onlyTopTraders ?? this.onlyTopTraders,
      positionType: positionType ?? this.positionType,
    );
  }

  factory OrderFlowInput.fromJson(Map<String, dynamic> json) {
    return OrderFlowInput(
      assetKeys: json['assetKeys']?.map<int>((o) => (o as int)).toList(),
      minCost: json['minCost']?.toDouble(),
      minPortfolioAllocation: json['minPortfolioAllocation']?.toDouble(),
      limit: json['limit']?.toDouble(),
      cursor: json['cursor'],
      onlyTopTraders: json['onlyTopTraders'],
      positionType: json['positionType'] != null
          ? POSITION_TYPE.values.byName(json['positionType'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['assetKeys'] = assetKeys;
    data['minCost'] = minCost;
    data['minPortfolioAllocation'] = minPortfolioAllocation;
    data['limit'] = limit;
    data['cursor'] = cursor;
    data['onlyTopTraders'] = onlyTopTraders;
    data['positionType'] = positionType?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is OrderFlowInput &&
            (identical(other.assetKeys, assetKeys) ||
                const DeepCollectionEquality()
                    .equals(other.assetKeys, assetKeys)) &&
            (identical(other.minCost, minCost) ||
                const DeepCollectionEquality()
                    .equals(other.minCost, minCost)) &&
            (identical(other.minPortfolioAllocation, minPortfolioAllocation) ||
                const DeepCollectionEquality().equals(
                    other.minPortfolioAllocation, minPortfolioAllocation)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.cursor, cursor) ||
                const DeepCollectionEquality().equals(other.cursor, cursor)) &&
            (identical(other.onlyTopTraders, onlyTopTraders) ||
                const DeepCollectionEquality()
                    .equals(other.onlyTopTraders, onlyTopTraders)) &&
            (identical(other.positionType, positionType) ||
                const DeepCollectionEquality()
                    .equals(other.positionType, positionType)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(assetKeys) ^
        const DeepCollectionEquality().hash(minCost) ^
        const DeepCollectionEquality().hash(minPortfolioAllocation) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(cursor) ^
        const DeepCollectionEquality().hash(onlyTopTraders) ^
        const DeepCollectionEquality().hash(positionType);
  }

  @override
  String toString() => 'OrderFlowInput(${toJson()})';
}
