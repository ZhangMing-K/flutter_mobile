import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

enum PROFILE_FEED_TYPE { POSTS, ORDERS, TRADE_IDEAS }

class ProfilePostsController extends GetxController
    with StateMixin<List<Rx<TextModel>>> {
  final IProfileRepository repository;
  final scrollController = ScrollController();

  int postOffset = 0;
  int orderOffset = 0;
  int tradeIdeaOffset = 0;

  Rx<TEXT_TYPE> currentFilter = TEXT_TYPE.ORDER.obs;

  final int profileUserKey;
  ProfilePostsController({
    required this.repository,
    required this.profileUserKey,
  });

  Future<void> fetchPosts(
      {TEXT_TYPE type = TEXT_TYPE.ORDER,
      int offset = 0,
      QueryType queryType = QueryType.loadCache}) {
    return repository.getPostsOrOrders(
      userKey: profileUserKey,
      offset: offset,
      type: type,
      callback: queryType == QueryType.loadMore ? onLoadMore : onSuccess,
      queryType: queryType,
      onError: onError,
    );
  }

  Future<void> loadMore() async {
    TEXT_TYPE type = currentFilter.value;
    int offset;
    switch (currentFilter.value) {
      case TEXT_TYPE.POST:
        postOffset += 10;
        offset = postOffset;
        break;
      case TEXT_TYPE.ORDER:
        orderOffset += 10;
        offset = orderOffset;
        break;
      case TEXT_TYPE.DUE_DILIGENCE:
        tradeIdeaOffset += 10;
        offset = tradeIdeaOffset;
        break;
      default:
        offset = postOffset;
    }
    await fetchPosts(type: type, queryType: QueryType.loadMore, offset: offset);
  }

  onClickFilterButton(TEXT_TYPE action) {
    HapticFeedback.mediumImpact();
    currentFilter.value = action;
    TEXT_TYPE type = action;
    int offset;
    switch (action) {
      case TEXT_TYPE.POST:
        offset = postOffset;
        break;
      case TEXT_TYPE.ORDER:
        offset = orderOffset;
        break;
      case TEXT_TYPE.DUE_DILIGENCE:
        offset = tradeIdeaOffset;
        break;
      default:
        type = TEXT_TYPE.POST;
        offset = postOffset;
    }
    fetchPosts(type: type);
  }

  markItemNoUnSeenStories(int userKey) {
    final len = state!.length;
    for (var i = 0; i < len; i++) {
      final item = state![i];
      if (item.value.user!.userKey == userKey) {
        TextModel originItem = item.value;
        final StoriesMetaData? newMetadata = originItem
            .user?.storiesConnection?.metaData
            ?.copyWith(areUnseenStories: false);
        final StoriesConnection? newStoriesConnection =
            originItem.user?.storiesConnection?.copyWith(metaData: newMetadata);
        final User? newUser =
            originItem.user?.copyWith(storiesConnection: newStoriesConnection);
        originItem = originItem.copyWith(user: newUser);
        state!.replaceIndex(originItem.obs, i);
      }
    }
    rebuildOnChange(state);
  }

  void onError(e) {
    // IrisExceptionHandler.show(ProfilePostsLoadException());
  }

  @override
  void onInit() {
    fetchPosts(queryType: QueryType.loadCache);
    super.onInit();
  }

  void onLoadMore(UserProfileFeedData<TextModel> data) {
    final TEXT_TYPE type = data.type;
    final List<TextModel> dataList = data.list;
    if (type == currentFilter.value) {
      if (dataList.isNotEmpty) {
        rebuildOnChange(state!..addAll(dataList.map((e) => e.obs).toList()));
      }
    }
  }

  void onSuccess(UserProfileFeedData<TextModel> data) {
    final TEXT_TYPE type = data.type;
    final List<TextModel> dataList = data.list;
    if (type == currentFilter.value) {
      rebuildOnChange(dataList.map((e) => e.obs).toList());
    }
  }

  Future<void> pullRefresh() async {
    int offset;
    TEXT_TYPE type = currentFilter.value;
    switch (currentFilter.value) {
      case TEXT_TYPE.POST:
        postOffset = 0;
        offset = postOffset;
        break;
      case TEXT_TYPE.ORDER:
        orderOffset = 0;
        offset = orderOffset;
        break;
      case TEXT_TYPE.DUE_DILIGENCE:
        tradeIdeaOffset = 0;
        offset = tradeIdeaOffset;
        break;
      default:
        postOffset = 0;
        offset = postOffset;
    }
    await fetchPosts(
        type: type, queryType: QueryType.loadRemote, offset: offset);
  }

  String get textType {
    String type = 'Post';
    switch (currentFilter.value) {
      case TEXT_TYPE.POST:
        type = 'Posts';
        break;
      case TEXT_TYPE.ORDER:
        type = 'Orders';
        break;
      case TEXT_TYPE.DUE_DILIGENCE:
        type = 'Trade Ideas';
        break;
      default:
        type = 'Post';
    }
    return type;
  }

  void rebuildOnChange(List<Rx<TextModel>>? data) {
    if (data == null) return;
    change(data, status: RxStatus.success());
  }

  List<Rx<TextModel>> replaceItem(
      Rx<TextModel> newItem, List<Rx<TextModel>> list) {
    final index = list.indexWhere(
        (item) => item.value.textCreateId == newItem.value.textCreateId);
    list.replaceRange(index, index + 1, [newItem]);
    return list;
  }
}

extension Rep<E> on List<E> {
  bool replaceIndex(E replacement, int index) {
    this[index] = replacement;
    return true;
  }
}
