// import 'dart:async';

// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:iris_mobile/app/routes/pages.dart';

// //TODO there is a ton of logic and code copied between this controller and story_controller. refactor story controller as needed, and use a list of story controllers in this controller
// class AssetStoriesStoriesController extends GetxController
//     with StateMixin<List<List<Rx<TextModel>>>> {
//   AssetStoriesStoriesController({
//     required this.repository,
//   });

//   StoryArgs? storyArgs;
//   final IWatchListRepository repository;
//   final IrisEvent irisEvent = Get.find();
//   final ReactionService reactionService = Get.find();
//   int limit = 5;
//   String storyPrevCursor = '';
//   String storyNextCursor = '';
//   List<int?> assetKeys = <int>[];
//   List<String?> prevCursors = <String>[];
//   List<String?> nextCursors = <String>[];
//   final List<Asset> assetList = <Asset>[];
//   int assetKey = 0;
//   Rx<Asset> currentAsset = const Asset().obs;
//   final Map<String, bool> isCursorLoaded = {'test': false};

//   final isReacted = false.obs;
//   int prevStoryIndex = -1;

//   FeedAssetStoryArgs get args {
//     if (Get.arguments is FeedAssetStoryArgs) {
//       return Get.arguments;
//     }
//     return FeedAssetStoryArgs(
//         initialPage: 0, assetList: <Asset>[], assetKey: 0);
//   }

//   int get initialPage {
//     return args.initialPage ?? 0;
//   }

//   int get pageLength {
//     return assetList.length;
//   }

//   int nbrStories(int pageIndex) {
//     return assetList[pageIndex].storiesConnection?.metaData?.nbrStories ?? 1;
//   }

//   int storyCurrentIndex(int pageIndex) {
//     return assetList[pageIndex].storiesConnection?.metaData?.currentIndex ?? 0;
//   }

//   Asset assetAtIndex(int pageIndex) {
//     return assetList[pageIndex];
//   }

//   void rebuildOnChange(List<List<Rx<TextModel>>>? data) {
//     if (data == null) return;
//     change(RxStatus.success(data));
//   }

//   @override
//   void onInit() {
//     if (Get.arguments is FeedAssetStoryArgs) {
//       final List<Asset> assetsList = args.assetList!;
//       assetList.assignAll(assetsList);
//       assetKey = args.assetKey;
//       currentAsset.value =
//           assetList.firstWhere((element) => element.assetKey! == assetKey);
//       final List<int> _assetKeys =
//           List.generate(assetList.length, (index) => 0);
//       final List<String> _prevCursors =
//           List.generate(assetList.length, (index) => '');
//       final List<String> _nextCursors =
//           List.generate(assetList.length, (index) => '');
//       final List<List<TextModel>> totalList = List.generate(
//           assetList.length,
//           (pageIndex) => List.generate(
//               nbrStories(pageIndex), (storyIndex) => const TextModel()));
//       final mappedAssets = assetList.asMap();
//       mappedAssets.forEach((key, value) {
//         final Asset asset = value;
//         final List<TextModel> stories =
//             asset.storiesConnection!.storiesPagination!.stories!;
//         _prevCursors[key] =
//             asset.storiesConnection!.storiesPagination!.previousCursor ?? '';
//         _nextCursors[key] =
//             asset.storiesConnection!.storiesPagination!.nextCursor ?? '';
//         final List<TextModel> allList = <TextModel>[];
//         _assetKeys[key] = asset.assetKey!;
//         if (storyCurrentIndex(key) == 0) {
//           allList.insertAll(0, stories);
//           final List<TextModel> nextList = List.generate(
//               nbrStories(key) - stories.length, (index) => const TextModel());
//           allList.insertAll(stories.length, nextList);
//         } else {
//           //
//           final List<TextModel> prevList = List.generate(
//               storyCurrentIndex(key), (index) => const TextModel());
//           allList.insertAll(0, prevList);
//           allList.insertAll(prevList.length, stories);
//           final List<TextModel> nextList = List.generate(
//               nbrStories(key) - storyCurrentIndex(key) - stories.length,
//               (index) => const TextModel());
//           allList.insertAll(storyCurrentIndex(key) + stories.length, nextList);
//         }
//         totalList[key].assignAll(allList);
//       });
//       assetKeys.assignAll(_assetKeys);
//       prevCursors.assignAll(_prevCursors);
//       nextCursors.assignAll(_nextCursors);
//       rebuildOnChange(totalList
//           .map((e) =>
//               e.map((e) => e.copyWith(asset: currentAsset.value).obs).toList())
//           .toList());
//     }
//     super.onInit();
//   }

//   void performReaction() {
//     isReacted.value = true;
//     HapticFeedback.lightImpact();
//     Future.delayed(const Duration(milliseconds: 700), () {
//       isReacted.value = false;
//     });
//   }

//   Future<void> reactToPost(int pageIndex, int index) async {
//     final text = state[pageIndex][index];
//     if (text.value.authUserReaction == null) {
//       performReaction();
//     } else {
//       HapticFeedback.lightImpact();
//     }
//     Reaction newReaction;
//     if (text.value.authUserReaction == null) {
//       newReaction = const Reaction();
//       text.value = text.value.copyWith(
//           numberOfReactions: text.value.numberOfReactions! + 1,
//           authUserReaction: newReaction);
//     }
//     await reactionService.reactToText(
//         reactionKind: REACTION_KIND.LIKE, textKey: text.value.textKey);
//   }

//   void getMoreStories(int pageIndex, bool next) {
//     final int assetKey = assetKeys[pageIndex]!;
//     final String cursorToApply =
//         next ? nextCursors[pageIndex]! : prevCursors[pageIndex]!;
//     final isCursorApplied = isCursorLoaded['"' + cursorToApply + '"'];
//     if (isCursorApplied == true) {
//       return;
//     }
//     isCursorLoaded['"' + cursorToApply + '"'] = true;
//     repository.getAssetByKey(
//         assetKey: assetKey,
//         queryType: QueryType.loadRemote,
//         callback: (List<Asset> data) {
//           if (data.isNotEmpty) {
//             final Asset asset = data[0];
//             final assetKeyFromAPI = asset.assetKey!;
//             if (assetKey != assetKeyFromAPI) return;
//             final List<TextModel> stories =
//                 asset.storiesConnection!.storiesPagination!.stories!;

//             if (stories.isNotEmpty) {
//               nextCursors.removeAt(pageIndex);
//               nextCursors.insert(pageIndex,
//                   asset.storiesConnection!.storiesPagination!.nextCursor ?? '');
//               prevCursors.removeAt(pageIndex);
//               prevCursors.insert(
//                   pageIndex,
//                   asset.storiesConnection!.storiesPagination!.previousCursor ??
//                       '');
//               if (next) {
//                 // get the last index where the textKey is not null
//                 final lastIndex = state[pageIndex]
//                     .lastIndexWhere((element) => element.value.textKey != null);
//                 if (lastIndex > nbrStories(pageIndex)) {
//                   return;
//                 }
//                 int endRangeIndex = lastIndex + 1 + stories.length;
//                 if (endRangeIndex > nbrStories(pageIndex)) {
//                   endRangeIndex = nbrStories(pageIndex);
//                 }

//                 state[pageIndex].replaceRange(
//                     lastIndex + 1, endRangeIndex, stories.map((e) => e.obs));
//                 rebuildOnChange(state);
//               } else {
//                 final int indexToStart = state[pageIndex]
//                     .indexWhere((element) => element.value.textKey != null);
//                 final newStoriesLength = stories.length;
//                 if (newStoriesLength > indexToStart) {
//                   final storiesToAdd = stories.take(indexToStart);
//                   state[pageIndex].replaceRange(
//                       0, indexToStart, storiesToAdd.map((e) => e.obs));
//                   rebuildOnChange(state);
//                 } else {
//                   state[pageIndex].replaceRange(indexToStart - newStoriesLength,
//                       indexToStart, stories.map((e) => e.obs));
//                   rebuildOnChange(state);
//                 }
//               }
//               isCursorLoaded['"' + cursorToApply + '"'] = true;
//             } else {
//               isCursorLoaded['"' + cursorToApply + '"'] = false;
//             }
//           }
//         },
//         requestedFields: storyGql(limit: 5, cursor: cursorToApply),
//         onError: onError);
//   }

//   onError(data) {}
// }
