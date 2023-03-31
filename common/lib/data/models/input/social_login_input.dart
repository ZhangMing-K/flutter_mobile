import 'package:iris_common/data/models/enums/social_source.dart';
import 'package:collection/collection.dart';

class SocialLoginInput {
  final String? token;
  final SOCIAL_SOURCE? socialSource;
  final String? firstName;
  final String? lastName;
  final int? invitedByUserKey;
  final int? invitedByInviteLinkKey;
  final String? deeplinkFrom;
  const SocialLoginInput(
      {required this.token,
      required this.socialSource,
      this.firstName,
      this.lastName,
      this.invitedByUserKey,
      this.invitedByInviteLinkKey,
      this.deeplinkFrom});
  SocialLoginInput copyWith(
      {String? token,
      SOCIAL_SOURCE? socialSource,
      String? firstName,
      String? lastName,
      int? invitedByUserKey,
      int? invitedByInviteLinkKey,
      String? deeplinkFrom}) {
    return SocialLoginInput(
      token: token ?? this.token,
      socialSource: socialSource ?? this.socialSource,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      invitedByUserKey: invitedByUserKey ?? this.invitedByUserKey,
      invitedByInviteLinkKey:
          invitedByInviteLinkKey ?? this.invitedByInviteLinkKey,
      deeplinkFrom: deeplinkFrom ?? this.deeplinkFrom,
    );
  }

  factory SocialLoginInput.fromJson(Map<String, dynamic> json) {
    return SocialLoginInput(
      token: json['token'],
      socialSource: json['socialSource'] != null
          ? SOCIAL_SOURCE.values.byName(json['socialSource'])
          : null,
      firstName: json['firstName'],
      lastName: json['lastName'],
      invitedByUserKey: json['invitedByUserKey'],
      invitedByInviteLinkKey: json['invitedByInviteLinkKey'],
      deeplinkFrom: json['deeplinkFrom'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['token'] = token;
    data['socialSource'] = socialSource?.name;
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
        (other is SocialLoginInput &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)) &&
            (identical(other.socialSource, socialSource) ||
                const DeepCollectionEquality()
                    .equals(other.socialSource, socialSource)) &&
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
        const DeepCollectionEquality().hash(token) ^
        const DeepCollectionEquality().hash(socialSource) ^
        const DeepCollectionEquality().hash(firstName) ^
        const DeepCollectionEquality().hash(lastName) ^
        const DeepCollectionEquality().hash(invitedByUserKey) ^
        const DeepCollectionEquality().hash(invitedByInviteLinkKey) ^
        const DeepCollectionEquality().hash(deeplinkFrom);
  }

  @override
  String toString() => 'SocialLoginInput(${toJson()})';
}
