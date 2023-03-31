// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iris_mobile/app/routes/pages.dart';
// import '../controllers/iris_gold_controller.dart';

// class IrisGoldOptionsOverviewScreen extends GetView<IrisGoldOptionsController> {
//   const IrisGoldOptionsOverviewScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: IrisTheme.darkful(),
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           title: const Text('Gold Settings'),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Obx(() {
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
//                   if (controller.dataSubscription.value ==
//                           DATA_SUBSCRIPTION.DONE ||
//                       controller.dataSubscription.value ==
//                           DATA_SUBSCRIPTION.CANCELED)
//                     Container(
//                       height: 80,
//                       width: double.infinity,
//                       margin: const EdgeInsets.symmetric(vertical: 15),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.withOpacity(.17),
//                         borderRadius: BorderRadius.circular(14),
//                       ),
//                       child: Center(
//                         child: Text(
//                           controller.dataSubscription.value ==
//                                   DATA_SUBSCRIPTION.DONE
//                               ? 'Success! Your membership will continue.'
//                               : 'Your subscription has been canceled successfully.',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: controller.dataSubscription.value ==
//                                     DATA_SUBSCRIPTION.DONE
//                                 ? const Color(0xff8dcb2c)
//                                 : Colors.red,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                   ListTile(
//                     title: const Text(
//                       'Current plan',
//                       style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     subtitle: Text(
//                       controller.authUserStore.loggedUser?.goldConnection
//                                   ?.autoRenew ==
//                               true
//                           ? '${controller.goldConnection?.userPayingPrice.formatCurrency()} Billed ${controller.intervalAdjective}${controller.nextPaymentString}'
//                           : '${controller.goldConnection?.userPayingPrice.formatCurrency()} Which will end in ${controller.endAt?.difference(DateTime.now()).inDays} days',
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                   const Divider(),
//                   ListTile(
//                     onTap: () {
//                       if (controller.requiresPayment) {
//                         controller
//                             .attachPaymentMethodToPaymentTransaction(context);
//                       } else {
//                         controller.updatePaymentMethod(context);
//                       }
//                     },
//                     title: const Text(
//                       'Change payment method',
//                       style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     subtitle: Obx(() {
//                       if (controller.loadingPaymentInfo.value) {
//                         return Container(
//                             alignment: Alignment.bottomLeft,
//                             child: const CupertinoActivityIndicator(
//                               radius: 8,
//                             ));
//                       } else if (controller.requiresPayment) {
//                         return const Text(
//                           "Requires payment",
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.red,
//                           ),
//                         );
//                       } else if (controller.paymentMethod.isEmpty) {
//                         return const Text(
//                           "Attach payment method",
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.red,
//                           ),
//                         );
//                       } else {
//                         return Text(
//                           controller.paymentMethod,
//                           style: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                           ),
//                         );
//                       }
//                     }),
//                     trailing: const Icon(Icons.chevron_right),
//                   ),
//                   const Divider(),
//                   if (controller.authUserStore.loggedUser?.goldConnection
//                           ?.autoRenew ==
//                       true)
//                     ListTile(
//                       onTap: () {
//                         Get.toNamed(Paths.IrisGoldOptionsConfirmation);
//                       },
//                       title: const Text(
//                         'Cancel Subscription',
//                         style: TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.red,
//                         ),
//                       ),
//                       trailing: const Icon(Icons.chevron_right),
//                     )
//                   else
//                     ListTile(
//                       onTap: () {
//                         Get.toNamed(Paths.IrisGoldOptionsChoose);
//                       },
//                       title: const Text(
//                         'Turn on auto renew',
//                         style: TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold,
//                           color: IrisColor.irisBlueLight,
//                         ),
//                       ),
//                       trailing: const Icon(Icons.chevron_right),
//                     ),
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
