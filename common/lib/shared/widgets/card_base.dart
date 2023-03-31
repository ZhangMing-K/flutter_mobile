import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/consts/decorations.dart';

class CardBase extends StatelessWidget {
  final Widget? child;
  final bool? border;
  final double? borderWidth;
  final Color? color;
  const CardBase(
      {Key? key, this.child, this.border, this.borderWidth, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: color ?? context.theme.backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(21)),
            boxShadow: Decorations.boxShadowBottom,
            border: border == true
                ? Border.all(
                    color: context.theme.primaryColor,
                    width: borderWidth ?? 2,
                  )
                : Border.all(
                    color: Colors.transparent,
                    width: 0,
                  )),
        padding: const EdgeInsets.all(10),
        child: child);
  }
}
