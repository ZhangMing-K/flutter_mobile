import 'package:iris_common/data/models/output/trade_statistics.dart';
import 'package:collection/collection.dart';

class TradeStatisticsGetResponse {
  final List<TradeStatistics>? tradeStatistics;
  const TradeStatisticsGetResponse({this.tradeStatistics});
  TradeStatisticsGetResponse copyWith(
      {List<TradeStatistics>? tradeStatistics}) {
    return TradeStatisticsGetResponse(
      tradeStatistics: tradeStatistics ?? this.tradeStatistics,
    );
  }

  factory TradeStatisticsGetResponse.fromJson(Map<String, dynamic> json) {
    return TradeStatisticsGetResponse(
      tradeStatistics: json['tradeStatistics']
          ?.map<TradeStatistics>((o) => TradeStatistics.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['tradeStatistics'] =
        tradeStatistics?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TradeStatisticsGetResponse &&
            (identical(other.tradeStatistics, tradeStatistics) ||
                const DeepCollectionEquality()
                    .equals(other.tradeStatistics, tradeStatistics)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(tradeStatistics);
  }

  @override
  String toString() => 'TradeStatisticsGetResponse(${toJson()})';
}
