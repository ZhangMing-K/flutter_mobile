import 'package:collection/collection.dart';

class FollowerFeedInput {
  final String? cursor;
  const FollowerFeedInput({this.cursor});
  FollowerFeedInput copyWith({String? cursor}) {
    return FollowerFeedInput(
      cursor: cursor ?? this.cursor,
    );
  }

  factory FollowerFeedInput.fromJson(Map<String, dynamic> json) {
    return FollowerFeedInput(
      cursor: json['cursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['cursor'] = cursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FollowerFeedInput &&
            (identical(other.cursor, cursor) ||
                const DeepCollectionEquality().equals(other.cursor, cursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(cursor);
  }

  @override
  String toString() => 'FollowerFeedInput(${toJson()})';
}
