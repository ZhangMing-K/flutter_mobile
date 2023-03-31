// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../widgets/recent_asset.dart';
// import '../widgets/recent_people.dart';
// import '../../../controllers/explorer_controller.dart';

// class RecentSearch extends GetView<ExplorerController> {
//   const RecentSearch({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final searchType = controller.searchType.value;
//       return searchType == ExplorerSearchType.WHO_FOLLOW
//           ? const RecentPeople()
//           : const RecentAsset();
//     });
//   }
// }
