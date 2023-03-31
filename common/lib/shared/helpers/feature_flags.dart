import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:throttling/throttling.dart';

import '../../../../shared/consts/env.dart';

final Function featureThrottle =
    Throttling(duration: const Duration(milliseconds: 30000)).throttle;

List<String>? _activeFeatureFlags = [];

Future<bool> isFeatureEnabled(FeatureFlag flag) async {
  final String _flag = EnumToString.convertToString(flag);
  try {
    if (_activeFeatureFlags == null) {
      await _loadActiveFeatureFlags();
    } else {
      featureThrottle(_loadActiveFeatureFlags);
    }
  } catch (err) {
    debugPrint('$isFeatureEnabled: $isFeatureEnabled');
  }
  return _activeFeatureFlags!.contains(_flag);
}

Future<bool> isOnlyFeatureEnabled(FeatureFlag flag) async {
  final String _flag = EnumToString.convertToString(flag);
  try {
    if (_activeFeatureFlags == null) {
      await _loadActiveFeatureFlags();
    } else {
      featureThrottle(_loadActiveFeatureFlags);
    }
  } catch (err) {
    debugPrint('$isOnlyFeatureEnabled: $isFeatureEnabled');
  }
  return _flag == _activeFeatureFlags!.single;
}

Future<void> _loadActiveFeatureFlags() async {
  if (GetPlatform.isAndroid || GetPlatform.isIOS) {
    final Posthog _posthog = Posthog();
    final String? anonUserId = await _posthog.getAnonymousId;
    final http.Response res = await http.post(
        Uri.parse('https://app.posthog.com/decide/'),
        body: jsonEncode(<String, String?>{
          'api_key': ENV.POSTHOG_API_KEY,
          'distinct_id': anonUserId
        }));

    final Map<dynamic, dynamic> parsed = jsonDecode(res.body);
    _activeFeatureFlags = parsed['featureFlags'].cast<String>();
    return;
  }
}

enum FeatureFlag {
  tracking_for_recently_registered,
  tracking_for_unidentified,
  unlimited_tracking
}
