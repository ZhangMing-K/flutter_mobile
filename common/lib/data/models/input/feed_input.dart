import 'package:collection/collection.dart';

class FeedInput {
  final String? cursor;
  final int? limit;
  const FeedInput({this.cursor, this.limit});
  FeedInput copyWith({String? cursor, int? limit}) {
    return FeedInput(
      cursor: cursor ?? this.cursor,
      limit: limit ?? this.limit,
    );
  }

  factory FeedInput.fromJson(Map<String, dynamic> json) {
    return FeedInput(
      cursor: json['cursor'],
      limit: json['limit'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['cursor'] = cursor;
    data['limit'] = limit;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FeedInput &&
            (identical(other.cursor, cursor) ||
                const DeepCollectionEquality().equals(other.cursor, cursor)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(cursor) ^
        const DeepCollectionEquality().hash(limit);
  }

  @override
  String toString() => 'FeedInput(${toJson()})';
}
