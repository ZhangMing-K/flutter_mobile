import 'package:collection/collection.dart';

class AutoPilotPortfolioPerformanceInfo {
  final double? yearlyAvg;
  final double? lastYear;
  final int? nbrTradesPerMonth;
  final double? length;
  const AutoPilotPortfolioPerformanceInfo(
      {this.yearlyAvg, this.lastYear, this.nbrTradesPerMonth, this.length});
  AutoPilotPortfolioPerformanceInfo copyWith(
      {double? yearlyAvg,
      double? lastYear,
      int? nbrTradesPerMonth,
      double? length}) {
    return AutoPilotPortfolioPerformanceInfo(
      yearlyAvg: yearlyAvg ?? this.yearlyAvg,
      lastYear: lastYear ?? this.lastYear,
      nbrTradesPerMonth: nbrTradesPerMonth ?? this.nbrTradesPerMonth,
      length: length ?? this.length,
    );
  }

  factory AutoPilotPortfolioPerformanceInfo.fromJson(
      Map<String, dynamic> json) {
    return AutoPilotPortfolioPerformanceInfo(
      yearlyAvg: json['yearlyAvg']?.toDouble(),
      lastYear: json['lastYear']?.toDouble(),
      nbrTradesPerMonth: json['nbrTradesPerMonth'],
      length: json['length']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['yearlyAvg'] = yearlyAvg;
    data['lastYear'] = lastYear;
    data['nbrTradesPerMonth'] = nbrTradesPerMonth;
    data['length'] = length;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotPortfolioPerformanceInfo &&
            (identical(other.yearlyAvg, yearlyAvg) ||
                const DeepCollectionEquality()
                    .equals(other.yearlyAvg, yearlyAvg)) &&
            (identical(other.lastYear, lastYear) ||
                const DeepCollectionEquality()
                    .equals(other.lastYear, lastYear)) &&
            (identical(other.nbrTradesPerMonth, nbrTradesPerMonth) ||
                const DeepCollectionEquality()
                    .equals(other.nbrTradesPerMonth, nbrTradesPerMonth)) &&
            (identical(other.length, length) ||
                const DeepCollectionEquality().equals(other.length, length)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(yearlyAvg) ^
        const DeepCollectionEquality().hash(lastYear) ^
        const DeepCollectionEquality().hash(nbrTradesPerMonth) ^
        const DeepCollectionEquality().hash(length);
  }

  @override
  String toString() => 'AutoPilotPortfolioPerformanceInfo(${toJson()})';
}
