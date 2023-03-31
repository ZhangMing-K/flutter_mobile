import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DDHeader extends StatelessWidget {
  const DDHeader({
    Key? key,
    required this.text,
    this.topPadding = 10.0,
    this.fontSize = 15,
  }) : super(key: key);
  final String text;
  final double topPadding;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: context.theme.colorScheme.secondary.withOpacity(.7),
          fontSize: fontSize,
        ),
      ),
    );
  }
}
