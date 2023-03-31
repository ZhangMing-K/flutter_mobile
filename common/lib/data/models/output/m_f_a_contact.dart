import 'package:iris_common/data/models/enums/mfa_contact_type.dart';
import 'package:collection/collection.dart';

class MFAContact {
  final int? mfaContactKey;
  final MFA_CONTACT_TYPE? contactType;
  final String? contactValue;
  final DateTime? verifiedAt;
  final String? challengeId;
  const MFAContact(
      {this.mfaContactKey,
      this.contactType,
      this.contactValue,
      this.verifiedAt,
      this.challengeId});
  MFAContact copyWith(
      {int? mfaContactKey,
      MFA_CONTACT_TYPE? contactType,
      String? contactValue,
      DateTime? verifiedAt,
      String? challengeId}) {
    return MFAContact(
      mfaContactKey: mfaContactKey ?? this.mfaContactKey,
      contactType: contactType ?? this.contactType,
      contactValue: contactValue ?? this.contactValue,
      verifiedAt: verifiedAt ?? this.verifiedAt,
      challengeId: challengeId ?? this.challengeId,
    );
  }

  factory MFAContact.fromJson(Map<String, dynamic> json) {
    return MFAContact(
      mfaContactKey: json['mfaContactKey'],
      contactType: json['contactType'] != null
          ? MFA_CONTACT_TYPE.values.byName(json['contactType'])
          : null,
      contactValue: json['contactValue'],
      verifiedAt: json['verifiedAt'] != null
          ? DateTime.parse(json['verifiedAt'])
          : null,
      challengeId: json['challengeId'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['mfaContactKey'] = mfaContactKey;
    data['contactType'] = contactType?.name;
    data['contactValue'] = contactValue;
    data['verifiedAt'] = verifiedAt?.toString();
    data['challengeId'] = challengeId;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MFAContact &&
            (identical(other.mfaContactKey, mfaContactKey) ||
                const DeepCollectionEquality()
                    .equals(other.mfaContactKey, mfaContactKey)) &&
            (identical(other.contactType, contactType) ||
                const DeepCollectionEquality()
                    .equals(other.contactType, contactType)) &&
            (identical(other.contactValue, contactValue) ||
                const DeepCollectionEquality()
                    .equals(other.contactValue, contactValue)) &&
            (identical(other.verifiedAt, verifiedAt) ||
                const DeepCollectionEquality()
                    .equals(other.verifiedAt, verifiedAt)) &&
            (identical(other.challengeId, challengeId) ||
                const DeepCollectionEquality()
                    .equals(other.challengeId, challengeId)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(mfaContactKey) ^
        const DeepCollectionEquality().hash(contactType) ^
        const DeepCollectionEquality().hash(contactValue) ^
        const DeepCollectionEquality().hash(verifiedAt) ^
        const DeepCollectionEquality().hash(challengeId);
  }

  @override
  String toString() => 'MFAContact(${toJson()})';
}
