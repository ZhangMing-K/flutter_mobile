import 'package:collection/collection.dart';

class OverviewBetweenInput {
  final DateTime? start;
  final DateTime? end;
  const OverviewBetweenInput({required this.start, required this.end});
  OverviewBetweenInput copyWith({DateTime? start, DateTime? end}) {
    return OverviewBetweenInput(
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  factory OverviewBetweenInput.fromJson(Map<String, dynamic> json) {
    return OverviewBetweenInput(
      start: json['start'] != null ? DateTime.parse(json['start']) : null,
      end: json['end'] != null ? DateTime.parse(json['end']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['start'] = start?.toString();
    data['end'] = end?.toString();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is OverviewBetweenInput &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(start) ^
        const DeepCollectionEquality().hash(end);
  }

  @override
  String toString() => 'OverviewBetweenInput(${toJson()})';
}
