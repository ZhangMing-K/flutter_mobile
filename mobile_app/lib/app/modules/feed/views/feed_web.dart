import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/feed_controller.dart';
import '../modules/posts/views/posts_new.dart';
import '../shared/widgets/create_post_placeholder/create_post_placeholder.dart';
import '../shared/widgets/rails/nav_rails.dart';

class Banners extends StatelessWidget {
  const Banners({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        borderRadius: kBorderRadius,
        color: context.theme.backgroundColor,
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: kBorderRadius,
              color: context.theme.primaryColor,
            ),
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: kBorderRadius,
                    color: IrisColor.irisBlue,
                  ),
                  child: const Center(
                    child: Text(
                      'Invest in Iris!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Center(
                    child: Text(
                      'Own a piece of Iris with a minimal investment.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      elevation: 0,
                    ),
                    onPressed: () {
                      UrlUtils.open('https://republic.co/iris');
                    },
                    child: const Text('Read More'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FeedWebView extends GetView<FeedController> {
  const FeedWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavRail(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      title: SizedBox(
        height: 40,
        child: Row(
          children: [
            Image.asset(Images.irisWhiteLogo),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            children: const [
              //  LeaderboardBar(),
              NotificationBell(
                nbrUnseenNotifications: null,
                // onTap: () {},
                isActive: false,
              ),
            ],
          ),
        )
      ],
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        // padding: EdgeInsets.symmetric(horizontal: context.width / 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              color: context.theme.scaffoldBackgroundColor,
              constraints: const BoxConstraints(maxWidth: 700),
              child: IrisTabView.expanded(
                borderRadius: kBorderRadius,
                keyboardHidesTabbar: false,
                backgroundColor: context.theme.backgroundColor,
                actions: const [],
                onTabChange: (index) {
                  controller.onTabChange(index);
                },
                tabController: controller.tabController,
                header: Container(),
                tabs: [
                  // IrisTab(
                  //   text: 'For You',
                  //   body: PostsForYouView(
                  //     header: Obx(
                  //       () => CreatePostPlaceholder(
                  //         onSubmit: controller.onSubmit,
                  //         avatarUrl: controller.authUserStore.loggedUser
                  //                 ?.profilePictureUrl ??
                  //             '',
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  IrisTab(
                    text: 'New',
                    redDot: controller.newPostsController.redDot.value,
                    body: PostsNewView(
                      header: Obx(
                        () => CreatePostPlaceholder(
                          onSubmit: controller.onSubmit,
                          avatarUrl: controller.authUserStore.loggedUser
                                  ?.profilePictureUrl ??
                              '',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            context.responsiveValue(
              desktop: const Banners(),
              tablet: const SizedBox.shrink(),
              mobile: const SizedBox.shrink(),
            )!,
          ],
        ),
      ),
    );
  }
}
