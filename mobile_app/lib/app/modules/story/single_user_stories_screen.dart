import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/story/controllers/story_controller.dart';
import 'package:iris_mobile/app/modules/story/widgets/story_bottom_actions.dart';
import 'package:iris_mobile/app/modules/story/widgets/story_item.dart';
import 'package:iris_mobile/app/modules/story/widgets/user_story_gesture_item.dart';
import 'package:unicons/unicons.dart';

class SingleUserStoriesScreen extends GetWidget<StoryController> {
  const SingleUserStoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragToPopScreen(
        child: CustomStoryPage(
      onStoryChange: (pageIndex, storyIndex) {
        final Rx<TextModel> text$ = controller.state![storyIndex];
        final IrisEvent irisEvent = Get.find();
        if (text$.value.textKey == null) {
          return;
        }
        irisEvent.registerTextView(
            textKey: text$.value.textKey!, from: TEXT_VIEW_FROM.STORY);
      },
      initialStoryIndex: (int pageIndex) {
        return controller.storyCurrentIndex;
      },
      itemBuilder: (context, pageIndex, storyIndex) {
        return controller.obx(
          (state) {
            if (storyIndex < controller.storyCurrentIndex) {
              if (storyIndex > 0) {
                if (state![storyIndex - 1].value.textKey == null) {
                  controller.getMoreStories(false);
                }
              }
            }
            if (storyIndex >= controller.storyCurrentIndex) {
              if (storyIndex < controller.nbrStories - 1) {
                if (state![storyIndex + 1].value.textKey == null) {
                  controller.getMoreStories(true);
                }
              }
            }
            final Rx<TextModel> text$ = state![storyIndex];
            if (storyIndex == controller.nbrStories - 1) {
              controller.onSeenLastStory(text$.value.user!.userKey!);
            }
            return StoryItem(
                text$: text$,
                heroTag: text$.value.user?.userKey.toString() ?? uuid.v4());
          },
          onLoading: const Text('loading'),
        );
      },
      gestureItemBuilder: (context, pageIndex, storyIndex) {
        final User user = controller.currentUser;
        return controller.obx(
          (state) {
            final Rx<TextModel> text = state![storyIndex];
            return UserStoryGestureItem(text: text, user: user);
          },
          onLoading: const Text('loading'),
        );
      },
      bottomGestureBuilder:
          (context, pageIndex, storyIndex, animationController, onTapLike) {
        return controller.obx(
          (state) {
            final Rx<TextModel> text$ = state![storyIndex];
            return StoryBottomActions(
                text$: text$, onLike: () => controller.reactToPost(storyIndex));
          },
          onLoading: Container(),
        );
      },
      storyLength: (pageIndex) {
        return controller.nbrStories;
      },
      pageLength: 1,
    ));
  }

  Widget comment(Rx<TextModel> text, BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Paths.Text.createPath([text.value.textKey]),
            arguments: TextScreenArgs(text: text, isComment: true));
      },
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: context.theme.backgroundColor,
                borderRadius: BorderRadius.circular(30)),
            child: Icon(
              UniconsLine.comment,
              size: kIconSize,
              color: context.theme.colorScheme.secondary.withOpacity(.8),
            ),
          )
        ],
      ),
    );
  }
}
