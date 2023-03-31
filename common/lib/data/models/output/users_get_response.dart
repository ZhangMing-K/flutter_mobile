import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class UsersGetResponse {
  final List<User>? users;
  const UsersGetResponse({this.users});
  UsersGetResponse copyWith({List<User>? users}) {
    return UsersGetResponse(
      users: users ?? this.users,
    );
  }

  factory UsersGetResponse.fromJson(Map<String, dynamic> json) {
    return UsersGetResponse(
      users: json['users']?.map<User>((o) => User.fromJson(o)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['users'] = users?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UsersGetResponse &&
            (identical(other.users, users) ||
                const DeepCollectionEquality().equals(other.users, users)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(users);
  }

  @override
  String toString() => 'UsersGetResponse(${toJson()})';
}
