import 'package:flutter/foundation.dart';
import 'package:get/utils.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

Future<void> reportErrorToPostHog(
    {String? technicalMessage, String? userFriendlyMessage}) async {
  if (GetPlatform.isWeb || GetPlatform.isDesktop) {
    return;
  }
  try {
    await Posthog().capture(eventName: '\$error', properties: {
      'user_friendly_message': userFriendlyMessage,
      'technical_message': technicalMessage
    });
  } catch (err) {
    debugPrint('Failed to capture error event with PostHog: $err');
  }
}
