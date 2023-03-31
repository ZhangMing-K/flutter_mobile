// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/top_investors_controller.dart';
// import '../../who_to_follow/widgets/recommended.dart';
// import '../../../../../../widgets_v2/top_trader_card/top_trader_row_item.dart';

// class TopInvestorsView extends GetView<TopInvestorsController> {
//   const TopInvestorsView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//             padding: const EdgeInsets.only(left: 16, top: 10, bottom: 0),
//             child: const Text(
//               'Top Investors',
//               textAlign: TextAlign.left,
//               style: TextStyle(
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold,
//               ),
//             )),
//         // TopTraderOverall()
//         TopTraderRow(
//           headerText: 'Overall',
//           topInvestors: controller.topTraderOverall,
//           saveToRecent: controller.saveUserToRecent,
//           afterStories: controller.markItemNoUnSeenStories,
//         ),
//         TopTraderRow(
//           headerText: 'Equity',
//           topInvestors: controller.topTraderEquity,
//           saveToRecent: controller.saveUserToRecent,
//           afterStories: controller.markItemNoUnSeenStories,
//         ),
//         TopTraderRow(
//           headerText: 'Options',
//           topInvestors: controller.topTraderOption,
//           saveToRecent: controller.saveUserToRecent,
//           afterStories: controller.markItemNoUnSeenStories,
//         ),
//         TopTraderRow(
//           headerText: 'Crypto',
//           topInvestors: controller.topTraderCrypto,
//           saveToRecent: controller.saveUserToRecent,
//           afterStories: controller.markItemNoUnSeenStories,
//         ),
//         TopTraderRow(
//           headerText: 'Meme',
//           topInvestors: controller.topTraderMeme,
//           saveToRecent: controller.saveUserToRecent,
//           afterStories: controller.markItemNoUnSeenStories,
//         ),
//         const Recommended(),
//       ],
//     );
//   }
// }
