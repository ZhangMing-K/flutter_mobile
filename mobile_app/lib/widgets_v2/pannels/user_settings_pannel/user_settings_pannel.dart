import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:unicons/unicons.dart';

import '../flag_pannel/flag_pannel.dart';
import 'user_setting_pannel_data.dart';
import 'user_settings_pannel_controller.dart';

class UserSettingsPannel extends StatelessWidget {
  UserSettingsPannelController c = UserSettingsPannelController();

  Rx<User>? user;

  UserSettingsPannelData? pannelData;
  UserSettingsPannel({this.user, this.pannelData}) {
    c.user$ = user;
    c.pannelData = pannelData;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (c.pannelData!.pannelItems.contains(PANNEL_ITEMS.FLAG)) report(),
        if (c.pannelData!.pannelItems.contains(PANNEL_ITEMS.UNSUSPEND))
          unsuspend(),
        if (c.pannelData!.pannelItems.contains(PANNEL_ITEMS.HIDE)) hideTile(),
        if (c.pannelData!.pannelItems.contains(PANNEL_ITEMS.BLOCK)) blockTile(),
      ],
    );
  }

  Widget blockTile() {
    return PannelTile(
      onTap: () async {
        await c.userRelationUpdate(block: true);
      },
      leading: const Icon(
        UniconsLine.exclamation_triangle,
        color: Colors.red,
      ),
      color: Colors.red,
      text: 'Block',
      textAlignment: Alignment.centerLeft,
    );
  }

  Widget hideTile() {
    String muteTitleText;
    String? muteSubTitleText;
    final actionText = c.pannelData!.userIsHid ? 'Unhide' : 'Hide';

    final icon = Builder(builder: (context) {
      return c.pannelData!.userIsHid
          ? Icon(
              Icons.check_circle,
              color: context.theme.primaryColor,
            )
          : Icon(
              Icons.remove_circle_outline,
              color: context.theme.colorScheme.secondary,
            );
    });

    muteTitleText = '$actionText posts from this user';
    muteSubTitleText = c.pannelData!.userIsHid
        ? null
        : 'Iris will not notify the user you hid them';

    return PannelTile(
      onTap: () async {
        await c.userRelationUpdate(
            hide: c.pannelData!.userIsHid ? false : true);
      },
      leading: icon,
      text: muteTitleText,
      textAlignment: Alignment.centerLeft,
      subtitleText: muteSubTitleText,
    );
  }

  Widget report() {
    String title = 'Report';
    const String action = 'suspend';

    if (c.authUserStore.loggedUser!.userAccessType == USER_ACCESS_TYPE.ADMIN) {
      title += ' and $action';
    }

    return PannelTile(
      text: title,
      leading: const Icon(
        Icons.error_outlined,
        color: Colors.red,
      ),
      textAlignment: Alignment.centerLeft,
      color: Colors.red,
      onTap: () async {
        c.closeBottomSheet();
        Timer(
            const Duration(milliseconds: 200),
            () async => {
                  FlagPannel.openPannel(
                    flagEntityType: FLAG_ENTITY_TYPE.USER,
                    flagEntityKey: c.user!.userKey,
                  )
                });
      },
    );
  }

  unsuspend() {
    const String title = 'Unsuspend User';
    return PannelTile(
      leading: Builder(builder: (context) {
        return Icon(
          Icons.check_circle,
          color: context.theme.primaryColor,
        );
      }),
      textAlignment: Alignment.centerLeft,
      text: title,
      onTap: () async {
        await c.unsuspend();
      },
    );
  }

  static openPannel(
      {Rx<User>? user, required UserSettingsPannelData pannelData}) {
    Get.bottomSheet(
        CustomBottomSheet(
          maxHeight: pannelData.maxHeight,
          child: UserSettingsPannel(
            user: user,
            pannelData: pannelData,
          ),
        ),
        isScrollControlled: true,
        enableDrag: true);
  }
}
