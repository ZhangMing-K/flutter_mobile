import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'controllers/notification_controller.dart';
import 'modules/notifications/views/notifications_view.dart';

class NewNotificationScreen extends GetView<NotificationController> {
  const NewNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IrisTabView.expanded(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          //  showBackButton: true,
          // horizontalPadding: 0,
          tabs: [
            IrisTab(
                text: 'Activity',
                body: NestedScrollView(
                  controller: controller.scrollController,
                  headerSliverBuilder: (context, _) {
                    return [
                      const SliverToBoxAdapter(
                          child: SizedBox(
                              height:
                                  1) // sometimes scroll doesn't work if the child is just Container()
                          ),
                    ];
                  },
                  body: NotificationsView(nController: controller),
                ))
          ]),
    );
  }
}
