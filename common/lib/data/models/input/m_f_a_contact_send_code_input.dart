import 'package:iris_common/data/models/enums/mfa_contact_type.dart';
import 'package:iris_common/data/models/enums/mfa_verify_action.dart';
import 'package:iris_common/data/models/enums/app_client_type.dart';
import 'package:collection/collection.dart';

class MFAContactSendCodeInput {
  final MFA_CONTACT_TYPE? contactType;
  final String? contactValue;
  final MFA_VERIFY_ACTION? action;
  final APP_CLIENT_TYPE? appClientType;
  const MFAContactSendCodeInput(
      {required this.contactType,
      required this.contactValue,
      this.action,
      this.appClientType});
  MFAContactSendCodeInput copyWith(
      {MFA_CONTACT_TYPE? contactType,
      String? contactValue,
      MFA_VERIFY_ACTION? action,
      APP_CLIENT_TYPE? appClientType}) {
    return MFAContactSendCodeInput(
      contactType: contactType ?? this.contactType,
      contactValue: contactValue ?? this.contactValue,
      action: action ?? this.action,
      appClientType: appClientType ?? this.appClientType,
    );
  }

  factory MFAContactSendCodeInput.fromJson(Map<String, dynamic> json) {
    return MFAContactSendCodeInput(
      contactType: json['contactType'] != null
          ? MFA_CONTACT_TYPE.values.byName(json['contactType'])
          : null,
      contactValue: json['contactValue'],
      action: json['action'] != null
          ? MFA_VERIFY_ACTION.values.byName(json['action'])
          : null,
      appClientType: json['appClientType'] != null
          ? APP_CLIENT_TYPE.values.byName(json['appClientType'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['contactType'] = contactType?.name;
    data['contactValue'] = contactValue;
    data['action'] = action?.name;
    data['appClientType'] = appClientType?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MFAContactSendCodeInput &&
            (identical(other.contactType, contactType) ||
                const DeepCollectionEquality()
                    .equals(other.contactType, contactType)) &&
            (identical(other.contactValue, contactValue) ||
                const DeepCollectionEquality()
                    .equals(other.contactValue, contactValue)) &&
            (identical(other.action, action) ||
                const DeepCollectionEquality().equals(other.action, action)) &&
            (identical(other.appClientType, appClientType) ||
                const DeepCollectionEquality()
                    .equals(other.appClientType, appClientType)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(contactType) ^
        const DeepCollectionEquality().hash(contactValue) ^
        const DeepCollectionEquality().hash(action) ^
        const DeepCollectionEquality().hash(appClientType);
  }

  @override
  String toString() => 'MFAContactSendCodeInput(${toJson()})';
}
