// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:iris_common/iris_common.dart';

// import '../controllers/iris_gold_controller.dart';

// class IrisGoldOptionsConfirmationScreen
//     extends GetView<IrisGoldOptionsController> {
//   const IrisGoldOptionsConfirmationScreen({Key? key}) : super(key: key);

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
//               return Column(
//                 children: [
//                   const Text(
//                     'Are you sure?',
//                     style: TextStyle(
//                       fontSize: 24,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),

//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 20.0, horizontal: 4),
//                     child: Text(
//                       '''
// You have ${controller.daysLeft} days left in your current subscription period. You will lose access to all enhanced analytics, trades of the top 10%, filters and other Gold features after ${DateFormat.yMMMMd().format(controller.endAt!)}.''',
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: context.width / 5,
//                     ),
//                     child: Image.asset(
//                       'assets/icons/graph.png',
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),

//                   const SizedBox(
//                     height: 45,
//                   ),

//                   // const SizedBox(
//                   //   height: 20,
//                   // ),
//                   IrisDefaultButton(
//                     color: IrisColor.irisBlueLight,
//                     text: 'Nevermind',
//                     textColor: Colors.white,
//                     onPressed: () {
//                       Get.back();
//                     },
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),

//                   Obx(() {
//                     if (controller.dataSubscription.value ==
//                         DATA_SUBSCRIPTION.LOADING) {
//                       return const IrisDefaultButton(isLoading: true, text: '');
//                     } else {
//                       return InkWell(
//                         onTap: () {
//                           controller.cancelSubscription();
//                         },
//                         child: const Padding(
//                           padding: EdgeInsets.all(16.0),
//                           child: Text(
//                             'Cancel my subscription',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.red,
//                             ),
//                           ),
//                         ),
//                       );
//                     }
//                   })
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
