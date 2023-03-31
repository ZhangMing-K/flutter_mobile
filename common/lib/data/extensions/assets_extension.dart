// import 'package:get/get.dart';
// import 'package:iris_common/iris_common.dart';

// extension AssetExt on Asset {
//   void routeToFromAssetImage(bool? showStories, Function? afterStories) {
//     if (storiesConnection != null &&
//         storiesConnection!.metaData != null &&
//         storiesConnection!.metaData!.nbrStories! > 0 &&
//         showStories!) {
//       final storyArgs = StoryArgs(
//           asset: this,
//           storiesConnection: storiesConnection!,
//           afterStories: afterStories);
//       Get.toNamed(
//         Paths.AssetSingleStory,
//         arguments: storyArgs,
//         parameters: {
//           'assetKey': assetKey.toString(),
//         },
//       );
//     } else {
//       Get.toNamed(Paths.Asset, parameters: {'assetKey': assetKey.toString()});
//     }
//   }
// }
