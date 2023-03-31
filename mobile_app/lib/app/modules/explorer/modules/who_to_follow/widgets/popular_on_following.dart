import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/widgets/iris_buttons.dart';

import '../../../../feed/shared/widgets/button_overlay/button_overlay.dart';
import '../controllers/who_to_follow_controller.dart';

class PopularOnFollowing extends GetView<WhoToFollowController> {
  const PopularOnFollowing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Obx(() {
        return ListView.builder(
          shrinkWrap: true,
          addAutomaticKeepAlives: false,
          primary: false,
          itemCount: controller.recommendedList.value.items?.length ?? 0,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final followSuggestion =
                controller.recommendedList.value.items?[index].followSuggestion;
            return SizedBox(
              width: context.width,
              child: IrisCarrousel(followSuggestion: followSuggestion!),
            );
            // return IrisCarrousel(followSuggestion: followSuggestion!);
          },
        );
      }),
    );
  }
}

class FollowingPopularCard extends GetView<WhoToFollowController> {
  const FollowingPopularCard({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        user.routeToProfile();
        controller.saveUserToRecent(user);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: kBorderRadius,
          color: context.theme.backgroundColor,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(10),
        height: 168,
        width: 192,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserImage(
              radius: 33,
              user: user,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              user.fullName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            FollowingAvatars(
                avatars: user.mutualFollowedBy!.users!
                    .map((user) => user.profilePictureUrl!)
                    .toList(),
                total: user.mutualFollowedBy!.total!),
            Row(
              children: [
                Expanded(
                  child: IrisFollowButton(
                    user$: user.obs,
                    followingAction: FOLLOWING_ACTION.VIEW_PROFILE,
                    customAction: () {
                      controller.saveUserToRecent(user);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FollowingAvatars extends StatelessWidget {
  const FollowingAvatars({Key? key, required this.avatars, required this.total})
      : super(key: key);
  final List<String> avatars;
  final int total;

  String get text {
    if (total == 4) {
      return '+1 other';
    } else if (total > 4) {
      return '+${total - 3} others';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AvatarsOverlay(
          avatars: avatars.take(3).toList(),
        ),
        const SizedBox(
          width: 6,
        ),
        Text(text),
      ],
    );
  }
}
