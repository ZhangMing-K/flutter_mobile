import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/feed/controllers/feed_controller.dart';
import 'package:iris_mobile/app/modules/feed/modules/posts/views/following_feed_view.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/create_post_icon/create_post_icon.dart';
import 'package:unicons/unicons.dart';

//TODO: Make home screen have your own controller
class HomeScreen extends GetView<FeedController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.scaffoldBackgroundColor,
      child: Container(
        margin: EdgeInsets.zero,
        child: IrisTabView.expanded(
          keyboardHidesTabbar: false,
          backgroundColor: context.theme.scaffoldBackgroundColor,
          onTabChange: (index) {
            controller.onTabChange(index);
          },
          tabController: controller.tabController,
          header: Container(
              margin: const EdgeInsets.only(left: 12, bottom: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 73,
                      height: 41,
                      child: Image.asset(
                        Images.irisWhiteLogo,
                        color: context.theme.colorScheme.secondary,
                      )),
                  Row(
                    children: [
                      CreatePostIcon(onSubmit: controller.onSubmit),
                      const SizedBox(
                        width: 4,
                      ),
                      // NotificationBell(
                      //   nbrUnseenNotifications: controller
                      //       .authUserStore.loggedUser?.nbrUnseenNotifications,
                      //   onTap: () {
                      //     Get.toNamed(
                      //         Paths.Feed + Paths.Feed + Paths.Home +Paths.Notifications);
                      //   },
                      // ),

                      IconButton(
                        icon: Obx(() {
                          return ChatNotificationIcon(
                            icon: const Icon(UniconsLine.location_arrow),
                            nbr: controller
                                .authUserStore.loggedUser?.nbrUnreadMessages,
                          );
                        }),
                        onPressed: () {
                          Get.toNamed(
                            Paths.Feed + Paths.Home + Paths.Inbox,
                            id: 1,
                          );
                        },
                      ),
                    ],
                  )
                ],
              )),
          hideTab: true,
          tabs: [
            const IrisTab(
              text: '',
              body: FollowingFeedView(),
            ),
          ],
        ),
      ),
    );
  }
}
