import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TypeWidget extends StatelessWidget {
  const TypeWidget(
      {Key? key,
      this.isSelected = false,
      required this.title,
      this.color,
      this.hasGraph = false,
      this.total = 3,
      required this.onPressed,
      this.graphVal})
      : super(key: key);
  final bool isSelected;
  final String title;
  final Color? color;
  final bool hasGraph;
  final double? graphVal;
  final Function onPressed;
  final int total;

  @override
  Widget build(BuildContext context) {
    final scaleFactor = context.textScaleFactor;
    return GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
                color: isSelected
                    ? context.theme.backgroundColor
                    : context.theme.scaffoldBackgroundColor,
                border: Border.all(
                  color: isSelected
                      ? context.theme.backgroundColor
                      : context.theme.colorScheme.secondary.withOpacity(0.5),
                  width: 1,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(100))),
            padding: EdgeInsets.symmetric(
                horizontal: 12 * scaleFactor, vertical: 8 * scaleFactor),
            height: 40 * scaleFactor,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w400,
                    color: context.theme.colorScheme.secondary),
                textAlign: TextAlign.center,
              )
            ])));
  }
}
