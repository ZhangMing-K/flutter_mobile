import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HoldingCardItem extends StatelessWidget {
  const HoldingCardItem(
      {Key? key,
      required this.title,
      required this.percentageChange,
      this.color,
      this.hasGraph = false,
      this.graphVal})
      : super(key: key);
  final String title;
  final double percentageChange;

  final Color? color;
  final bool hasGraph;
  final double? graphVal;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
      ),
      padding: const EdgeInsets.all(16),
      height: 51,
      width: Get.width / 3,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: context.theme.textTheme.bodyText1!.color,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
