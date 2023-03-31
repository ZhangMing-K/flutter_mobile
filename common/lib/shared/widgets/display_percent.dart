import 'package:flutter/material.dart';

import '../../shared/consts/icons.dart';
import '../extensions/double.dart';

class DisplayPercent extends StatelessWidget {
  final double? percent;
  final double fontSize;
  final FontWeight? fontWeight;
  final double roundedNumber;
  final bool? useArrow;
  const DisplayPercent(
      {Key? key,
      required this.percent,
      this.useArrow = true,
      this.fontSize = 13,
      this.fontWeight,
      this.roundedNumber = 0.03})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (percent == null) {
      return Text('-',
          textScaleFactor: 1,
          style: TextStyle(fontWeight: fontWeight, fontSize: fontSize));
    }
    return Container(
      child: row(),
    );
  }

  Widget row() {
    bool positive = true;
    if (percent! < 0) {
      positive = false;
    }

    Image arrow;

    Color color;
    if (!positive) {
      arrow = Image.asset(
        IconPath.redArrowPercent,
        width: 11,
        height: 6,
      );
      color = const Color(0xFFE94950);
    } else {
      arrow = Image.asset(IconPath.greenArrowPercent, width: 11, height: 6);
      color = const Color(0xFF69B11B);
    }

    final TextStyle style =
        TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize);
    final percentWidget = Text(
      percent!.isNaN
          ? 0.0.formatPercentage(roundedNumber: roundedNumber)
          : percent!.abs().formatPercentage(roundedNumber: roundedNumber),
      textScaleFactor: 1,
      style: style,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (useArrow!)
          arrow
        else
          Text(
            positive ? '+' : '-',
            style: style,
            textScaleFactor: 1,
          ),
        percentWidget
      ],
    );
  }
}
