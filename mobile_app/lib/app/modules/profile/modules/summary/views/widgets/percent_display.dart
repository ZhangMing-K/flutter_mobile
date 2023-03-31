import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

class PercentDisplay extends StatelessWidget {
  const PercentDisplay(
      {this.percent,
      this.textStyle,
      this.showPlusSign = true,
      this.showDecimal = true,
      this.nullPlaceholder,
      Key? key})
      : super(key: key);
  final double? percent;
  final TextStyle? textStyle;
  final bool showPlusSign;
  final bool showDecimal;
  final String? nullPlaceholder;

  Color get color {
    if (percent == null) return Colors.white;
    if (percent == 0) {
      // return IrisColor.positiveChange;
      return Colors.grey;
    }
    //TODO refactor and use the new customColorScheme under customThemeData
    if (percent! > 0) return IrisColor.positiveChange;
    return IrisColor.negativeChange;
  }

  String get text {
    var text = nullPlaceholder;
    if (percent != null) {
      text = percent.formatPercentage(roundedNumber: showDecimal ? 1 : 0.0);
      if (percent != null && showPlusSign) {
        if (percent! > 0) {
          text = '+$text';
        } else {
          text = text;
        }
      }
    } else if (text == null) {
      return 'ERR';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    if (percent == null && nullPlaceholder == null) {
      return Container();
    } else {
      return Text(text,
          style: textStyle != null
              ? textStyle?.copyWith(color: color)
              : TextStyle(
                  color: color, fontSize: 14,
                  // fontWeight: FontWeight.w400
                ));
    }
  }
}
