// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:iris_common/iris_common.dart';

// import '../../../controllers/explorer_controller.dart';

// class RecentAsset extends GetView<ExplorerController> {
//   const RecentAsset({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Obx(
//         () {
//           return IrisListView(
//             itemCount: controller.stocksController.recentList.length,
//             widgetLoader: const ShimmerScroll(),
//             header: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                     padding:
//                         const EdgeInsets.only(left: 6, top: 10, bottom: 30),
//                     child: const Text(
//                       'Recent',
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     )),
//               ],
//             ),
//             emptyWidget: NoData(
//               text: 'No recent searches',
//               backgroundColor: null,
//               type: NO_DATA_TYPE.FIT,
//               image: Image.asset(Images.noItemsInFeed, width: 300, height: 300),
//             ),
//             builder: (BuildContext context, int index) {
//               final Asset asset = controller.stocksController.recentList[index];
//               return RoutedAssetListTile(
//                   asset: asset,
//                   saveToStorage: () {
//                     controller.stocksController.saveAssetToRecent(asset);
//                   },
//                   assetToWatchlist: (bool watch) {
//                     controller.assetToWatchList(asset, watch);
//                   });
//             },
//           );
//         },
//       ),
//     );
//   }
// }
