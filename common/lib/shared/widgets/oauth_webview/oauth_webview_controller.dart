import 'package:get/get.dart';

import '../../../iris_common.dart';

class OauthWebviewController extends GetxController {
  SOCIAL_SOURCE? socialSource;

  BROKER_NAME? brokerName;

  final String url;

  late bool enableBot;

  OauthWebviewController(
      {required this.url, this.brokerName, this.socialSource}) {
    enableBot = url.contains('bot') ? true : false;
  }

  Uri get uri {
    return Uri.parse(url);
  }

  RegExp getBrokerUrlParser() {
    switch (brokerName) {
      case BROKER_NAME.TD_AMERITRADE:
        return RegExp(r'(?<=broker\/(td)\?code\=).*$');
      default:
        return RegExp(r'(?<=broker\/(td)\?code\=).*$');
    }
  }

  List<RegExp> getSocialUrlParser() {
    switch (socialSource) {
      case SOCIAL_SOURCE.TWITTER:
        return [
          RegExp(r'(?<=oauth_token\=)[\w-]+'),
          RegExp(r'(?<=oauth_verifier\=)[\w-]+')
        ];
      case SOCIAL_SOURCE.DISCORD:
        return enableBot
            ? [RegExp(r'(?<=code\=)[\w-]+'), RegExp(r'(?<=guild_id\=)[\w-]+')]
            : [RegExp(r'(?<=code\=)[\w-]+')];
      default:
        return [
          RegExp(r'(?<=oauth_token\=)[\w-]+'),
          RegExp(r'(?<=oauth_verifier\=)[\w-]+')
        ];
    }
  }

  getSocialUrlResult(url) {
    final socialRgxCode = getSocialUrlParser();

    switch (socialSource) {
      case SOCIAL_SOURCE.TWITTER:
        final oauthTokenRegEx = socialRgxCode[0];
        final oauthVerifierRegEx = socialRgxCode[1];
        final oauthToken = oauthTokenRegEx.firstMatch(url)!.group(0);
        final oauthVerifier = oauthVerifierRegEx.firstMatch(url)!.group(0);

        return {'oauthToken': oauthToken, 'oauthVerifier': oauthVerifier};

      case SOCIAL_SOURCE.DISCORD:
        final codeRegex = socialRgxCode[0];
        String? guildId;
        if (enableBot) {
          final guildIdRegex = socialRgxCode[1];
          guildId = guildIdRegex.firstMatch(url)?.group(0);
        }

        final code = codeRegex.firstMatch(url)!.group(0);

        return {'code': code, 'guildId': guildId};

      default:
    }
  }

  getUrlResult(RegExp rgxCode, Uri? url) {
    if (brokerName != null) {
      final code = rgxCode.firstMatch(url.toString())!.group(0)!;
      final decoded = Uri.decodeComponent(code);
      return decoded;
    }

    if (socialSource != null) {
      return getSocialUrlResult(url.toString());
    }
  }

  socialHasMatch(url) {
    int numberMatched = 0;

    final socialRgxCode = getSocialUrlParser();
    final numberToMatch = socialRgxCode.length;

    for (var element in socialRgxCode) {
      if (element.hasMatch(url.toString())) numberMatched++;
    }

    return numberMatched == numberToMatch;
  }
}
