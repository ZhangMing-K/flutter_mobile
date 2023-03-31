import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../routes/pages.dart';
import '../../../shared/mixins/scroll_controller_mixin.dart';

class UserStoriesUserController extends GetxController
    with StateMixin<List<Rx<User>>>, ScrollControllerMixin {
  StoryArgs? storyArgs;
  final IProfileRepository repository;
  final IrisEvent irisEvent = Get.find();
  final ReactionService reactionService = Get.find();
  late StreamSubscription _routeListener;
  final isReacted = false.obs;
  final IAuthUserService authUserStore;

  UserStoriesUserController({
    required this.repository,
    required this.authUserStore,
  });

  Future<void> getInitialUserStories(
      {QueryType queryType = QueryType.loadCache}) async {
    await repository.storiesUserGet(
        limit: 1,
        queryType: queryType,
        callback: (data) {
          rebuildOnChange(data.map((story) => story.user!.obs).toList());
        },
        onError: onError);
  }

  void goToUserStory(int pageIndex, String id) {
    final indexUser = state![pageIndex].value;
    if (indexUser.storiesConnection!.metaData!.areStories ?? false) {
      final usersWithStories = state!
          .where(
              (e) => e.value.storiesConnection!.metaData!.areStories ?? false)
          .toList();
      final storyArgs = FeedStoryArgs(
        userList: usersWithStories.map((e) => e.value).toList(),
        initialPage: pageIndex,
        heroId: id,
      );
      Get.toNamed(
        Paths.UserStory,
        arguments: storyArgs,
      );
    } else {
      // takes user to profile page
      indexUser.routeToFromProfilePicture(null, uuid.v4());
    }
  }

  @override
  void onClose() {
    _routeListener.cancel();
    super.onClose();
  }

  onError(data) {
    debugPrint('error');
  }

  @override
  void onInit() {
    getInitialUserStories();
    _routeListener = IrisStackObserver.stackChange.listen((stackChange) {
      if (stackChange.newRoute?.settings.name == Paths.Feed &&
          stackChange.oldRoute is GetPageRoute) {
        Future(getInitialUserStories);
      }
    });
    super.onInit();
  }

  void rebuildOnChange(List<Rx<User>>? data) {
    if (data!.isNotEmpty) {
      change(data, status: RxStatus.success());
    } else {
      change([], status: RxStatus.empty());
    }
  }

  toSearchPage() {
    Get.toNamed(Paths.Search, id: 1);
  }
}
