import 'package:collection/collection.dart';

class UsersInput {
  final int? limit;
  final int? offset;
  const UsersInput({this.limit, this.offset});
  UsersInput copyWith({int? limit, int? offset}) {
    return UsersInput(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory UsersInput.fromJson(Map<String, dynamic> json) {
    return UsersInput(
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
        (other is UsersInput &&
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
  String toString() => 'UsersInput(${toJson()})';
}
