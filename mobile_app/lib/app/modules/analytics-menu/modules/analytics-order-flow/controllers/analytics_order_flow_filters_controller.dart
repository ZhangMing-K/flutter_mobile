import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AnalyticsOrderFlowFiltersController extends GetxController {
  Rx<bool> currentIsGold = true.obs;

  Rx<double> currentMinPortfolio = 0.0.obs;
  Rx<double> currentMinTradeAmount = 0.0.obs;

  final isVisible = false.obs;

  void onError(err) {
    debugPrint(err.toString());
  }

  void onMinPortfolioChanged(double val) {
    currentMinPortfolio.value = val;
  }

  void onMinTradeAmountChanged(double val) {
    currentMinTradeAmount.value = val;
  }

  void onReset() {
    currentIsGold.value = false;
    currentMinPortfolio.value = 1.0;
    currentMinTradeAmount.value = 100.0;
  }

  void setIsGold(bool isGold) {
    currentIsGold.value = isGold;
  }
}
