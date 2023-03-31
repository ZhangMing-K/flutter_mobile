import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';

class OverlayButtonController extends GetxController {
  OverlayButtonController(this.isVisible);
  ScrollController? _scrollBottomBarController;
  final RxBool isVisible;
  bool isScrollingDown = false;
  bool hasMorePosts = false;
  RxBool canShow = false.obs;

  @override
  void onInit() {
    ever(isVisible, (dynamic value) {
      hasMorePosts = value;
      if (!value) {
        canShow.value = false;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    _scrollBottomBarController?.removeListener.call(_listener);
    super.onClose();
  }

  void didChangeDependencies(ScrollController scroll) {
    _scrollBottomBarController?.removeListener.call(_listener);
    _scrollBottomBarController = scroll;
    _scrollBottomBarController!.addListener(_listener);
  }

  void _listener() {
    if (_scrollBottomBarController!.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (!isScrollingDown) {
        isScrollingDown = true;

        canShow.value = false;
      }
    }
    if (_scrollBottomBarController!.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (isScrollingDown) {
        isScrollingDown = false;
        if (hasMorePosts) {
          canShow.value = true;
        }
      }
    }
  }
}
