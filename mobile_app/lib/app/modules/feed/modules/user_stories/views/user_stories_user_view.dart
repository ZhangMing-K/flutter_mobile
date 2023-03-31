import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/feed/modules/user_stories/controllers/user_stories_you_controller.dart';
import 'package:iris_mobile/app/modules/feed/modules/user_stories/views/dotted_border.dart';
import 'package:iris_mobile/app/modules/feed/modules/user_stories/views/empty_user_stories_header.dart';

import '../controllers/user_stories_user_controller.dart';

const _circularSize = 74.0;

class UserStoriesUserView extends GetView<UserStoriesUserController> {
  const UserStoriesUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        return SizedBox(
            height: 112,
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              addAutomaticKeepAlives: false,
              itemCount: controller.state!.length + 1,
              scrollDirection: Axis.horizontal,
              controller: controller.scrollController,
              itemBuilder: (context, index) {
                final User user =
                    index > 0 ? state![index - 1].value : const User();
                return Row(
                  children: [
                    if (index > 0)
                      _StoryItem(user: user, index: index - 1)
                    else
                      const _YourRankStoryItem(),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                );
              },
            ));
      },
      onEmpty: const EmptyUserStoriesHeader(),
      onLoading: const IrisLoading(),
    );
  }

  String name(int index) {
    User user = controller.state![index].value;
    if (user.username != null) {
      return user.username!;
    } else if (user.firstName != null) {
      return user.firstName!;
    }

    return '';
  }
}

class _StoryItem extends GetView<UserStoriesUserController> {
  const _StoryItem({
    Key? key,
    required this.user,
    required this.index,
  }) : super(key: key);

  final User user;
  final int index;

  @override
  Widget build(BuildContext context) {
    final id = uuid.v4();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
            height: _circularSize,
            width: _circularSize,
            child: Hero(
              tag: id,
              child: UserImage(
                radius: 35,
                user: user,
                hasHero: false,
                shouldResize: false,
                onTap: () {
                  controller.goToUserStory(index, id);
                },
              ),
            )),
        SizedBox(
          height: 20,
          width: _circularSize,
          child: Center(
              child: UserName(
            user: user,
            fontSize: 12,
            usernameOverFullName: true,
            maxLength: 10,
            shouldResize: false,
            showBadge: false,
            heroTag: uuid.v4(),
          )),
        ),
        DailyPercentGainView(percentGain: user.dailyPercentGain)
      ],
    );
  }
}

class _YourRankStoryItem extends GetView<UserStoriesYouController> {
  const _YourRankStoryItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      double? percentGain = state?.value.dailyPercentGain;
      return Row(
        children: [
          const SizedBox(width: 12),
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              //TODO: COME BACK
              Get.toNamed(Paths.Feed + Paths.Home + Paths.Profile, id: 1);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox(
                    height: _circularSize,
                    width: _circularSize,
                    child: DottedBorder(
                      color: percentGain != null && percentGain > 0
                          ? IrisColor.positiveChange
                          : percentGain == null || percentGain == 0
                              ? context.isDarkMode
                                  ? IrisColor.irisGrey
                                  : context.theme.colorScheme.secondary
                                      .withOpacity(0.6)
                              : IrisColor.negativeChange,
                      borderType: BorderType.Circle,
                      child: UserImage(
                        radius: 35,
                        user: controller.state!.value,
                        shouldResize: false,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: 20,
                    child: Row(
                      children: [
                        RichText(
                          textScaleFactor: 1,
                          text: TextSpan(
                            children: <InlineSpan>[
                              TextSpan(
                                text: 'You',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: IrisScreenUtil.dFontSize(12),
                                    color: context.theme.colorScheme.secondary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                DailyPercentGainView(percentGain: percentGain)
              ],
            ),
          )
        ],
      );
    },
        onLoading: Row(
          children: [
            const SizedBox(width: 12),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox(
                      height: _circularSize,
                      width: _circularSize,
                      child: DottedBorder(
                        color: context.isDarkMode
                            ? IrisColor.irisGrey
                            : context.theme.colorScheme.secondary
                                .withOpacity(0.6),
                        borderType: BorderType.Circle,
                        child: UserImage(
                            radius: 35,
                            user: controller.state?.value ?? const User(),
                            shouldResize: false),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 20,
                      child: Row(
                        children: [
                          RichText(
                            textScaleFactor: 1,
                            text: TextSpan(
                              children: <InlineSpan>[
                                TextSpan(
                                  text: 'You',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: IrisScreenUtil.dFontSize(12),
                                      color:
                                          context.theme.colorScheme.secondary),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            )
          ],
        ));
  }
}
