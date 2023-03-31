import 'package:collection/collection.dart';

class UsersFromContactsInput {
  final int? limit;
  final int? offset;
  final bool? recomended;
  const UsersFromContactsInput(
      {required this.limit, required this.offset, this.recomended});
  UsersFromContactsInput copyWith({int? limit, int? offset, bool? recomended}) {
    return UsersFromContactsInput(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      recomended: recomended ?? this.recomended,
    );
  }

  factory UsersFromContactsInput.fromJson(Map<String, dynamic> json) {
    return UsersFromContactsInput(
      limit: json['limit'],
      offset: json['offset'],
      recomended: json['recomended'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['limit'] = limit;
    data['offset'] = offset;
    data['recomended'] = recomended;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UsersFromContactsInput &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.recomended, recomended) ||
                const DeepCollectionEquality()
                    .equals(other.recomended, recomended)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(recomended);
  }

  @override
  String toString() => 'UsersFromContactsInput(${toJson()})';
}
