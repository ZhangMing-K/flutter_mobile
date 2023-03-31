// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iris_mobile/app/modules/assetStory/widgets/asset_story_gesture_item.dart';
// import 'package:iris_mobile/app/modules/story/widgets/story_bottom_actions.dart';
// import 'package:iris_mobile/app/modules/story/widgets/story_item.dart';
// import 'package:iris_mobile/app/routes/pages.dart';

// import '../controllers/assets_stories_stories_controller.dart';

// class AssetStoriesStoriesScreen extends GetView<AssetStoriesStoriesController> {
//   const AssetStoriesStoriesScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return DragToPopScreen(
//       child: Builder(builder: (context) {
//         return CustomStoryPage(
//           onStoryChange: (pageIndex, storyIndex) {
//             final Rx<TextModel> text$ = controller.state[pageIndex][storyIndex];
//             final IrisEvent irisEvent = Get.find();
//             final assetKey = controller.assetKey;
//             if (text$.value.textKey == null || assetKey == 0) {
//               return;
//             }
//             irisEvent.registerTextView(
//                 textKey: text$.value.textKey!,
//                 assetKey: assetKey,
//                 from: TEXT_VIEW_FROM.STORY);
//           },
//           initialStoryIndex: controller.storyCurrentIndex,
//           initialPage: controller.initialPage,
//           itemBuilder: (context, pageIndex, storyIndex) {
//             return controller.obx(
//               (state) {
//                 //TODO the following logic needs to be pulled out perhaps into the controller or probably into onStoryChange
//                 if (storyIndex < controller.storyCurrentIndex(pageIndex)) {
//                   if (storyIndex > 0) {
//                     if (state![pageIndex][storyIndex - 1].value.textKey ==
//                         null) {
//                       controller.getMoreStories(pageIndex, false);
//                     }
//                   }
//                 }
//                 if (storyIndex >= controller.storyCurrentIndex(pageIndex)) {
//                   if (storyIndex < controller.nbrStories(pageIndex) - 1) {
//                     if (state![pageIndex][storyIndex + 1].value.textKey ==
//                         null) {
//                       controller.getMoreStories(pageIndex, true);
//                     }
//                   }
//                 }
//                 ///// End Logic to be extracted //////

//                 final Rx<TextModel> text$ = state![pageIndex][storyIndex];
//                 return StoryItem(
//                   heroTag:
//                       controller.assetAtIndex(pageIndex).assetKey.toString(),
//                   text$: text$,
//                 );
//               },
//               onLoading: const Text('loading'),
//             );
//           },
//           gestureItemBuilder: (context, pageIndex, storyIndex) {
//             return controller.obx((state) {
//               final Asset asset = controller.assetAtIndex(pageIndex);
//               final Rx<TextModel> text$ = state![pageIndex][storyIndex];
//               return AssetStoryGestureItem(
//                 asset: asset,
//                 text: text$.value,
//               );
//             });
//           },
//           bottomGestureBuilder:
//               (context, pageIndex, storyIndex, animationController, onTapLike) {
//             return controller.obx(
//               (state) {
//                 final Rx<TextModel> text$ = state![pageIndex][storyIndex];
//                 if (text$.value.textKey == null) {
//                   return Center(child: Container());
//                 }
//                 return StoryBottomActions(
//                   text$: text$,
//                   animationController: animationController,
//                   onLike: () => controller.reactToPost(pageIndex, storyIndex),
//                 );
//               },
//               onLoading: Container(),
//             );
//           },
//           storyLength: (pageIndex) {
//             return controller.nbrStories(pageIndex);
//           },
//           pageLength: controller.pageLength,
//         );
//       }),
//     );
//   }
// }
