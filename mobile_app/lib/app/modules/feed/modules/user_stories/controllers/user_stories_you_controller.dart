import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_mobile/app/modules/profile/shared/profile_utils.dart';
import 'package:iris_mobile/app/routes/pages.dart';

String youStoriesGql = '''
email
firstName
lastName
dailyPercentGain
phoneNumber
profilePictureUrl
''';

class UserStoriesYouController extends GetxController
    with StateMixin<Rx<User>> {
  final IProfileRepository repository;
  final IAuthUserService authUserStore;
  late final profileUtils = ProfileUtils(authUserStore: authUserStore);

  UserStoriesYouController(
      {required this.authUserStore, required this.repository});

  @override
  void onInit() {
    _getUser();
    super.onInit();
  }

  void _getUser() {
    int userKey = profileUtils.getProfileKey;
    print('get user : $userKey');
    if (userKey == 0) {
      //TODO report error
      // IrisErrorReport(irisEvent: IrisEvent)
    } else {
      repository.getUserByKey(
          userKey: profileUtils.getProfileKey,
          userGql: youStoriesGql,
          callback: onSuccess,
          onError: onError);
    }
  }

  void onSuccess(UsersGetResponse data) {
    final users = data.users;
    if (users != null && users.isNotEmpty) {
      final User user = users.first;
      change(user.obs, status: RxStatus.success());
    }
  }

  void onError(e) {
    ///TODO: send error to server
    debugPrint(e.toString());
  }
}
