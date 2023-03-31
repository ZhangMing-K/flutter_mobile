import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:unicons/unicons.dart';

const _nonBottomSheetsRoutes = [
  Paths.Text,
  Paths.Feed + Paths.Home + Paths.Inbox,
  Paths.Feed + Paths.Home + Paths.MessageCollection,
  Paths.GroupDetails,
];

const Map<int, String> navMap = {
  0: Paths.Feed + Paths.Home,
  1: Paths.Feed + Paths.Explore,
  2: Paths.Feed + Paths.AutoPilotNav,
  3: Paths.Feed + Paths.Notifications,
  4: Paths.Feed + Paths.MyProfile,
};

const double _tabBarHeight = 50.0;

const String _showIndicator = 'showIndicator';

class BottomNavBarController extends GetxController {
  BottomNavBarController({required this.authUserStore, required this.storage});
  final IAuthUserService authUserStore;
  final ISecureStorage storage;

  @override
  void onInit() {
    getIndicator();
    IrisStackObserver.stackChange.listen((event) {
      final routeName = event.newRoute?.settings.name;
      if (routeName != null) {
        canShowBottomBar(routeName);
      }
    });
    super.onInit();
  }

  void canShowBottomBar(String route) {
    final hideBottomBar =
        _nonBottomSheetsRoutes.any((element) => route.startsWith(element));
    if (hideBottomBar) {
      isVisible = false;
    } else {
      isVisible = true;
    }
    update();
  }

  final showIndicator = false.obs;

  Future<void> getIndicator() async {
    final canNotShow = await storage.read(key: _showIndicator);

    if (canNotShow == null) {
      showIndicator.value = true;
    } else {
      showIndicator.value = false;
    }
  }

  Future<void> markShow() async {
    final canNotShow = await storage.read(key: _showIndicator);
    if (canNotShow != null) return;
    await storage.write(key: _showIndicator, value: 'true');
    getIndicator();
  }

  bool isVisible = true;

  void onTap(int index, BuildContext context,
      ValueSetter<int>? onActiveMenuItemPressed) {
    final currentRoute = Get.currentRoute;
    if (index == 2 && showIndicator.isTrue) {
      markShow();
    }
    final newRoute = navMap[index];
    if (newRoute == currentRoute) {
      onActiveMenuItemPressed?.call(index);
    } else {
      if (IrisStackObserver.stack.any((route) {
        return route.settings.name == newRoute;
      })) {
        Get.until((route) => route.settings.name == newRoute, id: 1);
      } else {
        Get.toNamed(newRoute!, id: 1);
      }
    }
    update();
  }

  int? getRouteIndex(String route) {
    final uri = Uri.parse(route);

    final isMyProfile = route.contains(Paths.MyProfile) ||
        (uri.queryParameters.containsKey('profileUserKey') &&
            uri.queryParameters['profileUserKey'] ==
                authUserStore.loggedUser?.userKey.toString());

    if (isMyProfile) {
      return 4;
    }
    int? index;
    route = route.replaceAll(RegExp(r'[0-9]'), ''); // remove all string numbers

    navMap.forEach((int key, String value) {
      if (value == route) {
        index = key;
      }
    });
    return index;
  }
}

class BottomNavbar extends StatelessWidget {
  final bool isGoldMode;
  final ValueSetter<int>? onActiveMenuItemPressed;
  final GetDelegate? getDelegate;

  const BottomNavbar({
    Key? key,
    this.onActiveMenuItemPressed,
    this.isGoldMode = false,
    this.getDelegate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavBarController>(builder: (controller) {
      return Builder(builder: (context) {
        final currentRoute = Get.currentRoute;
        var currentRouteIndex = controller.getRouteIndex(currentRoute) ?? 0;
        final bottomPadding = MediaQuery.of(context).padding.bottom;

        return AnimatedContainer(
          height: controller.isVisible ? _tabBarHeight + bottomPadding : 0,
          duration: const Duration(milliseconds: 270),
          child: CupertinoTabBar(
            // height: _tabBarHeight,
            border: const Border(
                top: BorderSide(
              width: 0.0,
              style: BorderStyle.none,
            )),
            inactiveColor: context.theme.colorScheme.secondary,
            currentIndex: currentRouteIndex,
            onTap: (index) {
              controller.onTap(index, context, onActiveMenuItemPressed);
            },
            backgroundColor: context.theme.bottomAppBarColor,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: _BottomBaritem(
                  showIndicator: false,
                  child: SvgPicture.asset(
                    Images.home,
                    color: context.theme.colorScheme.secondary,
                    height: 29,
                  ),
                ),
                activeIcon: _BottomBaritem(
                  showIndicator: false,
                  child: SvgPicture.asset(
                    Images.activeHome,
                    color: context.theme.colorScheme.secondary,
                    height: 29,
                  ),
                ),
                tooltip: 'Home',
              ),
              BottomNavigationBarItem(
                icon: const Icon(UniconsLine.search),
                activeIcon: SvgPicture.asset(
                  IconPath.search,
                  color: context.theme.colorScheme.secondary,
                  height: 29,
                ),
                tooltip: 'Discover',
              ),
              BottomNavigationBarItem(
                  icon: Obx(() {
                    return _BottomBaritem(
                      showIndicator: controller.showIndicator.value,
                      child: SizedBox(
                        width: 29,
                        child: Image.asset(
                          Images.autopilotIcon,
                          color: context.theme.colorScheme.secondary,
                        ),
                      ),
                    );
                  }),
                  activeIcon: Obx(() {
                    return _BottomBaritem(
                      showIndicator: controller.showIndicator.value,
                      child: SizedBox(
                          width: 29,
                          child: Image.asset(
                            Images.autopilotIcon,
                          )),
                    );
                  }),
                  tooltip: 'AutoPilot'),

              BottomNavigationBarItem(
                  icon: Obx(() {
                    return NotificationBell(
                      nbrUnseenNotifications: controller
                          .authUserStore.loggedUser?.nbrUnseenNotifications,
                      isActive: false,
                    );
                  }),
                  activeIcon: Obx(() {
                    return NotificationBell(
                      nbrUnseenNotifications: controller
                          .authUserStore.loggedUser?.nbrUnseenNotifications,
                      isActive: true,
                    );
                  }),
                  //label: 'Chats',
                  tooltip: 'Notifications'),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  IconPath.user,
                  color: context.theme.colorScheme.secondary,
                  height: 29,
                ),
                activeIcon: SvgPicture.asset(
                  IconPath.activeUser,
                  color: context.theme.colorScheme.secondary,
                  height: 29,
                ),
                // label: 'Profile',
                tooltip: 'Profile',
              ),
              // label: 'Profile',
            ],
          ),
        );
      });
    });
  }
}

class _BottomBaritem extends StatelessWidget {
  const _BottomBaritem(
      {Key? key, required this.child, required this.showIndicator})
      : super(key: key);
  final Widget child;
  final bool showIndicator;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        if (showIndicator)
          Positioned.fill(
            bottom: -12,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 7,
                width: 7,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
