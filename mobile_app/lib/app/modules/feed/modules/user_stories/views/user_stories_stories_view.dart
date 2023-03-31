import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/story/widgets/story_bottom_actions.dart';
import 'package:iris_mobile/app/modules/story/widgets/story_item.dart';
import 'package:iris_mobile/app/modules/story/widgets/user_story_gesture_item.dart';

import '../controllers/user_stories_stories_controller.dart';

class UserStoriesStoriesScreen extends GetView<UserStoriesStoriesController> {
  const UserStoriesStoriesScreen({Key? key}) : super(key: key);

  Widget userInfo(BuildContext context, User user, Rx<TextModel> text) {
    final String timeAgo = text.value.dateFromAbb;

    return GestureDetector(
        onTap: () {
          user.routeToProfile();
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          color: context.theme.scaffoldBackgroundColor,
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserImage(
                    radius: 15,
                    user: user,
                    hasHero: false,
                    //  id: id,
                    showStories: false,
                    onTap: () {
                      user.routeToProfile();
                    },
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      user.routeToProfile();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            UserName(
                              user: user,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              timeAgo,
                              style: TextStyle(
                                  color: context.theme.colorScheme.secondary
                                      .withOpacity(0.8),
                                  fontSize: 12),
                            )
                          ],
                        ),
                        if (user.traderPercentile != null)
                          Text(
                            '${user.traderPercentile} trader percentile',
                            style: TextStyle(
                                fontSize: 12,
                                color: context.theme.colorScheme.secondary
                                    .withOpacity(0.8)),
                          ),
                      ],
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (kDebugMode) {
                    print('on tap setting');
                  }
                },
                child: const Icon(Icons.more_vert),
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode([]);
    return DragToPopScreen(
      child: CustomStoryPage(
        onStoryChange: (pageIndex, storyIndex) {
          final Rx<TextModel> text$ = controller.state![pageIndex][storyIndex];
          final IrisEvent irisEvent = Get.find();
          if (text$.value.textKey == null) {
            return;
          }
          irisEvent.registerTextView(
              textKey: text$.value.textKey!, from: TEXT_VIEW_FROM.STORY);
        },
        initialStoryIndex: (int pageIndex) {
          return controller.storyCurrentIndex(pageIndex);
        },
        initialPage: controller.initialPage,
        itemBuilder: (context, pageIndex, storyIndex) {
          return Hero(
            tag: controller.heroId,
            child: controller.obx(
              (state) {
                final Rx<TextModel> text$ = state![pageIndex][storyIndex];
                if (storyIndex < controller.storyCurrentIndex(pageIndex)) {
                  if (storyIndex > 0) {
                    if (state[pageIndex][storyIndex - 1].value.textKey ==
                        null) {
                      controller.getMoreStories(pageIndex, false);
                    }
                  }
                }
                if (storyIndex >= controller.storyCurrentIndex(pageIndex)) {
                  if (storyIndex < controller.nbrStories(pageIndex) - 1) {
                    if (state[pageIndex][storyIndex + 1].value.textKey ==
                        null) {
                      controller.getMoreStories(pageIndex, true);
                    }
                  }
                }
                return StoryItem(
                  heroTag: controller.heroId,
                  text$: text$,
                );
              },
              onLoading: const Text('loading'),
            ),
          );
        },
        gestureItemBuilder: (context, pageIndex, storyIndex) {
          return controller.obx(
            (state) {
              final User user = controller.storyUser(pageIndex);
              final Rx<TextModel> text = state![pageIndex][storyIndex];
              return UserStoryGestureItem(text: text, user: user);
            },
            onLoading: const Text('loading'),
          );
        },
        bottomGestureBuilder:
            (context, pageIndex, storyIndex, animationController, onTapLike) {
          return controller.obx(
            (state) {
              final Rx<TextModel> text$ = state![pageIndex][storyIndex];
              return StoryBottomActions(
                text$: text$,
                onLike: () => controller.reactToPost(pageIndex, storyIndex),
              );
            },
            onLoading: Container(),
          );
        },
        storyLength: (pageIndex) {
          return controller.nbrStories(pageIndex);
        },
        pageLength: controller.pageLength,
      ),
    );
  }
}
