import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/text_card/text_card_controller.dart';
import 'package:unicons/unicons.dart';

import '../../share_link/share_link.dart';
import '../flag_pannel/flag_pannel.dart';
import 'text_setting_pannel_data.dart';
import 'text_settings_pannel_controller.dart';

//TODO: Refactor this
class TextSettingPannel extends StatelessWidget {
  final TextCardController? textCardController;
  final TextSettingPannelController c;
  // final CommentCardController commentCardController;
  final TextSettingsPannelData? pannelData;
  final Rx<TextModel?>? text;
  TextSettingPannel({
    this.pannelData,
    this.text,
    required this.textCardController,
    // @required this.commentCardController,
  }) : c = TextSettingPannelController(textCardController) {
    c.text = text;
    c.pannelData = pannelData;
  }

  // BuildContext scaffoldContext;
  @override
  Widget build(BuildContext context) {
    //  c.initContext(context: context);
    return Obx(() => Container(
          child: c.shareView.value != true
              ? ListView(
                  children: [
                    if (c.pannelData!.pannelItems
                        .contains(PANNEL_ITEMS.FEATURE))
                      feature(),
                    if (c.pannelData!.pannelItems.contains(PANNEL_ITEMS.FLAG))
                      report(context),
                    if (c.pannelData!.pannelItems.contains(PANNEL_ITEMS.EDIT))
                      edit(),
                    if (c.pannelData!.pannelItems.contains(PANNEL_ITEMS.SHARE))
                      share(context),
                    if (c.pannelData!.pannelItems
                        .contains(PANNEL_ITEMS.COPY_LINK))
                      copyLink(context),
                    if (c.pannelData!.pannelItems.contains(PANNEL_ITEMS.DELETE))
                      delete(),
                    if (c.pannelData!.pannelItems.contains(PANNEL_ITEMS.MUTE) ||
                        c.pannelData!.pannelItems.contains(PANNEL_ITEMS.UNMUTE))
                      muteTile(context),
                    if (c.pannelData!.pannelItems.contains(PANNEL_ITEMS.HIDE))
                      hideTile(context),
                    blockTile()
                  ],
                )
              : ShareLink(shareLink: c.shareLink.value),
        ));
  }

  copyLink(BuildContext context) {
    const String title = 'Copy Link!';
    return PannelTile(
      onTap: () async {
        await c.copy(context);
      },
      text: title,
      textAlignment: Alignment.centerLeft,
      leading: Icon(
        UniconsLine.copy,
        color: context.theme.colorScheme.secondary,
      ),
    );
  }

  delete() {
    return Builder(builder: (context) {
      return PannelTile(
        onTap: () async => await c.onDeleteTap(),
        textAlignment: Alignment.centerLeft,
        leading: Icon(
          UniconsLine.trash,
          color: context.theme.colorScheme.secondary,
          // color: Colors.black,
        ),
        text: 'Delete',
      );
    });
  }

  edit() {
    String title = 'Edit';
    // String subTitle;
    if (text!.value!.textType == TEXT_TYPE.ORDER && text!.value == null) {
      title = 'Add reason for trade';
    } else if (text!.value!.textType == TEXT_TYPE.ORDER &&
        text!.value != null) {
      title = 'Edit reason for trade';
    } else if (text!.value!.textType == TEXT_TYPE.DUE_DILIGENCE) {
      title = 'Edit this Trade Idea';
    }
    return Builder(builder: (context) {
      return PannelTile(
          text: title,
          leading: Icon(
            UniconsLine.edit_alt,
            color: context.theme.colorScheme.secondary,
            // color: Colors.black,
          ),
          onTap: () {
            if (text!.value!.textType == TEXT_TYPE.DUE_DILIGENCE) {
              c.editDDCard(text!);
            } else {
              c.onTapEdit();
            }
          },
          textAlignment: Alignment.centerLeft);
    });
  }

  feature() {
    String title = 'Feature';
    if (text!.value!.featuredAt != null) {
      title = 'Unfeature';
    }

    return PannelTile(
      textAlignment: Alignment.centerLeft,
      text: title,
      leading: const Icon(UniconsLine.star, color: IrisColor.gold),
      onTap: () async => await c.onFeatureTap(),
    );
  }

  hideTile(BuildContext context) {
    String? muteTitleText;
    String? muteSubTitleText;
    final bool isOrder = c.text?.value?.textType == TEXT_TYPE.ORDER;
    final actionText = c.pannelData!.textIsHid ? 'Unhide' : 'Hide';

    final icon = c.pannelData!.textIsHid
        ? Icon(
            UniconsLine.check_circle,
            color: context.theme.primaryColor,
          )
        : Icon(UniconsLine.minus_circle,
            color: context.theme.colorScheme.secondary);

    if (isOrder) {
      muteTitleText = '$actionText orders from this user';
      muteSubTitleText = c.pannelData!.textIsHid
          ? null
          : 'Iris will not notify the user you hid their portfolio';
    } else if (!isOrder) {
      muteTitleText = '$actionText posts from this user';
      muteSubTitleText = c.pannelData!.textIsHid
          ? null
          : 'Iris will not notify the user you hid them';
    }

    return PannelTile(
      onTap: () async {
        await c.userRelationUpdate(
            hide: c.pannelData!.textIsHid ? false : true);
      },
      leading: icon,
      text: muteTitleText,
      textAlignment: Alignment.centerLeft,
      subtitleText: muteSubTitleText,
    );
  }

  blockTile() {
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

  muteTile(BuildContext context) {
    String muteTitleText;
    String? muteSubTitleText;
    final bool isOrder = c.text?.value?.textType == TEXT_TYPE.ORDER;
    final actionText = c.pannelData!.textIsMuted ? 'Unmute' : 'Mute';

    final icon = c.pannelData!.textIsMuted
        ? Icon(
            FeatherIcons.bell,
            color: context.theme.primaryColor,
          )
        : Icon(
            FeatherIcons.bellOff,
            color: context.theme.colorScheme.secondary,
            // color: context.textTheme.subtitle1.color,
          );

    muteTitleText = '$actionText notifications from this thread';

    return PannelTile(
      textAlignment: Alignment.centerLeft,
      text: muteTitleText,
      subtitleText: muteSubTitleText,
      leading: icon,
      onTap: () async {
        await c.userRelationUpdate(
            mute: c.pannelData!.textIsMuted ? false : true);
      },
    );
  }

  report(context) {
    String title = 'Report';
    const String action = 'remove';

    if (c.authUserStore.loggedUser!.userAccessType == USER_ACCESS_TYPE.ADMIN) {
      title += ' and $action';
    }

    return PannelTile(
      leading: const Icon(
        UniconsLine.exclamation_circle,
        color: Colors.red,
      ),
      color: Colors.red,
      text: title,
      textAlignment: Alignment.centerLeft,
      onTap: () async {
        c.closeBottomSheet();
        Timer(
            const Duration(milliseconds: 200),
            () async => {
                  FlagPannel.openPannel(
                    flagEntityType: FLAG_ENTITY_TYPE.TEXT,
                    flagEntityKey: c.text!.value!.textKey,
                  )
                });
      },
    );
  }

  share(BuildContext context) {
    const String title = 'Share';

    return PannelTile(
        onTap: () async => await c.share(),
        textAlignment: Alignment.centerLeft,
        leading: Icon(
          UniconsLine.share,
          color: context.theme.colorScheme.secondary,
        ),
        text: title);
  }

  static openPannel({
    Rx<TextModel?>? text,
    required TextSettingsPannelData pannelData,
    TextCardController? textCardController,
  }) {
    Get.bottomSheet(
        CustomBottomSheet(
            child: TextSettingPannel(
              pannelData: pannelData,
              text: text,
              textCardController: textCardController,
            ),
            maxHeight: pannelData.maxHeight),
        isScrollControlled: true,
        enableDrag: true);
  }
}
