import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../../widgets_v2/material_floating_search_app_bar/material_floating_search_bar.dart';
import 'controllers/profile_search_controller.dart';
import 'modules/followers/views/followers_view.dart';
import 'modules/following/views/following_view.dart';

class ProfileSearchScreen extends GetWidget<ProfileSearchController> {
  const ProfileSearchScreen({Key? key}) : super(key: key);

  Widget appBar(BuildContext context) {
    return FloatingSearchAppBar(
      height: 50,
      transitionDuration: const Duration(milliseconds: 100),
      color: context.theme.appBarTheme.backgroundColor,
      shadowColor: Colors.white,
      iconColor: context.theme.backgroundColor,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
      automaticallyImplyDrawerHamburger: false,
      automaticallyImplyBackButton: false,
      showBack: true,
      hideKeyboardOnDownScroll: true,
      padding: const EdgeInsets.only(right: 4, bottom: 0, top: 0),
      titleStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
      clearQueryOnClose: false,
      onQueryChanged: controller.onQueryChanged,
      debounceDelay: const Duration(milliseconds: 200),
      body: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      title: 'Search',
      appBarBackButton: true,
      resizeToAvoidBottomInset: false,
      appBarType: APP_BAR_TYPE.NONE,
      onActiveMenuItemPressed: (_) {
        controller.scrollToTop();
      },
      child: NestedScrollView(
        controller: controller.scrollController,
        headerSliverBuilder: (context, _) {
          return [
            SliverToBoxAdapter(child: appBar(context)),
          ];
        },
        body: Obx(() {
          return IrisTabView(
            tabs: [
              IrisTab(
                  text: 'Followers',
                  body: FollowersView(
                      onUpdate: controller.onUpdate,
                      controller: controller.followersController),
                  upperText: controller.followersController.profileUser.value
                      ?.followStats?.numberOfFollowers
                      ?.compactNumber()),
              IrisTab(
                  text: 'Following',
                  body: FollowingView(
                      onUpdate: controller.onUpdate,
                      controller: controller.followingController),
                  upperText: controller.followingController.profileUser.value
                      ?.followStats?.numberFollowing
                      ?.compactNumber()),
            ],
            onTabChange: (int index) {
              final String val = controller.searchVal!;
              controller.onTabChange(index, val);
            },
            initialIndex: controller.selectedTab,
            indicatorColor: context.theme.colorScheme.secondary.withOpacity(.8),
          );
        }),
      ),
    );
  }
}
