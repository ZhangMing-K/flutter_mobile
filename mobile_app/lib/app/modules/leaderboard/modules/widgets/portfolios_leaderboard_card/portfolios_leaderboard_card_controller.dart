import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../routes/pages.dart';

class PortfolioLeaderboardController extends GetxController {
  final Rx<Portfolio?> portfolio;

  ///TODO: MOVE TO BINDINGS
  final IAuthUserService authUserStore = Get.find();

  final IFeedRepository feedRepository = Get.find();
  PortfolioLeaderboardController({required this.portfolio});

  bool get hasAlerts {
    return portfolio.value?.authUserRelation?.notificationAmount ==
        USER_RELATION_NOTIFICATION_AMOUNT.ALL;
  }

  bool get isAlertAll {
    if (portfolio.value!.authUserRelation == null) {
      return false;
    }
    return portfolio.value?.authUserRelation?.notificationAmount ==
        USER_RELATION_NOTIFICATION_AMOUNT.ALL;
  }

  bool get isAlertLarge {
    if (portfolio.value!.authUserRelation == null) {
      return false;
    }
    return portfolio.value?.authUserRelation?.notificationAmount ==
        USER_RELATION_NOTIFICATION_AMOUNT.LARGE;
  }

  bool get isAlertNone {
    if (portfolio.value!.authUserRelation == null) {
      return true;
    }
    return portfolio.value?.authUserRelation?.notificationAmount ==
        USER_RELATION_NOTIFICATION_AMOUNT.NONE;
  }

  get isAuthUser {
    return portfolio.value?.user?.userKey == authUserStore.loggedUser?.userKey;
  }

  bool get isSaved {
    return portfolio.value?.authUserRelation?.savedAt != null;
  }

  USER_RELATION_NOTIFICATION_AMOUNT get notificationAmount {
    if (portfolio.value!.authUserRelation == null) {
      return USER_RELATION_NOTIFICATION_AMOUNT.NONE;
    }
    return portfolio.value!.authUserRelation!.notificationAmount!;
  }

  List<PANNEL_ITEMS> get panelActions {
    if (portfolio.value?.authUserRelation?.hideAt == null) {
      return [PANNEL_ITEMS.HIDE];
    } else {
      return [PANNEL_ITEMS.UNHIDE];
    }
  }

  markSaved(void Function(void Function()) update) async {
    final UserRelation? data = await feedRepository.userRelationsUpdate(
      entityType: USER_RELATION_ENTITY_TYPE.PORTFOLIO,
      entityKeys: [portfolio.value?.portfolioKey],
      save: !isSaved,
    );
    portfolio.value = portfolio.value?.copyWith(authUserRelation: data);
    update(() {});
  }

  routeTo() {
    final List<FOLLOW_STATUS> list = [FOLLOW_STATUS.APPROVED, FOLLOW_STATUS.ME];
    if (list.contains(portfolio.value?.authUserFollowInfo!.followStatus)) {
      if (portfolio.value?.authUserFollowInfo!.followStatus ==
              FOLLOW_STATUS.APPROVED &&
          portfolio.value?.portfolioVisibilitySetting ==
              PORTFOLIO_VISIBILITY_SETTING.ONLY_ME) {
        return;
      }
      if (portfolio.value?.accountId != null ||
          portfolio.value?.authUserFollowInfo!.followStatus ==
              FOLLOW_STATUS.APPROVED) {
        Get.toNamed(Paths.Portfolio.createPath([portfolio.value?.portfolioKey]),
            id: 1);
      } else if (portfolio.value?.accountId == null &&
          portfolio.value?.authUserFollowInfo!.followStatus ==
              FOLLOW_STATUS.ME) {
        Get.toNamed(Paths.ConnectInstitution.createPath([
          describeEnum(portfolio.value!.brokerName!),
          portfolio.value!.portfolioKey,
          null,
        ]));
      }
    } else {
      if (Get.currentRoute.contains('profile')) {
        return;
      }
      final profileArgs = ProfileArgs(
        user: portfolio.value?.user ?? const User(),
        heroTag: portfolio.value?.user?.userKey.toString() ?? '',
      );
      Get.toNamed(
        Paths.Feed + Paths.Home + Paths.Profile,
        parameters: {
          'profileUserKey': portfolio.value!.user!.userKey.toString()
        },
        arguments: profileArgs,
        id: 1,
      );
    }
  }

  setAlerts(void Function(void Function()) update,
      USER_RELATION_NOTIFICATION_AMOUNT alert) async {
    final UserRelation? data = await feedRepository.userRelationsUpdate(
      entityType: USER_RELATION_ENTITY_TYPE.PORTFOLIO,
      entityKeys: [portfolio.value?.portfolioKey],
      notificationAmount: alert,
    );
    portfolio.value = portfolio.value?.copyWith(authUserRelation: data);
    update(() {});
  }

  setPortfolio(Portfolio? p) {
    if (p != null) {
      portfolio.value =
          portfolio.value?.copyWith(authUserFollowInfo: p.authUserFollowInfo);
    }
  }
}
