import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/consts/decorations.dart';
import '../../shared/themes/font.dart';

class DefaultButton extends StatelessWidget {
  final Color? backgroundColor;

  final Color? textColor;
  final Color borderColor;
  final Function? onPressed;
  final double height;
  final double width;
  final double? spFont;
  final String? text;
  final String? iconAssetPath;
  final int? haveBlur;
  final double? heightButton;
  final double? widthButton;
  final double? radiusButton;
  const DefaultButton({
    Key? key,
    this.backgroundColor,
    this.textColor,
    required this.borderColor,
    this.onPressed,
    this.height = 50,
    this.width = 1000,
    this.spFont,
    this.text,
    this.iconAssetPath,
    this.haveBlur,
    this.heightButton,
    this.widthButton,
    this.radiusButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget displayWidget;
    if (iconAssetPath == null) {
      displayWidget = flatButton();
    } else {
      displayWidget = flatIconButton();
    }
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            boxShadow: haveBlur == 1 ? Decorations.boxShadow : null),
        child: displayWidget);
  }

  Widget flatButton() {
    return Builder(builder: (context) {
      return FlatButton(
        color: backgroundColor ?? Colors.white,
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: borderColor),
            borderRadius: BorderRadius.circular(radiusButton ?? 35)),
        onPressed: onPressed as void Function()?,
        child: Text(
          text!,
          style: TextStyle(
              fontFamily: Font.airbnbFont,
              fontSize: spFont,
              fontWeight: FontWeight.w500,
              color: textColor ?? context.theme.primaryColor),
        ),
      );
    });
  }

  Widget flatIconButton() {
    return FlatButton.icon(
      color: backgroundColor ?? Colors.white,
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(35)),
      onPressed: onPressed as void Function()?,
      label: Text(text!),
      icon: Image.asset(
        iconAssetPath!,
        height: heightButton ?? 20,
        width: widthButton ?? 20,
      ),
    );
  }
}
