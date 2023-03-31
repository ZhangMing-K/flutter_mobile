import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BouncingNestedScrollController extends GetxController {
  BouncingNestedScrollController();
  final ScrollController controller = ScrollController();
  ScrollPhysics scrollPhysics = const AlwaysScrollableScrollPhysics();
  Rx<bool> isChildTop = true.obs;
  Rx<bool> isChildBottom = false.obs;
  Rx<String> direction = 'down'.obs;

  @override
  void onInit() {
    controller.addListener(() {
      if (controller.position.atEdge) {
        if (controller.position.pixels != 0) {
          isChildTop.value = false;
          isChildBottom.value = true;
        }

        if (controller.position.pixels == 0) {
          direction.value = 'up';
          isChildTop.value = true;
          isChildBottom.value = false;
        }
      } else {
        isChildTop.value = false;
        isChildBottom.value = false;
      }
      final offset = controller.offset;
      if (offset > 0) {
        direction.value = 'down';
      } else {
        direction.value = 'up';
      }
    });
    super.onInit();
  }

  ScrollPhysics getScrollPhysics(bool isTop, bool isBottom, bool reset) {
    if (isTop && isChildTop.value && !isBottom && !isChildBottom.value) {
      return const NeverScrollableScrollPhysics();
    }
    if (!isTop && isBottom && isChildTop.value && !isChildBottom.value) {
      if (reset) {
        return const BouncingScrollPhysics();
      } else {
        if (direction.value == 'down') {
          return const BouncingScrollPhysics();
        } else if (direction.value == 'up') {
          direction.value = 'down';
          return const NeverScrollableScrollPhysics();
        }
      }
    }
    if (!isTop && !isBottom) {
      if (direction.value == 'down') {
        return const BouncingScrollPhysics();
      } else if (direction.value == 'up') {
        direction.value = 'down';
        return const NeverScrollableScrollPhysics();
      }
    }
    if (!isTop && isBottom && !isChildTop.value && isChildBottom.value) {
      return const BouncingScrollPhysics();
    }
    return const BouncingScrollPhysics();
  }
}
