import 'package:collection/collection.dart';

class AdvancedUsersFollowingInput {
  final String? name;
  final int? limit;
  final int? offset;
  const AdvancedUsersFollowingInput({this.name, this.limit, this.offset});
  AdvancedUsersFollowingInput copyWith(
      {String? name, int? limit, int? offset}) {
    return AdvancedUsersFollowingInput(
      name: name ?? this.name,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory AdvancedUsersFollowingInput.fromJson(Map<String, dynamic> json) {
    return AdvancedUsersFollowingInput(
      name: json['name'],
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AdvancedUsersFollowingInput &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(name) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'AdvancedUsersFollowingInput(${toJson()})';
}
