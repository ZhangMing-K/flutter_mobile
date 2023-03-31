import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

@Deprecated('Instead, use the `IrisFollowButton` widget.')
class FollowButtonV2 extends StatelessWidget {
  final double width;
  final double height;
  final bool includeFollowerView;
  final FOLLOW_STATUS? followStatus;
  final UserRelation? authUserRelation;
  TextStyle? textStyle;
  FOLLOW_REQUEST_ENTITY_TYPE entityType;
  final int? entityKey;
  final c = FollowButtonController();
  final Function? refreshParent;
  final Function(int?, int?)? onFollow;
  final Function? onAfterFollowRequest;
  int? followRequestKey;
  int? notificationKey;

  FollowButtonV2({
    Key? key,
    this.width = 90,
    this.height = 28,
    this.textStyle,
    required this.followStatus,
    required this.entityType,
    required this.entityKey,
    this.refreshParent,
    this.authUserRelation,
    this.includeFollowerView = false,
    this.onFollow,
    this.followRequestKey,
    this.notificationKey,
    this.onAfterFollowRequest,
  }) : super(key: key) {
    c.entityKey = entityKey;
    c.entityType = entityType;
    c.followStatus$.value = followStatus;
    c.includeFollowerView = includeFollowerView;
    c.authUserRelation$.value = authUserRelation;
  }

  @override
  Widget build(BuildContext context) {
    if (entityKey == null) {
      return Container();
    }
    return followButton(context);
  }

  buttonText() {
    final status = c.followStatus$.value;
    if (status == FOLLOW_STATUS.APPROVED) {
      return 'Following';
    } else if (status == FOLLOW_STATUS.PENDING) {
      return 'Pending';
    } else if (status == FOLLOW_STATUS.NOT_FOLLOWING) {
      return 'Follow';
    } else if (status == FOLLOW_STATUS.ME) {
      return 'Me';
    }
  }

  Widget followButton(BuildContext context) {
    return Obx(() {
      var buttonType = APP_BUTTON_TYPE.OUTLINE;
      if (c.followStatus$.value == FOLLOW_STATUS.NOT_FOLLOWING) {
        buttonType = APP_BUTTON_TYPE.SOLID;
      }
      final status = c.followStatus$.value;
      final Color fontColor = context.theme.colorScheme.secondary;
      if (textStyle == null && status == FOLLOW_STATUS.APPROVED) {
        textStyle = TextStyle(fontSize: 12, color: fontColor);
      } else if (textStyle == null && status == FOLLOW_STATUS.PENDING) {
        textStyle = TextStyle(color: fontColor);
      }
      return AppButtonV2(
        buttonType: buttonType,
        width: width,
        padding: width <= 90 && includeFollowerView
            ? const EdgeInsets.symmetric(horizontal: 0)
            : null,
        height: height,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            buttonText(),
            style: textStyle,
          ),
          if (c.includeFollowerView && status == FOLLOW_STATUS.APPROVED)
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: fontColor,
            ),
        ]),
        onPressed: () async {
          if (onFollow != null) {
            onFollow!(followRequestKey, notificationKey);
          }
          if (refreshParent != null) {
            refreshParent!(
                followStatus: c.followStatus$.value,
                entityType: entityType,
                entityKey: entityKey);
          }
          await c.requestToFollow(context);
          if (onAfterFollowRequest != null) {
            onAfterFollowRequest!();
          }
        },
      );
    });
  }
}
