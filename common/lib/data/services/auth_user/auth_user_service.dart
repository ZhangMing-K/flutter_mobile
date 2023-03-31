import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../../../iris_common.dart';

class AuthUserService extends GetxService implements IAuthUserService {
  @override
  final ISecureStorage prefs;

  final IrisEvent? irisEvent;
  String _authToken = '';

  bool _onboardingDisplayed =
      true; // be sure to set and remove at login and logout.

  final Rx<User?> authUser$ = Rx<User?>(null);

  AuthUserService({required this.prefs, this.irisEvent});

  @override
  String get authToken => _authToken;

  @override
  bool get authUserIsSet {
    if (loggedUser?.username != null) {
      return true;
    } else if (loggedUser?.firstName != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  bool get isGoldMember => loggedUser?.goldConnection?.isGoldMember ?? false;

  @override
  bool get loggedIn {
    //return prefs.containsKeySync(key: 'authToken');
    //return (loggedUser?.userKey != null) ? true : false;
    return _authToken.isNotEmpty;
  }

  @override
  User? get loggedUser {
    return authUser$.value;
  }

  @override
  bool get onboadingDisplayed => _onboardingDisplayed;

  @override
  void clearUserNotifications() {
    authUser$.value = loggedUser!.copyWith(notifications: []);
  }

  Future<Rx<User?>?> configureAuthToken(String newAuthToken) async {
    _setAuthToken('Bearer $newAuthToken');
    final payload = Jwt.parseJwt(authToken);
    final payloadUser = User.fromJson(payload);

    authUser$.value = payloadUser;
    await prefs.write(key: 'authToken', value: newAuthToken);

    final int exp = payload['exp'];
    final jwtExpired =
        DateTime.fromMillisecondsSinceEpoch(exp * 1000, isUtc: true)
            .isBefore(DateTime.now());
    if (jwtExpired) {
      await logout(isAutoLogout: true, description: 'expired 1');
      return null;
    }

    //  await setAuthTokenPromises(payloadUser);
    return authUser$;
  }

  @override
  void editUserData(User result) {
    authUser$.value = result;
  }

  @override
  Future init() async {
    final onBoardingValue = await prefs.read(key: kVideoShowOnboarding);
    _onboardingDisplayed = onBoardingValue != null;
    final nauthToken = await prefs.read(key: 'authToken');
    if (nauthToken != null && nauthToken.isNotEmpty) {
      await configureAuthToken(nauthToken);
    }
  }

  @override
  Future<User> loginPhone({required User user, required String token}) async {
    await configureAuthToken(token);
    authUser$.value = user;
    identifyInPosthog(authUser$.value);

    return user;
  }

  @override
  Future<void> logout(
      {required bool isAutoLogout, required String description}) async {
    if (authUser$.value?.userKey != null) {
      irisEvent?.reportLogout(
          userKey: authUser$.value!.userKey!,
          isAutoLogout: isAutoLogout,
          description: description);
    }

    _setAuthToken('');

    await prefs.delete(key: 'authToken');
    authUser$.value = null;
    Future.microtask(() {
      IrisStackObserver.stack.clear();
      Get.offAllNamed(Paths.Welcome.createPath([false]));
    });

    debugPrint('DONE LOGGING OUT');
  }

  /// AuthToken cannot be modified from outside this class
  void _setAuthToken(String token) {
    irisEvent?.addAuthorization(token);
    _authToken = token;
  }

  static Future<String> getCoordinate() async {
    final code = ENV.IRIS_API_KEY ?? ''; // insert code here
    final decryptedData = await IrisCryptr(secret: code, iterations: 1)
        .encrypt(DateTime.now().toUtc().toIso8601String());
    return decryptedData;
  }
}

/// foo_store.dart and foo_store_impl.dart.

/// [I IAuthUserService] We use an abstract class from I IAuthUserService to implement
/// all mandatory methods, and allow unit tests.
/// Instead of using the  IAuthUserService class, we will only use the [I IAuthUserService]
/// class, which will allow us to inject a mock into the abstract class
/// when we are going to do unit tests.
/// Attention, whenever you add a method in the  IAuthUserService class,
/// add it here first.
abstract class IAuthUserService {
  String get authToken;

  bool get authUserIsSet;

  bool get isGoldMember;

  /// Check if user is loggedIn
  bool get loggedIn;

  User? get loggedUser;

  /// Check if user is loggedIn
  bool get onboadingDisplayed;

  ISecureStorage get prefs;

  void clearUserNotifications();

  void editUserData(User data);

  Future init();

  Future<User> loginPhone({required User user, required String token});

  Future<void> logout(
      {required bool isAutoLogout, required String description});
}
