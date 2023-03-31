import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class IrisConnectivity extends GetxService {
  static IrisConnectivity get to => Get.find();

  final connectivity = Connectivity();

  late final StreamSubscription subscription;
  final isConnected = true.obs;
  Future<void> init() async {
    var connectivityResult = await connectivity.checkConnectivity();
    setConnectivity(connectivityResult);
  }

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    subscription = connectivity.onConnectivityChanged.listen(setConnectivity);
    super.onInit();
  }

  void setConnectivity(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      isConnected.value = false;
    } else {
      isConnected.value = true;
    }
  }
}
