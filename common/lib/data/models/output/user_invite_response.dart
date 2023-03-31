import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class UserInviteResponse {
  final User? user;
  const UserInviteResponse({this.user});
  UserInviteResponse copyWith({User? user}) {
    return UserInviteResponse(
      user: user ?? this.user,
    );
  }

  factory UserInviteResponse.fromJson(Map<String, dynamic> json) {
    return UserInviteResponse(
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
        (other is UserInviteResponse &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(user);
  }

  @override
  String toString() => 'UserInviteResponse(${toJson()})';
}
