// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../app/shared/themes/font.dart';
// import '../../../shared/classes/action_item.dart';
// import '../../bottom_sheet/particular/settings_pannel.dart';
// import '../base_controller.dart';

// class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final bool appBarBackButton;
//   final List<ActionItem>? actions;
//   final BaseController baseController = Get.find();

//   final String title;

//   ProfileAppBar(
//       {Key? key,
//       this.appBarBackButton = true,
//       required this.title,
//       this.actions})
//       : super(key: key);

//   @override
//   Size get preferredSize => const Size.fromHeight(50);

//   @override
//   Widget build(BuildContext context) {
//     final list = <Widget>[];
//     if (actions!.isNotEmpty) {
//       for (var element in actions!) {
//         list.add(IconButton(
//             onPressed: () => {element.onPressed!()},
//             icon: element.actionIcon!));
//       }
//     } else {
//       list.add(IconButton(
//           onPressed: () {
//             openSettingsPannel();
//           },
//           icon: Icon(Icons.menu)));
//     }
//     return AppBar(
//         automaticallyImplyLeading: appBarBackButton,
//         leading: BackButton(),
//         elevation: 0, //this is shadow below app bar 0 gets rid of it
//         title: Text(
//           title,
//           style: TextStyle(
//             fontFamily: Font.airbnbFont,
//             color: context.theme.appBarTheme.iconTheme!.color,
//           ),
//         ),
//         backgroundColor: context.theme.appBarTheme.color,
//         iconTheme: context.theme.appBarTheme.iconTheme,
//         actions: [...list]);
//   }
// }
