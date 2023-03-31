import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../feed/shared/mixins/scroll_controller_mixin.dart';
import '../modules/follow_requests/controllers/follow_requests_controller.dart';
import '../modules/notifications/controllers/notifications_controller.dart';

class NotificationController extends GetxController with ScrollControllerMixin {
  NotificationController({
    required this.notificationsController,
    required this.followRequestsController,
    required this.irisEvent,
  });

  final NotificationsController notificationsController;
  final FollowRequestsController followRequestsController;
  final IrisEvent irisEvent;

  @override
  void onClose() {
    debugPrint('OnClose *******');
  }

  @override
  void onInit() {
    irisEvent.add(eventType: EVENT_TYPE.VIEW_SCREEN_FEED);
    super.onInit();
  }

  void scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
  }

  void jumpToBottom() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  void scrollToBottom() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
  }
}
