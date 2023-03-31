import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../../shared/mixins/scroll_controller_mixin.dart';
import '../../user_stories/controllers/user_stories_user_controller.dart';

///This class has the sole responsibility to control the status of the posts tab in the feed.
///We use StateMixin because it makes our code more secure. If an error is not caught,
///it is displayed automatically. The loading status is also displayed when there is no data.
///We can change the state of the controller through the change method, and attach a status to it
class FollowingFeedController extends GetxController
    with StateMixin<List<Rx<FeedItem>>>, ScrollControllerMixin {
  final IFeedRepository repository;
  final ISearchRepository searchRepository;
  final UserStoriesUserController userStoriesController;
  final IStorage storage = Get.find();
  RxBool redDot = false.obs;
  String cursor = '';
  final activePopularWithPortfolio = <User>[].obs;

  FollowingFeedController({
    required this.repository,
    required this.searchRepository,
    required this.userStoriesController,
  });

  void checkForUpdate() {
    const storageKey = 'visitFollowingFeedTime';
    final currentTime = DateTime.now().toUtc();
    final lastVisitTime = storage.read(storageKey);
    if (lastVisitTime == null) {
      pullRefresh();
      storage.write(key: storageKey, value: currentTime.toString());
    } else {
      final difference = currentTime.difference(DateTime.parse(lastVisitTime));
      if (difference.inMinutes > 2) {
        pullRefresh();
        storage.write(key: storageKey, value: currentTime.toString());
      }
    }
  }

  Future<void> fetchFollowingData({
    String? cursor,
    QueryType queryType = QueryType.loadCache,
  }) {
    final String cursorToApply = cursor ?? this.cursor;
    return repository.followingFeedGet(
        input: FollowerFeedInput(cursor: cursorToApply),
        queryType: queryType,
        callback: queryType == QueryType.loadMore ? onLoadMore : onSuccess,
        onError: onError);
  }

  void replaceData(Rx<TextModel> text) {
    state!.replaceWhere(
      (item) {
        return item.value.symbol == FEED_SYMBOL_TYPE.TEXT &&
            item.value.text?.textCreateId == text.value.textCreateId;
      },
      FeedItem(symbol: FEED_SYMBOL_TYPE.TEXT, text: text.value).obs,
    );
    rebuildOnChange(state);
  }

  void appendPostOnTop(Rx<TextModel> text) {
    state!.insert(
        0, FeedItem(symbol: FEED_SYMBOL_TYPE.TEXT, text: text.value).obs);
    rebuildOnChange(state);
  }

  void onSuccessSuggestions(List<User> suggestions) {
    activePopularWithPortfolio.assignAll(suggestions);
  }

  Future<void> loadMore() async {
    await fetchFollowingData(queryType: QueryType.loadMore, cursor: cursor);
  }

  void markItemNoUnSeenStories(int userKey) {
    final len = state!.length;
    for (var i = 0; i < len; i++) {
      final item = state![i];
      if (item.value.text?.user?.userKey == userKey) {
        FeedItem originItem = item.value;
        final StoriesMetaData? newMetadata = originItem
            .text?.user?.storiesConnection?.metaData!
            .copyWith(areUnseenStories: false);
        final StoriesConnection? newStoriesConnection = originItem
            .text?.user?.storiesConnection
            ?.copyWith(metaData: newMetadata);
        final User? newUser = originItem.text?.user
            ?.copyWith(storiesConnection: newStoriesConnection);
        originItem =
            originItem.copyWith(text: originItem.text!.copyWith(user: newUser));
        state!.replaceIndex(originItem.obs, i);
      }
    }
    rebuildOnChange(state);
  }

  void onError(exception) {
    debugPrint(exception.toString());
  }

  @override
  void onInit() {
    fetchFollowingData();
    //  _onLoadSuggestions();
    super.onInit();
  }

  void onLoadMore(FeedItemReturn serverResponse) {
    if (serverResponse.nextCursor!.isNotEmpty) {
      cursor = serverResponse.nextCursor!;

      rebuildOnChange(
        state!
          ..addAll(
            serverResponse.items!.map((d) => d.obs).toList(),
          ),
      );
    }
  }

  void onSuccess(FeedItemReturn serverResponse) {
    cursor = serverResponse.nextCursor ?? '';
    rebuildOnChange(
      serverResponse.items!.map((d) => d.obs).toList(),
    );
  }

  Future<void> pullRefresh() async {
    cursor = '';
    await fetchFollowingData(queryType: QueryType.loadRemote, cursor: cursor);
    userStoriesController.getInitialUserStories(
        queryType: QueryType.loadRemote);
  }

  bool get showRefreshIndicator {
    final followerLen = userStoriesController.state!.length;
    if (followerLen == 3) {
      return true;
    }
    return false;
  }

  Future<void> refreshFollowers() async {
    await userStoriesController.getInitialUserStories(
        queryType: QueryType.loadRemote);
    if (showRefreshIndicator) {
      await fetchFollowingData(queryType: QueryType.loadRemote, cursor: '');
    }
  }

  void rebuildOnChange(List<Rx<FeedItem>>? data) {
    if (data == null) return;
    change(data, status: RxStatus.success());
  }

  // check for update
  void reportFollow(TextModel text) {
    for (var text$ in state!) {
      if (text.user!.userKey == text$.value.text!.user!.userKey) {
        text$.value = text$.value.copyWith(
            text: text$.value.text!.copyWith(
                user: text$.value.text!.user?.copyWith(
                    authUserFollowInfo: const AuthUserFollowInfo(
                        followStatus: FOLLOW_STATUS.PENDING))));
      }
    }
  }
}

extension Rep<E> on List<E> {
  bool replaceIndex(E replacement, int index) {
    this[index] = replacement;
    return true;
  }
}

extension ReplaceWhereExt<E> on List<E> {
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

typedef TestPredicate<E> = bool Function(E element);
