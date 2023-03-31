import 'package:flutter/cupertino.dart';
import 'package:iris_common/vendor/packages/story_page_view/story.dart';

/// Notify current stack index
class StoryStackController extends ValueNotifier<int> {
  StoryStackController({
    required this.storyLength,
    required this.onPageForward,
    required this.onPageBack,
    required this.pageIndex,
    this.reactStory,
    this.onChangeStory,
    initialStoryIndex = 0,
  }) : super(initialStoryIndex);
  final int storyLength;
  final VoidCallback onPageForward;
  final VoidCallback onPageBack;
  final StoryReacted? reactStory;
  final StoryOnChanged? onChangeStory;
  final int pageIndex;
  int get limitIndex => storyLength - 1;

  //AnimationController? animationController;

  void increment(
      {VoidCallback? restartAnimation, VoidCallback? completeAnimation}) {
    if (value == limitIndex) {
      completeAnimation?.call();
      onPageForward();
    } else {
      value++;
      restartAnimation?.call();
    }
    if (onChangeStory != null) {
      onChangeStory!(pageIndex, value);
    }
    animateBackBottomGesture();
  }

  void decrement() {
    if (value == 0) {
      onPageBack();
    } else {
      value--;
    }

    if (onChangeStory != null) {
      onChangeStory!(pageIndex, value);
    }
    animateBackBottomGesture();
  }

  void animateBackBottomGesture() {
    if (reactStory != null) {
      reactStory!(pageIndex, value);
    }
  }
}
