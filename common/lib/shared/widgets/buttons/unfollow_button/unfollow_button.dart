import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class UnfollowButton extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;
  final FOLLOW_STATUS? followStatus;
  TextStyle? textStyle;
  final int? portfolioKey;
  final int? userKey;
  final c = UnfollowButtonController();
  final FollowActionFunction refreshParent;
  String? activeTab;

  UnfollowButton(
      {Key? key,
      this.width = 100,
      this.height = 30,
      this.textStyle,
      this.color,
      required this.followStatus,
      this.portfolioKey,
      required this.userKey,
      required this.refreshParent,
      this.activeTab})
      : super(key: key) {
    c.portfolioKey = portfolioKey;
    c.userKey = userKey;
    c.followStatus$.value = followStatus;
  }

  @override
  Widget build(BuildContext context) {
    return followButton(context);
  }

  Widget followButton(BuildContext context) {
    const buttonType = APP_BUTTON_TYPE.OUTLINE;
    return AppButtonV2(
      buttonType: buttonType,
      width: width * context.textScaleFactor,
      color: color ?? context.theme.primaryColor,
      height: height,
      child: Text(
        'Remove',
        style: textStyle,
      ),
      onPressed: () async => {
        FollowerView.openPannel(
            portfolioKey: portfolioKey,
            pannelActions: [PANNEL_ITEMS.REMOVE_FOLLOWER],
            userKey: userKey,
            context: context,
            refreshParent: refreshParent)
      },
    );
  }
}
