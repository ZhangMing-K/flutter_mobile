import 'package:iris_common/data/models/enums/historical_span.dart';
import 'package:collection/collection.dart';

class SpanPercentageInput {
  final HISTORICAL_SPAN? span;
  const SpanPercentageInput({required this.span});
  SpanPercentageInput copyWith({HISTORICAL_SPAN? span}) {
    return SpanPercentageInput(
      span: span ?? this.span,
    );
  }

  factory SpanPercentageInput.fromJson(Map<String, dynamic> json) {
    return SpanPercentageInput(
      span: json['span'] != null
          ? HISTORICAL_SPAN.values.byName(json['span'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['span'] = span?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SpanPercentageInput &&
            (identical(other.span, span) ||
                const DeepCollectionEquality().equals(other.span, span)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(span);
  }

  @override
  String toString() => 'SpanPercentageInput(${toJson()})';
}
