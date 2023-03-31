import 'package:iris_common/data/models/output/trade_analysis.dart';
import 'package:collection/collection.dart';

class AssetAnalysisGetResponse {
  final List<TradeAnalysis>? assetAnalysis;
  const AssetAnalysisGetResponse({this.assetAnalysis});
  AssetAnalysisGetResponse copyWith({List<TradeAnalysis>? assetAnalysis}) {
    return AssetAnalysisGetResponse(
      assetAnalysis: assetAnalysis ?? this.assetAnalysis,
    );
  }

  factory AssetAnalysisGetResponse.fromJson(Map<String, dynamic> json) {
    return AssetAnalysisGetResponse(
      assetAnalysis: json['assetAnalysis']
          ?.map<TradeAnalysis>((o) => TradeAnalysis.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['assetAnalysis'] =
        assetAnalysis?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AssetAnalysisGetResponse &&
            (identical(other.assetAnalysis, assetAnalysis) ||
                const DeepCollectionEquality()
                    .equals(other.assetAnalysis, assetAnalysis)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(assetAnalysis);
  }

  @override
  String toString() => 'AssetAnalysisGetResponse(${toJson()})';
}
