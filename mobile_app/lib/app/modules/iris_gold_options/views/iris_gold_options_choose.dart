// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iris_common/iris_common.dart';

// import '../controllers/iris_gold_controller.dart';

// class IrisGoldOptionsChooseScreen extends GetView<IrisGoldOptionsController> {
//   const IrisGoldOptionsChooseScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: IrisTheme.darkful(),
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           title: const Text('Iris Gold'),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Obx(() {
//               return Column(
//                 children: [
//                   Text(
//                     'You only have ${controller.daysLeft} days left!',
//                     style: const TextStyle(
//                       fontSize: 24,
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const Padding(
//                     padding:
//                         EdgeInsets.symmetric(vertical: 20.0, horizontal: 4),
//                     child: Text(
//                       '''
// Renew your membership now to make sure you don’t lose access to enhanced analytics, trades of the top 10%, filters and all Gold features!''',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.white,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),

//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Align(
//                     alignment: Alignment.topLeft,
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(vertical: 20.0),
//                       child: Text(
//                         'Current subscription',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Obx(() => IrisOptionSelection<PURCHASE_ITEM_PRICE_INTERVAL>(
//                         // isGold: false,
//                         showLeading: false,
//                         planType: PURCHASE_ITEM_PRICE_INTERVAL.MONTH,
//                         selectedType: controller.selectedPlanType.value,
//                         title:
//                             '${controller.intervalAdjective.capitalizeFirst}',
//                         subtitle: 'Next bill date: ${controller.nextBillDate}',
//                         price: controller.userPayingPrice,
//                         discount: controller.hasPortfolioConnected
//                             ? controller.nonDiscountedPrice
//                             : null,
//                         onSelected: (PURCHASE_ITEM_PRICE_INTERVAL? value) {
//                           controller.selectedPlanType.value =
//                               PURCHASE_ITEM_PRICE_INTERVAL.MONTH;
//                         },
//                       )),
//                   if (controller.goldConnection?.subscription?.paymentMethod
//                               ?.previewText !=
//                           null &&
//                       controller.goldConnection!.subscription!.paymentMethod!
//                           .previewText!.isNotEmpty) ...[
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Obx(() => IrisOptionSelection<PURCHASE_ITEM_PRICE_INTERVAL>(
//                           showLeading: false,

//                           trailingWidget: const Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Icon(Icons.chevron_right),
//                           ),
//                           // isGold: false,
//                           planType: PURCHASE_ITEM_PRICE_INTERVAL.MONTH,
//                           selectedType: controller.selectedPlanType.value,
//                           title: 'Payment method',
//                           subtitle: controller.goldConnection!.subscription!
//                                   .paymentMethod!.previewText ??
//                               '',
//                           price: controller.userPayingPrice,
//                           discount: controller.hasPortfolioConnected
//                               ? controller.nonDiscountedPrice
//                               : null,
//                           onSelected: (PURCHASE_ITEM_PRICE_INTERVAL? value) {
//                             controller.updatePaymentMethod(context);
//                           },
//                         )),
//                   ],

//                   // const Padding(
//                   //   padding: EdgeInsets.symmetric(vertical: 20.0),
//                   //   child: Center(
//                   //     child: Text(
//                   //       'or save an extra 60% with our beta discount!',
//                   //       style: TextStyle(
//                   //         color: Colors.grey,
//                   //         fontSize: 14,
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                   // Obx(() => IrisOptionSelection<PURCHASE_ITEM_PRICE_INTERVAL>(
//                   //       isGold: false,
//                   //       planType: PURCHASE_ITEM_PRICE_INTERVAL.YEAR,
//                   //       selectedType: controller.selectedPlanType.value,
//                   //       title: 'Yearly',
//                   //       subtitle: 'Billed every 12 months, cancel anytime.',
//                   //       onSelected: (PURCHASE_ITEM_PRICE_INTERVAL? value) {
//                   //         controller.selectedPlanType.value =
//                   //             PURCHASE_ITEM_PRICE_INTERVAL.YEAR;
//                   //       },
//                   //       price:
//                   //           controller.getYearlyPriceWithDiscountIfElegible ??
//                   //               controller.yearlyPrice,
//                   //       discount: controller.hasPortfolioConnected
//                   //           ? controller.yearlyPrice
//                   //           : null,
//                   //     )),
//                   if (!controller.hasPortfolioConnected) ...[
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 43,
//                       child: OutlinedButton(
//                         onPressed: () {
//                           controller.connectYourPortfolio();
//                         },
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
//                       padding: EdgeInsets.only(top: 5, bottom: 8),
//                       child: Text(
//                         'or',
//                         style: TextStyle(
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                   ] else
//                     Container(
//                       height: 25,
//                     ),
//                   Obx(() => IrisDefaultButton(
//                       isLoading: controller.dataSubscription.value ==
//                           DATA_SUBSCRIPTION.LOADING,
//                       text: 'Renew subscription',
//                       // color: IrisColor.irisBlue,
//                       // textColor: Colors.white,
//                       onPressed: () {
//                         controller.turnOnAutoSubscription();
//                       })),
//                   const Divider(
//                     height: 50,
//                   ),
//                   Text(
//                     controller.renewalText,
//                     style: const TextStyle(
//                       color: Colors.grey,
//                     ),
//                   )
//                 ],
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }
