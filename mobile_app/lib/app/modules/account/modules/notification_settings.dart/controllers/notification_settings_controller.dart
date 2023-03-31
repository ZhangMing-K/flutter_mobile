import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:permission_handler/permission_handler.dart';

String userRequestedFields({int offset = 0, String? name}) {
  return '''
      userKey
      firstName
      lastName
      profilePictureUrl
      tradeNotificationsSnoozed
      allNotificationsSnoozed
      nbrUsersTradeNotificationsOn
      authUserUser {
        postNotificationAmount
        tradeNotificationAmount
      }
      userSettings {
        messagingNotificationAmount
        tradeNotificationAmount
        followNotificationAmount
        postNotificationAmount
      }
      advancedUsersFollowing(input:{ limit:10, offset:$offset, name:"$name" }) {
        userKey
        firstName
        lastName
        profilePictureUrl
        authUserUser {
          postNotificationAmount
          tradeNotificationAmount
        }
        portfolios{
          brokerName
          portfolioKey
          connectionStatus
          authUserRelation {
            hideAt
            mutedAt
            savedAt
            notificationAmount
          }
          portfolioName
        }
      }
    ''';
}

class NotificationSettingsController extends SuperController {
  final Rx<User?> profileUser$ = Rx<User?>(null);
  final IAuthUserService authUserStore;
  final UserService userService;
  final IFeedRepository feedRepository;
  final INotificationRepository notificationRepository;

  final advancedFollowingUsers$ = <Rx<User>>[].obs;
  Rx<API_STATUS> apiStatus$ = Rx<API_STATUS>(API_STATUS.PENDING);
  final TextEditingController textEditingController = TextEditingController();

  int offset = 0;
  String searchName = '';
  RxInt numberUserTradesOn = 0.obs;
  bool canLoadMore = false;

  RxBool allowAllNotifications = true.obs;
  RxBool allowMessaging = true.obs;
  RxBool allowPostInteractions = true.obs;
  RxBool allowFollows = true.obs;
  RxBool allowTrades = true.obs;

  RxBool permissionGranted = false.obs;

  NotificationSettingsController({
    required this.authUserStore,
    required this.userService,
    required this.feedRepository,
    required this.notificationRepository,
  });

  bool get hasAllNotifications {
    return profileUser$.value?.allNotificationsSnoozed == false;
  }

  bool get hasTradeNotifications {
    return profileUser$.value?.tradeNotificationsSnoozed == false;
  }

  bool get isMuteAllPossible {
    return numberUserTradesOn.value > 0;
  }

  getAllNotificationAmount() {
    if (!allowTrades.value &&
        !allowFollows.value &&
        !allowPostInteractions.value &&
        !allowMessaging.value) {
      allowAllNotifications.value = false;
    } else {
      allowAllNotifications.value = true;
    }
  }

  getNotificationPermission({bool isDirect = false}) async {
    final permission = await Permission.notification.request();
    if (permission.isGranted) {
      return true;
    } else {
      if (!isDirect) {
        await Get.dialog(
          IrisDialog(
            title: 'Permission Required',
            subtitle:
                'You have denied access to notifications, you can go to settings and grant permission again.',
            onCancel: () => Get.back(),
            confirmButtonText: 'Settings',
            onConfirm: () {
              openAppSettings();
              Get.back();
            },
          ),
          barrierDismissible: true,
        );
      } else {
        openAppSettings();
      }
      return false;
    }
  }

  getPortfolioNotificationAmount(Portfolio portfolio) {
    if (portfolio.authUserRelation == null) {
      return USER_RELATION_NOTIFICATION_AMOUNT.NONE.obs;
    }
    return portfolio.authUserRelation!.notificationAmount!.obs;
  }

  getUser() async {
    profileUser$.value = await userService.getUserByKey(
        userKey: authUserStore.loggedUser?.userKey,
        requestedFields: userRequestedFields(
          offset: offset,
          name: searchName,
        ));

    if (profileUser$.value!.advancedUsersFollowing!.length == 10) {
      offset += 10;
      canLoadMore = true;
    } else {
      canLoadMore = false;
    }

    numberUserTradesOn.value =
        profileUser$.value!.nbrUsersTradeNotificationsOn!;
    advancedFollowingUsers$.assignAll(
        profileUser$.value!.advancedUsersFollowing!.map((e) => e.obs).toList());
    apiStatus$.value = API_STATUS.FINISHED;

    if (profileUser$.value!.userSettings != null) {
      allowFollows.value =
          profileUser$.value!.userSettings!.followNotificationAmount ==
                  FOLLOW_NOTIFICATION_AMOUNT.ALL
              ? true
              : false;
      allowTrades.value =
          profileUser$.value!.userSettings!.tradeNotificationAmount ==
                  TRADE_NOTIFICATION_AMOUNT.ALL
              ? true
              : false;
      allowMessaging.value =
          profileUser$.value!.userSettings!.messagingNotificationAmount ==
                  MESSAGING_NOTIFICATION_AMOUNT.ALL
              ? true
              : false;
      allowPostInteractions.value =
          profileUser$.value!.userSettings!.postNotificationAmount ==
                  POST_NOTIFICATION_AMOUNT.ALL
              ? true
              : false;
    } else {
      // userSettings null
      allowFollows.value = true;
      allowTrades.value = true;
      allowMessaging.value = true;
      allowPostInteractions.value = true;
    }
    getAllNotificationAmount();
  }

  isAlertAll(Portfolio portfolio) {
    if (portfolio.authUserRelation == null) {
      return false;
    }
    return portfolio.authUserRelation?.notificationAmount ==
        USER_RELATION_NOTIFICATION_AMOUNT.ALL;
  }

  Future<void> loadMore() async {
    if (canLoadMore) {
      final User? user = await userService.getUserByKey(
          userKey: authUserStore.loggedUser?.userKey,
          requestedFields:
              userRequestedFields(offset: offset, name: searchName));
      if (user!.advancedUsersFollowing!.length == 10) {
        offset += 10;
        canLoadMore = true;
      } else {
        canLoadMore = false;
      }
      numberUserTradesOn.value = user.nbrUsersTradeNotificationsOn!;
      advancedFollowingUsers$
          .addAll(user.advancedUsersFollowing!.map((e) => e.obs).toList());
    }
  }

  Future<void> muteAllUserTradeNotifications() async {
    if (isMuteAllPossible) {
      await Get.dialog(
        IrisDialog(
          title: 'Are you sure?',
          subtitle:
              'This will reset trade notifications for all $numberUserTradesOn users to the “off” setting. You can still adjust by user individually by clicking the bell icon.',
          onCancel: () => Get.back(),
          confirmButtonText: 'Mute all',
          onConfirm: () async {
            final isMuted =
                await notificationRepository.muteAllTradeNotifications();
            if (isMuted) {
              offset = 0;
              searchName = '';
              getUser();
            }
            Get.back();
          },
        ),
        barrierDismissible: true,
      );
    } else {
      HapticFeedback.heavyImpact();
    }
  }

  Future<void> onBellPressed(
      {required Rx<User> user, required bool isActive}) async {
    final userKey = user.value.userKey;
    if (userKey == null) return;

    final data = await notificationRepository.changeUserNotifications(
      userKey: userKey,
      tradeNotificationAmount: isActive
          ? USER_TRADE_NOTIFICATION_AMOUNT.NONE
          : USER_TRADE_NOTIFICATION_AMOUNT.ALL,
    );

    user.value = user.value.copyWith(authUserUser: data!.userUser);
    if (isActive) {
      numberUserTradesOn.value = numberUserTradesOn.value - 1;
    } else {
      numberUserTradesOn.value = numberUserTradesOn.value + 1;
    }
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  onInit() async {
    getUser();
    final permission = await getNotificationPermission();
    permissionGranted.value = permission;
    super.onInit();
  }

  @override
  void onPaused() {}

  @override
  onResumed() async {
    final permission = await Permission.notification.request();
    permissionGranted.value = permission.isGranted;
  }

  search(String val) async {
    offset = 0;
    searchName = val;
    getUser();
  }

  setAlerts(
      void Function(void Function()) update,
      USER_RELATION_NOTIFICATION_AMOUNT alert,
      int userKey,
      Portfolio portfolio) async {
    final currentSetting = getPortfolioNotificationAmount(portfolio);
    if (currentSetting != alert) {
      final UserRelation? data = await feedRepository.userRelationsUpdate(
        entityType: USER_RELATION_ENTITY_TYPE.PORTFOLIO,
        entityKeys: [portfolio.portfolioKey],
        notificationAmount: alert,
      );
      final currentPortfolioUser = advancedFollowingUsers$
          .where((u) => u.value.userKey! == userKey)
          .toList()[0];
      final List<Portfolio> currentPortfolioUserPortfolios =
          currentPortfolioUser.value.portfolios!;
      currentPortfolioUserPortfolios[currentPortfolioUserPortfolios.indexWhere(
              (element) => element.portfolioKey == portfolio.portfolioKey)] =
          portfolio.copyWith(authUserRelation: data);
      currentPortfolioUser.value = currentPortfolioUser.value
          .copyWith(portfolios: currentPortfolioUserPortfolios);
      advancedFollowingUsers$[advancedFollowingUsers$
              .indexWhere((element) => element.value.userKey == userKey)] =
          currentPortfolioUser;

      if (alert == USER_RELATION_NOTIFICATION_AMOUNT.NONE) {
        numberUserTradesOn.value = numberUserTradesOn.value - 1;
      }
      if (currentSetting == USER_RELATION_NOTIFICATION_AMOUNT.NONE) {
        numberUserTradesOn.value = numberUserTradesOn.value + 1;
      }
    }
    update(() {});
  }

  setAllNotificationSetting(bool value) async {
    final permission = await getNotificationPermission(isDirect: true);
    if (!permission) return;
    allowAllNotifications.value = value;
    notificationRepository.setNotificationsAmount(
        isAll: true, allAmount: value);
    allowMessaging.value = value;
    allowPostInteractions.value = value;
    allowTrades.value = value;
    allowFollows.value = value;
  }

  setSnooze(void Function(void Function()) update,
      USER_SNOOZE_TYPE snoozeType) async {
    UserSnooze res;

    if (snoozeType == USER_SNOOZE_TYPE.TRADE) {
      if (hasTradeNotifications) {
        res = await notificationRepository.snoozeNotifications(
            onError: (error) => debugPrint(error.toString()),
            snoozeType: snoozeType);
        profileUser$.value =
            profileUser$.value!.copyWith(tradeNotificationsSnoozed: true);
      } else {
        res = await notificationRepository.unsnoozeNotifications(
            snoozeType: snoozeType);
        profileUser$.value =
            profileUser$.value!.copyWith(tradeNotificationsSnoozed: false);
      }
    }

    if (snoozeType == USER_SNOOZE_TYPE.ALL) {
      if (hasAllNotifications) {
        res = await notificationRepository.snoozeNotifications(
            onError: (error) => debugPrint(error.toString()),
            snoozeType: snoozeType);
        profileUser$.value =
            profileUser$.value!.copyWith(allNotificationsSnoozed: true);
      } else {
        res = await notificationRepository.unsnoozeNotifications(
            snoozeType: snoozeType);
        profileUser$.value =
            profileUser$.value!.copyWith(allNotificationsSnoozed: false);
      }
      if (kDebugMode) {
        print(res);
      }
    }
    update(() {});
  }

  setSubNotificationSetting(String subName, bool value) async {
    final permission = await getNotificationPermission(isDirect: true);
    if (!permission) return;
    permissionGranted.value = permission;
    switch (subName) {
      case 'Messaging':
        allowMessaging.value = value;
        break;
      case 'Post interactions':
        allowPostInteractions.value = value;
        break;
      case 'Follows':
        allowFollows.value = value;
        break;
      case 'Trades':
        allowTrades.value = value;
        break;
      default:
        break;
    }
    notificationRepository.setNotificationsAmount(
        isAll: false,
        tradeNotificationAmount: allowTrades.value,
        followNotificationAmount: allowFollows.value,
        postNotificationAmount: allowPostInteractions.value,
        messagingNotificationAmount: allowMessaging.value);
    getAllNotificationAmount();
  }
}
