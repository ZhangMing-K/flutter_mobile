import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlUtils {
  UrlUtils._();

  ///A convenience utility for using the correct launch method for web or mobile.
  ///It will open link with [IrisBottomSheetWebView] if on mobile.
  ///It will open a new tab on web.
  static void open(String url) async {
    try {
      if (await canLaunch(url)) {
        if (!GetPlatform.isWeb) {
          await launch(url);
          // Get.bottomSheet(
          //   IrisBottomSheetWebView(
          //     url: url,
          //   ),
          //   isScrollControlled: true,
          // );
        } else {
          await launch(url);
        }
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      debugPrint('Url launch error: -> $e');
    }
  }
}
