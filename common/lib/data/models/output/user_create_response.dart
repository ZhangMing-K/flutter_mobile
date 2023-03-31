import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/auth.dart';
import 'package:iris_common/data/models/output/error.dart';
import 'package:collection/collection.dart';

class UserCreateResponse {
  final User? user;
  final Auth? auth;
  final Error? error;
  const UserCreateResponse({this.user, this.auth, this.error});
  UserCreateResponse copyWith({User? user, Auth? auth, Error? error}) {
    return UserCreateResponse(
      user: user ?? this.user,
      auth: auth ?? this.auth,
      error: error ?? this.error,
    );
  }

  factory UserCreateResponse.fromJson(Map<String, dynamic> json) {
    return UserCreateResponse(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      auth: json['auth'] != null ? Auth.fromJson(json['auth']) : null,
      error: json['error'] != null ? Error.fromJson(json['error']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['user'] = user?.toJson();
    data['auth'] = auth?.toJson();
    data['error'] = error?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserCreateResponse &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.auth, auth) ||
                const DeepCollectionEquality().equals(other.auth, auth)) &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(auth) ^
        const DeepCollectionEquality().hash(error);
  }

  @override
  String toString() => 'UserCreateResponse(${toJson()})';
}
