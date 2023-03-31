import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/enums/snapshot_type.dart';
import 'package:collection/collection.dart';

class Snapshot {
  final int? snapshotKey;
  final int? portfolioKey;
  final Portfolio? portfolio;
  final SNAPSHOT_TYPE? snapshotType;
  final double? dayPercent;
  final double? weekPercent;
  final double? monthPercent;
  final double? threeMonthPercent;
  final double? yearPercent;
  final double? fiveYearPercent;
  final double? allPercent;
  final DateTime? snapShotDayDate;
  final double? leveragePercent;
  final DateTime? lastUpdatedAt;
  const Snapshot(
      {this.snapshotKey,
      this.portfolioKey,
      this.portfolio,
      this.snapshotType,
      this.dayPercent,
      this.weekPercent,
      this.monthPercent,
      this.threeMonthPercent,
      this.yearPercent,
      this.fiveYearPercent,
      this.allPercent,
      this.snapShotDayDate,
      this.leveragePercent,
      this.lastUpdatedAt});
  Snapshot copyWith(
      {int? snapshotKey,
      int? portfolioKey,
      Portfolio? portfolio,
      SNAPSHOT_TYPE? snapshotType,
      double? dayPercent,
      double? weekPercent,
      double? monthPercent,
      double? threeMonthPercent,
      double? yearPercent,
      double? fiveYearPercent,
      double? allPercent,
      DateTime? snapShotDayDate,
      double? leveragePercent,
      DateTime? lastUpdatedAt}) {
    return Snapshot(
      snapshotKey: snapshotKey ?? this.snapshotKey,
      portfolioKey: portfolioKey ?? this.portfolioKey,
      portfolio: portfolio ?? this.portfolio,
      snapshotType: snapshotType ?? this.snapshotType,
      dayPercent: dayPercent ?? this.dayPercent,
      weekPercent: weekPercent ?? this.weekPercent,
      monthPercent: monthPercent ?? this.monthPercent,
      threeMonthPercent: threeMonthPercent ?? this.threeMonthPercent,
      yearPercent: yearPercent ?? this.yearPercent,
      fiveYearPercent: fiveYearPercent ?? this.fiveYearPercent,
      allPercent: allPercent ?? this.allPercent,
      snapShotDayDate: snapShotDayDate ?? this.snapShotDayDate,
      leveragePercent: leveragePercent ?? this.leveragePercent,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
    );
  }

  factory Snapshot.fromJson(Map<String, dynamic> json) {
    return Snapshot(
      snapshotKey: json['snapshotKey'],
      portfolioKey: json['portfolioKey'],
      portfolio: json['portfolio'] != null
          ? Portfolio.fromJson(json['portfolio'])
          : null,
      snapshotType: json['snapshotType'] != null
          ? SNAPSHOT_TYPE.values.byName(json['snapshotType'])
          : null,
      dayPercent: json['dayPercent']?.toDouble(),
      weekPercent: json['weekPercent']?.toDouble(),
      monthPercent: json['monthPercent']?.toDouble(),
      threeMonthPercent: json['threeMonthPercent']?.toDouble(),
      yearPercent: json['yearPercent']?.toDouble(),
      fiveYearPercent: json['fiveYearPercent']?.toDouble(),
      allPercent: json['allPercent']?.toDouble(),
      snapShotDayDate: json['snapShotDayDate'] != null
          ? DateTime.parse(json['snapShotDayDate'])
          : null,
      leveragePercent: json['leveragePercent']?.toDouble(),
      lastUpdatedAt: json['lastUpdatedAt'] != null
          ? DateTime.parse(json['lastUpdatedAt'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['snapshotKey'] = snapshotKey;
    data['portfolioKey'] = portfolioKey;
    data['portfolio'] = portfolio?.toJson();
    data['snapshotType'] = snapshotType?.name;
    data['dayPercent'] = dayPercent;
    data['weekPercent'] = weekPercent;
    data['monthPercent'] = monthPercent;
    data['threeMonthPercent'] = threeMonthPercent;
    data['yearPercent'] = yearPercent;
    data['fiveYearPercent'] = fiveYearPercent;
    data['allPercent'] = allPercent;
    data['snapShotDayDate'] = snapShotDayDate?.toString();
    data['leveragePercent'] = leveragePercent;
    data['lastUpdatedAt'] = lastUpdatedAt?.toString();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Snapshot &&
            (identical(other.snapshotKey, snapshotKey) ||
                const DeepCollectionEquality()
                    .equals(other.snapshotKey, snapshotKey)) &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.portfolio, portfolio) ||
                const DeepCollectionEquality()
                    .equals(other.portfolio, portfolio)) &&
            (identical(other.snapshotType, snapshotType) ||
                const DeepCollectionEquality()
                    .equals(other.snapshotType, snapshotType)) &&
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
            (identical(other.fiveYearPercent, fiveYearPercent) ||
                const DeepCollectionEquality()
                    .equals(other.fiveYearPercent, fiveYearPercent)) &&
            (identical(other.allPercent, allPercent) ||
                const DeepCollectionEquality()
                    .equals(other.allPercent, allPercent)) &&
            (identical(other.snapShotDayDate, snapShotDayDate) ||
                const DeepCollectionEquality()
                    .equals(other.snapShotDayDate, snapShotDayDate)) &&
            (identical(other.leveragePercent, leveragePercent) ||
                const DeepCollectionEquality()
                    .equals(other.leveragePercent, leveragePercent)) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.lastUpdatedAt, lastUpdatedAt)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(snapshotKey) ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(portfolio) ^
        const DeepCollectionEquality().hash(snapshotType) ^
        const DeepCollectionEquality().hash(dayPercent) ^
        const DeepCollectionEquality().hash(weekPercent) ^
        const DeepCollectionEquality().hash(monthPercent) ^
        const DeepCollectionEquality().hash(threeMonthPercent) ^
        const DeepCollectionEquality().hash(yearPercent) ^
        const DeepCollectionEquality().hash(fiveYearPercent) ^
        const DeepCollectionEquality().hash(allPercent) ^
        const DeepCollectionEquality().hash(snapShotDayDate) ^
        const DeepCollectionEquality().hash(leveragePercent) ^
        const DeepCollectionEquality().hash(lastUpdatedAt);
  }

  @override
  String toString() => 'Snapshot(${toJson()})';
}
