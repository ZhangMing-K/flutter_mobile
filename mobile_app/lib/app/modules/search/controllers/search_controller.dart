import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_mobile/app/modules/search/controllers/search_asset_controller.dart';
import 'package:iris_mobile/app/modules/search/controllers/search_people_controller.dart';

import '../../../routes/pages.dart';

class SearchController extends GetxController {
  final SearchPeopleController searchPeopleController;

  final SearchAssetController searchAssetController;
  final ISearchRepository repository;
  final TextEditingController textEditingController = TextEditingController();
  final IStorage storage;
  final searchType = SearchType.USERS;

  final query = ''.obs;

  final isQueryEmpty = true.obs;
  final searchUserList = <User>[].obs;

  final searchAssetList = <Asset>[].obs;
  int offsetUsers = 0;

  int offsetAssets = 0;
  late StreamSubscription _routeListener;

  late Workers _workers;

  String searchVal = '';

  SearchController({
    required this.searchPeopleController,
    required this.searchAssetController,
    required this.repository,
    required this.storage,
  });

  int get getSearchIndex {
    return searchType.index;
  }

  bool get isRecentAssetEmpty {
    return searchAssetController.recentList.isEmpty;
  }

  bool get isRecentPeopleEmpty {
    return searchPeopleController.recentList.isEmpty;
  }

  Future<void> loadAssets(QueryType type, String searchQuery) {
    return repository.loadAssets(
      queryType: type,
      searchValue: searchQuery,
      offset: offsetAssets,
      callback: (data) {
        if (type == QueryType.loadMore) {
          searchAssetList.addAll(data);
        } else {
          searchAssetList.assignAll(data);
        }
      },
      onError: onError,
    );
  }

  Future<void> loadMoreAssets() async {
    offsetAssets += 10;
    await loadAssets(QueryType.loadMore, query.value);
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
    loadUsers(QueryType.loadCache, '');
    _workers = Workers([
      ever<String>(query, onQueryChange),
      debounce(query, onQueryChangeDebounced,
          time: const Duration(milliseconds: 300))
    ]);
    _routeListener = IrisStackObserver.stackChange.listen((stackChange) {
      if (stackChange.newRoute!.settings.name == Paths.Search &&
          stackChange.oldRoute is GetPageRoute) {
        // initialize
      }
    });
    super.onInit();
  }

  void onQueryChange(String value) {
    offsetUsers = 0;
    offsetAssets = 0;
    if (value.isEmpty) {
      isQueryEmpty(true);
    } else if (value.length == 1) {
      isQueryEmpty(false);
    }
  }

  void onQueryChangeDebounced(String value) {
    // if (searchType.value == ExplorerSearchType.WHO_FOLLOW) {
    loadUsers(QueryType.loadCache, value);
    // } else if (searchType.value == ExplorerSearchType.ASSETS) {
    //   loadAssets(QueryType.loadCache, value);
    // }
  }

  Future<void> refreshUsers() async {
    offsetUsers = 0;
    await loadUsers(QueryType.loadRemote, query.value);
  }
}

enum SearchType {
  USERS,
  ASSETS,
}
