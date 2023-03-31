import 'package:collection/collection.dart';

class UserResetPasswordEmailInput {
  final String? username;
  const UserResetPasswordEmailInput({required this.username});
  UserResetPasswordEmailInput copyWith({String? username}) {
    return UserResetPasswordEmailInput(
      username: username ?? this.username,
    );
  }

  factory UserResetPasswordEmailInput.fromJson(Map<String, dynamic> json) {
    return UserResetPasswordEmailInput(
      username: json['username'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['username'] = username;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserResetPasswordEmailInput &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(username);
  }

  @override
  String toString() => 'UserResetPasswordEmailInput(${toJson()})';
}
