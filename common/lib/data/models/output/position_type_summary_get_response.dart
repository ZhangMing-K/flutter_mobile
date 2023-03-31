import 'package:iris_common/data/models/output/position_type_summary.dart';
import 'package:collection/collection.dart';

class PositionTypeSummaryGetResponse {
  final PositionTypeSummary? positionTypeSummary;
  const PositionTypeSummaryGetResponse({this.positionTypeSummary});
  PositionTypeSummaryGetResponse copyWith(
      {PositionTypeSummary? positionTypeSummary}) {
    return PositionTypeSummaryGetResponse(
      positionTypeSummary: positionTypeSummary ?? this.positionTypeSummary,
    );
  }

  factory PositionTypeSummaryGetResponse.fromJson(Map<String, dynamic> json) {
    return PositionTypeSummaryGetResponse(
      positionTypeSummary: json['positionTypeSummary'] != null
          ? PositionTypeSummary.fromJson(json['positionTypeSummary'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['positionTypeSummary'] = positionTypeSummary?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PositionTypeSummaryGetResponse &&
            (identical(other.positionTypeSummary, positionTypeSummary) ||
                const DeepCollectionEquality()
                    .equals(other.positionTypeSummary, positionTypeSummary)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(positionTypeSummary);
  }

  @override
  String toString() => 'PositionTypeSummaryGetResponse(${toJson()})';
}
