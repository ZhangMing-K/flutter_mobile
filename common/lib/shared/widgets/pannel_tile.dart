import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PannelTile extends StatelessWidget {
  final String? text;

  final String? subtitleText;
  final Color? color;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? trailing;
  final Alignment textAlignment;
  const PannelTile({
    Key? key,
    this.text,
    this.subtitleText,
    this.color,
    this.onTap,
    this.leading,
    this.trailing,
    this.textAlignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      trailing: trailing,
      title: Container(
        alignment: textAlignment,
        height: ScreenUtil().setHeight(30),
        width: double.infinity,
        child: Text(
          text!,
          style: TextStyle(color: color ?? context.theme.colorScheme.secondary),
        ),
      ),
      subtitle: subtitleText != null
          ? Container(
              alignment: textAlignment,
              child: Text(
                subtitleText!,
                textAlign: textAlignment == Alignment.centerLeft
                    ? TextAlign.left
                    : TextAlign.center,
                style: TextStyle(color: context.theme.colorScheme.secondary),
              ),
            )
          : null,
    );
  }
}
