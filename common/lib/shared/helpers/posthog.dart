import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:throttling/throttling.dart';

import '../../iris_common.dart';

class PosthogService {
  static final PosthogService _singleton = PosthogService._internal();

  factory PosthogService() {
    return _singleton;
  }

  PosthogService._internal();

  Future<void> capture({required String eventType, required String eventName}) {
    return Posthog()
        .capture(eventName: eventName, properties: {"eventType": eventType});
  }

  Future<void> setUser({required User user}) {
    final dynamic data = user
        .copyWith(notifications: [])
        .toJson()
        .map((key, value) => MapEntry(key, value));
    final properties = {
      '\$set': data,
    };

    return Posthog().capture(eventName: 'SET_USER', properties: properties);
  }
}

final Function posthogThrottle =
    Throttling(duration: const Duration(milliseconds: 10000)).throttle;

//TODO move this into IrisEvent and PosthogService
Future<void> identifyInPosthog(User? user) async {
  if (GetPlatform.isAndroid || GetPlatform.isIOS) {
    try {
      await Posthog().identify(
          userId: user?.userKey?.toString(),
          properties: {'name': user?.username, 'email': user?.email});
    } catch (err) {
      debugPrint('$identifyInPosthog: $err');
    }
  }
}

//TODO move this into IrisEvent and PosthogService
Future<void> sendScreenEvent(String? screenName,
    {String? prevScreenName}) async {
  try {
    if (GetPlatform.isWeb || GetPlatform.isDesktop) {
      return;
    }
    final bool shouldThrottle = !(await isFeatureEnabled(
            FeatureFlag.unlimited_tracking) ||
        await isFeatureEnabled(FeatureFlag.tracking_for_recently_registered) ||
        await isFeatureEnabled(FeatureFlag.tracking_for_unidentified));

    if (shouldThrottle) {
      posthogThrottle(() => _sendScreenEvent(screenName!,
          prevScreenName: prevScreenName, isThrottled: true));
    } else {
      await _sendScreenEvent(screenName!,
          prevScreenName: prevScreenName, isThrottled: false);
    }
  } catch (err) {
    debugPrint('$sendScreenEvent: $err');
  }
}

Future<void> _sendScreenEvent(String screenName,
    {String? prevScreenName, bool? isThrottled}) async {
  if (GetPlatform.isWeb || GetPlatform.isDesktop) {
    return;
  }
  await Posthog().screen(screenName: screenName, properties: {
    'prev_screen_name': prevScreenName,
    'is_throttled': isThrottled
  });
}
