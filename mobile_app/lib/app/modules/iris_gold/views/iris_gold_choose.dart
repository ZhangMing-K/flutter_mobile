// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iris_common/iris_common.dart';

// import '../controllers/iris_gold_controller.dart';

// class IrisGoldSettingsChooseScreen extends GetView<IrisGoldSettingsController> {
//   const IrisGoldSettingsChooseScreen({Key? key}) : super(key: key);

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
//                     height: 10,
//                   ),
//                   const Align(
//                     alignment: Alignment.topLeft,
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(vertical: 20.0),
//                       child: Text(
//                         'Choose your plan',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Obx(() => IrisOptionSelection<PURCHASE_ITEM_PRICE_INTERVAL>(
//                         planType: PURCHASE_ITEM_PRICE_INTERVAL.MONTH,
//                         selectedType: controller.selectedPlanType.value,
//                         title: 'Monthly',
//                         subtitle: 'Billed monthly, cancel anytime.',
//                         price:
//                             controller.getMonthlyPriceWithDiscountIfElegible ??
//                                 controller.monthlyPrice,
//                         discount: controller.hasPortfolioConnected
//                             ? controller.monthlyPrice
//                             : null,
//                         onSelected: (PURCHASE_ITEM_PRICE_INTERVAL? value) {
//                           controller.selectedPlanType.value =
//                               PURCHASE_ITEM_PRICE_INTERVAL.MONTH;
//                         },
//                       )),
//                   const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 20.0),
//                     child: Center(
//                       child: Text(
//                         'or save an extra 60% with our beta discount!',
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Obx(() => IrisOptionSelection<PURCHASE_ITEM_PRICE_INTERVAL>(
//                         planType: PURCHASE_ITEM_PRICE_INTERVAL.YEAR,
//                         selectedType: controller.selectedPlanType.value,
//                         title: 'Yearly',
//                         subtitle: 'Billed every 12 months, cancel anytime.',
//                         onSelected: (PURCHASE_ITEM_PRICE_INTERVAL? value) {
//                           controller.selectedPlanType.value =
//                               PURCHASE_ITEM_PRICE_INTERVAL.YEAR;
//                         },
//                         price:
//                             controller.getYearlyPriceWithDiscountIfElegible ??
//                                 controller.yearlyPrice,
//                         discount: controller.hasPortfolioConnected
//                             ? controller.yearlyPrice
//                             : null,
//                       )),
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
//                   IrisDefaultButton(
//                       text: 'Subscribe',
//                       onPressed: () {
//                         controller.onSubscribeClicked(context);
//                       }),
//                   const Divider(
//                     height: 50,
//                   ),
//                   const Text(
//                     '''
// Your subscription will be automatically renewed at the end of your chosen term until cancelled. Cancel anytime by managing your subscription in settings. The renewal must be cancelled within the 24-hours prior to  the end of the period at \$79.99/year. The “beta discount rate” will not change unless the subscription is canceled. ''',
//                     style: TextStyle(
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
