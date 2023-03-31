import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../widgets_v2/follow_request_card/follow_request_card.dart';
import '../../../controllers/notification_controller.dart';
import '../../shimmer.dart';
import '../controllers/follow_requests_controller.dart';

class FollowRequestsView extends GetView<FollowRequestsController> {
  const FollowRequestsView({Key? key, this.nController}) : super(key: key);
  final NotificationController? nController;

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      final widgets = [];
      state!.take(3).toList().forEach((e) => {
            widgets.add(Column(
              children: [
                FollowRequestCard(
                    followRequest: e,
                    onFollow: (request) {
                      final int? followRequestKey = request?.followRequestKey;
                      controller.onFollow(followRequestKey!);
                      nController!.notificationsController
                          .onRequestFollow(followRequestKey);
                    },
                    onAction: (request) {
                      final int? followRequestKey = request?.followRequestKey;
                      if (followRequestKey != null) {
                        controller.onAction(followRequestKey);
                        nController!.notificationsController
                            .onReactNotifications(followRequestKey);
                      }
                    }),
                Divider(
                  color: context.theme.colorScheme.secondary.withOpacity(.3),
                  height: 0,
                  thickness: 1,
                ),
              ],
            ))
          });
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                'Pending',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w500,
                  color: context.theme.colorScheme.secondary,
                ),
              )),
          ...widgets,
          if (state.isNotEmpty)
            Container(
                margin: const EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  'Recent',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(
                      16,
                    ),
                    fontWeight: FontWeight.w500,
                    color: context.theme.colorScheme.secondary,
                  ),
                )),
        ],
      );
    }, onLoading: const ShimmerScroll(), onEmpty: Container());
  }
}

class ShimmerScroll extends StatelessWidget {
  const ShimmerScroll({
    Key? key,
    this.isScrollable = true,
  }) : super(key: key);
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        physics: isScrollable
            ? const BouncingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return const NotificationCardShimmer();
        });
  }
}
