import 'package:flutter/material.dart' hide Notification;
import 'package:get/get.dart';

import '../../app/routes/pages.dart';

class NotificationCardController extends GetxController {
  final Rx<NotificationModel?>? notification$;
  final Function(int? notificationKey)? onDismiss;
  final Function(NotificationModel? notification)? onAction;
  final FollowService followService = Get.find();
  final NotificationService notificationService = Get.find();
  NotificationCardController({
    required this.notification$,
    required this.onAction,
    required this.onDismiss,
  });
  approve() async {
    return respondToRequest(action: FOLLOW_REQUEST_ACTION.APPROVE);
  }

  denied() {
    return respondToRequest(action: FOLLOW_REQUEST_ACTION.DENY);
  }

  onDismissed() async {
    onDismiss!(notification$?.value?.notificationKey);
    await notificationService.notificationsUpdate(
        ignored: true,
        notificationKeys: [notification$?.value?.notificationKey]);
  }

  onTapCard(String id) {
    final actionName = notification$!.value?.action!.actionName;
    String routePath = '';
    dynamic arguments;
    if (actionName == NOTIFICATION_ACTION_NAME.USER_REACTED ||
        actionName == NOTIFICATION_ACTION_NAME.USER_MENTIONED ||
        actionName == NOTIFICATION_ACTION_NAME.USER_POST_FEATURED) {
      if (notification$!.value?.text?.textType == TEXT_TYPE.COMMENT) {
        routePath =
            Paths.Text.createPath([notification$!.value?.text!.parentKey]);
      } else if (notification$!.value?.text?.textType == TEXT_TYPE.POST ||
          notification$!.value?.text?.textType == TEXT_TYPE.ORDER) {
        routePath =
            Paths.Text.createPath([notification$!.value?.text!.textKey]);
      }
    } else if (actionName == NOTIFICATION_ACTION_NAME.USER_COMMENTED) {
      routePath = Paths.Text.createPath([notification$!.value?.text!.textKey]);
    } else if (actionName == NOTIFICATION_ACTION_NAME.USER_TRADED) {
      /// If there are multiple orders, route to the "focused feed" screen to show the list of orders traded
      /// if only one order, route to the full page for that order to enable user to easily comment/like etc.
      if (notification$!.value!.orders!.isNotEmpty) {
        routePath = Paths.FocusedFeed.createPath();
        arguments = {
          'focusedFeedArguments': {
            'fromPush': true,
            'textKeys': notification$!.value?.orders!
                .map((e) => e.text!.textKey)
                .toList()
          }
        };
      } else {
        routePath = Paths.Text.createPath(
            [notification$!.value?.orders![0].text!.textKey]);
      }
    } else if (actionName ==
        NOTIFICATION_ACTION_NAME.PORTFOLIO_FIRST_SYNC_COMPLETE) {
      routePath = Paths.Portfolio.createPath(
          [notification$!.value!.portfolio!.portfolioKey]);
    } else if (actionName == NOTIFICATION_ACTION_NAME.FOLLOW_REQUEST_USER ||
        actionName == NOTIFICATION_ACTION_NAME.FOLLOW_REQUEST_USER_ACCEPTED) {
      routeToActionUserProfile(id);
      return;
    } else {
      routeToUserProfile(id);
      return;
    }
    Get.toNamed(routePath, arguments: arguments, id: 1);
  }

  Future<void> respondToRequest({required FOLLOW_REQUEST_ACTION action}) async {
    final followRequestKey =
        notification$?.value?.followRequest!.followRequestKey;
    if (action == FOLLOW_REQUEST_ACTION.APPROVE) {
      notification$?.value = notification$!.value?.copyWith(
          followRequest: notification$!.value?.followRequest
              ?.copyWith(status: FOLLOW_REQUEST_STATUS.APPROVED));
    } else {
      notification$?.value = notification$!.value?.copyWith(
          followRequest: notification$!.value?.followRequest!
              .copyWith(status: FOLLOW_REQUEST_STATUS.DENIED));
    }
    if (onAction != null) {
      onAction!(notification$!.value);
    }
    try {
      await followService.respondToFollowRequest(
          followRequestKey: followRequestKey, action: action);
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  routeToActionUserProfile(String id) {
    Get.toNamed(
      Paths.Feed + Paths.Home + Paths.Profile,
      parameters: {
        'profileUserKey': notification$!.value!.actionUser!.userKey.toString()
      },
      arguments: ProfileArgs(
        heroTag: id,
        user: notification$!.value!.actionUser ?? const User(),
      ),
      id: 1,
    );
  }

  routeToUserProfile(String id) {
    Get.toNamed(
      Paths.Feed + Paths.Home + Paths.Profile,
      parameters: {
        'profileUserKey': notification$!.value!.user!.userKey!.toString()
      },
      arguments: ProfileArgs(
        user: notification$?.value?.user ?? const User(),
        heroTag: id,
      ),
      id: 1,
    );
  }
}
