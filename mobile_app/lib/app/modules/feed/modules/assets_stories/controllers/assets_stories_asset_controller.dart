// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:iris_common/iris_common.dart';

// import '../../../shared/mixins/scroll_controller_mixin.dart';

// class AssetStoriesAssetController extends GetxController
//     with StateMixin<List<Rx<Asset>>>, ScrollControllerMixin {
//   StoryArgs? storyArgs;
//   final IWatchListRepository repository;
//   final IrisEvent irisEvent = Get.find();
//   final ReactionService reactionService = Get.find();
//   late StreamSubscription _routeListener;
//   final isReacted = false.obs;
//   final IAuthUserService authUserStore;

//   AssetStoriesAssetController({
//     required this.repository,
//     required this.authUserStore,
//   });

//   @override
//   void onInit() {
//     getInitialAssetStories();
//     _routeListener = IrisStackObserver.stackChange.listen((stackChange) {
//       if (stackChange.newRoute!.settings.name == Paths.Feed &&
//           stackChange.oldRoute is GetPageRoute) {
//         getInitialAssetStories();
//       }
//     });
//     super.onInit();
//   }

//   void rebuildOnChange(List<Rx<Asset>>? data) {
//     if (data!.isNotEmpty) {
//       change(RxStatus.success(data));
//     } else {
//       change(RxStatus.empty());
//     }
//   }

//   bool get hasConnectedPortfolio {
//     if (authUserStore.loggedUser!.connectedBrokerNames != null &&
//         authUserStore.loggedUser!.connectedBrokerNames!.isNotEmpty) {
//       return true;
//     }
//     return false;
//   }

//   bool get hasFetchedAuthInfo {
//     return authUserStore.authUserIsSet;
//   }

//   String getAssetsWatching({int limit = 3, int offset = 0}) {
//     final storiesConnectionString = storiesConnection(limit: 1);
//     return '''
//       topInterestedAssets(input: {limit: $limit, offset: $offset }) {
//         authUserIsWatching
//         assetKey
//         pictureUrl
//         symbol
//         name
//         symbol
//         quote {
//           change
//           changePercent
//           latestPrice
//         }
//         $storiesConnectionString
//         dayHistorical:historical(input: {span:DAY}) {
//           span
//           returnAmount
//           returnPercentage
//           openAmount
//           closeAmount
//           historicalType
//           points{
//             beginsAt
//             openAmount
//             closeAmount
//             spanReturnAmount
//             spanReturnPercentage
//             volume
//           }
//         }
//       }
//     ''';
//   }

//   String storiesConnection({int limit = 1}) {
//     return '''
//       storiesConnection(input: {limit: $limit}){
//         storiesPagination{
//           nextCursor
//           previousCursor
//           stories{
//             ${TextGql.fullTextWithOutStories}
//           }
//         }
//         metaData{
//           nbrStories
//           currentIndex
//           areStories
//           areUnseenStories
//         }
//       }
//     ''';
//   }

//   void getInitialAssetStories({QueryType queryType = QueryType.loadCache}) {
//     repository.getAuthUserTopInterestedAssets(
//         queryType: queryType,
//         callback: (data) {
//           final List<Rx<Asset>> assets =
//               data.map((story) => story.obs).toList();
//           rebuildOnChange(assets);
//         },
//         requestedFields: getAssetsWatching(limit: 15, offset: 0),
//         onError: onError);
//   }

//   @override
//   void onClose() {
//     _routeListener.cancel();
//     super.onClose();
//   }

//   onError(data) {
//     debugPrint('error on asset stories ? $data');
//   }

//   void goToAssetStory(int pageIndex, int assetKey) {
//     final indexAsset = state[pageIndex].value;
//     final areStories =
//         indexAsset.storiesConnection!.metaData!.areStories ?? false;
//     if (areStories) {
//       final assetsWithStories = state
//           .where(
//               (e) => e.value.storiesConnection!.metaData!.areStories ?? false)
//           .toList();
//       final storyArgs = FeedAssetStoryArgs(
//           assetKey: assetKey,
//           assetList: assetsWithStories.map((e) {
//             return e.value;
//           }).toList(),
//           initialPage: pageIndex);
//       Get.toNamed(
//         Paths.AssetStory,
//         arguments: storyArgs,
//       );
//     } else {
//       // goes to asset page
//       indexAsset.routeToFromAssetImage(false, null);
//     }
//   }

//   void toWatchList() {
//     Get.toNamed(Paths.WatchList.createPath([true]));
//   }
// }
