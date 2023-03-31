import 'package:collection/collection.dart';

class UserCreateInput {
  final String? email;
  final String? mfaChallengeId;
  final String? password;
  final String? username;
  final String? firstName;
  final String? lastName;
  final int? invitedByUserKey;
  final int? invitedByInviteLinkKey;
  final String? deeplinkFrom;
  const UserCreateInput(
      {this.email,
      this.mfaChallengeId,
      required this.password,
      this.username,
      required this.firstName,
      this.lastName,
      this.invitedByUserKey,
      this.invitedByInviteLinkKey,
      this.deeplinkFrom});
  UserCreateInput copyWith(
      {String? email,
      String? mfaChallengeId,
      String? password,
      String? username,
      String? firstName,
      String? lastName,
      int? invitedByUserKey,
      int? invitedByInviteLinkKey,
      String? deeplinkFrom}) {
    return UserCreateInput(
      email: email ?? this.email,
      mfaChallengeId: mfaChallengeId ?? this.mfaChallengeId,
      password: password ?? this.password,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      invitedByUserKey: invitedByUserKey ?? this.invitedByUserKey,
      invitedByInviteLinkKey:
          invitedByInviteLinkKey ?? this.invitedByInviteLinkKey,
      deeplinkFrom: deeplinkFrom ?? this.deeplinkFrom,
    );
  }

  factory UserCreateInput.fromJson(Map<String, dynamic> json) {
    return UserCreateInput(
      email: json['email'],
      mfaChallengeId: json['mfaChallengeId'],
      password: json['password'],
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      invitedByUserKey: json['invitedByUserKey'],
      invitedByInviteLinkKey: json['invitedByInviteLinkKey'],
      deeplinkFrom: json['deeplinkFrom'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['mfaChallengeId'] = mfaChallengeId;
    data['password'] = password;
    data['username'] = username;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['invitedByUserKey'] = invitedByUserKey;
    data['invitedByInviteLinkKey'] = invitedByInviteLinkKey;
    data['deeplinkFrom'] = deeplinkFrom;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserCreateInput &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.mfaChallengeId, mfaChallengeId) ||
                const DeepCollectionEquality()
                    .equals(other.mfaChallengeId, mfaChallengeId)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality()
                    .equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality()
                    .equals(other.lastName, lastName)) &&
            (identical(other.invitedByUserKey, invitedByUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.invitedByUserKey, invitedByUserKey)) &&
            (identical(other.invitedByInviteLinkKey, invitedByInviteLinkKey) ||
                const DeepCollectionEquality().equals(
                    other.invitedByInviteLinkKey, invitedByInviteLinkKey)) &&
            (identical(other.deeplinkFrom, deeplinkFrom) ||
                const DeepCollectionEquality()
                    .equals(other.deeplinkFrom, deeplinkFrom)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(email) ^
        const DeepCollectionEquality().hash(mfaChallengeId) ^
        const DeepCollectionEquality().hash(password) ^
        const DeepCollectionEquality().hash(username) ^
        const DeepCollectionEquality().hash(firstName) ^
        const DeepCollectionEquality().hash(lastName) ^
        const DeepCollectionEquality().hash(invitedByUserKey) ^
        const DeepCollectionEquality().hash(invitedByInviteLinkKey) ^
        const DeepCollectionEquality().hash(deeplinkFrom);
  }

  @override
  String toString() => 'UserCreateInput(${toJson()})';
}
