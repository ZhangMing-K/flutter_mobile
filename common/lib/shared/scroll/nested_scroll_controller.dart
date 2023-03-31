import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NestedScrollController {
  NestedScrollController() {
    addListener(_listener);
  }
  final Rx<NestedScrollPosition> scrollPosition = NestedScrollPosition.none.obs;
  final ScrollController controller = ScrollController();

  void dispose() {
    removeListener(_listener);
  }

  bool _isScrollingDown = false;

  void scrollToTop() {
    controller.animateTo(0,
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
  }

  void addListener(VoidCallback listener) {
    controller.addListener(listener);
  }

  void removeListener(VoidCallback listener) {
    controller.removeListener(listener);
  }

  void _listener() {
    if (controller.position.userScrollDirection == ScrollDirection.reverse) {
      if (!_isScrollingDown) {
        _isScrollingDown = true;
        scrollPosition(NestedScrollPosition.up);
      }
    }
    if (controller.position.userScrollDirection == ScrollDirection.forward) {
      if (_isScrollingDown) {
        _isScrollingDown = false;
        scrollPosition(NestedScrollPosition.down);
      }
    }
  }
}

enum NestedScrollPosition { none, up, down }
