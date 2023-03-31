import 'package:collection/collection.dart';

class BetweenInput {
  final DateTime? start;
  final DateTime? end;
  const BetweenInput({required this.start, this.end});
  BetweenInput copyWith({DateTime? start, DateTime? end}) {
    return BetweenInput(
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  factory BetweenInput.fromJson(Map<String, dynamic> json) {
    return BetweenInput(
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
        (other is BetweenInput &&
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
  String toString() => 'BetweenInput(${toJson()})';
}
