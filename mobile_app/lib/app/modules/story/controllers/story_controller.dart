import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../feed/controllers/feed_controller.dart';

class StoryController extends GetxController
    with StateMixin<List<Rx<TextModel>>> {
  StoryController({
    required this.repository,
  });

  StoryArgs? storyArgs;
  final IProfileRepository repository;
  final IrisEvent irisEvent = Get.find();
  final ReactionService reactionService = Get.find();
  final FeedController feedController = Get.find();
  int limit = 5;
  RxList<TextModel> storyList = <TextModel>[].obs;
  String storyPrevCursor = '';
  String storyNextCursor = '';
  int? userKey;
  Function? afterStories;
  User currentUser = const User();

  final isReacted = false.obs;
  bool seenLastStory = false;

  StoryArgs get args {
    if (Get.arguments is StoryArgs) {
      return Get.arguments;
    }
    return StoryArgs(
        storiesConnection: const StoriesConnection(),
        heroTag: uuid.v4()); //in case it wasnt sent
  }

  int get nbrStories {
    return args.storiesConnection.metaData?.nbrStories ?? 1;
  }

  int get storyCurrentIndex {
    return args.storiesConnection.metaData?.currentIndex ?? 0;
  }

  int get currentStoryLength {
    return storyList.length;
  }

  void rebuildOnChange(List<Rx<TextModel>>? data) {
    if (data == null) return;
    change(data, status: RxStatus.success());
  }

  @override
  void onInit() {
    if (Get.arguments is StoryArgs) {
      final List<TextModel> stories =
          args.storiesConnection.storiesPagination!.stories!;
      storyNextCursor = args.storiesConnection.storiesPagination!.nextCursor!;
      storyPrevCursor =
          args.storiesConnection.storiesPagination!.previousCursor!;
      if (args.afterStories != null) {
        afterStories = args.afterStories!;
      }
      final List<TextModel> allList = <TextModel>[];

      if (args.user != null) {
        currentUser = args.user!;
        userKey = args.user!.userKey!;
      }

      if (storyCurrentIndex == 0) {
        allList.insertAll(0, stories);
        final List<TextModel> nextList = List.generate(
            nbrStories - stories.length, (index) => const TextModel());
        allList.insertAll(stories.length, nextList);
      } else {
        //
        final List<TextModel> prevList =
            List.generate(storyCurrentIndex, (index) => const TextModel());
        allList.insertAll(0, prevList);
        allList.insertAll(prevList.length, stories);
        final List<TextModel> nextList = List.generate(
            nbrStories - storyCurrentIndex - stories.length,
            (index) => const TextModel());
        allList.insertAll(storyCurrentIndex + stories.length, nextList);
      }
      rebuildOnChange(allList.map((e) => e.obs).toList());
    }
    super.onInit();
  }

  @override
  void onClose() {
    if (seenLastStory) {
      feedController.homeController.markItemNoUnSeenStories(userKey!);
      if (afterStories != null) {
        afterStories!();
      }
    }
  }

  void performReaction() {
    isReacted.value = true;
    HapticFeedback.lightImpact();
    Future.delayed(
        const Duration(milliseconds: 700), () => isReacted.value = false);
  }

  Future<void> reactToPost(int index) async {
    final text = state![index];
    if (text.value.authUserReaction == null) {
      performReaction();
    }
    Reaction newReaction;
    if (text.value.authUserReaction == null) {
      newReaction = const Reaction();
      text.value = text.value.copyWith(
          numberOfReactions: text.value.numberOfReactions! + 1,
          authUserReaction: newReaction);
    }
    state!.removeAt(index);
    state!.insert(index, text);
    await reactionService.reactToText(
        reactionKind: REACTION_KIND.LIKE, textKey: text.value.textKey);
  }

  void getMoreStories(bool next) {
    repository.getUserByKey(
        userKey: userKey!,
        queryType: QueryType.loadRemote,
        callback: (data) {
          final users = data.users;
          if (users != null && users.isNotEmpty) {
            final User user = users.first;
            final List<TextModel> stories =
                user.storiesConnection!.storiesPagination!.stories!;
            storyNextCursor =
                user.storiesConnection!.storiesPagination!.nextCursor ?? '';
            storyPrevCursor =
                user.storiesConnection!.storiesPagination!.previousCursor ?? '';
            if (next) {
              // get the last index where the textKey is not null
              final lastIndex = state!
                  .lastIndexWhere((element) => element.value.textKey != null);
              if (lastIndex > nbrStories) {
                return;
              }
              int endRangeIndex = lastIndex + 1 + stories.length;
              if (endRangeIndex > nbrStories) {
                endRangeIndex = nbrStories;
              }
              rebuildOnChange(state!
                ..replaceRange(
                    lastIndex + 1, endRangeIndex, stories.map((e) => e.obs)));
            } else {
              final int indexToStart =
                  state!.indexWhere((element) => element.value.textKey != null);
              final newStoriesLength = stories.length;
              if (newStoriesLength > indexToStart) {
                final storiesToAdd = stories.take(indexToStart);
                rebuildOnChange(state!
                  ..replaceRange(
                      0, indexToStart, storiesToAdd.map((e) => e.obs)));
              } else {
                rebuildOnChange(state!
                  ..replaceRange(indexToStart - newStoriesLength, indexToStart,
                      stories.map((e) => e.obs)));
              }
            }
          }
        },
        userGql: storyGql(
            limit: 5, cursor: next ? storyNextCursor : storyPrevCursor),
        onError: onError);
  }

  void onSeenLastStory(int userKey) {
    seenLastStory = true;
  }

  onError(data) {}
}
