import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/themes/colors.dart';

class IrisDefaultButton extends GetView {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;
  final bool isLoading;
  const IrisDefaultButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.color,
    this.isLoading = false,
    this.textColor,
  }) : super(key: key);

  bool get showColor {
    return color != null || isLoading;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: showColor ? color ?? Colors.grey.withOpacity(.3) : null,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          gradient: showColor ? null : IrisColor.goldGradient,
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: isLoading
              ? const CupertinoActivityIndicator()
              : Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor ?? Colors.black,
                  ),
                ),
        ),
      ),
    );
  }
}
