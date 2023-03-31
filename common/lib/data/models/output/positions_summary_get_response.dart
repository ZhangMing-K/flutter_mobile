import 'package:iris_common/data/models/output/positions_summary_item.dart';
import 'package:collection/collection.dart';

class PositionsSummaryGetResponse {
  final List<PositionsSummaryItem>? summarizedPositions;
  final double? totalPortfolioValue;
  const PositionsSummaryGetResponse(
      {required this.summarizedPositions, required this.totalPortfolioValue});
  PositionsSummaryGetResponse copyWith(
      {List<PositionsSummaryItem>? summarizedPositions,
      double? totalPortfolioValue}) {
    return PositionsSummaryGetResponse(
      summarizedPositions: summarizedPositions ?? this.summarizedPositions,
      totalPortfolioValue: totalPortfolioValue ?? this.totalPortfolioValue,
    );
  }

  factory PositionsSummaryGetResponse.fromJson(Map<String, dynamic> json) {
    return PositionsSummaryGetResponse(
      summarizedPositions: json['summarizedPositions']
          ?.map<PositionsSummaryItem>((o) => PositionsSummaryItem.fromJson(o))
          .toList(),
      totalPortfolioValue: json['totalPortfolioValue']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['summarizedPositions'] =
        summarizedPositions?.map((item) => item.toJson()).toList();
    data['totalPortfolioValue'] = totalPortfolioValue;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PositionsSummaryGetResponse &&
            (identical(other.summarizedPositions, summarizedPositions) ||
                const DeepCollectionEquality()
                    .equals(other.summarizedPositions, summarizedPositions)) &&
            (identical(other.totalPortfolioValue, totalPortfolioValue) ||
                const DeepCollectionEquality()
                    .equals(other.totalPortfolioValue, totalPortfolioValue)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(summarizedPositions) ^
        const DeepCollectionEquality().hash(totalPortfolioValue);
  }

  @override
  String toString() => 'PositionsSummaryGetResponse(${toJson()})';
}
