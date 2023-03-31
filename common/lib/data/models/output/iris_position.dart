import 'package:iris_common/data/models/enums/position_type.dart';
import 'package:iris_common/data/models/enums/position_direction.dart';
import 'package:iris_common/data/models/enums/sentiment_type.dart';
import 'package:iris_common/data/models/output/asset.dart';
import 'package:iris_common/data/models/output/absolute_position_metrics.dart';
import 'package:iris_common/data/models/output/relative_position_metrics.dart';
import 'package:iris_common/data/models/output/option_info.dart';
import 'package:collection/collection.dart';

class IrisPosition {
  final int? userKey;
  final List<int>? portfolioKeys;
  final DateTime? openedAt;
  final DateTime? closedAt;
  final String? symbol;
  final int? assetKey;
  final String? stockName;
  final POSITION_TYPE? positionType;
  final POSITION_DIRECTION? positionDirection;
  final SENTIMENT_TYPE? sentiment;
  final int? totalTransactionCount;
  final double? averageBuyPrice;
  final Asset? asset;
  final AbsolutePositionMetrics? absoluteMetrics;
  final RelativePositionMetrics? relativeMetrics;
  final OptionInfo? optionInfo;
  const IrisPosition(
      {required this.userKey,
      required this.portfolioKeys,
      required this.openedAt,
      this.closedAt,
      required this.symbol,
      this.assetKey,
      this.stockName,
      this.positionType,
      this.positionDirection,
      this.sentiment,
      required this.totalTransactionCount,
      required this.averageBuyPrice,
      this.asset,
      this.absoluteMetrics,
      this.relativeMetrics,
      this.optionInfo});
  IrisPosition copyWith(
      {int? userKey,
      List<int>? portfolioKeys,
      DateTime? openedAt,
      DateTime? closedAt,
      String? symbol,
      int? assetKey,
      String? stockName,
      POSITION_TYPE? positionType,
      POSITION_DIRECTION? positionDirection,
      SENTIMENT_TYPE? sentiment,
      int? totalTransactionCount,
      double? averageBuyPrice,
      Asset? asset,
      AbsolutePositionMetrics? absoluteMetrics,
      RelativePositionMetrics? relativeMetrics,
      OptionInfo? optionInfo}) {
    return IrisPosition(
      userKey: userKey ?? this.userKey,
      portfolioKeys: portfolioKeys ?? this.portfolioKeys,
      openedAt: openedAt ?? this.openedAt,
      closedAt: closedAt ?? this.closedAt,
      symbol: symbol ?? this.symbol,
      assetKey: assetKey ?? this.assetKey,
      stockName: stockName ?? this.stockName,
      positionType: positionType ?? this.positionType,
      positionDirection: positionDirection ?? this.positionDirection,
      sentiment: sentiment ?? this.sentiment,
      totalTransactionCount:
          totalTransactionCount ?? this.totalTransactionCount,
      averageBuyPrice: averageBuyPrice ?? this.averageBuyPrice,
      asset: asset ?? this.asset,
      absoluteMetrics: absoluteMetrics ?? this.absoluteMetrics,
      relativeMetrics: relativeMetrics ?? this.relativeMetrics,
      optionInfo: optionInfo ?? this.optionInfo,
    );
  }

  factory IrisPosition.fromJson(Map<String, dynamic> json) {
    return IrisPosition(
      userKey: json['userKey'],
      portfolioKeys:
          json['portfolioKeys']?.map<int>((o) => (o as int)).toList(),
      openedAt:
          json['openedAt'] != null ? DateTime.parse(json['openedAt']) : null,
      closedAt:
          json['closedAt'] != null ? DateTime.parse(json['closedAt']) : null,
      symbol: json['symbol'],
      assetKey: json['assetKey'],
      stockName: json['stockName'],
      positionType: json['positionType'] != null
          ? POSITION_TYPE.values.byName(json['positionType'])
          : null,
      positionDirection: json['positionDirection'] != null
          ? POSITION_DIRECTION.values.byName(json['positionDirection'])
          : null,
      sentiment: json['sentiment'] != null
          ? SENTIMENT_TYPE.values.byName(json['sentiment'])
          : null,
      totalTransactionCount: json['totalTransactionCount'],
      averageBuyPrice: json['averageBuyPrice']?.toDouble(),
      asset: json['asset'] != null ? Asset.fromJson(json['asset']) : null,
      absoluteMetrics: json['absoluteMetrics'] != null
          ? AbsolutePositionMetrics.fromJson(json['absoluteMetrics'])
          : null,
      relativeMetrics: json['relativeMetrics'] != null
          ? RelativePositionMetrics.fromJson(json['relativeMetrics'])
          : null,
      optionInfo: json['optionInfo'] != null
          ? OptionInfo.fromJson(json['optionInfo'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKey'] = userKey;
    data['portfolioKeys'] = portfolioKeys;
    data['openedAt'] = openedAt?.toString();
    data['closedAt'] = closedAt?.toString();
    data['symbol'] = symbol;
    data['assetKey'] = assetKey;
    data['stockName'] = stockName;
    data['positionType'] = positionType?.name;
    data['positionDirection'] = positionDirection?.name;
    data['sentiment'] = sentiment?.name;
    data['totalTransactionCount'] = totalTransactionCount;
    data['averageBuyPrice'] = averageBuyPrice;
    data['asset'] = asset?.toJson();
    data['absoluteMetrics'] = absoluteMetrics?.toJson();
    data['relativeMetrics'] = relativeMetrics?.toJson();
    data['optionInfo'] = optionInfo?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is IrisPosition &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.portfolioKeys, portfolioKeys) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKeys, portfolioKeys)) &&
            (identical(other.openedAt, openedAt) ||
                const DeepCollectionEquality()
                    .equals(other.openedAt, openedAt)) &&
            (identical(other.closedAt, closedAt) ||
                const DeepCollectionEquality()
                    .equals(other.closedAt, closedAt)) &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.assetKey, assetKey) ||
                const DeepCollectionEquality()
                    .equals(other.assetKey, assetKey)) &&
            (identical(other.stockName, stockName) ||
                const DeepCollectionEquality()
                    .equals(other.stockName, stockName)) &&
            (identical(other.positionType, positionType) ||
                const DeepCollectionEquality()
                    .equals(other.positionType, positionType)) &&
            (identical(other.positionDirection, positionDirection) ||
                const DeepCollectionEquality()
                    .equals(other.positionDirection, positionDirection)) &&
            (identical(other.sentiment, sentiment) ||
                const DeepCollectionEquality()
                    .equals(other.sentiment, sentiment)) &&
            (identical(other.totalTransactionCount, totalTransactionCount) ||
                const DeepCollectionEquality().equals(
                    other.totalTransactionCount, totalTransactionCount)) &&
            (identical(other.averageBuyPrice, averageBuyPrice) ||
                const DeepCollectionEquality()
                    .equals(other.averageBuyPrice, averageBuyPrice)) &&
            (identical(other.asset, asset) ||
                const DeepCollectionEquality().equals(other.asset, asset)) &&
            (identical(other.absoluteMetrics, absoluteMetrics) ||
                const DeepCollectionEquality()
                    .equals(other.absoluteMetrics, absoluteMetrics)) &&
            (identical(other.relativeMetrics, relativeMetrics) ||
                const DeepCollectionEquality()
                    .equals(other.relativeMetrics, relativeMetrics)) &&
            (identical(other.optionInfo, optionInfo) ||
                const DeepCollectionEquality()
                    .equals(other.optionInfo, optionInfo)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(portfolioKeys) ^
        const DeepCollectionEquality().hash(openedAt) ^
        const DeepCollectionEquality().hash(closedAt) ^
        const DeepCollectionEquality().hash(symbol) ^
        const DeepCollectionEquality().hash(assetKey) ^
        const DeepCollectionEquality().hash(stockName) ^
        const DeepCollectionEquality().hash(positionType) ^
        const DeepCollectionEquality().hash(positionDirection) ^
        const DeepCollectionEquality().hash(sentiment) ^
        const DeepCollectionEquality().hash(totalTransactionCount) ^
        const DeepCollectionEquality().hash(averageBuyPrice) ^
        const DeepCollectionEquality().hash(asset) ^
        const DeepCollectionEquality().hash(absoluteMetrics) ^
        const DeepCollectionEquality().hash(relativeMetrics) ^
        const DeepCollectionEquality().hash(optionInfo);
  }

  @override
  String toString() => 'IrisPosition(${toJson()})';
}
