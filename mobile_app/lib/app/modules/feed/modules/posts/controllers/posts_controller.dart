import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/feed/shared/enums/feed_enums.dart';
import 'package:iris_mobile/app/routes/pages.dart';

import '../../../shared/mixins/scroll_controller_mixin.dart';

typedef TestPredicate<E> = bool Function(E element);

///This class has the sole responsibility to control the status of the posts tab in the feed.
///We use StateMixin because it makes our code more secure. If an error is not caught,
///it is displayed automatically. The loading status is also displayed when there is no data.
///We can change the state of the controller through the change method, and attach a status to it
class PostsController extends GetNotifier<List<Rx<TextModel>>>
    with ScrollControllerMixin {
  final IFeedRepository repository;
  // final AssetStoriesAssetController assetStoriesController;
  final isOverlayButtonVisible = false.obs;
  final IStorage storage;
  RxBool redDot = false.obs;
  String cursor = '';
  final String _visitNewStorageKey = 'visitNewTime';
  // RxBool isOrderFlow = false.obs;

  final pendingList =
      const DataList<TextModel>(list: <TextModel>[], cursor: '').obs;

  bool saved = false;

  final ISearchRepository searchRepository;

  final recommendedList =
      const DiscoverPageGetResponse(items: [], nextCursor: '').obs;

  final topPerfomersParam = [
    {'width': ScreenUtil().setWidth(148), 'height': 150, 'percentHeight': 120},
    {'width': ScreenUtil().setWidth(114), 'height': 120, 'percentHeight': 91},
    {'width': ScreenUtil().setWidth(93), 'height': 103, 'percentHeight': 49}
  ];
  List<User> savedUsers = <User>[];

  String recommendedCursor = '';

  String getCursor() {
    return recommendedCursor;
  }

  final _recentList = <User>[].obs;

  List<User> get recentList {
    _recentList.toList();
    final usersFromStorage = storage.read('savedUsers');
    if (usersFromStorage != null) {
      final List<User> userList = List<User>.from(usersFromStorage.map((i) {
        if (i is User) return i;
        return User.fromJson(i);
      }));
      return userList;
    } else {
      return [];
    }
  }

  void onDiscoveryPage(DiscoverPageGetResponse data) {
    recommendedList(data);
    change(state, status: RxStatus.success());
  }

  void onError(err) {
    debugPrint(err.toString());
    Get.snackbar('Error', 'Can not perform search');
  }

  void saveUserToRecent(User user) {
    final userKey = user.userKey;
    _recentList.assignAll(recentList);
    _recentList.removeWhere((element) => element.userKey == userKey);
    _recentList.insert(0, user);
    storage.write(
        key: 'savedUsers',
        value: _recentList.map((element) => element.toJson()).toList());
  }

  Rx<PUBLIC_FEED_CATEGORY> currentFilter = PUBLIC_FEED_CATEGORY.INVESTORS.obs;

  final IrisEvent irisEvent;

  PostsController({
    required this.repository,
    required this.irisEvent,
    required this.storage,
    required this.searchRepository,
  }) : super([]);

  List<String?> get avatars {
    final listPending = pendingList.value.list;
    final stateListKeys = state!.take(10).map((e) => e.value.textKey);
    final newPending =
        listPending.where((l) => !stateListKeys.contains(l.textKey));
    final List<TextModel> listAvatars = List.from(newPending);

    final listFiltered = listAvatars.reversed
        .where((item) =>
            item.user != null) //some posts like articles do not have a user
        .map((item) => item.user!.profilePictureUrl)
        .toSet()
        .take(3)
        .toList();
    listFiltered.removeWhere((element) => element == null || element.isEmpty);
    return listFiltered;
  }

  String get currentFilterString {
    String str = '';
    switch (currentFilter.value) {
      case PUBLIC_FEED_CATEGORY.TOP_TRADES:
        str = 'top trades';
        break;
      case PUBLIC_FEED_CATEGORY.TRENDING:
        str = 'trending posts';
        break;
      default:
        break;
    }
    return str;
  }

  void appendPostOnTop(Rx<TextModel> text) {
    state!.insert(0, text);
    rebuildOnChange(state);
  }

  void checkForNewPosts() {
    final currentTime = DateTime.now().toUtc();
    storage.write(key: _visitNewStorageKey, value: currentTime.toString());
    selectNewPosts(queryType: QueryType.loadRemote);
  }

  Future<void> selectNewPosts(
      {QueryType queryType = QueryType.loadCache,
      PUBLIC_FEED_CATEGORY? selectedFilter}) async {
    final currentTime = DateTime.now().toUtc();
    String? lastVisitTime;
    if (storage.containsKey(_visitNewStorageKey)) {
      lastVisitTime = storage.read(_visitNewStorageKey);
    } else {
      lastVisitTime = null;
    }
    if (selectedFilter != null) {
      currentFilter.value = selectedFilter;
    }
    if (lastVisitTime == null) {
      redDot.value = true;
    } else {
      final difference = currentTime.difference(DateTime.parse(lastVisitTime));
      if (difference.inDays >= 7) {
        redDot.value = true;
      } else {
        redDot.value = false;
      }
      if (queryType == QueryType.loadRemote) {
        redDot.value = false;
        final difference =
            currentTime.difference(DateTime.parse(lastVisitTime));
        if (difference.inMinutes > 2) {
          pullRefresh();
          storage.write(
              key: _visitNewStorageKey, value: currentTime.toString());
        }
      }
    }
    if (queryType == QueryType.loadCache) {
      fetchAdvancedPostsData(queryType: queryType);
    }
  }

  Future<void> checkNewPosts() async {
    fetchAdvancedPostsData(
        queryType: QueryType.loadRemote, checkNewPosts: true);
  }

  List<Rx<TextModel>> decodeData(DataList<TextModel> data) {
    final textsList = data.list.map((e) => e.obs).toList();
    final cursor = data.cursor;

    if (cursor.isNotEmpty) {
      this.cursor = cursor;
    }
    return textsList;
  }

  onClickFilterButton(PUBLIC_FEED_CATEGORY action) {
    // isOrderFlow.value = false;
    irisEvent.capture(EVENT_TYPE.FEED_FILTER, action.toString());
    HapticFeedback.mediumImpact();
    currentFilter.value = action;
    cursor = '';
    fetchAdvancedPostsData();
  }

  String feedSelectionToString(FEED_SELECTION category) {
    switch (category) {
      case FEED_SELECTION.ALL:
        return 'New';
      case FEED_SELECTION.FOR_YOU:
        return 'For You';
      case FEED_SELECTION.FEATURED:
        return 'Featured';
      case FEED_SELECTION.POPULAR:
        return 'Popular';
      default:
        return 'All';
    }
  }

  onCallback(PUBLIC_FEED_CATEGORY category, DataList<TextModel> feedData,
      QueryType queryType) {
    if (describeEnum(category) == describeEnum(currentFilter.value)) {
      if (queryType == QueryType.loadMore) {
        return onLoadMore(category, feedData);
      } else {
        return onSuccess(category, feedData);
      }
    }
  }

  Future<void> getInvestorsData() async {
    await searchRepository.discoverPageGet(
      input: DiscoverPageGetInput(nextCursor: getCursor()),
      queryType: QueryType.loadCache,
      callback: (data) => onDiscoveryPage(data),
      onError: onError,
    );
  }

  Future<void> fetchAdvancedPostsData(
      {String? cursor,
      QueryType queryType = QueryType.loadCache,
      bool checkNewPosts = false,
      FEED_CATEGORY? selectedCategory}) async {
    final String cursorToApply = cursor ?? this.cursor;
    final PUBLIC_FEED_CATEGORY filter = currentFilter.value;
    switch (filter) {
      case PUBLIC_FEED_CATEGORY.INVESTORS:
        await getInvestorsData();
        break;
      case PUBLIC_FEED_CATEGORY.TRENDING:
        await repository.trendingFeed(
            callback:
                (PUBLIC_FEED_CATEGORY category, DataList<TextModel> feedData) {
              onCallback(category, feedData, queryType);
            },
            cursor: cursorToApply,
            queryType: queryType,
            onError: onError);
        break;
      case PUBLIC_FEED_CATEGORY.TOP_TRADES:
        await repository.topTradesFeed(
            callback:
                (PUBLIC_FEED_CATEGORY category, DataList<TextModel> feedData) {
              onCallback(category, feedData, queryType);
            },
            cursor: cursorToApply,
            queryType: queryType,
            onError: onError);
        break;
      case PUBLIC_FEED_CATEGORY.ORDER_FLOW:
        // await getInvestorsData();
        break;
    }
  }

  Future<void> loadMore() async {
    await fetchAdvancedPostsData(queryType: QueryType.loadMore);
  }

  void onCheckNewPosts(
      PUBLIC_FEED_CATEGORY category, DataList<TextModel> feedData) {
    // if (describeEnum(_currentFeedSelection) != describeEnum(category)) return;
    // final feedData = data['advancedFeedGet'];
    final list = feedData.list;

    if (list.isEmpty || state!.isEmpty) {
      return;
    }

    final newCursor = feedData.cursor;

    final List<TextModel> filteredList = List.from(list);

    final stateListKeys = state!.take(10).map((e) => e.value.textKey).toList()
      ..sort();
    final newListKeys = filteredList.map((e) => e.textKey).toList()..sort();
    final isEqual = const ListEquality().equals(stateListKeys, newListKeys);
    if (!isEqual) {
      pendingList.value = DataList(
        cursor: newCursor,
        list: filteredList,
      );
      isOverlayButtonVisible(true);
    } else {
      isOverlayButtonVisible(false);
    }
  }

  ///The [getResponse] method receives a callback that is called whenever it has new data.
  ///It first searches the internal storage, and only then searches the server.
  ///If the result is exactly the same, it will only call the callback the first time (from the cache).
  @override
  void onInit() {
    selectNewPosts();
    super.onInit();
  }

  void onLoadMore(PUBLIC_FEED_CATEGORY category, DataList<TextModel> feedData) {
    // if (describeEnum(_currentFeedSelection) != describeEnum(category)) return;
    rebuildOnChange(state!..addAll(decodeData(feedData)));
  }

  void onSuccess(PUBLIC_FEED_CATEGORY category, DataList<TextModel> feedData) {
    rebuildOnChange(decodeData(feedData));
  }

  Future<void> pullRefresh() async {
    cursor = '';
    await fetchAdvancedPostsData(queryType: QueryType.loadRemote);
    // assetStoriesController.getInitialAssetStories(
    //     queryType: QueryType.loadRemote);
  }

  void rebuildOnChange(List<Rx<TextModel>>? data) {
    if (data == null) return;
    change(data, status: RxStatus.success());
    isOverlayButtonVisible(false);
  }

  void replaceData(Rx<TextModel> text) {
    state!.replaceWhere(
      (item) => item.value.textCreateId == text.value.textCreateId,
      text,
    );
    rebuildOnChange(state);
  }

  void reportFollow(TextModel text) {
    for (var text$ in state!) {
      if (text.user!.userKey == text$.value.user!.userKey) {
        text$.value = text$.value.copyWith(
            user: text$.value.user?.copyWith(
                authUserFollowInfo: const AuthUserFollowInfo(
                    followStatus: FOLLOW_STATUS.PENDING)));
      }
    }
  }

  void showNewPosts() {
    final List<TextModel> list = pendingList.value.list;
    rebuildOnChange(list.map((post) => post.obs).toList());
    cursor = pendingList.value.cursor;
    pendingList.value = const DataList(list: <TextModel>[], cursor: '');
  }

  Future<void> toggleSaved() async {
    change(state, status: RxStatus.loading());
    saved = !saved;
    cursor = '';
    fetchAdvancedPostsData();
  }
}

extension Rep<E> on List<E> {
  bool replaceWhere(TestPredicate<E> test, E replacement) {
    var found = false;
    final len = length;
    for (var i = 0; i < len; i++) {
      if (test(this[i])) {
        this[i] = replacement;
        found = true;
      }
    }

    return found;
  }
}
