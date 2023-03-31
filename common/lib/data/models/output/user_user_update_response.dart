import 'package:iris_common/data/models/output/user_user.dart';
import 'package:collection/collection.dart';

class UserUserUpdateResponse {
  final UserUser? userUser;
  const UserUserUpdateResponse({this.userUser});
  UserUserUpdateResponse copyWith({UserUser? userUser}) {
    return UserUserUpdateResponse(
      userUser: userUser ?? this.userUser,
    );
  }

  factory UserUserUpdateResponse.fromJson(Map<String, dynamic> json) {
    return UserUserUpdateResponse(
      userUser:
          json['userUser'] != null ? UserUser.fromJson(json['userUser']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userUser'] = userUser?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserUserUpdateResponse &&
            (identical(other.userUser, userUser) ||
                const DeepCollectionEquality()
                    .equals(other.userUser, userUser)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(userUser);
  }

  @override
  String toString() => 'UserUserUpdateResponse(${toJson()})';
}
