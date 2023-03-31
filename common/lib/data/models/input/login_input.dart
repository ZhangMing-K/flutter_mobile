import 'package:collection/collection.dart';

class LoginInput {
  final String? email;
  final String? password;
  const LoginInput({required this.email, required this.password});
  LoginInput copyWith({String? email, String? password}) {
    return LoginInput(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  factory LoginInput.fromJson(Map<String, dynamic> json) {
    return LoginInput(
      email: json['email'],
      password: json['password'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LoginInput &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(email) ^
        const DeepCollectionEquality().hash(password);
  }

  @override
  String toString() => 'LoginInput(${toJson()})';
}
