import 'package:flutter/material.dart' hide Notification;
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/widgets/iris_buttons.dart';

import 'notification_card_controller.dart';

class NotificationCard extends StatelessWidget {
  final NotificationCardController controller;
  final Function(int? followRequestKey, int? notificationKey)? onFollow;
  const NotificationCard({Key? key, required this.controller, this.onFollow})
      : super(key: key);
  User? get actionUser {
    return notification?.actionUser;
  }

  NotificationModel? get notification {
    return controller.notification$!.value;
  }

  acceptButton(NotificationCardController controller) {
    return Builder(
        builder: (context) => TextButton(
              onPressed: () async {
                await controller.approve();
              },
              child: SizedBox(
                width: 100,
                child: Text('Accept',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        color: context.theme.colorScheme.secondary)),
              ),
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(0)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    context.theme.primaryColor),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  const TextStyle(color: Colors.white),
                ),
              ),
            ));
  }

  Widget actions(NotificationCardController controller) {
    return Obx(() {
      bool followAcceptButtons = false;
      final notification = controller.notification$?.value;
      if (notification?.followRequest?.status ==
          FOLLOW_REQUEST_STATUS.PENDING) {
        followAcceptButtons = true;
      }
      if (!followAcceptButtons) {
        return Container();
      }
      return Container(
        margin: const EdgeInsets.only(left: 15, bottom: 10),
        child: Row(
          children: [
            acceptButton(controller),
            const SizedBox(
              width: 10,
            ),
            rejectButton(controller)
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return main(controller);
  }

  Widget leading(
      NotificationCardController controller, String id, BuildContext context) {
    double brokerRadius = 25;
    double brokerHeight = brokerRadius + baseRingNumber(brokerRadius);
    brokerHeight = brokerHeight * 2 * context.textScaleFactor;
    if (controller.notification$?.value?.action?.actionName ==
        NOTIFICATION_ACTION_NAME.PORTFOLIO_FIRST_SYNC_COMPLETE) {
      return BrokerIcon(
        brokerName: controller.notification$?.value?.portfolio!.brokerName,
        height: brokerHeight,
      );
    } else {
      return SizedBox(
          width: brokerHeight,
          height: brokerHeight,
          child: Center(
              child: UserImage(
                  user: actionUser!,
                  onTapIfNoStories: () =>
                      controller.routeToActionUserProfile(id),
                  brokerName: notification?.portfolio?.brokerName,
                  id: id)));
    }
  }

  Widget main(NotificationCardController controller) {
    final id = uuid.v4();
    return Obx(() {
      bool followAcceptButtons = false;
      final notification = controller.notification$?.value;
      if (notification?.followRequest?.status ==
          FOLLOW_REQUEST_STATUS.PENDING) {
        followAcceptButtons = true;
      }
      if (followAcceptButtons) {
        return Container();
      }
      return Builder(builder: (context) {
        return Container(
          color: context.theme.scaffoldBackgroundColor,
          child: Column(
            children: [
              Container(
                  height: 76 * context.textScaleFactor,
                  margin: EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8 * context.textScaleFactor),
                  width: context.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: InkWell(
                        onTap: () => controller.onTapCard(id),
                        child: Row(
                          children: [
                            leading(controller, id, context),
                            const SizedBox(width: 16),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                title(controller, id),
                                subTitle(controller, id)
                              ],
                            )),
                          ],
                        ),
                      )),
                      trailing(context)
                    ],
                  )),
              Container(
                child: actions(controller),
              ),
            ],
          ),
        );
      });
    });
  }

  Widget rejectButton(NotificationCardController controller) {
    return OutlinedButton(
      onPressed: () async {
        await controller.denied();
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
      ),
      child: const SizedBox(
          width: 100,
          child: Text(
            'Decline',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
            ),
          )),
    );
  }

  Widget subTitle(NotificationCardController controller, String id) {
    final notification = controller.notification$?.value;
    String? message = notification?.message;
    if (notification?.displayMessage != null &&
        notification!.displayMessage != '') {
      message = notification.displayMessage;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (message != null && message != '')
          Text(
            message,
            softWrap: true,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
        Text(
          notification?.dateFrom ?? '',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget title(NotificationCardController controller, String id) {
    return InkWell(
      onTap: () => controller.routeToActionUserProfile(id),
      child: titleContent(controller, id),
    );
  }

  titleContent(NotificationCardController controller, id) {
    if (controller.notification$?.value?.action?.actionName ==
        NOTIFICATION_ACTION_NAME.PORTFOLIO_FIRST_SYNC_COMPLETE) {
      return IrisPortfolioName(
          portfolio: controller.notification$!.value!.portfolio);
    } else {
      return UserName(
        user: controller.notification$?.value?.actionUser,
        heroTag: id,
      );
    }
  }

  trailing(BuildContext context) {
    if (notification?.assets != null && notification!.assets!.isNotEmpty) {
      final List<Asset> assets = notification!.assets!;
      if (assets.length > 1) {
        return SizedBox(
            width: 50 * context.textScaleFactor,
            height: 50 * context.textScaleFactor,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    // right: 10,
                    top: 0,
                    left: 0,
                    child: AppAssetImage(
                      asset: assets[0],
                      height: 35,
                    )),
                Positioned(
                    // left: 10,
                    bottom: 0,
                    right: 0,
                    child: AppAssetImage(
                      asset: assets[1],
                      height: 35,
                    ))
              ],
            ));
      }
      return SizedBox(
        width: 50 * context.textScaleFactor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppAssetImage(
              asset: assets[0],
              height: 50,
            )
          ],
        ),
      );
    }

    if (actionUser != null) {
      return IrisFollowButton(
          user$: actionUser!.obs,
          onFollow: (fr) {
            onFollow!(fr.followRequestKey,
                controller.notification$!.value!.notificationKey);
          });
    } else {
      return const SizedBox(
        width: 0,
      );
    }
  }
}
