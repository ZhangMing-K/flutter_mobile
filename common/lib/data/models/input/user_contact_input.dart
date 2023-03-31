import 'package:iris_common/data/models/enums/external_user_contact_type.dart';
import 'package:collection/collection.dart';

class UserContactInput {
  final String? firstName;
  final String? lastName;
  final EXTERNAL_USER_CONTACT_TYPE? contactType;
  final String? contactValue;
  const UserContactInput(
      {this.firstName,
      this.lastName,
      required this.contactType,
      required this.contactValue});
  UserContactInput copyWith(
      {String? firstName,
      String? lastName,
      EXTERNAL_USER_CONTACT_TYPE? contactType,
      String? contactValue}) {
    return UserContactInput(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      contactType: contactType ?? this.contactType,
      contactValue: contactValue ?? this.contactValue,
    );
  }

  factory UserContactInput.fromJson(Map<String, dynamic> json) {
    return UserContactInput(
      firstName: json['firstName'],
      lastName: json['lastName'],
      contactType: json['contactType'] != null
          ? EXTERNAL_USER_CONTACT_TYPE.values.byName(json['contactType'])
          : null,
      contactValue: json['contactValue'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['contactType'] = contactType?.name;
    data['contactValue'] = contactValue;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserContactInput &&
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
                    .equals(other.contactValue, contactValue)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(firstName) ^
        const DeepCollectionEquality().hash(lastName) ^
        const DeepCollectionEquality().hash(contactType) ^
        const DeepCollectionEquality().hash(contactValue);
  }

  @override
  String toString() => 'UserContactInput(${toJson()})';
}
