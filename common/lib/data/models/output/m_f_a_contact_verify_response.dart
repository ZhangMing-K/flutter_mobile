import 'package:iris_common/data/models/output/m_f_a_contact.dart';
import 'package:iris_common/data/models/output/auth.dart';
import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class MFAContactVerifyResponse {
  final MFAContact? mfaContact;
  final Auth? auth;
  final User? user;
  const MFAContactVerifyResponse({this.mfaContact, this.auth, this.user});
  MFAContactVerifyResponse copyWith(
      {MFAContact? mfaContact, Auth? auth, User? user}) {
    return MFAContactVerifyResponse(
      mfaContact: mfaContact ?? this.mfaContact,
      auth: auth ?? this.auth,
      user: user ?? this.user,
    );
  }

  factory MFAContactVerifyResponse.fromJson(Map<String, dynamic> json) {
    return MFAContactVerifyResponse(
      mfaContact: json['mfaContact'] != null
          ? MFAContact.fromJson(json['mfaContact'])
          : null,
      auth: json['auth'] != null ? Auth.fromJson(json['auth']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['mfaContact'] = mfaContact?.toJson();
    data['auth'] = auth?.toJson();
    data['user'] = user?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MFAContactVerifyResponse &&
            (identical(other.mfaContact, mfaContact) ||
                const DeepCollectionEquality()
                    .equals(other.mfaContact, mfaContact)) &&
            (identical(other.auth, auth) ||
                const DeepCollectionEquality().equals(other.auth, auth)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(mfaContact) ^
        const DeepCollectionEquality().hash(auth) ^
        const DeepCollectionEquality().hash(user);
  }

  @override
  String toString() => 'MFAContactVerifyResponse(${toJson()})';
}
