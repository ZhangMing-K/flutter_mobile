// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final env = dotenv.env;

class ENV {
  static String? GRAPHQL_API_URL = env['GRAPHQL_API_URL'];
  static String? GRAPHQL_SUBSCRIBE_URL = env['GRAPHQL_SUBSCRIBE_URL'];
  static String? AMPLITUDE_API_KEY = env['AMPLITUDE_API_KEY'];

  // static String? SMARTLOOK_API_KEY = env['SMARTLOOK_API_KEY'];
  static String? POSTHOG_API_KEY = env['POSTHOG_API_KEY'];
  static bool IS_WEB = kIsWeb;
  static String? GIPHY_API_KEY = env['GIPHY_API_KEY'];
  static String? IRIS_EVENT_GRAPHQL_API_URL = env['IRIS_EVENT_GRAPHQL_API_URL'];
  static String? IRIS_WEB_URL = env['IRIS_WEB_URL'];
  static String? DISCORD_WEB_URL = env['DISCORD_WEB_URL'];
  static String? IRIS_API_KEY = env['IRIS_API_KEY'];
  static String? STRIPE_PUBLISHABLE_KEY = env['STRIPE_PUBLISHABLE_KEY'];
  static String? STRIPE_TEST_ENV = env['STRIPE_TEST_ENV'];
  static String? NO_BROKER_REDIRECT_URL = env['NO_BROKER_REDIRECT_URL'];
}
