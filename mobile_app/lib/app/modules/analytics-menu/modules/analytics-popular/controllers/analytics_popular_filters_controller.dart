import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AnalyticsPopularFiltersController extends GetxController {
  Rx<bool> currentIsGold = true.obs;

  AnalyticsPopularFiltersController();

  void onError(err) {
    debugPrint(err.toString());
  }

  setIsGold(bool isGold) {
    currentIsGold.value = isGold;
  }
}
