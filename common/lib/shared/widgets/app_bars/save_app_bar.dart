import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class SaveAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SaveAppBar({Key? key, required this.title, this.onCancel, this.onDone})
      : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(50);

  final String title;
  final Function? onDone;
  final Function? onCancel;
  leading() {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(left: 2),
        child: const Text(
          'Cancel',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: IrisColor.irisBlue),
        ),
        alignment: Alignment.center,
      ),
      onTap: () {
        if (onCancel != null) {
          onCancel!();
        } else {
          Get.back();
        }
      },
    );
  }

  trailing() {
    return InkWell(
      child: Container(
        // width: 100,
        margin: const EdgeInsets.only(right: 10),
        child: Builder(builder: (context) {
          return Text(
            'Done',
            style: TextStyle(
                color: context.theme.colorScheme.secondary,
                fontWeight: FontWeight.bold),
          );
        }),
        alignment: Alignment.center,
      ),
      onTap: () {
        if (onDone != null) {
          onDone!();
        }
      },
    );
  }

  @override
  build(BuildContext context) {
    return AppBar(
      // automaticallyImplyLeading: appBarBackButton,
      elevation: 0, //this is shadow below app bar 0 gets rid of it
      leading: leading(),
      actions: [trailing()],
      title: Text(
        title,
        style:
            const TextStyle(fontFamily: Font.airbnbFont, color: Colors.white),
      ),
      backgroundColor: context.theme.appBarTheme.backgroundColor,
      iconTheme: context.theme.appBarTheme.iconTheme,
    );
  }
}
