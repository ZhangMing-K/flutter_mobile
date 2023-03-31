import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class StreakCheckBox extends StatelessWidget {
  const StreakCheckBox(
      {Key? key, required this.isPositive, this.date = "10/15"})
      : super(key: key);
  final bool isPositive;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: ScreenUtil().setWidth(8)),
        child: Row(
          children: [
            SizedBox(width: ScreenUtil().setWidth(12)),
            Container(
              width: ScreenUtil().setWidth(10),
              height: ScreenUtil().setWidth(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: isPositive
                    ? IrisColor.positiveChange
                    : IrisColor.negativeChange,
              ),
            ),
            const SizedBox(width: 4),
            // Text('Streak on ' + date! , style: TextStyle(fontSize: 12)),
            Text('Current streak',
                style: TextStyle(fontSize: ScreenUtil().setSp(12))),
            SizedBox(width: ScreenUtil().setWidth(10)),
            Container(
              width: ScreenUtil().setWidth(10),
              height: ScreenUtil().setWidth(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: Get.isDarkMode
                    ? context.theme.backgroundColor
                    : IrisColor.lightSecondaryColor,
              ),
            ),
            SizedBox(width: ScreenUtil().setWidth(4)),
            Text('Prev high',
                style: TextStyle(fontSize: ScreenUtil().setSp(12))),
            SizedBox(width: ScreenUtil().setWidth(10)),
            // Container(
            //   width: 10,
            //   height: 10,
            //   decoration: BoxDecoration(
            //     borderRadius: const BorderRadius.all(Radius.circular(4)),
            //     border: Border.all(color: isPositive ? IrisColor.positiveChange : IrisColor.negativeChange,)
            //   ),
            // ),
            // const SizedBox(width: 4),
            // const Text('Streak ended', style: TextStyle(fontSize: 12)),
          ],
        ));
  }
}
