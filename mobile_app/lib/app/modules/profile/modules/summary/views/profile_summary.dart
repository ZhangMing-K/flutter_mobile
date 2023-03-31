import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iris_common/shared/widgets/iris_buttons.dart';
import 'package:iris_mobile/app/modules/profile/modules/summary/views/widgets/bio.dart';
import 'package:iris_mobile/app/modules/profile/modules/summary/views/widgets/bio_footer.dart';
import 'package:iris_mobile/app/modules/profile/modules/summary/views/widgets/mutual_followers.dart';
import 'package:iris_mobile/app/modules/profile/modules/summary/views/widgets/profile_summary_header.dart';
import 'package:iris_mobile/app/modules/profile/modules/summary/views/widgets/trader_stats.dart';
import 'package:iris_mobile/app/routes/pages.dart';

import '../notifiers/profile_summary_notifier.dart';

class ProfileSummary extends StatelessWidget {
  const ProfileSummary({
    Key? key,
    required this.onEdit,
    required this.controller,
  }) : super(key: key);
  final VoidCallback onEdit;
  final ProfileSummaryController controller;

  void askForUserNotifications({required User user}) {
    Get.dialog(CupertinoAlertDialog(
      title: Text('Want to get notified when ${user.firstName} makes a trade?'),
      content: const Text(
          'Turn on trade and post notifications to know exactly when and what they trade.'),
      actions: [
        CupertinoDialogAction(
          child: const Text('Not now'),
          onPressed: () {
            Get.back();
          },
        ),
        CupertinoDialogAction(
          child: const Text('Turn on'),
          onPressed: () async {
            //TODO connect to a controller, once they are done
            // await controller.changeUserNotifications(
            //   postNotificationAmount: USER_POST_NOTIFICATION_AMOUNT.ALL,
            //   tradeNotificationAmount: USER_TRADE_NOTIFICATION_AMOUNT.ALL,
            // );
            Get.back();
          },
        ),
      ],
    ));
  }

  Widget authUserButtons() {
    return Builder(
      builder: (BuildContext context) {
        return Row(
          children: [
            Expanded(
              child: AppButtonV2(
                color: context.theme.colorScheme.secondary,
                onPressed: onEdit,
                height: 35,
                width: double.infinity,
                buttonType: APP_BUTTON_TYPE.OUTLINE,
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                      fontSize: 13, color: context.theme.colorScheme.secondary),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: InviteLinkButton(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return controller.obx(onLoading: const IrisLoading(), (state) {
      final user = state!.value;
      return Container(
        color: context.theme.scaffoldBackgroundColor,
        width: double.infinity,
        padding: const EdgeInsets.only(left: 2, right: 2, bottom: 20, top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileSummaryHeader(controller: controller),
            AnimatedCrossFade(
              //TODO connect to a controller, once they are done
              // crossFadeState: controller.profileSummaryController.status.isLoading
              //     ? CrossFadeState.showFirst
              //     : CrossFadeState.showSecond,
              crossFadeState: CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
              firstChild: const SizedBox(
                height: 200,
                child: Center(
                  child: IrisLoading(
                    size: 50,
                  ),
                ),
              ),
              secondChild: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  suspended(user: user),
                  Bio(user: user),
                  BioFooter(user: user),
                  TraderStats(user: user),
                  if (user.mutualFollowedBy != null &&
                      user.authUserFollowInfo?.followStatus ==
                          FOLLOW_STATUS.NOT_FOLLOWING)
                    MutualFollowers(
                      mutual: user.mutualFollowedBy!,
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  buttonsRow(user$: state)
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget buttonsRow({required Rx<User> user$}) {
    final user = user$.value;
    return user.authUserFollowInfo?.followStatus == FOLLOW_STATUS.ME
        ? authUserButtons()
        : Row(
            children: [
              Expanded(
                child: IrisFollowButton(
                  height: 44,
                  //TODO use real data from a controller
                  user$: user.obs,
                  followingAction: FOLLOWING_ACTION.OPTIONS,
                  onFollow: (fr) {
                    askForUserNotifications(user: user);
                  },
                ),
              ),
              const SizedBox(width: 8),
              if (user.userPrivacyType == USER_PRIVACY_TYPE.PUBLIC ||
                  user.authUserFollowInfo?.followStatus ==
                      FOLLOW_STATUS.APPROVED)
                IrisFollowButton(
                  height: 44,
                  width: 44,
                  //TODO use real data from a controller
                  user$: user$,
                  followingAction: FOLLOWING_ACTION.MESSAGE,
                ),
              const SizedBox(width: 8),
              IrisButton.autopilot(),
            ],
          );
  }

  Widget suspended({required User user}) {
    return Visibility(
      visible:
          //TODO connect to a controller, once they are done
          user.suspendedAt != null &&
              controller.authUserStore.loggedUser!.userAccessType ==
                  USER_ACCESS_TYPE.ADMIN,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: const Text(
          'SUSPENDED',
          style: TextStyle(
              fontWeight: FontWeight.w600, color: IrisColor.sellColor),
        ),
      ),
    );
  }
}
