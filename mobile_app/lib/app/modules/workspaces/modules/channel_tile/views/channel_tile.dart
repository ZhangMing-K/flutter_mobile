import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../../../../../widgets_v2/pannels/workspace_pannel/workspace_pannel.dart';
import '../../../views/private_channels_warning_dialog.dart';
import '../controllers/channel_tile_controller.dart';

class ChannelTile extends GetWidget<ChannelTileController> {
  final Workspace? workspace;
  const ChannelTile({
    Key? key,
    required this.workspace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.setWorkspace(workspace!);
    return main(context);
  }

  connectedIcon(BuildContext context) {
    return iconWithText(
        Image.asset(
          IconPath.connected,
          height: 25,
        ),
        'Portfolio Connected',
        IrisColor.primaryColor);
  }

  disconnectedIcon(BuildContext context) {
    return iconWithText(
        Image.asset(
          IconPath.disconnected,
          height: 25,
        ),
        'Connect portfolio',
        IrisColor.subTitle);
  }

  enableBotSlider(BuildContext context) {
    return Obx(() {
      return SizedBox(
          height: 20,
          child: Switch(
            value: controller.workspace$.value!.botEnabled!,
            onChanged: (value) async {
              HapticFeedback.mediumImpact();
              await controller.updateWorkspace(
                  workspaceKey: controller.workspace$.value!.workspaceKey!,
                  botEnabled: value);
            },
            inactiveTrackColor: IrisColor.inactive,
            activeTrackColor: IrisColor.primaryColor,
            inactiveThumbColor: IrisColor.accentColorDark,
            activeColor: IrisColor.accentColorDark,
          ));
    });
  }

  iconWithText(Image icon, String text, Color color) {
    return Container(
      width: 90,
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          Text(text,
              textAlign: TextAlign.center, style: TextStyle(color: color))
        ],
      ),
    );
  }

  main(BuildContext context) {
    return Obx(() {
      final bool slideUpEnabled =
          controller.workspace$.value!.authUserMayAddPortfolio == true;

      final bool dialogEnabled =
          controller.workspace$.value!.botInChannel == false &&
              controller.workspace$.value!.authUserHasUpdatePermissions;

      return GestureDetector(
          onTap: () async => {
                if (dialogEnabled == true)
                  await Get.dialog(
                      const PrivateChannelsWarningDialog(
                        isParentWorkspace: false,
                      ),
                      barrierDismissible: true)
                else if (slideUpEnabled == true)
                  WorkspacePannel.openPannel(
                      workspace: controller.workspace$.value!),
              },
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(workspace!.channelName,
                      style: const TextStyle(fontSize: 18)),
                  if (controller.workspace$.value!.botEnabled == true)
                    subText(context)
                ]),
                trailing(context)
              ]));
    });
  }

  permissionsRow(BuildContext context) {
    return Obx(() {
      final Color color = controller.workspace$.value!.botEnabled == true
          ? context.theme.primaryColor
          : context.theme.colorScheme.secondary;
      final String text = controller.workspace$.value!.orderPostingPermission ==
              ORDER_POSTING_PERMISSIONS.ADMIN_ONLY
          ? 'Admin Only'
          : 'All Members';

      return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 6),
          child: Text(text,
              textAlign: TextAlign.start, style: TextStyle(color: color)));
    });
  }

  portfoliosRow(BuildContext context) {
    return Obx(() {
      final String portfolioText =
          controller.workspace$.value!.authUserPortfolios!.length == 1
              ? 'portfolio'
              : 'portfolios';
      final String prefixText =
          controller.workspace$.value!.authUserPortfolios!.isEmpty
              ? 'No'
              : '${controller.workspace$.value!.authUserPortfolios!.length}';

      return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 3),
          child: Text('$prefixText $portfolioText connected',
              textAlign: TextAlign.start,
              style: TextStyle(color: context.theme.hintColor)));
    });
  }

  subText(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          permissionsRow(context),
          if (controller.workspace$.value!.authUserMayAddPortfolio == true)
            portfoliosRow(context)
        ],
      ),
    );
  }

  trailing(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (!controller.workspace$.value!.botInChannel &&
              controller.workspace$.value!.authUserHasUpdatePermissions == true)
            SizedBox(
                width: 80,
                child: Text(
                  'Action Required',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: context.theme.hintColor),
                ))
          else if (controller.workspace$.value!.authUserHasUpdatePermissions ==
                  true &&
              controller.workspace$.value!.botInChannel)
            enableBotSlider(context)
          else if (controller.workspace$.value!.authUserMayAddPortfolio == true)
            trailingIcon(context)
          else
            SizedBox(
                width: 80,
                child: Text(
                  "Can't connect",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: context.theme.hintColor),
                ))
        ],
      ),
    );
  }

  trailingIcon(BuildContext context) {
    return Container(
        child: controller.workspace$.value!.authUserPortfolios!.isNotEmpty
            ? connectedIcon(context)
            : disconnectedIcon(context));
  }
}
