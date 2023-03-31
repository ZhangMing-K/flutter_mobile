import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../../routes/pages.dart';
import '../controllers/feed_controller.dart';

class FeedMobileView extends GetView<FeedController> {
  const FeedMobileView({Key? key}) : super(key: key);
  GetPage get unknownRoute =>
      GetPage(name: '/404', page: () => const Scaffold());

  Route<dynamic> generator(RouteSettings settings) {
    return PageRedirect(settings: settings, unknownRoute: unknownRoute).page();
  }

  List<Route<dynamic>> initialRoutesGenerate(state, String name) {
    return [
      PageRedirect(
        settings: RouteSettings(name: name),
        unknownRoute: unknownRoute,
      ).page()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return Navigator(
          // reportsRouteUpdateToEngine: true,
          restorationScopeId: 'home',
          observers: [
            GetObserver(null, Get.routing),
            IrisStackObserver(),
            HeroController(),
          ],
          initialRoute: Paths.Feed + Paths.Home,
          key: controller.innerKey,
          onGenerateRoute: generator,
          onGenerateInitialRoutes: initialRoutesGenerate,
        );
      }),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade500, width: 0.0),
          ),
        ),
        child: BottomNavbar(
          isGoldMode: false,
          // getDelegate: Get.nestedKey(Paths.Feed),
          onActiveMenuItemPressed: (index) =>
              controller.scrollToTopOrBackOneTab(index),
        ),
      ),
    );
  }
}
