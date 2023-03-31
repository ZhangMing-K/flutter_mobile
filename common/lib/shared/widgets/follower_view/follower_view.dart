import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/shared/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:iris_common/shared/widgets/bottom_sheet/bottom_sheet_single_scroll.dart';

import '../../../shared/types/index.dart';
import 'follower_view_controller.dart';

// import 'package:iris_mobile/screens/profile_search/profile_search_controller.dart';

//TODO: Refactor this
class FollowerView extends StatelessWidget {
  late final FollowerViewController c;

  final int? userKey;

  final int? portfolioKey;
  final FollowActionFunction refreshParent;
  final List<PANNEL_ITEMS>? pannelActions;

  FollowerView({
    Key? key,
    required this.userKey,
    required this.refreshParent,
    required this.portfolioKey,
    required this.pannelActions,
  }) : super(key: key) {
    //TODO: remove this
    c = FollowerViewController(
      userKey: userKey,
      portfolioKey: portfolioKey,
      pannelActions: pannelActions,
      refreshParent: refreshParent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        if (pannelActions!.contains(PANNEL_ITEMS.REMOVE_FOLLOWER) ||
            pannelActions!.contains(PANNEL_ITEMS.STOP_FOLLOWING))
          removeFollowerTile(context),
        if (pannelActions!.contains(PANNEL_ITEMS.HIDE) ||
            pannelActions!.contains(PANNEL_ITEMS.UNHIDE))
          hideTile(context)
      ]),
    );
  }

  Widget hideTile(BuildContext context) {
    late String muteTitleText;
    String? muteSubTitleText;

    final bool hide = c.pannelActions!.contains(PANNEL_ITEMS.HIDE);
    final String actionText = hide ? 'Hide' : 'Unhide';
    final icon = hide
        ? Icon(Icons.remove_circle_outline,
            color: context.theme.colorScheme.secondary)
        : Icon(
            Icons.check_circle,
            color: context.theme.primaryColor,
          );

    if (c.portfolioKey == null) {
      muteTitleText = '$actionText posts from this user';
      muteSubTitleText =
          hide ? 'Iris will not notify the user you hid them' : null;
    } else if (c.portfolioKey != null) {
      muteTitleText = '$actionText orders from this portfolio';
      muteSubTitleText = hide
          ? 'Iris will not notify the user you stopped their portfolio'
          : null;
    }

    return tile(context,
        icon: icon,
        titleText: muteTitleText,
        subTitleText: muteSubTitleText, onTap: () async {
      await c.hide(context, hide: hide);
    });
  }

  removeFollowerTile(BuildContext context) {
    late String titleText;
    String? subTitleText;
    if (c.userKey != null &&
        c.pannelActions!.contains(PANNEL_ITEMS.REMOVE_FOLLOWER)) {
      titleText = 'Remove User';
      subTitleText =
          'Iris will not notify the user they were removed from your followers';
    } else if (c.portfolioKey == null &&
        c.pannelActions!.contains(PANNEL_ITEMS.STOP_FOLLOWING)) {
      titleText = 'Stop following this user';
      subTitleText = 'Iris will not notify the user you stopped following them';
    }
    return tile(context,
        icon: Icon(Icons.cancel, color: context.theme.colorScheme.secondary),
        titleText: titleText,
        subTitleText: subTitleText, onTap: () async {
      if (c.pannelActions!.contains(PANNEL_ITEMS.REMOVE_FOLLOWER)) {
        await c.removeFollower(context);
      } else if (c.pannelActions!.contains(PANNEL_ITEMS.STOP_FOLLOWING)) {
        await c.unfollow(context);
      }
    });
  }

  tile(context,
      {Function? onTap,
      Icon? icon,
      required String titleText,
      String? subTitleText}) {
    return Column(children: [
      ListTile(
        onTap: onTap as void Function()?,
        leading: icon,
        title: Text(titleText),
        subtitle: subTitleText != null ? Text(subTitleText) : null,
      )
    ]);
  }

  static openPannel(
      {int? userKey,
      int? portfolioKey,
      required FollowActionFunction refreshParent,
      required BuildContext context,
      List<PANNEL_ITEMS>? pannelActions}) {
    return IrisBottomSheet.show(
      initialHeight: 310,
      maxHeight: 310,
      context: context,
      child: (_) => IrisBottomSheetSingleScroll(
        initialChildSize: .7,
        maxChildSize: .7,
        child: FollowerView(
          userKey: userKey,
          refreshParent: refreshParent,
          portfolioKey: portfolioKey,
          pannelActions: pannelActions,
        ),
      ),
      // openPanelPosition: 0.35,
    );
  }
}
