import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../iris_common.dart';

class MfaContactService extends GetxService {
  final IGraphqlProvider iGraphqlProvider;
  final IAuthUserService authUserStore;
  MfaContactService(
      {required this.iGraphqlProvider, required this.authUserStore});

  Future<MFAContact?> sendCode(
      {required MFA_VERIFY_ACTION action,
      required MFA_CONTACT_TYPE contactType,
      String? contactValue}) async {
    const document = r'''
        mutation sendCode($input: MFAContactSendCodeInput!) {
          MFAContactSendCode(input: $input) {
            mfaContact {
              mfaContactKey
              challengeId
              verifiedAt
              contactValue
              contactType
            }
          }
        }
    ''';

    final Map<String, dynamic> input = {
      'action': describeEnum(action),
      'contactType': describeEnum(contactType),
      'contactValue': contactValue,
    };

    final _options = iGraphqlProvider
        .createQueryOptions(document: document, variables: {'input': input});

    try {
      final res = await iGraphqlProvider.queryWithOptions(_options);
      if (res?.hasException ?? false) {
        throw res!.exception!.graphqlErrors;
      }

      final data = res?.data;
      if (data == null) {
        return null;
      }

      final response =
          MFAContactSendCodeResponse.fromJson(data['MFAContactSendCode'] ?? {});

      final mfaContact = response.mfaContact;

      return mfaContact;
    } catch (err) {
      rethrow;
    }
  }

  Future<MFAContact?> verifyCode(
      {required MFA_VERIFY_ACTION action,
      String? code,
      String? challengeId}) async {
    const document = r'''
        mutation verify($input: MFAContactVerifyInput!) {
          MFAContactVerify(input: $input) {
            mfaContact {
              mfaContactKey
              challengeId
              verifiedAt
              contactValue
              contactType
            }
            auth {
              token
              type
            }
            user {
              userKey
              firstName
              lastName
              profilePictureUrl
              phoneNumber
              username
            }
          }
        }
    ''';

    final Map<String, dynamic> input = {
      'action': describeEnum(action),
      'code': code,
      'challengeId': challengeId,
    };

    final _options = iGraphqlProvider
        .createQueryOptions(document: document, variables: {'input': input});

    try {
      final res = await iGraphqlProvider.queryWithOptions(_options);
      if (res?.hasException ?? false) {
        throw res!.exception!.graphqlErrors;
      }

      final data = res?.data;
      if (data == null) {
        return null;
      }

      final mfaContactData =
          MFAContactVerifyResponse.fromJson(data['MFAContactVerify'] ?? {});
      final mfaContact = mfaContactData.mfaContact;

      if (action == MFA_VERIFY_ACTION.LOGIN) {
        final token = mfaContactData.auth?.token;
        final user = mfaContactData.user;
        if (token == null || user == null) {
          return null;
        }

        if (token.isNotEmpty) {
          authUserStore.loginPhone(
            user: user,
            token: token,
          );
        }
      }

      return mfaContact;
    } catch (err) {
      rethrow;
    }
  }
}
