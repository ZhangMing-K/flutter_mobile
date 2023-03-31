import 'package:flutter/widgets.dart';

import '../../shared/helpers/posthog.dart';

String? _extractScreenName(Route? route) => route?.settings.name;

class UserNavigationObserver extends NavigatorObserver {
  UserNavigationObserver();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final String? pushedScreen = _extractScreenName(route);
    final String? buriedScreen = _extractScreenName(previousRoute);
    if (pushedScreen != null && pushedScreen.isNotEmpty) {
      // debugPrint('##PUSH $pushedScreen on top of $buriedScreen');
      sendScreenEvent(pushedScreen, prevScreenName: buriedScreen);

      // NOTE(Taro): toggleSmartlookBasedOnUserAndRoute is conditionally
      // enabled using feature flags and a blacklist of sensitive routes

    }

    super.didPush(route, previousRoute);
  }

  /*
  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    debugPrint(
        '##REPLACE ${oldRoute?.settings?.name} with ${newRoute?.settings?.name}\n');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
  */

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final String? poppedScreen = _extractScreenName(route);
    final String? revealedScreen = _extractScreenName(previousRoute);
    // debugPrint('##POP $poppedScreen to reveal $revealedScreen');
    if (poppedScreen != null && poppedScreen.isNotEmpty) {
      // NOTE(Taro): sendScreenEvent is conditionally throttled using feature flags
      sendScreenEvent(revealedScreen, prevScreenName: poppedScreen);

      // NOTE(Taro): toggleSmartlookBasedOnUserAndRoute is conditionally
      // enabled using feature flags and a blacklist of sensitive routes
      // toggleSmartlookBasedOnUserAndRoute(revealedScreen);
    }

    super.didPop(route, previousRoute);
  }

  /*
  @override
  void didRemove(Route route, Route previousRoute) {
    debugPrint(
        '##REMOVE ${route?.settings?.name} to reveal ${previousRoute?.settings?.name}\n');
    super.didRemove(route, previousRoute);
  }
  */
}
