import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/pages.dart';
import '../../feed/modules/posts/controllers/posts_controller.dart';

class ExplorerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final PostsController whoToFollowController;

  final ISearchRepository repository;
  final IrisEvent irisEvent;
  final TextEditingController textEditingController = TextEditingController();
  final IStorage storage;
  late final TabController tabController = TabController(
    vsync: this,
    length: 1,
    initialIndex: 0,
  );

  final explorerType = ExplorerPageType.EXPLORER.obs;

  final query = ''.obs;
  final isQueryEmpty = true.obs;
  final RxBool showRecentSearch = false.obs;
  final searchUserList = <User>[].obs;

  final searchAssetList = <Asset>[].obs;
  int offsetUsers = 0;

  int offsetAssets = 0;
  late StreamSubscription _routeListener;

  late Workers _workers;

  String searchVal = '';

  ExplorerController({
    required this.whoToFollowController,
    required this.repository,
    required this.irisEvent,
    required this.storage,
  });

  int get activeTab => explorerType.value.index;

  bool get isRecentPeopleEmpty {
    return whoToFollowController.recentList.isEmpty;
  }

  void changePage(ExplorerPageType type) {
    explorerType(type);
  }

  Future<void> loadMoreUsers() async {
    offsetUsers += 10;
    await loadUsers(QueryType.loadMore, query.value);
  }

  Future<void> loadUsers(QueryType type, String searchQuery) async {
    await repository.loadUsers(
      name: searchQuery,
      offset: offsetUsers,
      queryType: type,
      callback: (data) {
        if (type == QueryType.loadMore) {
          searchUserList.addAll(data);
        } else {
          searchUserList.assignAll(data);
        }
      },
      onError: onError,
    );
  }

  @override
  void onClose() {
    debugPrint('*************** OnClose *******');
    _workers.dispose();
    _routeListener.cancel();
    query.value = '';
    isQueryEmpty.value = true;
  }

  void onError(err) {
    debugPrint(err.toString());
  }

  @override
  void onInit() {
    irisEvent.add(eventType: EVENT_TYPE.VIEW_SCREEN_SEARCH);
    _workers = Workers([
      ever<String>(query, onQueryChange),
      debounce(query, onQueryChangeDebounced,
          time: const Duration(milliseconds: 300))
    ]);
    _routeListener = IrisStackObserver.stackChange.listen((stackChange) {
      if (stackChange.newRoute!.settings.name == Paths.Search &&
          stackChange.oldRoute is GetPageRoute) {
        // initialize
        whoToFollowController.getInvestorsData();
        // stocksController.onLoadData();
      }
    });
    super.onInit();
  }

  void onQueryChange(String value) {
    if (value.isEmpty) {
      isQueryEmpty(true);
    } else if (value.length == 1) {
      isQueryEmpty(false);
    }
  }

  void onQueryChangeDebounced(String value) {
    offsetUsers = 0;
    offsetAssets = 0;
    // if (searchType.value == ExplorerSearchType.WHO_FOLLOW) {
    loadUsers(QueryType.loadCache, value);
    // } else if (searchType.value == ExplorerSearchType.ASSETS) {
    //   loadAssets(QueryType.loadCache, value);
    // }
  }
}

enum ExplorerPageType {
  EXPLORER,
  LEADERBOARD,
}
