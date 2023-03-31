import 'package:collection/collection.dart';

class UserDeleteInput {
  final int? userKey;
  final bool? removePhoneNumber;
  const UserDeleteInput({required this.userKey, this.removePhoneNumber});
  UserDeleteInput copyWith({int? userKey, bool? removePhoneNumber}) {
    return UserDeleteInput(
      userKey: userKey ?? this.userKey,
      removePhoneNumber: removePhoneNumber ?? this.removePhoneNumber,
    );
  }

  factory UserDeleteInput.fromJson(Map<String, dynamic> json) {
    return UserDeleteInput(
      userKey: json['userKey'],
      removePhoneNumber: json['removePhoneNumber'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKey'] = userKey;
    data['removePhoneNumber'] = removePhoneNumber;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserDeleteInput &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.removePhoneNumber, removePhoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.removePhoneNumber, removePhoneNumber)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(removePhoneNumber);
  }

  @override
  String toString() => 'UserDeleteInput(${toJson()})';
}
