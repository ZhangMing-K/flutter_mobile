import 'package:iris_common/data/models/output/trade_analysis.dart';
import 'package:collection/collection.dart';

class TradeAnalysisGetResponse {
  final List<TradeAnalysis>? tradeAnalysis;
  const TradeAnalysisGetResponse({this.tradeAnalysis});
  TradeAnalysisGetResponse copyWith({List<TradeAnalysis>? tradeAnalysis}) {
    return TradeAnalysisGetResponse(
      tradeAnalysis: tradeAnalysis ?? this.tradeAnalysis,
    );
  }

  factory TradeAnalysisGetResponse.fromJson(Map<String, dynamic> json) {
    return TradeAnalysisGetResponse(
      tradeAnalysis: json['tradeAnalysis']
          ?.map<TradeAnalysis>((o) => TradeAnalysis.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['tradeAnalysis'] =
        tradeAnalysis?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TradeAnalysisGetResponse &&
            (identical(other.tradeAnalysis, tradeAnalysis) ||
                const DeepCollectionEquality()
                    .equals(other.tradeAnalysis, tradeAnalysis)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(tradeAnalysis);
  }

  @override
  String toString() => 'TradeAnalysisGetResponse(${toJson()})';
}
