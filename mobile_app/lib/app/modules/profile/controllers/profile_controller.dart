import 'dart:async';

import 'package:get/get.dart';
import 'package:iris_mobile/app/modules/feed/controllers/feed_controller.dart';

import '../../../../widgets_v2/pannels/user_settings_pannel/user_setting_pannel_data.dart';
import '../../../../widgets_v2/pannels/user_settings_pannel/user_settings_pannel.dart';
import '../../../routes/pages.dart';
import '../modules/posts/controllers/profile_posts_controller.dart';
import '../modules/summary/notifiers/profile_summary_notifier.dart';
import '../modules/summary/notifiers/pie_chart_notifier.dart';
import '../modules/summary/notifiers/portfolios_notifier.dart';
import '../modules/summary/notifiers/position_list_notifier.dart';

enum LAST_ACTION {
  NONE,
  FOLLOW,
  TRADE_NOTIFICATION_ON,
  TRADE_NOTIFICATION_OFF,
  POST_NOTIFICATION_ON,
  POST_NOTIFICATION_OFF,
}

class ProfileController extends SuperController {
  final ProfileSummaryController profileSummaryController;
  // final ProfilePortfolioController profilePortfolioController;
  final ProfilePostsController profilePostsController;
  final IProfileRepository repository;
  final IAuthUserService authUserStore;
  final UserService userService;
  final IrisEvent irisEvent;
  final IFeedRepository feedRepository;
  StreamSubscription? _routeListener;

  final int profileUserKey;

  final Rx<API_STATUS> apiStatus$ = Rx(API_STATUS.NOT_STARTED);

  final RxBool showBackButton$ = RxBool(false);
  final Rx<LAST_ACTION> lastAction$ = Rx(LAST_ACTION.NONE);
  late UserSettingsPannelData pannelData;
  int selectedTab = 0;
  final FeedController feedController = Get.find();
  ProfileController({
    required this.profileUserKey,
    required this.repository,
    required this.profileSummaryController,
    required this.profilePostsController,
    required this.irisEvent,
    required this.authUserStore,
    required this.userService,
    required this.feedRepository,
    //  required this.analyticsService,
  });

  late final portfoliosNotifier = PortfoliosNotifier(
      authUserStore: authUserStore,
      repository: repository,
      profileUserKey: profileUserKey);

  late final pieChartNotifier =
      PieChartNotifier(profileKey: profileUserKey, repository: repository);

  late final positionListNotifier =
      PositionListNotifier(repository: repository, profileKey: profileUserKey);

  bool get isAuthUser => authUserStore.loggedUser?.userKey == profileUserKey;

  @override
  void onInit() {
    portfoliosNotifier.start();
    pieChartNotifier.start();
    positionListNotifier.start();
    showBackButton$.value = isAuthUser;
    irisEvent.registerProfileView(profileUserKey: profileUserKey);
    super.onInit();
  }

  @override
  void onClose() {
    _routeListener?.cancel();
    super.onClose();
  }

  final portfolioSelectedKey = Rxn<int?>();

  Portfolio? get selectedPortfolio => portfoliosNotifier.state
      ?.firstWhereOrNull((p) => p.portfolioKey == portfolioSelectedKey.value);

  void onSelected(int? portfolioKey) {
    portfolioSelectedKey.value = portfolioKey;
    pieChartNotifier.fetchPieChart(portfolioKey);
    positionListNotifier.fetchPositionList(portfolioKey);
  }

  String get authUsername {
    return authUserStore.loggedUser?.username ?? '';
  }

  void unBlockUser({required bool block}) async {
    final UserRelation? authUserRelation =
        await feedRepository.userRelationsUpdate(
            entityType: USER_RELATION_ENTITY_TYPE.USER,
            entityKeys: [profileUserKey],
            block: block);

    profileSummaryController.state?.value = profileSummaryController
        .state!.value
        .copyWith(authUserRelation: authUserRelation);
  }

  @override
  void onPaused() {}

  @override
  void onResumed() async {
    updateNotificationToggles();
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  Future<void> updateNotificationToggles() async {
    final bool update = await shouldUpdateNotification();
    if (update) {
      if (lastAction$.value == LAST_ACTION.FOLLOW) {
        await changeUserNotifications(
            postNotificationAmount: USER_POST_NOTIFICATION_AMOUNT.ALL,
            tradeNotificationAmount: USER_TRADE_NOTIFICATION_AMOUNT.ALL);
      }
      if (lastAction$.value == LAST_ACTION.POST_NOTIFICATION_ON) {
        await changeUserNotifications(
            postNotificationAmount: USER_POST_NOTIFICATION_AMOUNT.ALL);
      }
      if (lastAction$.value == LAST_ACTION.TRADE_NOTIFICATION_ON) {
        await changeUserNotifications(
            tradeNotificationAmount: USER_TRADE_NOTIFICATION_AMOUNT.ALL);
      }
      lastAction$.value = LAST_ACTION.NONE;
    }
  }

  Future<bool> shouldUpdateNotification() async {
    // check current toggle status
    UserUser? authUserUser = profileSummaryController.state!.value.authUserUser;

    bool shouldTurnToggleOn = false;
    if (authUserUser != null) {
      if (authUserUser.postNotificationAmount! ==
          USER_POST_NOTIFICATION_AMOUNT.NONE) {
        shouldTurnToggleOn = true;
      }
      if (authUserUser.tradeNotificationAmount! ==
          USER_TRADE_NOTIFICATION_AMOUNT.NONE) {
        shouldTurnToggleOn = true;
      }
    }
    final shouldUpdate = shouldTurnToggleOn &&
        await NotificationPermission.currentNotificationStatus();
    return shouldUpdate;
  }

 

  Future<UserUserUpdateResponse?> changeUserNotifications(
      {USER_POST_NOTIFICATION_AMOUNT? postNotificationAmount,
      USER_TRADE_NOTIFICATION_AMOUNT? tradeNotificationAmount}) async {
    final data = await overlayLoader(
        context: Get.context!,
        loaderColor: Get.context!.theme.primaryColor,
        asyncFunction: () => repository.changeNotifications(
              userKey: profileUserKey,
              postNotificationAmount: postNotificationAmount,
              tradeNotificationAmount: tradeNotificationAmount,
            ));

    if (data != null) {
      profileSummaryController.state!.value = profileSummaryController
          .state!.value
          .copyWith(authUserUser: data.userUser);
    }
    return null;
  }

  Future<void> goToEditPage() async {
    await Get.toNamed(Paths.EditProfile);
    profileSummaryController.updateProfileSummary();
  }

  Future<void> onPostNotificationClicked(bool selected) async {
    if (selected) {
      lastAction$.value = LAST_ACTION.POST_NOTIFICATION_ON;
    } else {
      lastAction$.value = LAST_ACTION.POST_NOTIFICATION_OFF;
    }
    final isGranted = await NotificationPermission.getNotificationPermission();
    USER_POST_NOTIFICATION_AMOUNT postNotificationAmount = selected
        ? USER_POST_NOTIFICATION_AMOUNT.ALL
        : USER_POST_NOTIFICATION_AMOUNT.NONE;
    if (selected) {
      if (isGranted) {
        await changeUserNotifications(
          postNotificationAmount: postNotificationAmount,
        );
      }
    } else {
      await changeUserNotifications(
        postNotificationAmount: postNotificationAmount,
      );
    }
  }

  void onTabChange(int index) {
    selectedTab = index;
  }

  Future<void> onTradeNotificationClicked(bool selected) async {
    if (selected) {
      lastAction$.value = LAST_ACTION.TRADE_NOTIFICATION_ON;
    } else {
      lastAction$.value = LAST_ACTION.TRADE_NOTIFICATION_OFF;
    }
    final isGranted = await NotificationPermission.getNotificationPermission();
    USER_TRADE_NOTIFICATION_AMOUNT tradeNotificationAmount = selected
        ? USER_TRADE_NOTIFICATION_AMOUNT.ALL
        : USER_TRADE_NOTIFICATION_AMOUNT.NONE;
    if (selected) {
      if (isGranted) {
        changeUserNotifications(
          tradeNotificationAmount: tradeNotificationAmount,
        );
      }
    } else {
      changeUserNotifications(
        tradeNotificationAmount: tradeNotificationAmount,
      );
    }
  }

  void openSettingsPannel() {
    UserSettingsPannel.openPannel(
      user: profileSummaryController.state!,
      pannelData: UserSettingsPannelData(
          authUser: authUserStore.loggedUser,
          user$: profileSummaryController.state!),
    );
  }
}
