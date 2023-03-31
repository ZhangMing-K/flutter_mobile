import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class SavedFeedController extends GetxController
    with StateMixin<List<Rx<TextModel>>> {
  SavedFeedController({required this.repository});

  final IFeedRepository repository;
  final scrollController = ScrollController();

  final IAuthUserService authUserStore = Get.find<IAuthUserService>();
  final UserService userService = Get.find<UserService>();

  int offset = 0;
  bool canLoadMore = true;

  @override
  void onInit() {
    loadSavedTexts();
    super.onInit();
  }

  void rebuildOnChange(List<Rx<TextModel>> data) {
    if (data.isNotEmpty) {
      change(data, status: RxStatus.success());
    } else {
      change(state, status: RxStatus.empty());
    }
  }

  Future<void> loadSavedTexts(
      {QueryType queryType = QueryType.loadCache}) async {
    return await repository.getUserSavedTexts(
      queryType: queryType,
      callback: queryType == QueryType.loadMore ? onLoadMore : onSuccess,
      offset: offset,
      onError: onError,
    );
  }

  void onSuccess(serverResponse) {
    final List<TextModel> savedTexts = serverResponse;
    if (savedTexts.length == 10) {
      offset += 10;
    } else {
      canLoadMore = false;
    }
    rebuildOnChange(
      savedTexts.map((text) => text.obs).toList(),
    );
  }

  Future<void> loadMore() async {
    if (canLoadMore) await loadSavedTexts(queryType: QueryType.loadMore);
  }

  void onLoadMore(serverResponse) {
    final List<TextModel> savedTexts = serverResponse;
    if (savedTexts.length == 10) {
      offset += 10;
      canLoadMore = true;
    } else {
      canLoadMore = false;
    }
    rebuildOnChange(
      state!
        ..addAll(
          savedTexts.map((text) => text.obs).toList(),
        ),
    );
  }

  void onError(err) {}

  Future<void> pullRefresh() async {}
}
