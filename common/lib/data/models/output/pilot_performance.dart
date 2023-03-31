import 'package:collection/collection.dart';

class PilotPerformance {
  final double? yearlyAverage;
  final double? currentYear;
  final double? previousYear;
  final double? yearsTrading;
  const PilotPerformance(
      {this.yearlyAverage,
      this.currentYear,
      this.previousYear,
      this.yearsTrading});
  PilotPerformance copyWith(
      {double? yearlyAverage,
      double? currentYear,
      double? previousYear,
      double? yearsTrading}) {
    return PilotPerformance(
      yearlyAverage: yearlyAverage ?? this.yearlyAverage,
      currentYear: currentYear ?? this.currentYear,
      previousYear: previousYear ?? this.previousYear,
      yearsTrading: yearsTrading ?? this.yearsTrading,
    );
  }

  factory PilotPerformance.fromJson(Map<String, dynamic> json) {
    return PilotPerformance(
      yearlyAverage: json['yearlyAverage']?.toDouble(),
      currentYear: json['currentYear']?.toDouble(),
      previousYear: json['previousYear']?.toDouble(),
      yearsTrading: json['yearsTrading']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['yearlyAverage'] = yearlyAverage;
    data['currentYear'] = currentYear;
    data['previousYear'] = previousYear;
    data['yearsTrading'] = yearsTrading;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PilotPerformance &&
            (identical(other.yearlyAverage, yearlyAverage) ||
                const DeepCollectionEquality()
                    .equals(other.yearlyAverage, yearlyAverage)) &&
            (identical(other.currentYear, currentYear) ||
                const DeepCollectionEquality()
                    .equals(other.currentYear, currentYear)) &&
            (identical(other.previousYear, previousYear) ||
                const DeepCollectionEquality()
                    .equals(other.previousYear, previousYear)) &&
            (identical(other.yearsTrading, yearsTrading) ||
                const DeepCollectionEquality()
                    .equals(other.yearsTrading, yearsTrading)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(yearlyAverage) ^
        const DeepCollectionEquality().hash(currentYear) ^
        const DeepCollectionEquality().hash(previousYear) ^
        const DeepCollectionEquality().hash(yearsTrading);
  }

  @override
  String toString() => 'PilotPerformance(${toJson()})';
}
