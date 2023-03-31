import 'package:collection/collection.dart';

class TemporarySnapshotHistoricalPoints {
  final double? dayPercent;
  final double? weekPercent;
  final double? monthPercent;
  final double? threeMonthPercent;
  final double? yearPercent;
  final double? allPercent;
  final DateTime? lastUpdated;
  const TemporarySnapshotHistoricalPoints(
      {this.dayPercent,
      this.weekPercent,
      this.monthPercent,
      this.threeMonthPercent,
      this.yearPercent,
      this.allPercent,
      this.lastUpdated});
  TemporarySnapshotHistoricalPoints copyWith(
      {double? dayPercent,
      double? weekPercent,
      double? monthPercent,
      double? threeMonthPercent,
      double? yearPercent,
      double? allPercent,
      DateTime? lastUpdated}) {
    return TemporarySnapshotHistoricalPoints(
      dayPercent: dayPercent ?? this.dayPercent,
      weekPercent: weekPercent ?? this.weekPercent,
      monthPercent: monthPercent ?? this.monthPercent,
      threeMonthPercent: threeMonthPercent ?? this.threeMonthPercent,
      yearPercent: yearPercent ?? this.yearPercent,
      allPercent: allPercent ?? this.allPercent,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  factory TemporarySnapshotHistoricalPoints.fromJson(
      Map<String, dynamic> json) {
    return TemporarySnapshotHistoricalPoints(
      dayPercent: json['dayPercent']?.toDouble(),
      weekPercent: json['weekPercent']?.toDouble(),
      monthPercent: json['monthPercent']?.toDouble(),
      threeMonthPercent: json['threeMonthPercent']?.toDouble(),
      yearPercent: json['yearPercent']?.toDouble(),
      allPercent: json['allPercent']?.toDouble(),
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['dayPercent'] = dayPercent;
    data['weekPercent'] = weekPercent;
    data['monthPercent'] = monthPercent;
    data['threeMonthPercent'] = threeMonthPercent;
    data['yearPercent'] = yearPercent;
    data['allPercent'] = allPercent;
    data['lastUpdated'] = lastUpdated?.toString();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TemporarySnapshotHistoricalPoints &&
            (identical(other.dayPercent, dayPercent) ||
                const DeepCollectionEquality()
                    .equals(other.dayPercent, dayPercent)) &&
            (identical(other.weekPercent, weekPercent) ||
                const DeepCollectionEquality()
                    .equals(other.weekPercent, weekPercent)) &&
            (identical(other.monthPercent, monthPercent) ||
                const DeepCollectionEquality()
                    .equals(other.monthPercent, monthPercent)) &&
            (identical(other.threeMonthPercent, threeMonthPercent) ||
                const DeepCollectionEquality()
                    .equals(other.threeMonthPercent, threeMonthPercent)) &&
            (identical(other.yearPercent, yearPercent) ||
                const DeepCollectionEquality()
                    .equals(other.yearPercent, yearPercent)) &&
            (identical(other.allPercent, allPercent) ||
                const DeepCollectionEquality()
                    .equals(other.allPercent, allPercent)) &&
            (identical(other.lastUpdated, lastUpdated) ||
                const DeepCollectionEquality()
                    .equals(other.lastUpdated, lastUpdated)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(dayPercent) ^
        const DeepCollectionEquality().hash(weekPercent) ^
        const DeepCollectionEquality().hash(monthPercent) ^
        const DeepCollectionEquality().hash(threeMonthPercent) ^
        const DeepCollectionEquality().hash(yearPercent) ^
        const DeepCollectionEquality().hash(allPercent) ^
        const DeepCollectionEquality().hash(lastUpdated);
  }

  @override
  String toString() => 'TemporarySnapshotHistoricalPoints(${toJson()})';
}
