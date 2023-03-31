import 'package:collection/collection.dart';

class RelativePositionMetrics {
  final double? portfolioAllocation;
  final double? totalProfitLossPercent;
  final double? todayProfitLossPercent;
  const RelativePositionMetrics(
      {required this.portfolioAllocation,
      required this.totalProfitLossPercent,
      required this.todayProfitLossPercent});
  RelativePositionMetrics copyWith(
      {double? portfolioAllocation,
      double? totalProfitLossPercent,
      double? todayProfitLossPercent}) {
    return RelativePositionMetrics(
      portfolioAllocation: portfolioAllocation ?? this.portfolioAllocation,
      totalProfitLossPercent:
          totalProfitLossPercent ?? this.totalProfitLossPercent,
      todayProfitLossPercent:
          todayProfitLossPercent ?? this.todayProfitLossPercent,
    );
  }

  factory RelativePositionMetrics.fromJson(Map<String, dynamic> json) {
    return RelativePositionMetrics(
      portfolioAllocation: json['portfolioAllocation']?.toDouble(),
      totalProfitLossPercent: json['totalProfitLossPercent']?.toDouble(),
      todayProfitLossPercent: json['todayProfitLossPercent']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['portfolioAllocation'] = portfolioAllocation;
    data['totalProfitLossPercent'] = totalProfitLossPercent;
    data['todayProfitLossPercent'] = todayProfitLossPercent;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RelativePositionMetrics &&
            (identical(other.portfolioAllocation, portfolioAllocation) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioAllocation, portfolioAllocation)) &&
            (identical(other.totalProfitLossPercent, totalProfitLossPercent) ||
                const DeepCollectionEquality().equals(
                    other.totalProfitLossPercent, totalProfitLossPercent)) &&
            (identical(other.todayProfitLossPercent, todayProfitLossPercent) ||
                const DeepCollectionEquality().equals(
                    other.todayProfitLossPercent, todayProfitLossPercent)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(portfolioAllocation) ^
        const DeepCollectionEquality().hash(totalProfitLossPercent) ^
        const DeepCollectionEquality().hash(todayProfitLossPercent);
  }

  @override
  String toString() => 'RelativePositionMetrics(${toJson()})';
}
