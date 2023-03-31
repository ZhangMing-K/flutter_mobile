import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../profile/modules/summary/notifiers/portfolios_notifier.dart';

class AccountPortfoliosController extends GetxController {
  final UserService userService;

  final IAuthUserService authUserStore;
  final PortfoliosNotifier profilePortfolioController;
  Rx<User?> profileUser$ = Rx<User?>(null);

  AccountPortfoliosController(
      {required this.userService,
      required this.authUserStore,
      required this.profilePortfolioController});

  getUser() async {
    // apiStatus$.value = API_STATUS.PENDING;
    profileUser$.value = await userService.getUserByKey(
        userKey: authUserStore.loggedUser?.userKey,
        requestedFields: userRequestedFields());

    // apiStatus$.value = API_STATUS.FINISHED;
  }

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  userRequestedFields() {
    return '''
      userKey
      firstName
      lastName
      profilePictureUrl
      portfolios{
        brokerName
        portfolioVisibilitySetting
        portfolioKey
        accountId
        connectionStatus
        authUserRelation {
          hideAt
          mutedAt
          savedAt
          notificationAmount
        }
        followStats{
          numberOfFollowers
        }
        authUserFollowInfo{
          followStatus
          watching
        }
        snapshot(input: {mostRecent: true}){
          dayPercent
          weekPercent
          threeMonthPercent
          yearPercent
          allPercent
          lastUpdatedAt
        }
        portfolioName
      }
    ''';
  }
}
