import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class DeeplinkService extends GetxService {
  int? invitedByUserKey;
  int? invitedByInviteLinkKey;
  String? deeplinkFrom;

  String? getDeeplinkFrom(Uri uri) {
    if (uri.queryParameters['from'] == null) {
      return null;
    }
    return uri.queryParameters['from'];
  }

  int? getInvitedByInviteLinkKey(Uri uri) {
    if (uri.queryParameters['invitedByInviteLinkKey'] == null) {
      return null;
    }
    final userKeyStr = uri.queryParameters['invitedByInviteLinkKey'];
    if (userKeyStr != null && userKeyStr.isNotEmpty) {
      return int.parse(userKeyStr);
    } else {
      return null;
    }
  }

  int? getInviteUserKey(Uri uri) {
    if (uri.queryParameters['invitedBy'] == null) {
      return null;
    }
    final userKeyStr = uri.queryParameters['invitedBy'];
    if (userKeyStr != null && userKeyStr.isNotEmpty) {
      return int.parse(userKeyStr);
    } else {
      return null;
    }
  }

  Future handleDynamicLinks() async {
    if (GetPlatform.isAndroid || GetPlatform.isIOS) {
      // 1. Get the initial dynamic link if the app is opened with a dynamic link
      final PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();

      // 2. handle link that has been retrieved
      _handleDeepLink(data);

      // 3. Register a link callback to fire if the app is opened up from the background
      // using a dynamic link.
      FirebaseDynamicLinks.instance.onLink.listen((dynamicLink) {
        // 3a. handle link that has been retrieved
        _handleDeepLink(dynamicLink);
      }, onError: (e) async {
        debugPrint('Link Failed: $e');
      });
    }
  }

  void _handleDeepLink(PendingDynamicLinkData? data) {
    if (GetPlatform.isWeb) {
      return;
    }
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      invitedByUserKey = getInviteUserKey(deepLink);
      deeplinkFrom = getDeeplinkFrom(deepLink);
      invitedByInviteLinkKey = getInvitedByInviteLinkKey(deepLink);
    } else {
      debugPrint('No dynamic link found');
    }
  }
}
