import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class UserEditResponse {
  final User? user;
  const UserEditResponse({this.user});
  UserEditResponse copyWith({User? user}) {
    return UserEditResponse(
      user: user ?? this.user,
    );
  }

  factory UserEditResponse.fromJson(Map<String, dynamic> json) {
    return UserEditResponse(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['user'] = user?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserEditResponse &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(user);
  }

  @override
  String toString() => 'UserEditResponse(${toJson()})';
}
