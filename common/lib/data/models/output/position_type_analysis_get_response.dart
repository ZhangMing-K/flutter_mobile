import 'package:iris_common/data/models/output/trade_analysis.dart';
import 'package:collection/collection.dart';

class PositionTypeAnalysisGetResponse {
  final List<TradeAnalysis>? positionTypeAnalysis;
  const PositionTypeAnalysisGetResponse({this.positionTypeAnalysis});
  PositionTypeAnalysisGetResponse copyWith(
      {List<TradeAnalysis>? positionTypeAnalysis}) {
    return PositionTypeAnalysisGetResponse(
      positionTypeAnalysis: positionTypeAnalysis ?? this.positionTypeAnalysis,
    );
  }

  factory PositionTypeAnalysisGetResponse.fromJson(Map<String, dynamic> json) {
    return PositionTypeAnalysisGetResponse(
      positionTypeAnalysis: json['positionTypeAnalysis']
          ?.map<TradeAnalysis>((o) => TradeAnalysis.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['positionTypeAnalysis'] =
        positionTypeAnalysis?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PositionTypeAnalysisGetResponse &&
            (identical(other.positionTypeAnalysis, positionTypeAnalysis) ||
                const DeepCollectionEquality()
                    .equals(other.positionTypeAnalysis, positionTypeAnalysis)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(positionTypeAnalysis);
  }

  @override
  String toString() => 'PositionTypeAnalysisGetResponse(${toJson()})';
}
