import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class UserResetPasswordConfirmResponse {
  final User? user;
  final bool? pass;
  const UserResetPasswordConfirmResponse({this.user, this.pass});
  UserResetPasswordConfirmResponse copyWith({User? user, bool? pass}) {
    return UserResetPasswordConfirmResponse(
      user: user ?? this.user,
      pass: pass ?? this.pass,
    );
  }

  factory UserResetPasswordConfirmResponse.fromJson(Map<String, dynamic> json) {
    return UserResetPasswordConfirmResponse(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      pass: json['pass'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['user'] = user?.toJson();
    data['pass'] = pass;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserResetPasswordConfirmResponse &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.pass, pass) ||
                const DeepCollectionEquality().equals(other.pass, pass)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(pass);
  }

  @override
  String toString() => 'UserResetPasswordConfirmResponse(${toJson()})';
}
