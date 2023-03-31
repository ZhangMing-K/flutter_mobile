import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/widgets/app_easy_rich_text/index.dart';

import '../../controllers/inbox_controller.dart';

class InboxCard extends GetView<InboxController> {
  final Rx<TextModel> text;
  final bool isLast;
  final bool isFirst;

  const InboxCard(
      {Key? key, required this.text, this.isLast = false, this.isFirst = false})
      : super(key: key);

  Collection get collection {
    return text.value.collection!;
  }

  IconData get getIcon =>
      !hasAllNotificationsOn ? Icons.notifications_off : Icons.notifications;

  bool get hasAllNotificationsOn =>
      text.value.collection?.authUserRelation?.notificationAmount ==
      USER_RELATION_NOTIFICATION_AMOUNT.ALL;

  Widget get titleWidget {
    const double fontSize = 15;
    const FontWeight fontWeight = FontWeight.w500;

    if (collection.collectionType == COLLECTION_TYPE.PRIVATE_MESSAGE) {
      final user = controller.getUser(text);
      return UserName(
        user: user,
        fontSize: fontSize,
        fontWeight: fontWeight,
        route: false,
      );
    } else if (collection.collectionType == COLLECTION_TYPE.GROUP_MESSAGE) {
      return Builder(
        builder: (context) => Text(
          text.value.collection!
              .name!, // Consistent through out the app, show correct name without capitalizing it.
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: context.theme.colorScheme.secondary,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = uuid.v4();
    final scaleFactor = context.textScaleFactor;
    return GestureDetector(
      onTap: () => controller.navigateToChat(text: text, id: id),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            Obx(() => SlidableAction(
                  backgroundColor: IrisColor.imessagePurple,
                  icon: getIcon,
                  onPressed: (_) {
                    controller.setNotificationSetting(
                      !hasAllNotificationsOn,
                      text,
                    );
                  },
                )),
          ],
          extentRatio: 0.25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            content(id),
            Transform.translate(
                offset: Offset(90 * scaleFactor, 0),
                child: Container(
                  height: 1 * scaleFactor,
                  color: Colors.grey.withOpacity(.3),
                ))
          ],
        ),
      ),
    );
  }

  Widget content(String id) {
    return Builder(builder: (context) {
      final scaleFactor = context.textScaleFactor;
      return SizedBox(
        height: 75 * scaleFactor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leading(id),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title(),
                  subtitle(),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Widget leading(String id) {
    return Builder(builder: (context) {
      final scaleFactor = context.textScaleFactor;
      return Padding(
        padding: EdgeInsets.all(8.0 * scaleFactor),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                final hasUnread = controller.isUnread(text);
                return Container(
                  width: 12.0 * scaleFactor,
                  height: 12.0 * scaleFactor,
                  decoration: BoxDecoration(
                    color: hasUnread ? Colors.blue : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: hasAllNotificationsOn
                      //icon needs same size as container to be perfectly centered
                      //after that, we scale it down slightly, this was the only way to make it as close to imessage as possible.
                      //Icons dont play nice sometimes
                      ? null
                      : Transform.scale(
                          scale: .85,
                          child: Icon(
                            CupertinoIcons.moon_fill,
                            size: 12 * scaleFactor,
                            color: hasUnread
                                ? context.isDarkMode
                                    ? Colors.black
                                    : Colors.white
                                : Colors.grey.shade500,
                          ),
                        ),
                );
              }),
              SizedBox(width: 4 * scaleFactor),
              leadingImage(id),
            ]),
      );
    });
  }

  leadingImage(String id) {
    return Builder(builder: (context) {
      final scaleFactor = context.textScaleFactor;
      var collectionPictureUrl = '';
      User? profilePicUser;
      final textCollection = collection;
      final collectionType = textCollection.collectionType;
      if (collectionType == COLLECTION_TYPE.PRIVATE_MESSAGE) {
        final currentUsers = textCollection.currentUsers;
        final User _user = (currentUsers == null || currentUsers.isEmpty)
            ? Fallback.user
            : textCollection.currentUsers![0];

        profilePicUser = _user;
      } else {
        // it's group chat
        final groupPicUrl = textCollection.pictureUrl;
        if (groupPicUrl != null) {
          collectionPictureUrl = groupPicUrl;
        }
      }

      final showGroupAvatars =
          collectionType == COLLECTION_TYPE.GROUP_MESSAGE &&
              text.value.collection!.pictureUrl == null;
      return Visibility(
        visible: showGroupAvatars,
        replacement: (collectionType == COLLECTION_TYPE.PRIVATE_MESSAGE)
            ? UserImage(
                user: profilePicUser!,
                onTapIfNoStories: () =>
                    controller.navigateToChat(text: text, id: id),
              )
            : ProfileImage(
                radius: 28 * context.textScaleFactor,
                // user: profilePicUser,
                uuid: id,
                onTap: () => controller.navigateToChat(text: text, id: id),
                url: collectionPictureUrl,
              ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2 * scaleFactor),
          child: CircleAvatar(
            backgroundColor: Colors.black,
            radius: 27 * scaleFactor,
            child: ClipOval(
              child: GroupCircleAvatar(
                height: 54 * scaleFactor,
                width: 54 * scaleFactor,
                users: [
                  ...text.value.collection!.currentUsers ?? [],
                  if (controller.authUserStore.loggedUser != null) ...[
                    controller.authUserStore.loggedUser!
                  ]
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget orderDot() {
    return Container(
        margin: const EdgeInsets.only(right: 5),
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.grey.shade600,
          shape: BoxShape.circle,
        ));
  }

//if auth relation AND notification amount not null, check notification amount
//      (text.value.collection!.authUserRelation != null &&
//              text.value.collection!.authUserRelation!.notificationAmount !=
//                  null)
//          ? text.value.collection!.authUserRelation!.notificationAmount ==
//              USER_RELATION_NOTIFICATION_AMOUNT.ALL
//          //else, assume notifications already on
//          : true;

  Widget subtitle() {
    //if the most recent message is a shared item

    return Obx(() {
      final isTyping = text.value.collection!.isTyping != null;
      final visibleText = controller.getSubtitle(text);
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isTyping)
            const Text('Typing ...')
          else
            Container(
              padding: const EdgeInsets.only(
                right: 16,
              ), //prevent long text from running to the edge of the screen
              child: RichTextEditor(
                originalText: text.value.collection!.messages?.last.value ?? '',
                text: visibleText,
                selectable: false,
                richTextStyleType: RICH_TEXT_STYLE.GREY,
                style: TextStyle(
                  color: Colors.grey.shade500,
                ),
                disableOnTap: true,
                maxLines: 2,
              ),
            ),
          // const SizedBox(height: 10),
        ],
      );
    });
  }

  Widget title() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: titleWidget),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (collection.nbrTradesToday != null &&
                    collection.nbrTradesToday! > 0)
                  orderDot(),
                Text(text.value.dateCompact,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade500,
                    )),
                const SizedBox(
                  width: 3,
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade800,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
