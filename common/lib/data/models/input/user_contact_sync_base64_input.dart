import 'package:collection/collection.dart';

class UserContactSyncBase64Input {
  final String? userContactsBase64;
  const UserContactSyncBase64Input({required this.userContactsBase64});
  UserContactSyncBase64Input copyWith({String? userContactsBase64}) {
    return UserContactSyncBase64Input(
      userContactsBase64: userContactsBase64 ?? this.userContactsBase64,
    );
  }

  factory UserContactSyncBase64Input.fromJson(Map<String, dynamic> json) {
    return UserContactSyncBase64Input(
      userContactsBase64: json['userContactsBase64'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userContactsBase64'] = userContactsBase64;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserContactSyncBase64Input &&
            (identical(other.userContactsBase64, userContactsBase64) ||
                const DeepCollectionEquality()
                    .equals(other.userContactsBase64, userContactsBase64)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userContactsBase64);
  }

  @override
  String toString() => 'UserContactSyncBase64Input(${toJson()})';
}
