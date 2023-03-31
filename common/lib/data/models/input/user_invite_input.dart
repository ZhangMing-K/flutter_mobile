import 'package:collection/collection.dart';

class UserInviteInput {
  final String? email;
  const UserInviteInput({required this.email});
  UserInviteInput copyWith({String? email}) {
    return UserInviteInput(
      email: email ?? this.email,
    );
  }

  factory UserInviteInput.fromJson(Map<String, dynamic> json) {
    return UserInviteInput(
      email: json['email'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserInviteInput &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(email);
  }

  @override
  String toString() => 'UserInviteInput(${toJson()})';
}
