import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/widgets_v2/notification_card/notification_card_controller.dart';

import '../../../../../../widgets_v2/notification_card/notification_card.dart';
import '../../../controllers/notification_controller.dart';
import '../../follow_requests/views/follow_requests_view.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  final NotificationController? nController;

  const NotificationsView({Key? key, this.nController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) => Column(
              children: [
                Expanded(
                  child: IrisListView(
                    header: Column(
                      children: [
                        FollowRequestsView(nController: nController),
                      ],
                    ),
                    onRefresh: controller.pullRefresh,
                    itemCount: state!.length,
                    //key: controller.listviewController,
                    widgetLoader: const Padding(
                      padding: EdgeInsets.only(top: 24.0),
                      child: IrisLoading(),
                    ),
                    loadMore: controller.loadMore,
                    builder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          NotificationCard(
                            controller: NotificationCardController(
                              notification$: state[index],
                              onDismiss: (notificationkey) {
                                // controller.onDismiss(notificationkey);
                              },
                              onAction: (notification) {
                                final int? followRequestKey = notification
                                    ?.followRequest?.followRequestKey;
                                if (followRequestKey != null) {
                                  controller.onAction(followRequestKey);
                                  nController!.followRequestsController
                                      .onReactToFollowRequestAction(
                                          followRequestKey);
                                }
                              },
                            ),
                            onFollow:
                                (int? followRequestKey, int? notificationKey) {
                              if (followRequestKey != null) {
                                controller.onRequestFollow(followRequestKey);
                                nController!.followRequestsController
                                    .onFollow(followRequestKey);
                              } else {
                                controller
                                    .onNotificationFollow(notificationKey!);
                              }
                            },
                          ),
                          Divider(
                            color: context.theme.colorScheme.secondary
                                .withOpacity(.3),
                            height: 0,
                            thickness: 1,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
        onLoading: const IrisLoading(),
        onEmpty: NoData(
          text: 'All up to date',
          image: Image.asset(Images.noItemsInFeed,
              width: 300, height: ScreenUtil().setHeight(200)),
        ));
  }
}
