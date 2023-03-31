import 'package:collection/collection.dart';

class UsersGetInput {
  final List<int>? userKeys;
  const UsersGetInput({this.userKeys});
  UsersGetInput copyWith({List<int>? userKeys}) {
    return UsersGetInput(
      userKeys: userKeys ?? this.userKeys,
    );
  }

  factory UsersGetInput.fromJson(Map<String, dynamic> json) {
    return UsersGetInput(
      userKeys: json['userKeys']?.map<int>((o) => (o as int)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKeys'] = userKeys;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UsersGetInput &&
            (identical(other.userKeys, userKeys) ||
                const DeepCollectionEquality()
                    .equals(other.userKeys, userKeys)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(userKeys);
  }

  @override
  String toString() => 'UsersGetInput(${toJson()})';
}
