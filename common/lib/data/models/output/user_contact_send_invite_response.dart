import 'package:iris_common/data/models/output/user_contact.dart';
import 'package:collection/collection.dart';

class UserContactSendInviteResponse {
  final UserContact? userContact;
  const UserContactSendInviteResponse({this.userContact});
  UserContactSendInviteResponse copyWith({UserContact? userContact}) {
    return UserContactSendInviteResponse(
      userContact: userContact ?? this.userContact,
    );
  }

  factory UserContactSendInviteResponse.fromJson(Map<String, dynamic> json) {
    return UserContactSendInviteResponse(
      userContact: json['userContact'] != null
          ? UserContact.fromJson(json['userContact'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userContact'] = userContact?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserContactSendInviteResponse &&
            (identical(other.userContact, userContact) ||
                const DeepCollectionEquality()
                    .equals(other.userContact, userContact)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userContact);
  }

  @override
  String toString() => 'UserContactSendInviteResponse(${toJson()})';
}
