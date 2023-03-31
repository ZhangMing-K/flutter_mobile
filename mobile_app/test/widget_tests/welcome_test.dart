import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:iris_mobile/app/modules/feed/bindings/feed_binding.dart';
import 'package:iris_mobile/app/modules/feed/feed.dart';
import 'package:iris_mobile/app/modules/splashscreen/bindings/splashscreen_binding.dart';
import 'package:iris_mobile/app/modules/splashscreen/middleware/splashscreen_middleware.dart';
import 'package:iris_mobile/app/modules/splashscreen/views/splashscreen_view.dart';
import 'package:iris_mobile/app/modules/welcome/welcome.dart';
import 'package:iris_mobile/app/routes/pages.dart';

void main() {
  Future<void> loadMockDependencies() async {
    Get.put<ISecureStorage>(SecureStorageMock());
    Get.put<IStorage>(StorageMock(secure: Get.find()));
    final authUser = Get.put<IAuthUserService>(
        AuthUserService(prefs: Get.find(), irisEvent: Get.find()));
    await authUser.init();
  }

  setUpAll(loadMockDependencies);
  testWidgets(
      "Open splashscreen, try open the onboading video and skip the video if it doesn't start playing in 3 seconds",
      (tester) async {
    await tester.pumpWidget(GetMaterialApp(
      initialRoute: Paths.SplashScreen,
      getPages: [
        GetPage(
          name: Paths.SplashScreen,
          page: () => const SplashScreenView(),
          bindings: [SplashScreenBinding()],
          middlewares: [
            SplashScreenMiddleware(),
          ],
        ),
        GetPage(
          name: Paths.Feed,
          page: () => const FeedScreen(),
          bindings: [
            // ExplorerBinding(),
            FeedBinding(),

            // AssetViewBinding()
          ],
          transition: Transition.noTransition,
          transitionDuration: const Duration(milliseconds: 0),
        ),
        GetPage(
          name: Paths.Welcome.createPath([':auto']),
          page: () => const WelcomeScreen(),
          //  fullscreenDialog: true,
        ),
      ],
    ));

    await tester.pumpAndSettle();
    expect(find.byType(SplashScreenView), findsOneWidget);
    // await tester.pumpAndSettle(const Duration(seconds: 3));
    // expect(find.byType(WelcomeScreen), findsOneWidget);
  });
}
