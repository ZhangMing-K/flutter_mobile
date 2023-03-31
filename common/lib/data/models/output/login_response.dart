import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/auth.dart';
import 'package:collection/collection.dart';

class LoginResponse {
  final User? user;
  final Auth? auth;
  final bool? newlyCreated;
  const LoginResponse({this.user, this.auth, this.newlyCreated});
  LoginResponse copyWith({User? user, Auth? auth, bool? newlyCreated}) {
    return LoginResponse(
      user: user ?? this.user,
      auth: auth ?? this.auth,
      newlyCreated: newlyCreated ?? this.newlyCreated,
    );
  }

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      auth: json['auth'] != null ? Auth.fromJson(json['auth']) : null,
      newlyCreated: json['newlyCreated'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['user'] = user?.toJson();
    data['auth'] = auth?.toJson();
    data['newlyCreated'] = newlyCreated;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LoginResponse &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.auth, auth) ||
                const DeepCollectionEquality().equals(other.auth, auth)) &&
            (identical(other.newlyCreated, newlyCreated) ||
                const DeepCollectionEquality()
                    .equals(other.newlyCreated, newlyCreated)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(auth) ^
        const DeepCollectionEquality().hash(newlyCreated);
  }

  @override
  String toString() => 'LoginResponse(${toJson()})';
}
