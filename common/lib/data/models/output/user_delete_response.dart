import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class UserDeleteResponse {
  final User? user;
  const UserDeleteResponse({this.user});
  UserDeleteResponse copyWith({User? user}) {
    return UserDeleteResponse(
      user: user ?? this.user,
    );
  }

  factory UserDeleteResponse.fromJson(Map<String, dynamic> json) {
    return UserDeleteResponse(
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
        (other is UserDeleteResponse &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(user);
  }

  @override
  String toString() => 'UserDeleteResponse(${toJson()})';
}
