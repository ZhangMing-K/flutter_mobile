// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iris_mobile/app/routes/pages.dart';
// import 'package:unicons/unicons.dart';

// import '../controllers/iris_gold_controller.dart';

// class IrisGoldSettingsPreviewScreen
//     extends GetView<IrisGoldSettingsController> {
//   const IrisGoldSettingsPreviewScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: IrisTheme.darkful(),
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           backgroundColor: Colors.black,
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Obx(() {
//               final purchaseItem = controller.purchaseItem.value;
//               if (purchaseItem == null || controller.canShowPrice.isFalse) {
//                 return Center(
//                   child: Column(
//                     children: const [
//                       Padding(
//                         padding: EdgeInsets.all(20.0),
//                         child: Text('Looking for discounts'),
//                       ),
//                       CupertinoActivityIndicator(),
//                     ],
//                   ),
//                 );
//               }
//               return Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: context.width / 4,
//                     ),
//                     child: Image.asset(
//                       'assets/images/iris_gold.png',
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   listile(
//                     icon: const Icon(UniconsLine.crosshair),
//                     title: 'Trade like the best investors on Iris',
//                     subtitle:
//                         'Know what the best investors on Iris are trading and holding in real time.',
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   listile(
//                     icon: const Icon(UniconsLine.graph_bar),
//                     title: 'Discover the hottest stocks',
//                     subtitle:
//                         'Sift through the noise and see what the Iris community is buying the minute they buy.',
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   listile(
//                     icon: Image.asset(
//                       'assets/icons/auto-pilot-icon.png',
//                       height: 25,
//                       color: Colors.white,
//                     ),
//                     title: 'Lock in your early-access price',
//                     subtitle: 'Have the current price guaranteed for life.',
//                   ),
//                   const SizedBox(
//                     height: 45,
//                   ),
//                   if (controller.hasPortfolioConnected) ...[
//                     Row(
//                       children: const [
//                         CircleAvatar(
//                           radius: 15,
//                           backgroundColor: Colors.white10,
//                           child: Icon(
//                             UniconsLine.check,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Flexible(
//                             child: Text(
//                                 'Portfolio connected. 90% discount applied!')),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                   ] else ...[
//                     SizedBox(
//                       width: double.infinity,
//                       height: 43,
//                       child: OutlinedButton(
//                         onPressed: controller.connectYourPortfolio,
//                         style: ButtonStyle(
//                           shape: MaterialStateProperty.all(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                               side: const BorderSide(
//                                   width: 2, color: Colors.grey),
//                             ),
//                           ),
//                         ),
//                         child: const Text(
//                           "Connect a portfolio for 90% discount!",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         'or',
//                         style: TextStyle(
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                   ],
//                   // const SizedBox(
//                   //   height: 20,
//                   // ),
//                   IrisDefaultButton(
//                       text: controller.price,
//                       onPressed: () {
//                         Get.toNamed(Paths.IrisGoldSettingsChoose);
//                       }),
//                 ],
//               );
//             }),
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
