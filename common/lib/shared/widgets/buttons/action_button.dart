import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/data/calc/index.dart';

import '../../../shared/consts/units.dart';
import '../../../shared/widgets/default_text_title.dart';
import '../app_button_v2.dart';

class ActionButton extends StatelessWidget {
  final bool disabled;
  final bool shadow;
  final Function() onPressed;
  final String? text;
  final Color? textColor;
  final APP_BUTTON_TYPE? appButtonType;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final double? fontSize;
  const ActionButton({
    Key? key,
    this.disabled = false,
    required this.onPressed,
    this.text,
    this.textColor,
    this.appButtonType,
    this.padding,
    this.width,
    this.height = 45,
    this.fontSize,
    this.shadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding ?? EdgeInsets.only(top: IrisScreenUtil.dWidth(50)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // boxShadow: [BoxShadow(blurRadius: 20, spreadRadius: 20)],
        ),
        child: Container(
            decoration: shadow
                ? const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ],
                  )
                : null,
            child: button(context)));
  }

  button(BuildContext context) {
    return SizedBox(
      height: IrisScreenUtil.dWidth(height!),
      width: width ?? double.maxFinite,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        child: DefaultTextTitle(
          textTitle: text,
          fontSize: fontSize != null
              ? IrisScreenUtil.dFontSize(fontSize!)
              : ScreenUtil().setSp(TextUnit.medium),
          color: textColor ?? context.theme.colorScheme.secondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
