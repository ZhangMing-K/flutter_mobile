import 'package:iris_common/data/models/enums/historical_span.dart';
import 'package:collection/collection.dart';

class AssetHistoricalInput {
  final HISTORICAL_SPAN? span;
  const AssetHistoricalInput({this.span});
  AssetHistoricalInput copyWith({HISTORICAL_SPAN? span}) {
    return AssetHistoricalInput(
      span: span ?? this.span,
    );
  }

  factory AssetHistoricalInput.fromJson(Map<String, dynamic> json) {
    return AssetHistoricalInput(
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
        (other is AssetHistoricalInput &&
            (identical(other.span, span) ||
                const DeepCollectionEquality().equals(other.span, span)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(span);
  }

  @override
  String toString() => 'AssetHistoricalInput(${toJson()})';
}
