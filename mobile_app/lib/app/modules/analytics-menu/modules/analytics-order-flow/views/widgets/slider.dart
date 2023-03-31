import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

typedef SliderCallback = void Function(double changedVal);

class FilterSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final SliderCallback onChanged;
  const FilterSlider(
      {Key? key,
      required this.value,
      this.min = 0,
      this.max = 100,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      margin: EdgeInsets.only(top: ScreenUtil().setWidth(12)),
      child: CupertinoSlider(
          min: min,
          max: max,
          thumbColor: Colors.white,
          activeColor: IrisColor.primaryColor,
          value: value,
          onChanged: onChanged),
    );
  }
}
