import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';

import 'app_controller.dart';
import 'routes/pages.dart';
import 'shared/utils/analytics_observer.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(builder: (controller) {
      return GetMaterialApp(
        title: 'Iris',
        //builder: DevicePreview.appBuilder,
        //  themeMode: controller.themeMode,
        darkTheme: IrisTheme.darkful(),
        theme: IrisTheme.light(),
        themeMode: ThemeMode.system,
        transitionDuration: kRouteTransition,
        // locale: DevicePreview.locale(context),
        defaultTransition: Transition.cupertino,
        popGesture: true, //dont know what this does?
        getPages: Routes.pages,
        supportedLocales: const [
          Locale('en', ''),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          FormBuilderLocalizations.delegate,
        ],
        initialRoute: Routes.initial,
        builder: (context, widget) {
          ScreenUtil.init(
            context,
            designSize: const Size(kDefaultScreenWidth, kDefaultScreenHeight),
          );
          return KeyboardListenerWrapper(
            child: widget ?? const Material(),
          );
        },
        navigatorObservers: [
          if (ENV.POSTHOG_API_KEY != null) UserNavigationObserver(),
          IrisFirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
          IrisStackObserver(),
        ],

        debugShowCheckedModeBanner: false,
      );
    });
  }
}
