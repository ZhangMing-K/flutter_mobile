import 'package:iris_common/data/models/output/position_analysis.dart';
import 'package:collection/collection.dart';

class OpenPositionAnalysisGetResponse {
  final List<PositionAnalysis>? openPositionAnalysis;
  const OpenPositionAnalysisGetResponse({this.openPositionAnalysis});
  OpenPositionAnalysisGetResponse copyWith(
      {List<PositionAnalysis>? openPositionAnalysis}) {
    return OpenPositionAnalysisGetResponse(
      openPositionAnalysis: openPositionAnalysis ?? this.openPositionAnalysis,
    );
  }

  factory OpenPositionAnalysisGetResponse.fromJson(Map<String, dynamic> json) {
    return OpenPositionAnalysisGetResponse(
      openPositionAnalysis: json['openPositionAnalysis']
          ?.map<PositionAnalysis>((o) => PositionAnalysis.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['openPositionAnalysis'] =
        openPositionAnalysis?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is OpenPositionAnalysisGetResponse &&
            (identical(other.openPositionAnalysis, openPositionAnalysis) ||
                const DeepCollectionEquality()
                    .equals(other.openPositionAnalysis, openPositionAnalysis)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(openPositionAnalysis);
  }

  @override
  String toString() => 'OpenPositionAnalysisGetResponse(${toJson()})';
}
