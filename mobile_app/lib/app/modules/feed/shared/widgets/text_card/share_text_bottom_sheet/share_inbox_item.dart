import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'share_inbox_item_controller.dart';
import 'share_text_controller.dart';

enum SHARE_INBOX_TYPE { INBOX, USER }

class ShareInboxItemView extends StatelessWidget {
  final Rx<TextModel>? text;
  final Rx<User>? user;
  final bool isLast;
  final bool isFirst;
  //final IAuthUserService authUserStore = Get.find();
  final ShareTextController controller;
  final Function onShow;
  final Function onHide;
  final SHARE_INBOX_TYPE inboxType;
  final ShareInboxItemController itemController;
  const ShareInboxItemView(
      {Key? key,
      this.text,
      this.user,
      required this.controller,
      required this.itemController,
      required this.onShow,
      required this.onHide,
      required this.inboxType,
      this.isLast = false,
      this.isFirst = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool isSelected = controller.isSelected(
          inboxType == SHARE_INBOX_TYPE.INBOX ? text!.value : user!.value);
      return ListTile(
          onTap: onTap,
          minVerticalPadding: 0,
          contentPadding: const EdgeInsets.only(top: 0, left: 10, right: 10),
          tileColor: Colors.transparent,
          focusColor: Colors.grey.shade300,
          hoverColor: Colors.grey.shade300,
          leading: leading(),
          title: title(context),
          trailing: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: isSelected ? IrisColor.irisBlueLight : Colors.grey),
              color: isSelected ? IrisColor.irisBlueLight : Colors.transparent,
            ),
            child: Icon(isSelected ? Icons.check : null,
                color: context.theme.colorScheme.secondary),
          ),
          subtitle: Obx(() {
            final status = itemController.userStatus;
            return Row(
              children: [
                if (status == 'Active now')
                  CircleAvatar(
                    radius: 6.0,
                    backgroundColor: context.theme.primaryColor,
                    child: Icon(null,
                        color: context.theme.primaryColor, size: 10.0),
                  )
                else
                  Container(),
                if (status == 'Active now')
                  const SizedBox(width: 8)
                else
                  Container(),
                Text(
                  GetUtils.capitalizeFirst(status)!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(13),
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            );
          }));
    });
  }

  leading() {
    if (inboxType == SHARE_INBOX_TYPE.INBOX) {
      final collectionType = itemController.collection.collectionType;
      String url = '';
      // String? avatarCode;
      int? id;
      if (collectionType == COLLECTION_TYPE.PRIVATE_MESSAGE) {
        url = itemController.getUser!.profilePictureUrl!;
        //  avatarCode = itemController.getUser!.avatar?.code!;
        id = itemController.getUser!.userKey;
      } else {
        // it's group chat
        final groupPicUrl = itemController.collection.pictureUrl;
        if (groupPicUrl != null) {
          url = groupPicUrl;
        }
      }
      final showGroupAvatars =
          collectionType == COLLECTION_TYPE.GROUP_MESSAGE &&
              itemController.collection.pictureUrl == null;

      return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: showGroupAvatars,
              replacement: ProfileImage(
                radius: 25,
                uuid: id.toString(),
                onTap: onTap,
                url: url,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 25,
                child: ClipOval(
                  child: GroupCircleAvatar(
                    height: 50,
                    width: 50,
                    users: [
                      ...itemController.collection.currentUsers ?? [],
                      ...[controller.authUserStore.loggedUser!]
                    ],
                  ),
                ),
              ),
            ),
          ]);
    } else {
      final url = user!.value.profilePictureUrl;
      // final avatarCode = user!.value.avatar?.code;
      final id = user!.value.userKey;
      return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ProfileImage(
              radius: 25,
              url: url,
              onTap: onTap,
              uuid: id.toString(),
            )
          ]);
    }
  }

  Future<void> onTap() async {
    controller.onClick(
        inboxType == SHARE_INBOX_TYPE.INBOX ? text!.value : user!.value);

    if (controller.selectedInbox$.isEmpty &&
        controller.selectedFollowerList$.isEmpty) {
      onHide();
    } else {
      onShow();
    }
  }

  Widget title(BuildContext context) {
    Widget titleWiget = Container();
    const double fontSize = 15;
    const FontWeight fontWeight = FontWeight.w500;
    if (inboxType == SHARE_INBOX_TYPE.INBOX) {
      if (itemController.collection.collectionType ==
          COLLECTION_TYPE.PRIVATE_MESSAGE) {
        final user = itemController.getUser;

        titleWiget = UserName(
          user: user,
          fontSize: fontSize,
          fontWeight: fontWeight,
          route: false,
        );
      } else if (itemController.collection.collectionType ==
          COLLECTION_TYPE.GROUP_MESSAGE) {
        titleWiget = Flexible(
            child: Text(
          itemController.collection.name!,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: context.theme.colorScheme.secondary),
        ));
      }
    } else {
      titleWiget = UserName(
        user: user!.value,
        fontSize: fontSize,
        fontWeight: fontWeight,
        route: false,
      );
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleWiget,
          ],
        ),
      ],
    );
  }
}
