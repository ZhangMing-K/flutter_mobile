import 'package:collection/collection.dart';

class CollectionMessagesInput {
  final int? limit;
  final int? offset;
  final String? cursor;
  const CollectionMessagesInput({this.limit, this.offset, this.cursor});
  CollectionMessagesInput copyWith({int? limit, int? offset, String? cursor}) {
    return CollectionMessagesInput(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      cursor: cursor ?? this.cursor,
    );
  }

  factory CollectionMessagesInput.fromJson(Map<String, dynamic> json) {
    return CollectionMessagesInput(
      limit: json['limit'],
      offset: json['offset'],
      cursor: json['cursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['limit'] = limit;
    data['offset'] = offset;
    data['cursor'] = cursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CollectionMessagesInput &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.cursor, cursor) ||
                const DeepCollectionEquality().equals(other.cursor, cursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(cursor);
  }

  @override
  String toString() => 'CollectionMessagesInput(${toJson()})';
}
