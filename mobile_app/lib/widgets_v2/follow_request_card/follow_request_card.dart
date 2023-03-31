import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/widgets/iris_buttons.dart';
import 'package:simple_moment/simple_moment.dart';

import 'follow_request_card_controller.dart';

//TODO: Refactor this, StatelessWidget need be immutable
class FollowRequestCard extends StatelessWidget {
  final Rx<FollowRequest?> followRequest;
  final Function(FollowRequest? followRequest)? onAction;
  final Function(FollowRequest?)? onFollow;

  const FollowRequestCard({
    Key? key,
    required this.followRequest,
    this.onAction,
    this.onFollow,
  }) : super(key: key);

  User? get actionUser {
    return followRequest.value?.followerUser;
  }

  Widget acceptButton(FollowRequestCardController controller) {
    return ElevatedButton(
      child: const SizedBox(
        width: 100,
        child: Text('Accept',
            textAlign: TextAlign.center, style: TextStyle(fontSize: 15)),
      ),
      style: ButtonStyle(
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
          backgroundColor:
              MaterialStateProperty.all<Color>(IrisColor.primaryColor),
          textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(color: Colors.white))),
      onPressed: () async {
        await controller.approve();
      },
    );
  }

  Widget actions(FollowRequestCardController controller) {
    return Obx(() {
      bool followAcceptButtons = false;
      final fr = controller.followRequest$.value!;
      if (fr.status == FOLLOW_REQUEST_STATUS.PENDING) {
        followAcceptButtons = true;
      }
      if (!followAcceptButtons) {
        return Container();
      }
      return Container(
        margin: const EdgeInsets.only(left: 15, bottom: 10),
        // height: 100,
        // color: Colors.red,
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
    final id = uuid.v4();

    return GetBuilder<FollowRequestCardController>(
        global: false,
        init: FollowRequestCardController(
            followRequest$: followRequest, onAction: onAction),
        builder: (controller) {
          return Builder(builder: (context) {
            return Container(
              color: context.theme.scaffoldBackgroundColor,
              child: Column(
                children: [
                  ListTile(
                    // onTap: c.onTapCard,
                    leading: leading(controller, id),
                    title: title(controller, id),
                    subtitle: subTitle(controller, id),
                    trailing: trailing(),
                  ),
                  Container(
                    // color: Colors.red,
                    // // height: 10,
                    child: actions(controller),
                  ),
                ],
              ),
            );
          });
        });
  }

  Widget dismissable() {
    return Container(
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              margin: const EdgeInsets.only(right: 20),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ))
        ],
      ),
    );
  }

  Widget leading(FollowRequestCardController controller, String id) {
    return ProfileImage(
      url: actionUser?.profilePictureUrl,
      onTap: () => controller.routeToActionUserProfile(id),
      radius: 25,
      uuid: id,
    );
  }

  Widget rejectButton(FollowRequestCardController controller) {
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

  Widget subTitle(FollowRequestCardController controller, String id) {
    return Obx(() {
      final fr = controller.followRequest$.value!;
      String dateFrom = '';
      if (fr.requestedAt == null) {
        dateFrom = 'Unknown';
      } else {
        final moment = Moment.now();
        dateFrom = moment.from(fr.requestedAt!);
      }
      String message = 'has requested to follow you';
      if (fr.portfolio != null) {
        message =
            'has requested to follow your portfolio: ${fr.portfolio!.portfolioName}';
      }
      return InkWell(
        onTap: () => controller.onTapCard(id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              dateFrom,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    });
  }

  Widget title(FollowRequestCardController controller, String id) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () => controller.routeToActionUserProfile(id),
          child: UserName(
            user: controller.followRequest$.value!.followerUser,
          ),
        ),
      ],
    );
  }

  Widget trailing() {
    return IrisFollowButton(user$: actionUser!.obs, onFollow: onFollow);
  }
}
