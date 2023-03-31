import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

// NOTE(Taro): This function doesn't behave like a normal widget, since GetX
// handles insertion of it.
void showTempSuccessSnackbar(
    {String? technicalMessage, required String userFriendlyMessage}) {
  Get.rawSnackbar(
    padding: const EdgeInsets.only(
        left: SpaceUnit.small,
        top: SpaceUnit.extraSmall,
        right: SpaceUnit.small,
        bottom: 6),
    titleText: Text(
      userFriendlyMessage,
      textAlign: TextAlign.left,
      style: const TextStyle(
          fontSize: TextUnit.small, color: Colors.white, height: 1.5),
    ),
    messageText: const UnconstrainedBox(
      alignment: AlignmentDirectional.bottomEnd,
    ),
    snackPosition: SnackPosition.TOP,
    margin: const EdgeInsets.only(
      top: SpaceUnit.small,
      left: SpaceUnit.extraSmall,
      right: SpaceUnit.extraSmall,
    ),
    boxShadows: [
      BoxShadow(
          offset: const Offset(0, 3),
          blurRadius: 4,
          color: Colors.black.withOpacity(0.5),
          spreadRadius: 1)
    ],
    backgroundColor: const Color(0xFF323232),
    borderRadius: 5,
    isDismissible: true,
    dismissDirection: DismissDirection.vertical,
    snackStyle: SnackStyle.FLOATING,
    duration: const Duration(milliseconds: 3000),
    animationDuration: const Duration(milliseconds: 400),
  );
}
