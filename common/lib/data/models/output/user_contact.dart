import 'package:iris_common/data/models/enums/external_user_contact_type.dart';
import 'package:collection/collection.dart';

class UserContact {
  final int? userContactKey;
  final String? firstName;
  final String? lastName;
  final EXTERNAL_USER_CONTACT_TYPE? contactType;
  final String? contactValue;
  final int? friendCount;
  final DateTime? sentInviteAt;
  const UserContact(
      {this.userContactKey,
      this.firstName,
      this.lastName,
      this.contactType,
      this.contactValue,
      this.friendCount,
      this.sentInviteAt});
  UserContact copyWith(
      {int? userContactKey,
      String? firstName,
      String? lastName,
      EXTERNAL_USER_CONTACT_TYPE? contactType,
      String? contactValue,
      int? friendCount,
      DateTime? sentInviteAt}) {
    return UserContact(
      userContactKey: userContactKey ?? this.userContactKey,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      contactType: contactType ?? this.contactType,
      contactValue: contactValue ?? this.contactValue,
      friendCount: friendCount ?? this.friendCount,
      sentInviteAt: sentInviteAt ?? this.sentInviteAt,
    );
  }

  factory UserContact.fromJson(Map<String, dynamic> json) {
    return UserContact(
      userContactKey: json['userContactKey'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      contactType: json['contactType'] != null
          ? EXTERNAL_USER_CONTACT_TYPE.values.byName(json['contactType'])
          : null,
      contactValue: json['contactValue'],
      friendCount: json['friendCount'],
      sentInviteAt: json['sentInviteAt'] != null
          ? DateTime.parse(json['sentInviteAt'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userContactKey'] = userContactKey;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['contactType'] = contactType?.name;
    data['contactValue'] = contactValue;
    data['friendCount'] = friendCount;
    data['sentInviteAt'] = sentInviteAt?.toString();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserContact &&
            (identical(other.userContactKey, userContactKey) ||
                const DeepCollectionEquality()
                    .equals(other.userContactKey, userContactKey)) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality()
                    .equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality()
                    .equals(other.lastName, lastName)) &&
            (identical(other.contactType, contactType) ||
                const DeepCollectionEquality()
                    .equals(other.contactType, contactType)) &&
            (identical(other.contactValue, contactValue) ||
                const DeepCollectionEquality()
                    .equals(other.contactValue, contactValue)) &&
            (identical(other.friendCount, friendCount) ||
                const DeepCollectionEquality()
                    .equals(other.friendCount, friendCount)) &&
            (identical(other.sentInviteAt, sentInviteAt) ||
                const DeepCollectionEquality()
                    .equals(other.sentInviteAt, sentInviteAt)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userContactKey) ^
        const DeepCollectionEquality().hash(firstName) ^
        const DeepCollectionEquality().hash(lastName) ^
        const DeepCollectionEquality().hash(contactType) ^
        const DeepCollectionEquality().hash(contactValue) ^
        const DeepCollectionEquality().hash(friendCount) ^
        const DeepCollectionEquality().hash(sentInviteAt);
  }

  @override
  String toString() => 'UserContact(${toJson()})';
}
