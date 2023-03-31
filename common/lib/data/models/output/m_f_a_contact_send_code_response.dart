import 'package:iris_common/data/models/output/m_f_a_contact.dart';
import 'package:collection/collection.dart';

class MFAContactSendCodeResponse {
  final MFAContact? mfaContact;
  const MFAContactSendCodeResponse({this.mfaContact});
  MFAContactSendCodeResponse copyWith({MFAContact? mfaContact}) {
    return MFAContactSendCodeResponse(
      mfaContact: mfaContact ?? this.mfaContact,
    );
  }

  factory MFAContactSendCodeResponse.fromJson(Map<String, dynamic> json) {
    return MFAContactSendCodeResponse(
      mfaContact: json['mfaContact'] != null
          ? MFAContact.fromJson(json['mfaContact'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['mfaContact'] = mfaContact?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MFAContactSendCodeResponse &&
            (identical(other.mfaContact, mfaContact) ||
                const DeepCollectionEquality()
                    .equals(other.mfaContact, mfaContact)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(mfaContact);
  }

  @override
  String toString() => 'MFAContactSendCodeResponse(${toJson()})';
}
