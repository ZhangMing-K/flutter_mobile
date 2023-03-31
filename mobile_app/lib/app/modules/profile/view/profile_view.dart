import 'package:flutter/cupertino.dart' hide NestedScrollView;
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/profile/controllers/profile_controller.dart';
import 'package:iris_mobile/app/routes/pages.dart';
import 'package:unicons/unicons.dart';

import '../modules/performance/views/performance.dart';
import '../modules/posts/views/profile_posts_view.dart';
import '../modules/summary/views/profile_summary.dart';
import 'widgets/blocked_user.dart';

class ProfileView extends GetWidget<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  void openNotificationsSettings() {
    Get.bottomSheet(
      IrisBottomSheetSingleScroll(
        initialChildSize: .4,
        maxChildSize: .4,
        child: Builder(builder: (context) {
          return Obx(() {
            final authUserUser =
                controller.profileSummaryController.state!.value.authUserUser;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Notifications',
                  style: TextStyle(
                      color: context.theme.colorScheme.secondary, fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                CupertinoFormRow(
                    prefix: Text(
                      'Trade notifications',
                      style: TextStyle(
                        color: context.theme.colorScheme.secondary,
                      ),
                    ),
                    child: CupertinoSwitch(
                      activeColor: IrisColor.irisBlueLight,
                      value: authUserUser?.tradeNotificationAmount ==
                          USER_TRADE_NOTIFICATION_AMOUNT.ALL,
                      onChanged: (bool value) {
                        controller.onTradeNotificationClicked(value);
                      },
                    )),
                CupertinoFormRow(
                    prefix: Text(
                      'Post notifications',
                      style: TextStyle(
                        color: context.theme.colorScheme.secondary,
                      ),
                    ),
                    child: CupertinoSwitch(
                      activeColor: IrisColor.irisBlueLight,
                      value: authUserUser?.postNotificationAmount ==
                          USER_POST_NOTIFICATION_AMOUNT.ALL,
                      onChanged: (bool value) {
                        controller.onPostNotificationClicked(value);
                      },
                    )),
              ],
            );
          });
        }),
      ),
      enableDrag: true,
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: controller.profileSummaryController.obx(
          onLoading: const IrisLoading(),
          (state) {
            return Obx(() {
              final userIsBlocked =
                  state?.value.authUserRelation?.blockedAt != null;

              if (userIsBlocked) {
                return SizedBox(
                  width: double.infinity,
                  child: Center(child: BlockedUser(
                    onPressed: () {
                      controller.unBlockUser(block: false);
                    },
                  )),
                );
              }
              return Builder(builder: (context) {
                return IrisTabView.expanded(
                  backgroundColor: context.theme.scaffoldBackgroundColor,
                  actions: [
                    // if (!isLoading)
                    Obx(() {
                      final isFollowing =
                          state?.value.authUserFollowInfo?.followStatus ==
                              FOLLOW_STATUS.APPROVED;

                      final hasTradeNotifications =
                          state?.value.authUserUser?.tradeNotificationAmount ==
                              USER_TRADE_NOTIFICATION_AMOUNT.ALL;
                      final hasPostNotifications =
                          state?.value.authUserUser?.postNotificationAmount ==
                              USER_POST_NOTIFICATION_AMOUNT.ALL;

                      if (!isFollowing) {
                        return const SizedBox.shrink();
                      } else {
                        final isNotificationsActive =
                            hasTradeNotifications || hasPostNotifications;
                        return IconButton(
                          onPressed: openNotificationsSettings,
                          icon: isNotificationsActive
                              ? const Icon(
                                  Icons.notifications,
                                  color: IrisColor.irisBlueLight,
                                )
                              : const Icon(FeatherIcons.bell),
                        );
                      }
                    }),
                    if (controller.isAuthUser)
                      const IconButton(
                        onPressed: openSettingsPanel,
                        icon: Icon(UniconsLine.bars),
                      )
                    else
                      IconButton(
                        onPressed: controller.openSettingsPannel,
                        icon: const Icon(UniconsLine.ellipsis_h),
                      ),
                    const SizedBox(width: 4)
                  ],
                  showBackButton: !controller.isAuthUser,
                  horizontalPadding: !controller.isAuthUser ? 0.0 : 16.0,
                  tabs: [
                    IrisTab(
                      text: '',
                      body: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: NestedScrollView(
                            headerSliverBuilder: (context, _) {
                              return [
                                SliverOverlapAbsorber(
                                  handle: NestedScrollView
                                      .sliverOverlapAbsorberHandleFor(context),
                                  sliver: SliverToBoxAdapter(
                                    child: Container(
                                      color:
                                          context.theme.scaffoldBackgroundColor,
                                      padding: const EdgeInsets.all(8),
                                      child: ProfileSummary(
                                        onEdit: controller.goToEditPage,
                                        controller:
                                            controller.profileSummaryController,
                                      ),
                                    ),
                                  ),
                                ),
                              ];
                            },
                            body: IrisTabView.expanded(
                              backgroundColor:
                                  context.theme.scaffoldBackgroundColor,
                              onTabChange: controller.onTabChange,
                              horizontalPadding: 8,
                              tabs: [
                                IrisTab(
                                  text: 'Performance',
                                  body: Performance(
                                    user$: state!,
                                    controller: controller,
                                  ),
                                ),
                                IrisTab(
                                  text: 'Feed',
                                  body: ProfilePostsView(
                                    controller:
                                        controller.profilePostsController,
                                  ),
                                )
                              ],
                              //  indicatorColor: context.theme.colorScheme.secondary,
                            ),
                          )),
                    ),
                  ],
                );
              });
            });
          },
        ),
      ),
    );
  }
}
