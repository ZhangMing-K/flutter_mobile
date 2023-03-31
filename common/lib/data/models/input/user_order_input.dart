import 'package:collection/collection.dart';

class UserOrderInput {
  final int? limit;
  final int? offset;
  const UserOrderInput({this.limit, this.offset});
  UserOrderInput copyWith({int? limit, int? offset}) {
    return UserOrderInput(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory UserOrderInput.fromJson(Map<String, dynamic> json) {
    return UserOrderInput(
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
        (other is UserOrderInput &&
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
  String toString() => 'UserOrderInput(${toJson()})';
}
