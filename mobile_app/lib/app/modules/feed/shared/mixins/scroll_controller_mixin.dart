import 'package:flutter/material.dart';

/// Informs if the page is at the beginning. If the page is not in
/// the initial position, when clicking on the page that uses this mixin,
/// the scroll will go to position 0 and return false because the page
///  should not be changed. If it is in position 0, it will return true,
/// and the tab will be changed.
mixin ScrollControllerMixin {
  final scrollController = ScrollController();

  void mustChangePages() {
    scrollController.animateTo(0,
        curve: Curves.easeIn, duration: const Duration(milliseconds: 250));
  }
}
