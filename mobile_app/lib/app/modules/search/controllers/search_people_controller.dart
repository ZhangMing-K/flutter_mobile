import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class SearchPeopleController extends GetxController {
  final recentList = <User>[].obs;
  final IStorage storage = Get.find();

  @override
  void onInit() {
    loadRecentList();
    super.onInit();
  }

  void loadRecentList() {
    final usersFromStorage = storage.read('savedUsers');
    if (usersFromStorage != null) {
      final List<User> userList = List<User>.from(usersFromStorage.map((i) {
        if (i is User) return i;
        return User.fromJson(i);
      }));
      recentList.assignAll(userList);
    }
  }

  void saveUserToRecent(User user) {
    final userKey = user.userKey;
    recentList.removeWhere((element) => element.userKey == userKey);
    recentList.insert(0, user);
    storage.write(
        key: 'savedUsers',
        value: recentList.map((element) => element.toJson()).toList());
  }
}
