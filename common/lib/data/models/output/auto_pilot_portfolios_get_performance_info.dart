import 'package:collection/collection.dart';

class AutoPilotPortfoliosGetPerformanceInfo {
  final double? yearlyAvg;
  final double? lastYear;
  final int? nbrTradesPerMonth;
  final double? length;
  const AutoPilotPortfoliosGetPerformanceInfo(
      {this.yearlyAvg, this.lastYear, this.nbrTradesPerMonth, this.length});
  AutoPilotPortfoliosGetPerformanceInfo copyWith(
      {double? yearlyAvg,
      double? lastYear,
      int? nbrTradesPerMonth,
      double? length}) {
    return AutoPilotPortfoliosGetPerformanceInfo(
      yearlyAvg: yearlyAvg ?? this.yearlyAvg,
      lastYear: lastYear ?? this.lastYear,
      nbrTradesPerMonth: nbrTradesPerMonth ?? this.nbrTradesPerMonth,
      length: length ?? this.length,
    );
  }

  factory AutoPilotPortfoliosGetPerformanceInfo.fromJson(
      Map<String, dynamic> json) {
    return AutoPilotPortfoliosGetPerformanceInfo(
      yearlyAvg: json['yearlyAvg']?.toDouble(),
      lastYear: json['lastYear']?.toDouble(),
      nbrTradesPerMonth: json['nbrTradesPerMonth'],
      length: json['length']?.toDouble(),
    );
  }

  Map toJson() {
    Map _data = {};
    _data['yearlyAvg'] = yearlyAvg;
    _data['lastYear'] = lastYear;
    _data['nbrTradesPerMonth'] = nbrTradesPerMonth;
    _data['length'] = length;
    return _data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotPortfoliosGetPerformanceInfo &&
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
}
