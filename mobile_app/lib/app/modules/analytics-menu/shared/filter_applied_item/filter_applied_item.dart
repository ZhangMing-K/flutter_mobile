import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_mobile/app/modules/analytics-menu/shared/gold_gradient_wrapper/gold_gradient_wrapper.dart';

class FilterAppliedItem extends StatelessWidget {
  final String title;
  const FilterAppliedItem({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: context.theme.backgroundColor,
            // color: IrisColor.backgroundUnderGold,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(16),
            vertical: ScreenUtil().setWidth(8)),
        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
        child: IrisGoldGradientRapper(
          child: Text(title,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(13),
                  fontWeight: FontWeight.w700)),
        ));
  }
}
