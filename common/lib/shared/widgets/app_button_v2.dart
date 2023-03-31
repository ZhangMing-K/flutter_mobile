import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/themes/colors.dart';

enum APP_BUTTON_TYPE { OUTLINE, SOLID, FLAT }

class AppButtonV2 extends StatelessWidget {
  const AppButtonV2({
    Key? key,
    this.height,
    this.width,
    this.borderWidth = .5,
    this.color,
    this.child,
    this.borderRadius = 0,
    required this.onPressed,
    this.padding,
    this.disabled,
    this.buttonType = APP_BUTTON_TYPE.OUTLINE,
  }) : super(key: key);

  final bool? disabled;
  final double? height;
  final double? width;
  final double borderWidth;
  final Color? color;
  final Widget? child;
  final Function() onPressed;
  final APP_BUTTON_TYPE buttonType;
  final double borderRadius;
  final EdgeInsets? padding;

  Widget outlineButton(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        // padding: padding,
        onPressed: (disabled != true) ? onPressed : null,
        // borderSide: BorderSide(
        //     color: color ?? context.theme.primaryColor, width: borderWidth),
        // textColor: color ?? context.theme.primaryColor,
        child: child!,
        // style: ButtonStyle(textStyle: )
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
      ),
    );
  }

  Widget solidButton(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,

      child: TextButton(
        child: child!,
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(context.theme.primaryColor),
            textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(color: Colors.white, fontSize: 12))),
        onPressed: onPressed,
      ),
      // child: FlatButton(
      //   onPressed: (disabled ?? false) ? null : onPressed,
      //   color: color ?? context.theme.primaryColor,
      //   padding: padding,
      //   textColor: Colors.white,
      //   child: child!,
      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(3))),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget button;
    if (buttonType == APP_BUTTON_TYPE.OUTLINE) {
      button = outlineButton(context);
    } else if (buttonType == APP_BUTTON_TYPE.SOLID) {
      button = solidButton(context);
    } else {
      button = solidButton(context);
    }
    return Stack(
      children: [
        button,
        if (disabled == true)
          Container(
            height: height,
            width: width,
            padding: padding,
            decoration: BoxDecoration(
                color: IrisColor.backgroundColorDark.withOpacity(0.7),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          ),
      ],
    );
  }
}
