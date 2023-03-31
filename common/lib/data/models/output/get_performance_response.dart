import 'package:iris_common/data/models/output/timeseries.dart';
import 'package:collection/collection.dart';

class GetPerformanceResponse {
  final double? startingMarketValue;
  final double? endingMarketValue;
  final double? profitLossPercent;
  final List<Timeseries>? timeseries;
  const GetPerformanceResponse(
      {this.startingMarketValue,
      this.endingMarketValue,
      required this.profitLossPercent,
      required this.timeseries});
  GetPerformanceResponse copyWith(
      {double? startingMarketValue,
      double? endingMarketValue,
      double? profitLossPercent,
      List<Timeseries>? timeseries}) {
    return GetPerformanceResponse(
      startingMarketValue: startingMarketValue ?? this.startingMarketValue,
      endingMarketValue: endingMarketValue ?? this.endingMarketValue,
      profitLossPercent: profitLossPercent ?? this.profitLossPercent,
      timeseries: timeseries ?? this.timeseries,
    );
  }

  factory GetPerformanceResponse.fromJson(Map<String, dynamic> json) {
    return GetPerformanceResponse(
      startingMarketValue: json['startingMarketValue']?.toDouble(),
      endingMarketValue: json['endingMarketValue']?.toDouble(),
      profitLossPercent: json['profitLossPercent']?.toDouble(),
      timeseries: json['timeseries']
          ?.map<Timeseries>((o) => Timeseries.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['startingMarketValue'] = startingMarketValue;
    data['endingMarketValue'] = endingMarketValue;
    data['profitLossPercent'] = profitLossPercent;
    data['timeseries'] = timeseries?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetPerformanceResponse &&
            (identical(other.startingMarketValue, startingMarketValue) ||
                const DeepCollectionEquality()
                    .equals(other.startingMarketValue, startingMarketValue)) &&
            (identical(other.endingMarketValue, endingMarketValue) ||
                const DeepCollectionEquality()
                    .equals(other.endingMarketValue, endingMarketValue)) &&
            (identical(other.profitLossPercent, profitLossPercent) ||
                const DeepCollectionEquality()
                    .equals(other.profitLossPercent, profitLossPercent)) &&
            (identical(other.timeseries, timeseries) ||
                const DeepCollectionEquality()
                    .equals(other.timeseries, timeseries)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(startingMarketValue) ^
        const DeepCollectionEquality().hash(endingMarketValue) ^
        const DeepCollectionEquality().hash(profitLossPercent) ^
        const DeepCollectionEquality().hash(timeseries);
  }

  @override
  String toString() => 'GetPerformanceResponse(${toJson()})';
}
