import 'package:collection/collection.dart';

class UserResetPasswordConfirmInput {
  final String? username;
  final String? code;
  final String? password;
  const UserResetPasswordConfirmInput(
      {required this.username, required this.code, this.password});
  UserResetPasswordConfirmInput copyWith(
      {String? username, String? code, String? password}) {
    return UserResetPasswordConfirmInput(
      username: username ?? this.username,
      code: code ?? this.code,
      password: password ?? this.password,
    );
  }

  factory UserResetPasswordConfirmInput.fromJson(Map<String, dynamic> json) {
    return UserResetPasswordConfirmInput(
      username: json['username'],
      code: json['code'],
      password: json['password'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['username'] = username;
    data['code'] = code;
    data['password'] = password;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserResetPasswordConfirmInput &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(username) ^
        const DeepCollectionEquality().hash(code) ^
        const DeepCollectionEquality().hash(password);
  }

  @override
  String toString() => 'UserResetPasswordConfirmInput(${toJson()})';
}
