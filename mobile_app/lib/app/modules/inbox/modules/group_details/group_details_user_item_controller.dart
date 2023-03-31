import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:timeago/timeago.dart' as timeago;

class GroupDetailsUserItemController extends GetxController {
  GroupDetailsUserItemController({
    this.user,
  });

  final Rx<User>? user;

  IAuthUserService authUserStore = Get.find();
  final lastSeen = Rx<DateTime?>(null);

  String url = '';
  String avatarCode = '';
  int? id;

  User get getUser {
    return user!.value;
  }

  String get userStatus {
    final seenAt = getUser.lastOnlineAt;
    if (seenAt != null) {
      return DateTime.now().difference(seenAt) < const Duration(minutes: 10)
          ? 'Active now'
          : 'Active ${timeago.format(seenAt)}';
    } else {
      return 'Offline';
    }
  }

  void onError(err) {
    // Get.snackbar('Error', err.toString());
  }
}
