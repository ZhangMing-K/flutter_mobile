import 'package:iris_common/data/models/output/asset.dart';
import 'package:iris_common/data/models/enums/position_type.dart';
import 'package:iris_common/data/models/output/iris_position.dart';
import 'package:iris_common/data/models/output/position_type_summary.dart';
import 'package:collection/collection.dart';

class PositionsSummaryItem {
  final int? userKey;
  final List<int>? portfolioKeys;
  final String? symbol;
  final int? assetKey;
  final Asset? asset;
  final DateTime? openedAt;
  final int? totalTransactionCount;
  final List<POSITION_TYPE>? positionTypes;
  final double? relativePositionValue;
  final double? profitLossPercent;
  final double? todayProfitLossPercent;
  final double? totalPositionValue;
  final double? profitLoss;
  final double? todayProfitLoss;
  final List<IrisPosition>? positions;
  final PositionTypeSummary? positionTypeSummary;
  final int? dueDiligenceCount;
  final int? postCount;
  const PositionsSummaryItem(
      {required this.userKey,
      required this.portfolioKeys,
      required this.symbol,
      this.assetKey,
      this.asset,
      this.openedAt,
      this.totalTransactionCount,
      this.positionTypes,
      required this.relativePositionValue,
      required this.profitLossPercent,
      required this.todayProfitLossPercent,
      required this.totalPositionValue,
      required this.profitLoss,
      required this.todayProfitLoss,
      this.positions,
      this.positionTypeSummary,
      this.dueDiligenceCount,
      this.postCount});
  PositionsSummaryItem copyWith(
      {int? userKey,
      List<int>? portfolioKeys,
      String? symbol,
      int? assetKey,
      Asset? asset,
      DateTime? openedAt,
      int? totalTransactionCount,
      List<POSITION_TYPE>? positionTypes,
      double? relativePositionValue,
      double? profitLossPercent,
      double? todayProfitLossPercent,
      double? totalPositionValue,
      double? profitLoss,
      double? todayProfitLoss,
      List<IrisPosition>? positions,
      PositionTypeSummary? positionTypeSummary,
      int? dueDiligenceCount,
      int? postCount}) {
    return PositionsSummaryItem(
      userKey: userKey ?? this.userKey,
      portfolioKeys: portfolioKeys ?? this.portfolioKeys,
      symbol: symbol ?? this.symbol,
      assetKey: assetKey ?? this.assetKey,
      asset: asset ?? this.asset,
      openedAt: openedAt ?? this.openedAt,
      totalTransactionCount:
          totalTransactionCount ?? this.totalTransactionCount,
      positionTypes: positionTypes ?? this.positionTypes,
      relativePositionValue:
          relativePositionValue ?? this.relativePositionValue,
      profitLossPercent: profitLossPercent ?? this.profitLossPercent,
      todayProfitLossPercent:
          todayProfitLossPercent ?? this.todayProfitLossPercent,
      totalPositionValue: totalPositionValue ?? this.totalPositionValue,
      profitLoss: profitLoss ?? this.profitLoss,
      todayProfitLoss: todayProfitLoss ?? this.todayProfitLoss,
      positions: positions ?? this.positions,
      positionTypeSummary: positionTypeSummary ?? this.positionTypeSummary,
      dueDiligenceCount: dueDiligenceCount ?? this.dueDiligenceCount,
      postCount: postCount ?? this.postCount,
    );
  }

  factory PositionsSummaryItem.fromJson(Map<String, dynamic> json) {
    return PositionsSummaryItem(
      userKey: json['userKey'],
      portfolioKeys:
          json['portfolioKeys']?.map<int>((o) => (o as int)).toList(),
      symbol: json['symbol'],
      assetKey: json['assetKey'],
      asset: json['asset'] != null ? Asset.fromJson(json['asset']) : null,
      openedAt:
          json['openedAt'] != null ? DateTime.parse(json['openedAt']) : null,
      totalTransactionCount: json['totalTransactionCount'],
      positionTypes: json['positionTypes']
          ?.map<POSITION_TYPE>((o) => POSITION_TYPE.values.byName(o))
          .toList(),
      relativePositionValue: json['relativePositionValue']?.toDouble(),
      profitLossPercent: json['profitLossPercent']?.toDouble(),
      todayProfitLossPercent: json['todayProfitLossPercent']?.toDouble(),
      totalPositionValue: json['totalPositionValue']?.toDouble(),
      profitLoss: json['profitLoss']?.toDouble(),
      todayProfitLoss: json['todayProfitLoss']?.toDouble(),
      positions: json['positions']
          ?.map<IrisPosition>((o) => IrisPosition.fromJson(o))
          .toList(),
      positionTypeSummary: json['positionTypeSummary'] != null
          ? PositionTypeSummary.fromJson(json['positionTypeSummary'])
          : null,
      dueDiligenceCount: json['dueDiligenceCount'],
      postCount: json['postCount'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKey'] = userKey;
    data['portfolioKeys'] = portfolioKeys;
    data['symbol'] = symbol;
    data['assetKey'] = assetKey;
    data['asset'] = asset?.toJson();
    data['openedAt'] = openedAt?.toString();
    data['totalTransactionCount'] = totalTransactionCount;
    data['positionTypes'] = positionTypes?.map((item) => item.name).toList();
    data['relativePositionValue'] = relativePositionValue;
    data['profitLossPercent'] = profitLossPercent;
    data['todayProfitLossPercent'] = todayProfitLossPercent;
    data['totalPositionValue'] = totalPositionValue;
    data['profitLoss'] = profitLoss;
    data['todayProfitLoss'] = todayProfitLoss;
    data['positions'] = positions?.map((item) => item.toJson()).toList();
    data['positionTypeSummary'] = positionTypeSummary?.toJson();
    data['dueDiligenceCount'] = dueDiligenceCount;
    data['postCount'] = postCount;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PositionsSummaryItem &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.portfolioKeys, portfolioKeys) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKeys, portfolioKeys)) &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.assetKey, assetKey) ||
                const DeepCollectionEquality()
                    .equals(other.assetKey, assetKey)) &&
            (identical(other.asset, asset) ||
                const DeepCollectionEquality().equals(other.asset, asset)) &&
            (identical(other.openedAt, openedAt) ||
                const DeepCollectionEquality()
                    .equals(other.openedAt, openedAt)) &&
            (identical(other.totalTransactionCount, totalTransactionCount) ||
                const DeepCollectionEquality().equals(
                    other.totalTransactionCount, totalTransactionCount)) &&
            (identical(other.positionTypes, positionTypes) ||
                const DeepCollectionEquality()
                    .equals(other.positionTypes, positionTypes)) &&
            (identical(other.relativePositionValue, relativePositionValue) ||
                const DeepCollectionEquality().equals(
                    other.relativePositionValue, relativePositionValue)) &&
            (identical(other.profitLossPercent, profitLossPercent) ||
                const DeepCollectionEquality()
                    .equals(other.profitLossPercent, profitLossPercent)) &&
            (identical(other.todayProfitLossPercent, todayProfitLossPercent) ||
                const DeepCollectionEquality().equals(
                    other.todayProfitLossPercent, todayProfitLossPercent)) &&
            (identical(other.totalPositionValue, totalPositionValue) ||
                const DeepCollectionEquality()
                    .equals(other.totalPositionValue, totalPositionValue)) &&
            (identical(other.profitLoss, profitLoss) ||
                const DeepCollectionEquality()
                    .equals(other.profitLoss, profitLoss)) &&
            (identical(other.todayProfitLoss, todayProfitLoss) ||
                const DeepCollectionEquality()
                    .equals(other.todayProfitLoss, todayProfitLoss)) &&
            (identical(other.positions, positions) ||
                const DeepCollectionEquality()
                    .equals(other.positions, positions)) &&
            (identical(other.positionTypeSummary, positionTypeSummary) ||
                const DeepCollectionEquality()
                    .equals(other.positionTypeSummary, positionTypeSummary)) &&
            (identical(other.dueDiligenceCount, dueDiligenceCount) ||
                const DeepCollectionEquality()
                    .equals(other.dueDiligenceCount, dueDiligenceCount)) &&
            (identical(other.postCount, postCount) ||
                const DeepCollectionEquality()
                    .equals(other.postCount, postCount)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(portfolioKeys) ^
        const DeepCollectionEquality().hash(symbol) ^
        const DeepCollectionEquality().hash(assetKey) ^
        const DeepCollectionEquality().hash(asset) ^
        const DeepCollectionEquality().hash(openedAt) ^
        const DeepCollectionEquality().hash(totalTransactionCount) ^
        const DeepCollectionEquality().hash(positionTypes) ^
        const DeepCollectionEquality().hash(relativePositionValue) ^
        const DeepCollectionEquality().hash(profitLossPercent) ^
        const DeepCollectionEquality().hash(todayProfitLossPercent) ^
        const DeepCollectionEquality().hash(totalPositionValue) ^
        const DeepCollectionEquality().hash(profitLoss) ^
        const DeepCollectionEquality().hash(todayProfitLoss) ^
        const DeepCollectionEquality().hash(positions) ^
        const DeepCollectionEquality().hash(positionTypeSummary) ^
        const DeepCollectionEquality().hash(dueDiligenceCount) ^
        const DeepCollectionEquality().hash(postCount);
  }

  @override
  String toString() => 'PositionsSummaryItem(${toJson()})';
}
