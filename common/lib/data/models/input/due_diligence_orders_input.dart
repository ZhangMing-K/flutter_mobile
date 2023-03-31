import 'package:collection/collection.dart';

class DueDiligenceOrdersInput {
  final int? limit;
  final int? offset;
  const DueDiligenceOrdersInput({this.limit, this.offset});
  DueDiligenceOrdersInput copyWith({int? limit, int? offset}) {
    return DueDiligenceOrdersInput(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory DueDiligenceOrdersInput.fromJson(Map<String, dynamic> json) {
    return DueDiligenceOrdersInput(
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DueDiligenceOrdersInput &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'DueDiligenceOrdersInput(${toJson()})';
}
