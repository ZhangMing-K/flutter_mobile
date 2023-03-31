import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

class DailyPercentGainView extends StatelessWidget {
  const DailyPercentGainView({this.percentGain, this.textStyle, Key? key})
      : super(key: key);
  final double? percentGain;
  final TextStyle? textStyle;

  Color get color {
    if (percentGain == null) return Colors.white;
    if (percentGain == 0) {
      // return IrisColor.positiveChange;
      return Colors.grey;
    }
    if (percentGain! > 0) return IrisColor.positiveChange;
    return IrisColor.negativeChange;
  }

  String get text {
    final percentage = percentGain.formatPercentage();
    if (percentGain != null && percentGain! > 0) {
      return '+' + percentage;
    }
    return percentage;
  }

  @override
  Widget build(BuildContext context) {
    if (percentGain == null) {
      return Container();
    } else {
      return Text(text,
          textScaleFactor: 1,
          style: textStyle != null
              ? textStyle?.copyWith(color: color)
              : TextStyle(
                  color: color, fontSize: IrisScreenUtil.dFontSize(14),
                  // fontWeight: FontWeight.w400
                ));
    }
  }
}
