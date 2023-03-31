import 'package:collection/collection.dart';

class UserContactSendInviteInput {
  final int? userContactKey;
  const UserContactSendInviteInput({required this.userContactKey});
  UserContactSendInviteInput copyWith({int? userContactKey}) {
    return UserContactSendInviteInput(
      userContactKey: userContactKey ?? this.userContactKey,
    );
  }

  factory UserContactSendInviteInput.fromJson(Map<String, dynamic> json) {
    return UserContactSendInviteInput(
      userContactKey: json['userContactKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userContactKey'] = userContactKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserContactSendInviteInput &&
            (identical(other.userContactKey, userContactKey) ||
                const DeepCollectionEquality()
                    .equals(other.userContactKey, userContactKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userContactKey);
  }

  @override
  String toString() => 'UserContactSendInviteInput(${toJson()})';
}
