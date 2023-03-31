import 'package:iris_common/data/models/enums/segment_type.dart';
import 'package:iris_common/data/models/output/trade_performance.dart';
import 'package:iris_common/data/models/output/percentile_connection.dart';
import 'package:iris_common/data/models/output/asset.dart';
import 'package:collection/collection.dart';

class TradePerformanceConnection {
  final SEGMENT_TYPE? segmentType;
  final TradePerformance? tradePerformance;
  final PercentileConnection? percentileConnection;
  final List<Asset>? mostTradedAssets;
  final List<Asset>? mostProfitableAssets;
  const TradePerformanceConnection(
      {this.segmentType,
      this.tradePerformance,
      this.percentileConnection,
      this.mostTradedAssets,
      this.mostProfitableAssets});
  TradePerformanceConnection copyWith(
      {SEGMENT_TYPE? segmentType,
      TradePerformance? tradePerformance,
      PercentileConnection? percentileConnection,
      List<Asset>? mostTradedAssets,
      List<Asset>? mostProfitableAssets}) {
    return TradePerformanceConnection(
      segmentType: segmentType ?? this.segmentType,
      tradePerformance: tradePerformance ?? this.tradePerformance,
      percentileConnection: percentileConnection ?? this.percentileConnection,
      mostTradedAssets: mostTradedAssets ?? this.mostTradedAssets,
      mostProfitableAssets: mostProfitableAssets ?? this.mostProfitableAssets,
    );
  }

  factory TradePerformanceConnection.fromJson(Map<String, dynamic> json) {
    return TradePerformanceConnection(
      segmentType: json['segmentType'] != null
          ? SEGMENT_TYPE.values.byName(json['segmentType'])
          : null,
      tradePerformance: json['tradePerformance'] != null
          ? TradePerformance.fromJson(json['tradePerformance'])
          : null,
      percentileConnection: json['percentileConnection'] != null
          ? PercentileConnection.fromJson(json['percentileConnection'])
          : null,
      mostTradedAssets: json['mostTradedAssets']
          ?.map<Asset>((o) => Asset.fromJson(o))
          .toList(),
      mostProfitableAssets: json['mostProfitableAssets']
          ?.map<Asset>((o) => Asset.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['segmentType'] = segmentType?.name;
    data['tradePerformance'] = tradePerformance?.toJson();
    data['percentileConnection'] = percentileConnection?.toJson();
    data['mostTradedAssets'] =
        mostTradedAssets?.map((item) => item.toJson()).toList();
    data['mostProfitableAssets'] =
        mostProfitableAssets?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TradePerformanceConnection &&
            (identical(other.segmentType, segmentType) ||
                const DeepCollectionEquality()
                    .equals(other.segmentType, segmentType)) &&
            (identical(other.tradePerformance, tradePerformance) ||
                const DeepCollectionEquality()
                    .equals(other.tradePerformance, tradePerformance)) &&
            (identical(other.percentileConnection, percentileConnection) ||
                const DeepCollectionEquality().equals(
                    other.percentileConnection, percentileConnection)) &&
            (identical(other.mostTradedAssets, mostTradedAssets) ||
                const DeepCollectionEquality()
                    .equals(other.mostTradedAssets, mostTradedAssets)) &&
            (identical(other.mostProfitableAssets, mostProfitableAssets) ||
                const DeepCollectionEquality()
                    .equals(other.mostProfitableAssets, mostProfitableAssets)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(segmentType) ^
        const DeepCollectionEquality().hash(tradePerformance) ^
        const DeepCollectionEquality().hash(percentileConnection) ^
        const DeepCollectionEquality().hash(mostTradedAssets) ^
        const DeepCollectionEquality().hash(mostProfitableAssets);
  }

  @override
  String toString() => 'TradePerformanceConnection(${toJson()})';
}
