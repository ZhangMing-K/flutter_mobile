import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/reactions/iris_reactions.dart';

extension PositionExt on BuildContext {
  Rect get position {
    final RenderBox box = findRenderObject() as RenderBox;
    final Offset topLeft = box.size.topLeft(box.localToGlobal(Offset.zero));
    final Offset bottomRight =
        box.size.bottomRight(box.localToGlobal(Offset.zero));
    return Rect.fromLTRB(
        topLeft.dx, topLeft.dy, bottomRight.dx, bottomRight.dy);
  }
}

enum OverlayDirection {
  left,
  right,
}

class IrisReactionManager {
  Widget show(Widget child, Rect position) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
            color: Colors.black12,
            child: Stack(
              children: [
                Positioned.fromRect(
                  rect: position,
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future showReactions({
    required Rect position,
    required Widget mainWidget,
    required Widget overlayWidget,
    required OverlayDirection overlayPosition,
  }) {
    final child = CustomOverlay(
      child: CustomOverlayEntry(
        visible: true,
        childAnchor: overlayPosition == OverlayDirection.left
            ? Alignment.topLeft
            : Alignment.topRight,
        overlayAnchor: overlayPosition == OverlayDirection.left
            ? Alignment.bottomLeft
            : Alignment.bottomRight,
        overlay: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOut,
          tween: Tween(begin: 0, end: 1),
          builder: (context, progress, child) {
            return Transform(
              transform: Matrix4.translationValues(0, (1 - progress) * 50, 0),
              child: Opacity(
                opacity: progress,
                child: child,
              ),
            );
          },
          child: overlayWidget,
        ),
        child: mainWidget,
      ),
    );

    return Get.to(
      () => show(child, position),
      opaque: false,
      fullscreenDialog: true,
      transition: Transition.downToUp,
      duration: const Duration(milliseconds: 100),
    )!;
  }
}

// class _PopupItemRouteLayout extends SingleChildLayoutDelegate {
//   _PopupItemRouteLayout(this.position);

//   final Rect position;

//   @override
//   BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
//     return BoxConstraints.loose(Size(position.width, position.height));
//   }

//   @override
//   Offset getPositionForChild(Size size, Size childSize) {
//     return Offset(position.left, position.top);
//   }

//   @override
//   bool shouldRelayout(_PopupItemRouteLayout oldDelegate) {
//     return position != oldDelegate.position;
//   }
// }
