import 'dart:async';

// import 'package:cryptography_flutter/cryptography_flutter.dart';
import 'package:cryptography_flutter/cryptography_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'app/app_binding.dart';
import 'app/app_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (err) {
    FlutterError.presentError(err);
    if (Get.isRegistered<IrisErrorReport>()) {
      Get.find<IrisErrorReport>().send(err);
    }
  };
  runZonedGuarded(
    () async {
      await ScreenUtil.ensureScreenSize();
      await IrisFlavorConfig.init();
      await AppBinding.registerEventsDependencies();
      await AppBinding.initServices();

      if (GetPlatform.isMobile) {
        Stripe.publishableKey = ENV.STRIPE_PUBLISHABLE_KEY!;
        Stripe.merchantIdentifier = StripeConfig.MERCHANT_NAME;
        Stripe.urlScheme = StripeConfig.URL_SCHEME;
        FlutterLibphonenumber().init();
        FlutterCryptography.enable();
        Stripe.instance.applySettings();
      }

      runApp(
        const MyApp(),
      );
    },
    (error, stack) async {
      if (!Get.isRegistered<IrisErrorReport>()) {
        await IrisFlavorConfig.init();
        await AppBinding.registerEventsDependencies();
      }

      Get.find<IrisErrorReport>().send(
        ForeignException(error, stack),
      );
    },
  );
}
