import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IrisStackObserver extends NavigatorObserver {
  static final List<Route> stack = <Route>[];

  /// Gets the current route open
  static Route get onTop => stack.last;

  static final _stackChangeController =
      StreamController<StackChange>.broadcast();

  void popUntil(RoutePredicate predicate) {
    while (predicate(onTop)) {
      navigator?.pop();
    }
  }

  /// A Stream to listen navigator changes
  static Stream<StackChange> get stackChange => _stackChangeController.stream;

  @override
  void didPop(Route route, Route? previousRoute) {
    if (route is! GetPageRoute) {
      return;
    }
    stack.removeLast();
    _stackChangeController.add(StackChange(
      action: NavigationStackAction.pop,
      newRoute: previousRoute,
      oldRoute: route,
    ));
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route is! GetPageRoute) {
      return;
    }
    stack.add(route);
    _stackChangeController.add(StackChange(
      action: NavigationStackAction.push,
      newRoute: route,
      oldRoute: previousRoute,
    ));
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    if (route is! GetPageRoute) {
      return;
    }
    stack.remove(route);
    _stackChangeController.add(StackChange(
      action: NavigationStackAction.remove,
      newRoute: route,
      oldRoute: previousRoute,
    ));
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (newRoute is! GetPageRoute) {
      return;
    }
    final int oldRouteIndex = stack.indexOf(oldRoute!);
    stack.replaceRange(oldRouteIndex, oldRouteIndex + 1, [newRoute]);
    _stackChangeController.add(StackChange(
      action: NavigationStackAction.replace,
      newRoute: newRoute,
      oldRoute: oldRoute,
    ));
  }
}

class StackChange {
  StackChange({this.action, this.newRoute, this.oldRoute});

  final NavigationStackAction? action;
  final Route? newRoute;
  final Route? oldRoute;
}

enum NavigationStackAction {
  push,
  pop,
  remove,
  replace,
}
