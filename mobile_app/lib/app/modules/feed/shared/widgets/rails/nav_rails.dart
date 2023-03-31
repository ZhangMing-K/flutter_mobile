import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../../../../routes/pages.dart';

const _denseRailSize = 56.0;
const _desktopBreakpoint = 1440.0;
const _drawerWidth = 270.0;
const _minHeight = 400.0;
const _railSize = 72.0;
const _tabletBreakpoint = 720.0;

class NavRail extends StatelessWidget {
  final FloatingActionButton? floatingActionButton;
  // final int currentIndex;
  final Widget? body;
  final Widget? title;
  final Widget? leading;
  //final ValueChanged<int> onTap;
  // final List<BottomNavigationBarItem> tabs;
  final WidgetBuilder? drawerHeaderBuilder, drawerFooterBuilder;
  final Color? bottomNavigationBarColor;
  final double tabletBreakpoint, desktopBreakpoint, minHeight, drawerWidth;
  final List<Widget>? actions;
  final BottomNavigationBarType bottomNavigationBarType;
  final Color? bottomNavigationBarSelectedColor,
      bottomNavigationBarUnselectedColor;
  final bool isDense;
  final bool hideTitleBar;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final ValueSetter<int>? onActiveMenuItemPressed;
  final PreferredSizeWidget? appbar;
  final EdgeInsetsGeometry padding;

  final Map<int, String> navMap = {
    0: Paths.Feed,
    1: Paths.Search,
    2: Paths.Inbox,
    3: Paths.Profile,
  };

  NavRail({
    Key? key,
    //required this.currentIndex,
    //required this.tabs,
    // required this.onTap,
    this.scaffoldKey,
    this.actions,
    this.onActiveMenuItemPressed,
    this.isDense = false,
    this.padding = EdgeInsets.zero,
    this.floatingActionButton,
    this.drawerFooterBuilder,
    this.drawerHeaderBuilder,
    this.body,
    this.leading,
    this.appbar,
    this.title,
    this.bottomNavigationBarColor,
    this.tabletBreakpoint = _tabletBreakpoint,
    this.desktopBreakpoint = _desktopBreakpoint,
    this.drawerWidth = _drawerWidth,
    this.bottomNavigationBarType = BottomNavigationBarType.fixed,
    this.bottomNavigationBarSelectedColor,
    this.bottomNavigationBarUnselectedColor,
    this.minHeight = _minHeight,
    this.hideTitleBar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Directionality(
        textDirection: Directionality.of(context),
        child: context.responsiveValue(
          //desktop: desktop(),
          desktop: tablet(),
          tablet: tablet(),
          mobile: mobile(),
        )!,
      ),
    );
  }

  Widget buildRail(BuildContext context, bool extended) {
    final IAuthUserService authUserStore = Get.find();

    final currentRoute = ModalRoute.of(context)!.settings.name!;
    var currentRouteIndex = getRouteIndex(currentRoute);
    currentRouteIndex ??= 0;

    return NavigationRail(
      extended: extended,

      //unselectedItemColor: context.theme.colorScheme.secondary.withOpacity(.8),
      backgroundColor: Colors.transparent,

      minWidth: isDense ? _denseRailSize : _railSize,
      selectedIconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.secondary,
      ),
      selectedLabelTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
      ),
      unselectedIconTheme: const IconThemeData(
        color: Colors.grey,
      ),
      labelType: extended ? null : NavigationRailLabelType.all,
      selectedIndex: currentRouteIndex,
      onDestinationSelected: (_) {
        final newRoute = navMap[_];
        if (newRoute == currentRoute) {
          onActiveMenuItemPressed?.call(_);
        } else {
          /// This prevents opening new instances of the feed. This approach is common in all major social networks that exist.
          if (IrisStackObserver.stack
              .any((route) => route.settings.name == newRoute)) {
            Get.until((route) => route.settings.name == newRoute);
          } else {
            Get.toNamed(newRoute!);
          }
        }
      },
      destinations: [
        NavigationRailDestination(
          icon: const Icon(
            UniconsLine.home,
            size: 20,
          ),
          label: _title('Home'),
        ),
        NavigationRailDestination(
          icon: const Icon(
            UniconsLine.search,
            size: 20,
          ),
          label: _title('Explorer'),
        ),
        NavigationRailDestination(
          icon: const Icon(
            UniconsLine.user,
            size: 20,
          ),
          label: _title('Profile'),
        ),
      ],
    );
  }

  Widget desktop() {
    return Builder(builder: (context) {
      return Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: _drawerWidth,
              child: _buildDrawer(
                  context, true), // true make the sidebar to expands
            ),
            Expanded(
              child: Scaffold(
                key: scaffoldKey,
                resizeToAvoidBottomInset: false,
                floatingActionButton: floatingActionButton,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.startTop,
                appBar: hideTitleBar
                    ? null
                    : appbar ??
                        AppBar(
                          title: title,
                          shape: RoundedRectangleBorder(
                            borderRadius: kBorderRadius.copyWith(
                              topLeft: Radius.zero,
                              bottomLeft: Radius.zero,
                            ),
                          ),
                          actions: actions,
                          leading: leading,
                          backgroundColor: context.theme.backgroundColor,
                          automaticallyImplyLeading: false,
                        ),
                body: body,
              ),
            ),
          ],
        ),
      );
    });
  }

  int? getRouteIndex(String route) {
    int? index;
    route = route.replaceAll(RegExp(r'[0-9]'), ''); // remove all string numbers
    navMap.forEach((int key, String value) {
      if (value == route) {
        index = key;
      }
    });
    if (route == Paths.MessageCollection) {
      return 2;
    }
    return index;
  }

  Widget mobile() {
    return Builder(builder: (context) {
      return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: hideTitleBar
            ? null
            : appbar ??
                AppBar(
                  title: title,
                  actions: actions,
                  leading: leading,
                  shape: const RoundedRectangleBorder(
                    borderRadius: kBorderRadius,
                  ),
                  backgroundColor: context.theme.backgroundColor,
                  automaticallyImplyLeading: true,
                ),
        drawer: drawerHeaderBuilder != null || drawerFooterBuilder != null
            ? _buildDrawer(context, false)
            : null,
        body: body,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: BottomNavbar(
          isGoldMode: false,
          onActiveMenuItemPressed: onActiveMenuItemPressed,
        ),
      );
    });
  }

  Widget tablet() {
    return Builder(builder: (context) {
      return Scaffold(
        key: scaffoldKey,
        appBar: hideTitleBar
            ? null
            : appbar ??
                AppBar(
                  title: title,
                  actions: actions,
                  leading: leading,
                  shape: const RoundedRectangleBorder(
                    borderRadius: kBorderRadius,
                  ),
                  backgroundColor: context.theme.backgroundColor,
                  automaticallyImplyLeading: true,
                ),
        drawer: drawerHeaderBuilder != null || drawerFooterBuilder != null
            ? _buildDrawer(context, false)
            : null,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: Row(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: kBorderRadius,
                  color: context.theme.backgroundColor,
                ),
                child: buildRail(context, false)),
            Expanded(child: body ?? Container()),
          ],
        ),
      );
    });
  }

  Widget _buildDrawer(BuildContext context, bool showTabs) {
    return Drawer(
      child: Center(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              // borderRadius: kBorderRadius,
              color: context.theme.backgroundColor,
            ),
            child: Column(
              children: <Widget>[
                if (drawerHeaderBuilder != null) drawerHeaderBuilder!(context),
                if (showTabs) ...[
                  Expanded(child: buildRail(context, true)),
                ],
                if (drawerFooterBuilder != null) drawerFooterBuilder!(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
