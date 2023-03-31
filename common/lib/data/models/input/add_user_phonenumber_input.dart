import 'package:collection/collection.dart';

class AddUserPhonenumberInput {
  final String? accessCode;
  final String? email;
  final String? phoneNumber;
  const AddUserPhonenumberInput(
      {required this.accessCode,
      required this.email,
      required this.phoneNumber});
  AddUserPhonenumberInput copyWith(
      {String? accessCode, String? email, String? phoneNumber}) {
    return AddUserPhonenumberInput(
      accessCode: accessCode ?? this.accessCode,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  factory AddUserPhonenumberInput.fromJson(Map<String, dynamic> json) {
    return AddUserPhonenumberInput(
      accessCode: json['accessCode'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['accessCode'] = accessCode;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AddUserPhonenumberInput &&
            (identical(other.accessCode, accessCode) ||
                const DeepCollectionEquality()
                    .equals(other.accessCode, accessCode)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(accessCode) ^
        const DeepCollectionEquality().hash(email) ^
        const DeepCollectionEquality().hash(phoneNumber);
  }

  @override
  String toString() => 'AddUserPhonenumberInput(${toJson()})';
}
