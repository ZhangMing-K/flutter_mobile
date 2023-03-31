import 'package:iris_common/data/models/input/user_contact_input.dart';
import 'package:collection/collection.dart';

class UserContactSyncInput {
  final List<UserContactInput>? userContacts;
  const UserContactSyncInput({this.userContacts});
  UserContactSyncInput copyWith({List<UserContactInput>? userContacts}) {
    return UserContactSyncInput(
      userContacts: userContacts ?? this.userContacts,
    );
  }

  factory UserContactSyncInput.fromJson(Map<String, dynamic> json) {
    return UserContactSyncInput(
      userContacts: json['userContacts']
          ?.map<UserContactInput>((o) => UserContactInput.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userContacts'] = userContacts?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserContactSyncInput &&
            (identical(other.userContacts, userContacts) ||
                const DeepCollectionEquality()
                    .equals(other.userContacts, userContacts)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userContacts);
  }

  @override
  String toString() => 'UserContactSyncInput(${toJson()})';
}
