import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class ProfileUtils {
  // This class is re
  ProfileUtils({required this.authUserStore});

  //TODO(Jonatas): HEALTH, made  IAuthUserService abstract class to
  //be possible mock it and build tests
  final IAuthUserService authUserStore;

  static int? get getCurrentProfileKey {
    return ProfileUtils(authUserStore: Get.find()).getProfileKey;
  }

  int? get getProfileKeyFromArguments {
    final parameters = Get.parameters['profileUserKey'];
    if (parameters != null && parameters != '') {
      return int.tryParse(parameters);
    }
    return null;
  }

  int get getProfileKey {
    if (authUserStore.loggedUser == null) {
      return 0;
    }
    final localUser = authUserStore.loggedUser!.userKey!;
    return getProfileKeyFromArguments ?? localUser;
  }

  bool get isMyProfile {
    return authUserStore.loggedUser?.userKey == getProfileKey;
  }

  bool isMyProfileKey(int profileKey) {
    return authUserStore.loggedUser?.userKey == profileKey;
  }
}
