import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthenticationService extends GetxService {
  final _auth = LocalAuthentication();
  bool isProtectionEnabled = false;

  bool isAuthenticated = false;

  // To check if any type of biometric authentication
  // hardware is available.
  Future<bool> isBiometricAvailable() async {
    bool isAvailable = false;
    try {
      isAvailable = await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
    return isAvailable;
  }

  // To retrieve the list of biometric types
  // (if available).
  Future<void> getListOfBiometricTypes() async {
    // List<BiometricType> listOfBiometrics;
    try {
      // listOfBiometrics =
      await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> authenticate() async {
    ///TODO: The local_auth plugin requires the main activity to extend FlutterActivity.
    ///The problem is that we have a plethora of plugins that depend on MainActivity,
    ///which leads to unexpected bugs, inconsistencies in themes, and crashes when a video is shown.
    ///This temporarily disables biometrics on android. See for references:
    ///https://github.com/flutter/flutter/issues/41119
    if (GetPlatform.isAndroid) {
      return false;
    }
    try {
      isAuthenticated = await _auth.authenticate(
        localizedReason: 'authenticate to access',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
    return isAuthenticated;
  }
}
