import 'package:iris_common/data/models/enums/historical_span.dart';
import 'package:collection/collection.dart';

class LeaderboardGetInput {
  final HISTORICAL_SPAN? span;
  final String? dayDate;
  final bool? mostRecent;
  final int? limit;
  final int? offset;
  const LeaderboardGetInput(
      {this.span, this.dayDate, this.mostRecent, this.limit, this.offset});
  LeaderboardGetInput copyWith(
      {HISTORICAL_SPAN? span,
      String? dayDate,
      bool? mostRecent,
      int? limit,
      int? offset}) {
    return LeaderboardGetInput(
      span: span ?? this.span,
      dayDate: dayDate ?? this.dayDate,
      mostRecent: mostRecent ?? this.mostRecent,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory LeaderboardGetInput.fromJson(Map<String, dynamic> json) {
    return LeaderboardGetInput(
      span: json['span'] != null
          ? HISTORICAL_SPAN.values.byName(json['span'])
          : null,
      dayDate: json['dayDate'],
      mostRecent: json['mostRecent'],
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['span'] = span?.name;
    data['dayDate'] = dayDate;
    data['mostRecent'] = mostRecent;
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LeaderboardGetInput &&
            (identical(other.span, span) ||
                const DeepCollectionEquality().equals(other.span, span)) &&
            (identical(other.dayDate, dayDate) ||
                const DeepCollectionEquality()
                    .equals(other.dayDate, dayDate)) &&
            (identical(other.mostRecent, mostRecent) ||
                const DeepCollectionEquality()
                    .equals(other.mostRecent, mostRecent)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(span) ^
        const DeepCollectionEquality().hash(dayDate) ^
        const DeepCollectionEquality().hash(mostRecent) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'LeaderboardGetInput(${toJson()})';
}
