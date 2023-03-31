// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iris_common/iris_common.dart';

// import '../controllers/iris_gold_controller.dart';

// class IrisGoldSettingsLoadingScreen
//     extends GetView<IrisGoldSettingsController> {
//   const IrisGoldSettingsLoadingScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: IrisTheme.darkful(),
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: context.width / 4,
//                   ),
//                   child: Image.asset(
//                     'assets/images/iris_gold.png',
//                   ),
//                 ),
//                 SizedBox(
//                   height: context.height / 5,
//                 ),
//                 const SizedBox(
//                   height: 130,
//                   width: 130,
//                   child: IrisGradientProgressIndicator(
//                     // value: 100,
//                     gradient: LinearGradient(
//                       colors: [
//                         Colors.black12,
//                         IrisColor.gold,
//                         Colors.white,
//                       ],
//                     ),
//                     radius: 3,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 const Text(
//                   'Applying Gold features...',
//                   style: TextStyle(fontSize: 16),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget listile({
//     required String title,
//     required String subtitle,
//     required Widget icon,
//   }) {
//     return ListTile(
//       horizontalTitleGap: 0,
//       minVerticalPadding: 0,
//       dense: false,
//       contentPadding: EdgeInsets.zero,
//       isThreeLine: true,
//       leading: icon,
//       title: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//       subtitle: Text(
//         subtitle,
//         style: const TextStyle(
//           fontSize: 14,
//           color: Colors.grey,
//         ),
//       ),
//     );
//   }
// }
