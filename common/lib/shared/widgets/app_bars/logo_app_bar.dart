// import 'package:flutter/material.dart';

// import 'package:unicons/unicons.dart';
// import 'package:get/get.dart';
// import 'package:iris_mobile/app/modules/notification/notification.dart';

// import '../../../app/app_controller.dart';
// import '../../../app/routes/pages.dart';
// import '../../../shared/constants/icons.dart';
// import '../../../shared/constants/images.dart';
// import '../../../shared/stores/auth_user_store.dart';

// class LogoAppBar extends StatelessWidget implements PreferredSizeWidget {
//   LogoAppBar({this.customAction});

//   final Widget? customAction;
//   @override
//   Size get preferredSize => const Size.fromHeight(50);

//   final IAuthUserService authUserStore = Get.find();
//   title() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         Container(
//           margin: EdgeInsets.only(left: 13),
//           child: Builder(builder: (context) {
//             return Image.asset(
//               Images.irisWhiteLogo,
//               width: 60,
//               color: context.theme.appBarTheme.iconTheme!.color,
//             );
//           }),
//         )
//       ],
//     );
//   }

//   Widget redDot({int? nbr}) {
//     String displayNbr = nbr.toString();
//     double fontSize = 11;
//     if (nbr != null && nbr > 2) {
//       displayNbr = '3+';
//       fontSize = 9;
//     }
//     return Positioned(
//         right: 0,
//         left: 13,
//         // bottom: 0,
//         top: 7,
//         // down: 10,
//         child: Container(
//           // margin: EdgeInsets.all(10.0),
//           height: 17,
//           child: nbr != null
//               ? Center(
//                   child: Text(
//                     displayNbr,
//                     style: TextStyle(
//                         fontSize: fontSize,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 )
//               : null,
//           decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
//         ));
//   }

//   notification() {
//     return Obx(() {
//       final authUser = authUserStore.loggedUser;
//       if (authUser?.notifications != null &&
//           authUser!.notifications!.isNotEmpty) {
//         return Stack(
//           children: [
//             IconButton(
//               icon: Icon(Icons.notifications),
//               onPressed: () {
//                 Get.toNamed(NewNotificationScreen.routeName());
//               },
//             ),
//             if (authUserStore.loggedUser?.notifications?.isNotEmpty ==
//                 true)
//               redDot(nbr: authUser.notifications!.length)
//           ],
//         );
//       }
//       return IconButton(
//         icon: Icon(
//           UniconsLine.bell,
//           size: 25,
//         ),
//         onPressed: () {
//           Get.toNamed(NewNotificationScreen.routeName());
//         },
//       );
//     });
//   }

//   invite() {
//     return Obx(() {
//       final authUser = authUserStore.loggedUser;

//       final bool syncedNumber =
//           authUser?.phoneNumber != null && authUser!.phoneNumber!.isNotEmpty;
//       return Stack(
//         children: [
//           IconButton(
//             icon: Image.asset(
//               IconPath.inviteStar,
//               height: 25,
//             ),
//             onPressed: () {
//               if (!syncedNumber)
//                 Get.toNamed(Paths.MfaContactConnect);
//               else
//                 Get.toNamed(Paths.ExploreFriends);
//             },
//           ),
//           if (!syncedNumber) redDot()
//         ],
//       );
//     });
//   }

//   List<Widget> actions() {
//     return [
//       // Builder(
//       //     builder: (context) => Visibility(
//       //           visible: context.isDarkMode,
//       //           replacement: IconButton(
//       //             icon: Icon(UniconsLine.moon),
//       //             onPressed: () {

//       //               AppController.to.toggleTheme();
//       //             },
//       //           ),
//       //           child: IconButton(
//       //             icon: Icon(UniconsLine.sun),
//       //             onPressed: () {
//       //               AppController.to.toggleTheme();
//       //             },
//       //           ),
//       //         )),
//       invite(),
//       notification(),
//       // IconButton(
//       //   icon: Icon(UniconsLine.send),
//       //   onPressed: () {
//       //     Get.toNamed(InboxScreen.routeName());
//       //   },
//       // ),
//     ];
//   }

//   @override
//   build(BuildContext context) {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       titleSpacing: 0,
//       elevation: 0, //this is shadow below app bar 0 gets rid of it
//       title: title(),

//       backgroundColor: context.theme.appBarTheme.color,
//       iconTheme: context.theme.appBarTheme.iconTheme,
//       actions: actions(),
//     );
//   }
// }
