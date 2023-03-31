import 'package:iris_common/data/models/enums/historical_span.dart';
import 'package:iris_common/data/models/enums/historical_interval.dart';
import 'package:iris_common/data/models/enums/historical_type.dart';
import 'package:iris_common/data/models/output/historical_point.dart';
import 'package:collection/collection.dart';

class PortfolioHistorical {
  final HISTORICAL_SPAN? span;
  final HISTORICAL_INTERVAL? interval;
  final HISTORICAL_TYPE? historicalType;
  final double? returnAmount;
  final double? openAmount;
  final double? closeAmount;
  final double? returnPercentage;
  final List<HistoricalPoint>? points;
  const PortfolioHistorical(
      {this.span,
      this.interval,
      this.historicalType,
      this.returnAmount,
      this.openAmount,
      this.closeAmount,
      this.returnPercentage,
      this.points});
  PortfolioHistorical copyWith(
      {HISTORICAL_SPAN? span,
      HISTORICAL_INTERVAL? interval,
      HISTORICAL_TYPE? historicalType,
      double? returnAmount,
      double? openAmount,
      double? closeAmount,
      double? returnPercentage,
      List<HistoricalPoint>? points}) {
    return PortfolioHistorical(
      span: span ?? this.span,
      interval: interval ?? this.interval,
      historicalType: historicalType ?? this.historicalType,
      returnAmount: returnAmount ?? this.returnAmount,
      openAmount: openAmount ?? this.openAmount,
      closeAmount: closeAmount ?? this.closeAmount,
      returnPercentage: returnPercentage ?? this.returnPercentage,
      points: points ?? this.points,
    );
  }

  factory PortfolioHistorical.fromJson(Map<String, dynamic> json) {
    return PortfolioHistorical(
      span: json['span'] != null
          ? HISTORICAL_SPAN.values.byName(json['span'])
          : null,
      interval: json['interval'] != null
          ? HISTORICAL_INTERVAL.values.byName(json['interval'])
          : null,
      historicalType: json['historicalType'] != null
          ? HISTORICAL_TYPE.values.byName(json['historicalType'])
          : null,
      returnAmount: json['returnAmount']?.toDouble(),
      openAmount: json['openAmount']?.toDouble(),
      closeAmount: json['closeAmount']?.toDouble(),
      returnPercentage: json['returnPercentage']?.toDouble(),
      points: json['points']
          ?.map<HistoricalPoint>((o) => HistoricalPoint.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['span'] = span?.name;
    data['interval'] = interval?.name;
    data['historicalType'] = historicalType?.name;
    data['returnAmount'] = returnAmount;
    data['openAmount'] = openAmount;
    data['closeAmount'] = closeAmount;
    data['returnPercentage'] = returnPercentage;
    data['points'] = points?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PortfolioHistorical &&
            (identical(other.span, span) ||
                const DeepCollectionEquality().equals(other.span, span)) &&
            (identical(other.interval, interval) ||
                const DeepCollectionEquality()
                    .equals(other.interval, interval)) &&
            (identical(other.historicalType, historicalType) ||
                const DeepCollectionEquality()
                    .equals(other.historicalType, historicalType)) &&
            (identical(other.returnAmount, returnAmount) ||
                const DeepCollectionEquality()
                    .equals(other.returnAmount, returnAmount)) &&
            (identical(other.openAmount, openAmount) ||
                const DeepCollectionEquality()
                    .equals(other.openAmount, openAmount)) &&
            (identical(other.closeAmount, closeAmount) ||
                const DeepCollectionEquality()
                    .equals(other.closeAmount, closeAmount)) &&
            (identical(other.returnPercentage, returnPercentage) ||
                const DeepCollectionEquality()
                    .equals(other.returnPercentage, returnPercentage)) &&
            (identical(other.points, points) ||
                const DeepCollectionEquality().equals(other.points, points)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(span) ^
        const DeepCollectionEquality().hash(interval) ^
        const DeepCollectionEquality().hash(historicalType) ^
        const DeepCollectionEquality().hash(returnAmount) ^
        const DeepCollectionEquality().hash(openAmount) ^
        const DeepCollectionEquality().hash(closeAmount) ^
        const DeepCollectionEquality().hash(returnPercentage) ^
        const DeepCollectionEquality().hash(points);
  }

  @override
  String toString() => 'PortfolioHistorical(${toJson()})';
}
