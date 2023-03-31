import 'package:iris_common/data/models/enums/historical_interval.dart';
import 'package:iris_common/data/models/enums/historical_span.dart';
import 'package:iris_common/data/models/enums/historical_type.dart';
import 'package:iris_common/data/models/output/historical_point.dart';
import 'package:collection/collection.dart';

class Historical {
  final HISTORICAL_INTERVAL? interval;
  final HISTORICAL_SPAN? span;
  final HISTORICAL_TYPE? historicalType;
  final double? openAmount;
  final double? closeAmount;
  final double? returnAmount;
  final double? returnPercentage;
  final List<HistoricalPoint>? points;
  const Historical(
      {this.interval,
      this.span,
      this.historicalType,
      this.openAmount,
      this.closeAmount,
      this.returnAmount,
      this.returnPercentage,
      this.points});
  Historical copyWith(
      {HISTORICAL_INTERVAL? interval,
      HISTORICAL_SPAN? span,
      HISTORICAL_TYPE? historicalType,
      double? openAmount,
      double? closeAmount,
      double? returnAmount,
      double? returnPercentage,
      List<HistoricalPoint>? points}) {
    return Historical(
      interval: interval ?? this.interval,
      span: span ?? this.span,
      historicalType: historicalType ?? this.historicalType,
      openAmount: openAmount ?? this.openAmount,
      closeAmount: closeAmount ?? this.closeAmount,
      returnAmount: returnAmount ?? this.returnAmount,
      returnPercentage: returnPercentage ?? this.returnPercentage,
      points: points ?? this.points,
    );
  }

  factory Historical.fromJson(Map<String, dynamic> json) {
    return Historical(
      interval: json['interval'] != null
          ? HISTORICAL_INTERVAL.values.byName(json['interval'])
          : null,
      span: json['span'] != null
          ? HISTORICAL_SPAN.values.byName(json['span'])
          : null,
      historicalType: json['historicalType'] != null
          ? HISTORICAL_TYPE.values.byName(json['historicalType'])
          : null,
      openAmount: json['openAmount']?.toDouble(),
      closeAmount: json['closeAmount']?.toDouble(),
      returnAmount: json['returnAmount']?.toDouble(),
      returnPercentage: json['returnPercentage']?.toDouble(),
      points: json['points']
          ?.map<HistoricalPoint>((o) => HistoricalPoint.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['interval'] = interval?.name;
    data['span'] = span?.name;
    data['historicalType'] = historicalType?.name;
    data['openAmount'] = openAmount;
    data['closeAmount'] = closeAmount;
    data['returnAmount'] = returnAmount;
    data['returnPercentage'] = returnPercentage;
    data['points'] = points?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Historical &&
            (identical(other.interval, interval) ||
                const DeepCollectionEquality()
                    .equals(other.interval, interval)) &&
            (identical(other.span, span) ||
                const DeepCollectionEquality().equals(other.span, span)) &&
            (identical(other.historicalType, historicalType) ||
                const DeepCollectionEquality()
                    .equals(other.historicalType, historicalType)) &&
            (identical(other.openAmount, openAmount) ||
                const DeepCollectionEquality()
                    .equals(other.openAmount, openAmount)) &&
            (identical(other.closeAmount, closeAmount) ||
                const DeepCollectionEquality()
                    .equals(other.closeAmount, closeAmount)) &&
            (identical(other.returnAmount, returnAmount) ||
                const DeepCollectionEquality()
                    .equals(other.returnAmount, returnAmount)) &&
            (identical(other.returnPercentage, returnPercentage) ||
                const DeepCollectionEquality()
                    .equals(other.returnPercentage, returnPercentage)) &&
            (identical(other.points, points) ||
                const DeepCollectionEquality().equals(other.points, points)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(interval) ^
        const DeepCollectionEquality().hash(span) ^
        const DeepCollectionEquality().hash(historicalType) ^
        const DeepCollectionEquality().hash(openAmount) ^
        const DeepCollectionEquality().hash(closeAmount) ^
        const DeepCollectionEquality().hash(returnAmount) ^
        const DeepCollectionEquality().hash(returnPercentage) ^
        const DeepCollectionEquality().hash(points);
  }

  @override
  String toString() => 'Historical(${toJson()})';
}
