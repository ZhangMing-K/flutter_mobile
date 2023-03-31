import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/consts/units.dart';
import '../themes/colors.dart';

class IrisSnackbar {
  static trigger(
      {VoidCallback? onPressed, required String title, required String body}) {
    Get.snackbar(
      title,
      body,
      shouldIconPulse: true,
      onTap: (_) {
        if (onPressed != null) onPressed();
      },
      colorText: IrisColor.defaultTextColorDark,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.only(
        top: SpaceUnit.small,
        bottom: SpaceUnit.small,
        left: SpaceUnit.extraSmall,
        right: SpaceUnit.extraSmall,
      ),
      boxShadows: [
        BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1)
      ],
      padding: const EdgeInsets.only(
        left: SpaceUnit.small,
        top: SpaceUnit.extraSmall,
        right: SpaceUnit.small,
        bottom: SpaceUnit.small,
      ),
      barBlur: 20,
      backgroundColor: const Color(0xFF323232),
      borderRadius: 5,
      dismissDirection: DismissDirection.vertical,
      snackStyle: SnackStyle.FLOATING,
      animationDuration: const Duration(milliseconds: 400),
      isDismissible: true,
      duration: const Duration(seconds: 4),
    );
  }
}
