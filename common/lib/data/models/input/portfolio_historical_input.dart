import 'package:iris_common/data/models/enums/historical_span.dart';
import 'package:iris_common/data/models/enums/historical_interval.dart';
import 'package:collection/collection.dart';

class PortfolioHistoricalInput {
  final HISTORICAL_SPAN? span;
  final HISTORICAL_INTERVAL? interval;
  const PortfolioHistoricalInput({required this.span, this.interval});
  PortfolioHistoricalInput copyWith(
      {HISTORICAL_SPAN? span, HISTORICAL_INTERVAL? interval}) {
    return PortfolioHistoricalInput(
      span: span ?? this.span,
      interval: interval ?? this.interval,
    );
  }

  factory PortfolioHistoricalInput.fromJson(Map<String, dynamic> json) {
    return PortfolioHistoricalInput(
      span: json['span'] != null
          ? HISTORICAL_SPAN.values.byName(json['span'])
          : null,
      interval: json['interval'] != null
          ? HISTORICAL_INTERVAL.values.byName(json['interval'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['span'] = span?.name;
    data['interval'] = interval?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PortfolioHistoricalInput &&
            (identical(other.span, span) ||
                const DeepCollectionEquality().equals(other.span, span)) &&
            (identical(other.interval, interval) ||
                const DeepCollectionEquality()
                    .equals(other.interval, interval)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(span) ^
        const DeepCollectionEquality().hash(interval);
  }

  @override
  String toString() => 'PortfolioHistoricalInput(${toJson()})';
}
