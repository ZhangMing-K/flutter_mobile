import 'package:flutter/material.dart';

import '../../shared/themes/font.dart';

class DefaultTextTitle extends StatelessWidget {
  final double? top;

  final double? bottom;
  final double? right;
  final double? left;
  final String? textTitle;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? align;
  final TextOverflow? textOverflow;
  const DefaultTextTitle(
      {Key? key,
      this.top,
      this.bottom,
      this.right,
      this.left,
      required this.textTitle,
      this.color,
      this.fontWeight,
      this.fontSize,
      this.align,
      this.textOverflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: bottom ?? 0, top: top ?? 0),
      child: Text(
        textTitle ?? '',
        overflow: textOverflow,
        style: TextStyle(
          fontFamily: Font.airbnbFont,
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
        ),
        textAlign: align,
      ),
    );
  }
}
