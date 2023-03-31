import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HeadingTitleWidget extends StatelessWidget {
  const HeadingTitleWidget(
      {Key? key, required this.title, this.isDisabled = false, this.marginLeft})
      : super(key: key);
  final String title;
  final double? marginLeft;
  final bool? isDisabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: marginLeft ?? 5),
      child: Text(title,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(17),
              fontWeight: FontWeight.w500,
              color: !isDisabled!
                  ? context.theme.colorScheme.secondary
                  : context.theme.colorScheme.secondary.withOpacity(0.5))),
    );
  }
}
