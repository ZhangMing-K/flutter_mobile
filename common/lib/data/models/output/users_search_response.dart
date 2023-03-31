import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class UsersSearchResponse {
  final String? name;
  final List<User>? users;
  const UsersSearchResponse({this.name, this.users});
  UsersSearchResponse copyWith({String? name, List<User>? users}) {
    return UsersSearchResponse(
      name: name ?? this.name,
      users: users ?? this.users,
    );
  }

  factory UsersSearchResponse.fromJson(Map<String, dynamic> json) {
    return UsersSearchResponse(
      name: json['name'],
      users: json['users']?.map<User>((o) => User.fromJson(o)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['users'] = users?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UsersSearchResponse &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.users, users) ||
                const DeepCollectionEquality().equals(other.users, users)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(name) ^
        const DeepCollectionEquality().hash(users);
  }

  @override
  String toString() => 'UsersSearchResponse(${toJson()})';
}
