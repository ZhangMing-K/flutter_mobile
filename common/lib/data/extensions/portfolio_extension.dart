import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

extension PortfolioExt on Portfolio {
  bool get isAuthUser {
    final IAuthUserService authUserStore = Get.find();
    final int? authUserKey = authUserStore.loggedUser?.userKey;
    if (user?.userKey == authUserKey) {
      return true;
    }
    // else if (userKey == authUserKey) {
    //   return true;
    // }
    return false;
  }
}
