import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class DeactivateController extends BaseController {
  UserService userService = Get.find();

  Future<void> deactivate() async {
    final bool? success = await userService.userDelete(
        userKey: authUserStore.loggedUser?.userKey);
    if (success == null) {
      return;
    }
    if (success) {
      authUserStore.logout(
          isAutoLogout: false, description: 'deactived account');
    }
  }
}
