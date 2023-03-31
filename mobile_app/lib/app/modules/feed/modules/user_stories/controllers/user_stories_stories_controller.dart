import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class UserStoriesStoriesController extends GetxController
    with StateMixin<List<List<Rx<TextModel>>>> {
  UserStoriesStoriesController({
    required this.repository,
  });

  StoryArgs? storyArgs;
  final IProfileRepository repository;
  final IrisEvent irisEvent = Get.find();
  final ReactionService reactionService = Get.find();
  int limit = 5;
  String storyPrevCursor = '';
  String storyNextCursor = '';
  List<int?> userKeys = <int>[];
  List<String?> prevCursors = <String>[];
  List<String?> nextCursors = <String>[];
  final List<User> usersList = <User>[];
  final Map<String, bool> isCursorLoaded = {'test': false};
  late String heroId;

  final isReacted = false.obs;

  late int initialPage;

  int get pageLength {
    return usersList.length;
  }

  int nbrStories(int pageIndex) {
    return usersList[pageIndex].storiesConnection?.metaData?.nbrStories ?? 1;
  }

  int storyCurrentIndex(int pageIndex) {
    return usersList[pageIndex].storiesConnection?.metaData?.currentIndex ?? 0;
  }

  int userKey(int pageIndex) {
    return usersList[pageIndex].userKey!;
  }

  User storyUser(int pageIndex) {
    return usersList[pageIndex];
  }

  void rebuildOnChange(List<List<Rx<TextModel>>> data) {
    change(data, status: RxStatus.success());
  }

  @override
  void onInit() {
    final args = (Get.arguments is FeedStoryArgs)
        ? Get.arguments
        : FeedStoryArgs(initialPage: 0, userList: <User>[], heroId: uuid.v4());

    initialPage = args.initialPage ?? 0;

    heroId = args.heroId;
    final List<User> userList = args.userList!;
    usersList.assignAll(userList);
    final List<int> _userKeys = List.generate(userList.length, (index) => 0);
    final List<String> _prevCursors =
        List.generate(userList.length, (index) => '');
    final List<String> _nextCursors =
        List.generate(userList.length, (index) => '');
    final List<List<TextModel>> totalList = List.generate(
        userList.length,
        (pageIndex) => List.generate(
            nbrStories(pageIndex), (storyIndex) => const TextModel()));
    final mappedUsers = userList.asMap();
    mappedUsers.forEach((key, value) {
      final User user = value;
      final List<TextModel> stories =
          user.storiesConnection!.storiesPagination!.stories!;
      _prevCursors[key] =
          user.storiesConnection!.storiesPagination!.previousCursor ?? '';
      _nextCursors[key] =
          user.storiesConnection!.storiesPagination!.nextCursor ?? '';
      final List<TextModel> allList = <TextModel>[];
      _userKeys[key] = user.userKey!;
      if (storyCurrentIndex(key) == 0) {
        allList.insertAll(0, stories);
        final List<TextModel> nextList = List.generate(
            nbrStories(key) - stories.length, (index) => const TextModel());
        allList.insertAll(stories.length, nextList);
      } else {
        //
        final List<TextModel> prevList =
            List.generate(storyCurrentIndex(key), (index) => const TextModel());
        allList.insertAll(0, prevList);
        allList.insertAll(prevList.length, stories);
        final List<TextModel> nextList = List.generate(
            nbrStories(key) - storyCurrentIndex(key) - stories.length,
            (index) => const TextModel());
        allList.insertAll(storyCurrentIndex(key) + stories.length, nextList);
      }
      totalList[key].assignAll(allList);
    });
    userKeys.assignAll(_userKeys);
    prevCursors.assignAll(_prevCursors);
    nextCursors.assignAll(_nextCursors);
    rebuildOnChange(
        totalList.map((e) => e.map((e) => e.obs).toList()).toList());

    super.onInit();
  }

  void performReaction() {
    isReacted.value = true;
    HapticFeedback.lightImpact();
    Future.delayed(
        const Duration(milliseconds: 700), () => isReacted.value = false);
  }

  Future<void> reactToPost(int pageIndex, int index) async {
    final text = state![pageIndex][index];
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
    await reactionService.reactToText(
        reactionKind: REACTION_KIND.LIKE, textKey: text.value.textKey);
  }

  getMoreStories(int pageIndex, bool next) {
    final int userKey = userKeys[pageIndex]!;
    final String cursorToApply =
        next ? nextCursors[pageIndex]! : prevCursors[pageIndex]!;
    final isCursorApplied = isCursorLoaded['"' + cursorToApply + '"'];
    if (isCursorApplied == true) {
      return;
    }
    isCursorLoaded['"' + cursorToApply + '"'] = true;
    repository.getUserByKey(
        userKey: userKey,
        queryType: QueryType.loadRemote,
        callback: (data) {
          final users = data.users;
          if (users != null && users.isNotEmpty) {
            final User user = users.first;
            final userKeyFromAPI = user.userKey!;
            if (userKey != userKeyFromAPI) return;
            final List<TextModel> stories =
                user.storiesConnection!.storiesPagination!.stories!;

            if (stories.isNotEmpty) {
              nextCursors.removeAt(pageIndex);
              nextCursors.insert(pageIndex,
                  user.storiesConnection!.storiesPagination!.nextCursor ?? '');
              prevCursors.removeAt(pageIndex);
              prevCursors.insert(
                  pageIndex,
                  user.storiesConnection!.storiesPagination!.previousCursor ??
                      '');
              if (next) {
                // get the last index where the textKey is not null
                final lastIndex = state![pageIndex]
                    .lastIndexWhere((element) => element.value.textKey != null);
                if (lastIndex > nbrStories(pageIndex)) {
                  return;
                }
                int endRangeIndex = lastIndex + 1 + stories.length;
                if (endRangeIndex > nbrStories(pageIndex)) {
                  endRangeIndex = nbrStories(pageIndex);
                }

                state![pageIndex].replaceRange(
                    lastIndex + 1, endRangeIndex, stories.map((e) => e.obs));
                rebuildOnChange(state!);
              } else {
                final int indexToStart = state![pageIndex]
                    .indexWhere((element) => element.value.textKey != null);
                final newStoriesLength = stories.length;
                if (newStoriesLength > indexToStart) {
                  final storiesToAdd = stories.take(indexToStart);
                  state![pageIndex].replaceRange(
                      0, indexToStart, storiesToAdd.map((e) => e.obs));
                  rebuildOnChange(state!);
                } else {
                  state![pageIndex].replaceRange(
                      indexToStart - newStoriesLength,
                      indexToStart,
                      stories.map((e) => e.obs));
                  rebuildOnChange(state!);
                }
              }
              isCursorLoaded['"' + cursorToApply + '"'] = true;
            } else {
              isCursorLoaded['"' + cursorToApply + '"'] = false;
            }
          }
        },
        userGql: storyGql(limit: 5, cursor: cursorToApply),
        onError: onError);
  }

  onError(data) {}
}

class StoryData {}
