import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppBar(
      {Key? key,
      this.appBarBackButton = true,
      required this.title,
      this.customAction})
      : super(key: key);
  final bool appBarBackButton;
  final Widget? customAction;
  @override
  Size get preferredSize => const Size.fromHeight(50);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: appBarBackButton,
      leading: BackButton(onPressed: () {
        Navigator.pop(context);
      } //Get.back,
          ),
      elevation: 0, //this is shadow below app bar 0 gets rid of it
      title: Text(
        title,
        style: TextStyle(
          fontFamily: Font.airbnbFont,
          color: context.theme.appBarTheme.iconTheme!.color,
        ),
      ),
      backgroundColor: context.theme.appBarTheme.backgroundColor,
      iconTheme: context.theme.appBarTheme.iconTheme,
      actions: customAction != null ? [customAction!] : null,
    );
  }
}
