import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class WhoToFollowController extends GetxController {
  WhoToFollowController({required this.repository, required this.storage});

  final ISearchRepository repository;
  final IStorage storage;

  final recommendedList =
      const DiscoverPageGetResponse(items: [], nextCursor: '').obs;

  final topPerfomersParam = [
    {'width': ScreenUtil().setWidth(148), 'height': 150, 'percentHeight': 120},
    {'width': ScreenUtil().setWidth(114), 'height': 120, 'percentHeight': 91},
    {'width': ScreenUtil().setWidth(93), 'height': 103, 'percentHeight': 49}
  ];
  List<User> savedUsers = <User>[];

  @override
  void onInit() {
    onLoadData();

    super.onInit();
  }

  void onLoadData() {
    repository.discoverPageGet(
      input: DiscoverPageGetInput(nextCursor: getCursor()),
      queryType: QueryType.loadCache,
      callback: (data) => onSuccess(data),
      onError: onError,
    );
  }

  String recommendedCursor = '';

  String getCursor() {
    return recommendedCursor;
  }

  final _recentList = <User>[].obs;

  List<User> get recentList {
    _recentList.toList();
    final usersFromStorage = storage.read('savedUsers');
    if (usersFromStorage != null) {
      final List<User> userList = List<User>.from(usersFromStorage.map((i) {
        if (i is User) return i;
        return User.fromJson(i);
      }));
      return userList;
    } else {
      return [];
    }
  }

  void onSuccess(DiscoverPageGetResponse data) {
    recommendedList(data);
  }

  void onError(err) {
    debugPrint(err.toString());
    Get.snackbar('Error', 'Can not perform search');
  }

  void saveUserToRecent(User user) {
    final userKey = user.userKey;
    _recentList.assignAll(recentList);
    _recentList.removeWhere((element) => element.userKey == userKey);
    _recentList.insert(0, user);
    storage.write(
        key: 'savedUsers',
        value: _recentList.map((element) => element.toJson()).toList());
  }
}
