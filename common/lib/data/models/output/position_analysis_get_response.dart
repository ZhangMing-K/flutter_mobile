import 'package:iris_common/data/models/output/position_analysis.dart';
import 'package:collection/collection.dart';

class PositionAnalysisGetResponse {
  final List<PositionAnalysis>? positionAnalysis;
  const PositionAnalysisGetResponse({this.positionAnalysis});
  PositionAnalysisGetResponse copyWith(
      {List<PositionAnalysis>? positionAnalysis}) {
    return PositionAnalysisGetResponse(
      positionAnalysis: positionAnalysis ?? this.positionAnalysis,
    );
  }

  factory PositionAnalysisGetResponse.fromJson(Map<String, dynamic> json) {
    return PositionAnalysisGetResponse(
      positionAnalysis: json['positionAnalysis']
          ?.map<PositionAnalysis>((o) => PositionAnalysis.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['positionAnalysis'] =
        positionAnalysis?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PositionAnalysisGetResponse &&
            (identical(other.positionAnalysis, positionAnalysis) ||
                const DeepCollectionEquality()
                    .equals(other.positionAnalysis, positionAnalysis)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(positionAnalysis);
  }

  @override
  String toString() => 'PositionAnalysisGetResponse(${toJson()})';
}
