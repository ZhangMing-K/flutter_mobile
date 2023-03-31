import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../iris_common.dart';

class SocialService extends GetxService {
  IGraphqlProvider iGraphqlProvider = Get.find();
  final socialLinkResponseFragment = '''
    fragment socialLinkResponseFragment on SocialLinkResponse {
        user{
          userKey
          email
          firstName
          lastName
          username
          verifiedAt
          verifiedText
          firstOrderAt
          description
          profilePictureUrl
          inviteLink
          nbrUnreadMessages
        }
    }
    ''';

  SocialService();

  Future<Share?> shareCreate(
      {required int? entityKey,
      required SHARE_TYPE shareType,
      bool? preview,
      bool? showAmounts,
      DateTime? expiresAt}) async {
    const document = r'''
        mutation shareCreate($input: ShareCreateInput) {
          shareCreate(input: $input) {
              share {
                shareKey
                shareType
                entityKey
                expiresAt
                uri
                showAmounts
                preview
                sharedByUser {
                  userKey
                  username
                }
              }
            }
          }
      ''';

    final Map<String, dynamic> input = {
      'shareType': describeEnum(shareType),
      'entityKey': entityKey,
      'preview': preview,
      'showAmounts': showAmounts,
      'expiresAt': expiresAt
    };

    final _options = iGraphqlProvider
        .createQueryOptions(document: document, variables: {'input': input});

    try {
      final res = await iGraphqlProvider.queryWithOptions(_options);
      if (res?.hasException ?? false) {
        throw 'Could not authenticate with provider';
      } else {
        final shareData = res!.data!['shareCreate']['share'];
        final share = Share.fromJson(shareData);

        return share;
      }
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  Future<List<Integration>?> socialLink(SOCIAL_SOURCE socialSource,
      {String? token, String? verifierToken, int? integrationKey}) async {
    switch (socialSource) {
      case SOCIAL_SOURCE.TWITTER:
        return await twitterLink(
            token: token,
            verifierToken: verifierToken,
            integrationKey: integrationKey);
      default:
        {
          throw const Error();
        }
    }
  }

  Future<List<Integration>?> socialLinkComplete(
      {required String? token,
      required SOCIAL_SOURCE socialSource,
      String? verifierToken,
      int? integrationKey}) async {
    final socialSourceName = socialSource.toString().split('.')[
        1]; //because enums dont have an easy way to get their name in dart.
    const document = r'''
        query socialLink($input: SocialLinkInput, $integrationInput: IntegrationsInput) {
          socialLink(input: $input) {
            user {
              userKey
              integrations(input: $integrationInput) {
                integrationKey
                source
                username
                token
              }
            }
          }
        }
    ''';

    final Map<String, dynamic> input = {
      'token': token,
      'socialSource': socialSourceName,
      'verifierToken': verifierToken
    };

    final Map<String, dynamic> integrationInput = {
      'sources': getSocialsInput()
    };

    if (integrationKey != null) input['integrationKey'] = integrationKey;

    final _options = iGraphqlProvider.createQueryOptions(
        document: document,
        variables: {'input': input, 'integrationInput': integrationInput});

    try {
      final res = await iGraphqlProvider.queryWithOptions(_options);
      if (res?.hasException ?? false) {
        throw 'Could not authenticate with provider';
      } else {
        final userData = res!.data!['socialLink']['user'];
        final user = User.fromJson(userData);

        return user.integrations;
      }
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  Future<List<Integration>?> twitterLink(
      {String? token, String? verifierToken, int? integrationKey}) async {
    final data = await socialLinkComplete(
        token: token,
        socialSource: SOCIAL_SOURCE.TWITTER,
        verifierToken: verifierToken,
        integrationKey: integrationKey);
    return data;
  }
}
