import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/widgets/like_button/like_button.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/text_card/text_card.dart';
import 'package:unicons/unicons.dart';

import '../controllers/story_controller.dart';
import '../widgets/story_user_info_header.dart';

class StoryMobileScreen extends GetWidget<StoryController> {
  const StoryMobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 5, // context.mediaQueryPadding.top,
        color: context.theme.scaffoldBackgroundColor,
      ),
      Expanded(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Obx(() => Stack(
                    alignment: Alignment.center,
                    children: [
                      StoryPageView(
                          onChangedStory: (pageIndex, storyIndex) {
                            final Rx<TextModel> text$ =
                                controller.state![storyIndex];
                            final IrisEvent irisEvent = Get.find();
                            if (text$.value.textKey == null) {
                              return;
                            }
                            irisEvent.registerTextView(
                                textKey: text$.value.textKey!,
                                from: TEXT_VIEW_FROM.STORY);
                          },
                          indicatorDuration: const Duration(seconds: 5),
                          onPageLimitReached: () {
                            Navigator.pop(context);
                          },
                          initialStoryIndex: (int pageIndex) {
                            return controller.storyCurrentIndex;
                          },
                          backgroundColor: Colors.grey.shade400,
                          itemBuilder: (context, pageIndex, storyIndex) {
                            return controller.obx(
                              (state) {
                                if (storyIndex < controller.storyCurrentIndex) {
                                  if (storyIndex > 0) {
                                    if (state![storyIndex - 1].value.textKey ==
                                        null) {
                                      controller.getMoreStories(false);
                                    }
                                  }
                                }
                                if (storyIndex >=
                                    controller.storyCurrentIndex) {
                                  if (storyIndex < controller.nbrStories - 1) {
                                    if (state![storyIndex + 1].value.textKey ==
                                        null) {
                                      controller.getMoreStories(true);
                                    }
                                  }
                                }

                                final Rx<TextModel> text$ = state![storyIndex];
                                if (text$.value.textKey == null) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      CupertinoActivityIndicator(radius: 10),
                                      SizedBox(height: 16),
                                      Center(child: Text('Loading new story'))
                                    ],
                                  );
                                }

                                if (storyIndex == controller.nbrStories - 1) {
                                  controller.onSeenLastStory(
                                      text$.value.user!.userKey!);
                                }
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextCard(
                                        text: text$,
                                        textCardDisplayType:
                                            TEXT_CARD_DISPLAY_TYPE.STORY),
                                    const SizedBox(
                                      height: 150,
                                    )
                                  ],
                                );
                              },
                              onLoading: const Text('loading'),
                            );
                          },
                          storyLength: (pageIndex) {
                            return controller.nbrStories;
                          },
                          pageLength: 1,
                          gestureItemBuilder: (context, pageIndex, storyIndex) {
                            final User user = controller.currentUser;
                            return controller.obx(
                              (state) {
                                final Rx<TextModel> text = state![storyIndex];
                                return Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                      padding: const EdgeInsets.only(top: 56),
                                      child: StoryUserInfoHeader(
                                          text: text, user: user)
                                      // IconButton(
                                      //   padding: EdgeInsets.zero,
                                      //   color: context.theme.colorScheme.secondary,
                                      //   icon: const Icon(Icons.close),
                                      //   onPressed: () {
                                      //     Navigator.pop(context);
                                      //   },
                                      // ),
                                      ),
                                );
                              },
                              onLoading: const Text('loading'),
                            );
                          },
                          bottomGestureBuilder: (context, pageIndex, storyIndex,
                              animationController, onTapLike) {
                            return controller.obx(
                              (state) {
                                final Rx<TextModel> text$ = state![storyIndex];
                                debugPrint(
                                    "building text s ${text$.value.textKey}");
                                if (text$.value.textKey == null) {
                                  return Center(child: Container());
                                }
                                return GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      color: Colors.transparent,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 32,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          comment(text$, context),
                                          LikeButton(
                                              hasCircle: true,
                                              color:
                                                  IrisColor.lighterPrimaryColor,
                                              height: 40, // kIconSize * 1.5,
                                              text$: text$,
                                              onPressed: (reaction) =>
                                                  controller
                                                      .reactToPost(storyIndex)),
                                          InkWell(
                                              onTap: () {
                                                animationController.stop();
                                                //s onClickItem(text$, context);
                                              },
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    color: context
                                                        .theme.backgroundColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Icon(
                                                  UniconsLine.location_arrow,
                                                  size: kIconSize,
                                                  color: context.theme
                                                      .colorScheme.secondary
                                                      .withOpacity(.8),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ));
                              },
                              onLoading: Container(),
                            );
                          }),
                      IgnorePointer(
                        child: IrisIconAnimation(
                          isLiked: controller.isReacted.value,
                          child: const Icon(
                            IrisIcon.like,
                            color: IrisColor.lighterPrimaryColor,
                            size: 40,
                          ),
                        ),
                      )
                    ],
                  )))),
      Container(
          color: context.theme.scaffoldBackgroundColor,
          // height: context.mediaQueryPadding.bottom - 15, // this is causing error on Android
          height: context.mediaQueryPadding.bottom > 15
              ? context.mediaQueryPadding.bottom - 15
              : 0),
    ]);
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
