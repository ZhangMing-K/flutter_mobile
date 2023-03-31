import 'package:iris_common/data/models/enums/user_privacy_type.dart';
import 'package:iris_common/data/models/enums/trade_stat_visibility.dart';
import 'package:iris_common/data/models/enums/experience_level.dart';
import 'package:collection/collection.dart';

class UserEditInput {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? description;
  final String? phoneNumber;
  final String? username;
  final bool? acceptedTerms;
  final bool? acceptedPrivacy;
  final String? avatarCode;
  final int? avatarKey;
  final USER_PRIVACY_TYPE? userPrivacyType;
  final TRADE_STAT_VISIBILITY? tradeStatVisibility;
  final EXPERIENCE_LEVEL? experienceLevel;
  const UserEditInput(
      {this.firstName,
      this.lastName,
      this.email,
      this.description,
      this.phoneNumber,
      this.username,
      this.acceptedTerms,
      this.acceptedPrivacy,
      this.avatarCode,
      this.avatarKey,
      this.userPrivacyType,
      this.tradeStatVisibility,
      this.experienceLevel});
  UserEditInput copyWith(
      {String? firstName,
      String? lastName,
      String? email,
      String? description,
      String? phoneNumber,
      String? username,
      bool? acceptedTerms,
      bool? acceptedPrivacy,
      String? avatarCode,
      int? avatarKey,
      USER_PRIVACY_TYPE? userPrivacyType,
      TRADE_STAT_VISIBILITY? tradeStatVisibility,
      EXPERIENCE_LEVEL? experienceLevel}) {
    return UserEditInput(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      description: description ?? this.description,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      username: username ?? this.username,
      acceptedTerms: acceptedTerms ?? this.acceptedTerms,
      acceptedPrivacy: acceptedPrivacy ?? this.acceptedPrivacy,
      avatarCode: avatarCode ?? this.avatarCode,
      avatarKey: avatarKey ?? this.avatarKey,
      userPrivacyType: userPrivacyType ?? this.userPrivacyType,
      tradeStatVisibility: tradeStatVisibility ?? this.tradeStatVisibility,
      experienceLevel: experienceLevel ?? this.experienceLevel,
    );
  }

  factory UserEditInput.fromJson(Map<String, dynamic> json) {
    return UserEditInput(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      description: json['description'],
      phoneNumber: json['phoneNumber'],
      username: json['username'],
      acceptedTerms: json['acceptedTerms'],
      acceptedPrivacy: json['acceptedPrivacy'],
      avatarCode: json['avatarCode'],
      avatarKey: json['avatarKey'],
      userPrivacyType: json['userPrivacyType'] != null
          ? USER_PRIVACY_TYPE.values.byName(json['userPrivacyType'])
          : null,
      tradeStatVisibility: json['tradeStatVisibility'] != null
          ? TRADE_STAT_VISIBILITY.values.byName(json['tradeStatVisibility'])
          : null,
      experienceLevel: json['experienceLevel'] != null
          ? EXPERIENCE_LEVEL.values.byName(json['experienceLevel'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['description'] = description;
    data['phoneNumber'] = phoneNumber;
    data['username'] = username;
    data['acceptedTerms'] = acceptedTerms;
    data['acceptedPrivacy'] = acceptedPrivacy;
    data['avatarCode'] = avatarCode;
    data['avatarKey'] = avatarKey;
    data['userPrivacyType'] = userPrivacyType?.name;
    data['tradeStatVisibility'] = tradeStatVisibility?.name;
    data['experienceLevel'] = experienceLevel?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserEditInput &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality()
                    .equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality()
                    .equals(other.lastName, lastName)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.acceptedTerms, acceptedTerms) ||
                const DeepCollectionEquality()
                    .equals(other.acceptedTerms, acceptedTerms)) &&
            (identical(other.acceptedPrivacy, acceptedPrivacy) ||
                const DeepCollectionEquality()
                    .equals(other.acceptedPrivacy, acceptedPrivacy)) &&
            (identical(other.avatarCode, avatarCode) ||
                const DeepCollectionEquality()
                    .equals(other.avatarCode, avatarCode)) &&
            (identical(other.avatarKey, avatarKey) ||
                const DeepCollectionEquality()
                    .equals(other.avatarKey, avatarKey)) &&
            (identical(other.userPrivacyType, userPrivacyType) ||
                const DeepCollectionEquality()
                    .equals(other.userPrivacyType, userPrivacyType)) &&
            (identical(other.tradeStatVisibility, tradeStatVisibility) ||
                const DeepCollectionEquality()
                    .equals(other.tradeStatVisibility, tradeStatVisibility)) &&
            (identical(other.experienceLevel, experienceLevel) ||
                const DeepCollectionEquality()
                    .equals(other.experienceLevel, experienceLevel)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(firstName) ^
        const DeepCollectionEquality().hash(lastName) ^
        const DeepCollectionEquality().hash(email) ^
        const DeepCollectionEquality().hash(description) ^
        const DeepCollectionEquality().hash(phoneNumber) ^
        const DeepCollectionEquality().hash(username) ^
        const DeepCollectionEquality().hash(acceptedTerms) ^
        const DeepCollectionEquality().hash(acceptedPrivacy) ^
        const DeepCollectionEquality().hash(avatarCode) ^
        const DeepCollectionEquality().hash(avatarKey) ^
        const DeepCollectionEquality().hash(userPrivacyType) ^
        const DeepCollectionEquality().hash(tradeStatVisibility) ^
        const DeepCollectionEquality().hash(experienceLevel);
  }

  @override
  String toString() => 'UserEditInput(${toJson()})';
}
