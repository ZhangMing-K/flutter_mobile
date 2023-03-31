import 'package:iris_common/data/models/output/leaderboard_instance.dart';
import 'package:iris_common/data/models/enums/historical_span.dart';
import 'package:collection/collection.dart';

class Leaderboard {
  final List<LeaderboardInstance>? instances;
  final DateTime? dayDate;
  final HISTORICAL_SPAN? span;
  final int? totalNumberPortfolios;
  const Leaderboard(
      {this.instances, this.dayDate, this.span, this.totalNumberPortfolios});
  Leaderboard copyWith(
      {List<LeaderboardInstance>? instances,
      DateTime? dayDate,
      HISTORICAL_SPAN? span,
      int? totalNumberPortfolios}) {
    return Leaderboard(
      instances: instances ?? this.instances,
      dayDate: dayDate ?? this.dayDate,
      span: span ?? this.span,
      totalNumberPortfolios:
          totalNumberPortfolios ?? this.totalNumberPortfolios,
    );
  }

  factory Leaderboard.fromJson(Map<String, dynamic> json) {
    return Leaderboard(
      instances: json['instances']
          ?.map<LeaderboardInstance>((o) => LeaderboardInstance.fromJson(o))
          .toList(),
      dayDate: json['dayDate'] != null ? DateTime.parse(json['dayDate']) : null,
      span: json['span'] != null
          ? HISTORICAL_SPAN.values.byName(json['span'])
          : null,
      totalNumberPortfolios: json['totalNumberPortfolios'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['instances'] = instances?.map((item) => item.toJson()).toList();
    data['dayDate'] = dayDate?.toString();
    data['span'] = span?.name;
    data['totalNumberPortfolios'] = totalNumberPortfolios;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Leaderboard &&
            (identical(other.instances, instances) ||
                const DeepCollectionEquality()
                    .equals(other.instances, instances)) &&
            (identical(other.dayDate, dayDate) ||
                const DeepCollectionEquality()
                    .equals(other.dayDate, dayDate)) &&
            (identical(other.span, span) ||
                const DeepCollectionEquality().equals(other.span, span)) &&
            (identical(other.totalNumberPortfolios, totalNumberPortfolios) ||
                const DeepCollectionEquality().equals(
                    other.totalNumberPortfolios, totalNumberPortfolios)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(instances) ^
        const DeepCollectionEquality().hash(dayDate) ^
        const DeepCollectionEquality().hash(span) ^
        const DeepCollectionEquality().hash(totalNumberPortfolios);
  }

  @override
  String toString() => 'Leaderboard(${toJson()})';
}
