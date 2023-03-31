import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class UserResetPasswordEmailResponse {
  final User? user;
  const UserResetPasswordEmailResponse({this.user});
  UserResetPasswordEmailResponse copyWith({User? user}) {
    return UserResetPasswordEmailResponse(
      user: user ?? this.user,
    );
  }

  factory UserResetPasswordEmailResponse.fromJson(Map<String, dynamic> json) {
    return UserResetPasswordEmailResponse(
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
        (other is UserResetPasswordEmailResponse &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(user);
  }

  @override
  String toString() => 'UserResetPasswordEmailResponse(${toJson()})';
}
