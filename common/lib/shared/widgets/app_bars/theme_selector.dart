// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iris_mobile/app/shared/themes/theme.dart';

// import '../../../app/app_controller.dart';

// class Selector extends StatelessWidget {
//   Selector({Key key}) : super(key: key);

//   final colors = [
//     IrisTheme.light().backgroundColor,
//     IrisTheme.dark().backgroundColor,
//     IrisTheme.darkful().backgroundColor
//   ];

//   @override
//   Widget build(BuildContext context) {
//     context.theme;
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.grey.withOpacity(.17),
//         borderRadius: BorderRadius.circular(11),
//       ),
//       child: Center(
//         child: ListView.builder(
//           // scrollDirection: Axis.horizontal,
//           shrinkWrap: true,
//           itemCount: 3,
//           itemBuilder: (BuildContext context, int index) {
//             return Center(
//               child: InkWell(
//                 onTap: () {
//                   Get.until((route) => !Get.isDialogOpen);
//                   switch (index) {
//                     case 0:
//                       AppController.to.changeTheme('light');
//                       break;
//                     case 1:
//                       AppController.to.changeTheme('dark');
//                       break;
//                     case 2:
//                       AppController.to.changeTheme('darkful');
//                       break;
//                   }
//                 },
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         width: 50,
//                         height: 50,
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(width: 2, color: Colors.yellow),
//                             color: colors[index]),
//                       ),
//                     ),
//                     Text(() {
//                       if (index == 0) {
//                         return ' Light ';
//                       } else if (index == 1) {
//                         return ' Dark ';
//                       } else {
//                         return ' Darkful ';
//                       }
//                     }(),
//                         style: TextStyle(
//                           backgroundColor: Colors.black,
//                           color: Colors.white,
//                         )),
//                     SizedBox(height: 7),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
