// import 'package:collection/collection.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../../../routes/pages.dart';
// import '../../../shared/mixins/scroll_controller_mixin.dart';

// enum FEED_ORDER_SELECTION {
//   FOLLOWING,
//   POPULAR,
// }

// class OrdersController extends GetxController
//     with StateMixin<List<Rx<TextModel>>>, ScrollControllerMixin {
//   OrdersController({required this.repository});
//   final IFeedRepository repository;

//   final listviewController = GlobalKey<IrisListViewState>();
//   final isOverlayButtonVisible = false.obs;
//   final pendingList =
//       const DataList<TextModel>(list: <TextModel>[], cursor: '').obs;

//   String? cursor = '';

//   List<FEED_ORDER_SELECTION> feedSelection = [
//     FEED_ORDER_SELECTION.FOLLOWING,
//     FEED_ORDER_SELECTION.POPULAR
//   ];

//   @override
//   void onInit() {
//     fetchAdvancedPostsData();
//     super.onInit();
//   }

//   String feedSelectionToString(FEED_ORDER_SELECTION selection) {
//     switch (selection) {
//       case FEED_ORDER_SELECTION.FOLLOWING:
//         return 'Following';
//       case FEED_ORDER_SELECTION.POPULAR:
//         return 'Popular';
//       default:
//         return 'Following';
//     }
//   }

//   List<String?> get avatars {
//     final listPending = pendingList.value.list;
//     final stateListKeys = state!.take(10).map((e) => e.value.textKey);
//     final newPending =
//         listPending.where((l) => !stateListKeys.contains(l.textKey));
//     final List<TextModel> listAvatars = List.from(newPending);

//     final listFiltered = listAvatars.reversed
//         .where((item) =>
//             item.user != null) //some posts like artciles do not have a user
//         .map((item) => item.user!.profilePictureUrl)
//         .toSet()
//         .take(3)
//         .toList();
//     listFiltered.removeWhere((element) => element == null || element.isEmpty);
//     return listFiltered;
//   }

//   FEED_ORDER_SELECTION getCurrentCategory() {
//     return _currentFeedSelection;
//   }

//   String getCurrentSelectionString() {
//     return feedSelectionToString(_currentFeedSelection);
//   }

//   int getCurrentCategoryIndex() {
//     return feedSelection.indexOf(_currentFeedSelection);
//   }

//   Future<void> changeCategory(String? index) async {
//     change(state, status: RxStatus.loading());
//     final newCategory = feedSelection
//         .firstWhere((value) => feedSelectionToString(value) == index);
//     _currentFeedSelection = newCategory;
//     cursor = '';
//     fetchAdvancedPostsData();
//   }

//   bool saved = false;
//   Future<void> toggleSaved() async {
//     change(state, status: RxStatus.loading());
//     saved = !saved;
//     cursor = '';
//     fetchAdvancedPostsData();
//   }

//   /// Current feed category. It receives the default value
//   FEED_ORDER_SELECTION _currentFeedSelection = FEED_ORDER_SELECTION.FOLLOWING;

//   void rebuildOnChange(List<Rx<TextModel>>? data) {
//     change(data, status: RxStatus.success());
//     isOverlayButtonVisible(false);
//   }

//   Future<void> fetchAdvancedPostsData({
//     String? cursor,
//     QueryType queryType = QueryType.loadCache,
//     bool checkNewPosts = false,
//   }) async {
//     FEED_CATEGORY feedCategory = FEED_CATEGORY.ALL;
//     FEED_ORDER_BY_TYPE? orderBy;
//     FeedTimeSpan? timeSpan;
//     if (_currentFeedSelection == FEED_ORDER_SELECTION.FOLLOWING) {
//       feedCategory = FEED_CATEGORY.ALL;
//     } else if (_currentFeedSelection == FEED_ORDER_SELECTION.POPULAR) {
//       feedCategory = FEED_CATEGORY.ALL;
//       orderBy = FEED_ORDER_BY_TYPE.MOST_ENGAGEMENT;
//       timeSpan =
//           FeedTimeSpan(start: DateTime.now().subtract(const Duration(days: 7)));
//     }

//     final String? cursorToApply = cursor ?? this.cursor;
//     if (saved) {
//       return repository.advancedFeedGet(
//         textTypes: [TEXT_TYPE.ORDER],
//         saved: saved,
//         cursor: cursorToApply,
//         queryType: queryType,
//         callback: () {
//           if (checkNewPosts) {
//             return onCheckNewPosts;
//           } else if (queryType == QueryType.loadMore) {
//             return onLoadMore;
//           } else {
//             return onSuccess;
//           }
//         }(),
//         onError: onError,
//       );
//     } else {
//       return repository.advancedFeedGet(
//         textTypes: [TEXT_TYPE.ORDER],
//         cursor: cursorToApply,
//         saved: saved,
//         feedCategory: feedCategory,
//         feedOrderBy: orderBy,
//         timeSpan: timeSpan,
//         queryType: queryType,
//         callback: () {
//           if (checkNewPosts) {
//             return onCheckNewPosts;
//           } else if (queryType == QueryType.loadMore) {
//             return onLoadMore;
//           } else {
//             return onSuccess;
//           }
//         }(),
//         onError: onError,
//       );
//     }
//   }

//   List<Rx<TextModel>> decodeData(AdvancedFeedGetResponse data) {
//     final textsList = data.texts.map((e) => e.obs).toList();
//     final cursor = data.nextCursor;

//     if (cursor.isNotEmpty) {
//       this.cursor = cursor;
//     }
//     return textsList;
//   }

//   onSuccess(category, data) {
//     rebuildOnChange(decodeData(data));
//   }

//   onLoadMore(category, data) {
//     rebuildOnChange(state!..addAll(decodeData(data)));
//   }

//   onCheckNewPosts(category, data) {
//     final feedData = data?['advancedFeedGet'];
//     if (feedData != null) {
//       final list = (feedData?['texts'])
//           .where((d) => d != null)
//           .map((i) => TextModel.fromJson(i))
//           .toList();

//       if (list.isEmpty || state!.isEmpty) {
//         return;
//       }

//       final newCursor = feedData['nextCursor'];

//       final List<TextModel> filteredList = List.from(list);

//       final stateListKeys = state!.take(10).map((e) => e.value.textKey).toList()
//         ..sort();
//       final newListKeys = filteredList.map((e) => e.textKey).toList()..sort();
//       final isEqual = const ListEquality().equals(stateListKeys, newListKeys);
//       if (!isEqual) {
//         pendingList.value = DataList(
//           cursor: newCursor ?? '',
//           list: filteredList,
//         );
//         isOverlayButtonVisible(true);
//       } else {
//         isOverlayButtonVisible(false);
//       }
//     }
//   }

//   void onError(exception) {
//     // if (exception.graphqlErrors.isNotEmpty &&
//     //     exception.graphqlErrors.first.extensions!['exception']['status'] ==
//     //         401) {
//     //   Get.offAllNamed(Paths.Login.createPath([true]));
//     // }
//   }

//   Future<void> loadMore() async {
//     await fetchAdvancedPostsData(queryType: QueryType.loadMore);
//   }

//   Future<void> checkNewPosts() async {
//     await fetchAdvancedPostsData(
//         queryType: QueryType.loadRemote, checkNewPosts: true);
//   }

//   void showNewPosts() {
//     final List<TextModel> list = pendingList.value.list;
//     rebuildOnChange(list.map((post) => post.obs).toList());
//     cursor = pendingList.value.cursor;
//     pendingList.value = const DataList(list: <TextModel>[], cursor: '');
//   }

//   void appendPostOnTop(Rx<TextModel> text) {
//     state!.insert(0, text);
//     rebuildOnChange(state);
//   }

//   void replaceData(Rx<TextModel> text) {
//     state!.replaceWhere(
//       (item) => item.value.textCreateId == text.value.textCreateId,
//       text,
//     );
//     rebuildOnChange(state);
//   }

//   Future<void> pullRefresh() async {
//     cursor = '';
//     await fetchAdvancedPostsData(queryType: QueryType.loadRemote);
//   }
// }

// extension Rep<E> on List<E> {
//   bool replaceWhere(TestPredicate<E> test, E replacement) {
//     var found = false;
//     final len = length;
//     for (var i = 0; i < len; i++) {
//       if (test(this[i])) {
//         this[i] = replacement;
//         found = true;
//       }
//     }

//     return found;
//   }
// }

// typedef TestPredicate<E> = bool Function(E element);
