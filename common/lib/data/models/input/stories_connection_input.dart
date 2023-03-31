import 'package:collection/collection.dart';

class StoriesConnectionInput {
  final String? cursor;
  final int? limit;
  const StoriesConnectionInput({this.cursor, this.limit});
  StoriesConnectionInput copyWith({String? cursor, int? limit}) {
    return StoriesConnectionInput(
      cursor: cursor ?? this.cursor,
      limit: limit ?? this.limit,
    );
  }

  factory StoriesConnectionInput.fromJson(Map<String, dynamic> json) {
    return StoriesConnectionInput(
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
        (other is StoriesConnectionInput &&
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
  String toString() => 'StoriesConnectionInput(${toJson()})';
}
