import 'package:collection/collection.dart';

class UserCreateMFAInput {
  final String? mfaChallengeId;
  final String? phoneNumber;
  final String? firstName;
  final String? lastName;
  final String? username;
  final int? invitedByUserKey;
  final int? invitedByInviteLinkKey;
  final String? deeplinkFrom;
  const UserCreateMFAInput(
      {required this.mfaChallengeId,
      required this.phoneNumber,
      required this.firstName,
      required this.lastName,
      this.username,
      this.invitedByUserKey,
      this.invitedByInviteLinkKey,
      this.deeplinkFrom});
  UserCreateMFAInput copyWith(
      {String? mfaChallengeId,
      String? phoneNumber,
      String? firstName,
      String? lastName,
      String? username,
      int? invitedByUserKey,
      int? invitedByInviteLinkKey,
      String? deeplinkFrom}) {
    return UserCreateMFAInput(
      mfaChallengeId: mfaChallengeId ?? this.mfaChallengeId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      invitedByUserKey: invitedByUserKey ?? this.invitedByUserKey,
      invitedByInviteLinkKey:
          invitedByInviteLinkKey ?? this.invitedByInviteLinkKey,
      deeplinkFrom: deeplinkFrom ?? this.deeplinkFrom,
    );
  }

  factory UserCreateMFAInput.fromJson(Map<String, dynamic> json) {
    return UserCreateMFAInput(
      mfaChallengeId: json['mfaChallengeId'],
      phoneNumber: json['phoneNumber'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      invitedByUserKey: json['invitedByUserKey'],
      invitedByInviteLinkKey: json['invitedByInviteLinkKey'],
      deeplinkFrom: json['deeplinkFrom'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['mfaChallengeId'] = mfaChallengeId;
    data['phoneNumber'] = phoneNumber;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['username'] = username;
    data['invitedByUserKey'] = invitedByUserKey;
    data['invitedByInviteLinkKey'] = invitedByInviteLinkKey;
    data['deeplinkFrom'] = deeplinkFrom;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserCreateMFAInput &&
            (identical(other.mfaChallengeId, mfaChallengeId) ||
                const DeepCollectionEquality()
                    .equals(other.mfaChallengeId, mfaChallengeId)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality()
                    .equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality()
                    .equals(other.lastName, lastName)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
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
        const DeepCollectionEquality().hash(mfaChallengeId) ^
        const DeepCollectionEquality().hash(phoneNumber) ^
        const DeepCollectionEquality().hash(firstName) ^
        const DeepCollectionEquality().hash(lastName) ^
        const DeepCollectionEquality().hash(username) ^
        const DeepCollectionEquality().hash(invitedByUserKey) ^
        const DeepCollectionEquality().hash(invitedByInviteLinkKey) ^
        const DeepCollectionEquality().hash(deeplinkFrom);
  }

  @override
  String toString() => 'UserCreateMFAInput(${toJson()})';
}
