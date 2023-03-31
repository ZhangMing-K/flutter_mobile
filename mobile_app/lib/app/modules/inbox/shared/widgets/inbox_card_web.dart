import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/widgets/app_easy_rich_text/index.dart';
import 'package:iris_mobile/app/modules/inbox/controllers/inbox_controller.dart';
import 'package:unicons/unicons.dart';

class InboxCardWeb extends GetView<InboxController> {
  final Rx<TextModel> text;
  final bool isLast;
  final bool isFirst;

  const InboxCardWeb(
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
    const double fontSize = 12;
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
          GetUtils.capitalize(text.value.collection!.name!)!,
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
    return GestureDetector(
      onTap: () => controller.navigateToChat(text: text, id: id),
      child: Slidable(
        // startActionPane: SlidableDrawerActionPane(),
        // // actions: [
        // //   IconSlideAction(
        // //     color: Colors.red,
        // //     icon: UniconsLine.trash,
        // //     onTap: () {
        // //       controller.removeConversation(collection.collectionKey);
        // //     },
        // //   )
        // // ],
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
        ),

        child: SizedBox(
          height: 75,
          child: content(id),
        ),
      ),
    );
  }

  Widget content(String id) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        children: [
          leading(id),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title(),
                subtitle(),
                Expanded(child: Container()),
                Divider(
                  color: Colors.grey.withOpacity(.3),
                  indent: 0,
                  endIndent: 0,
                  height: 0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget leading(String id) {
    String? url;
    final textCollection = collection;
    final collectionType = textCollection.collectionType;
    if (collectionType == COLLECTION_TYPE.PRIVATE_MESSAGE) {
      final currentUsers = textCollection.currentUsers;
      final User _user = (currentUsers == null || currentUsers.isEmpty)
          ? Fallback.user
          : textCollection.currentUsers![0];

      url = _user.profilePictureUrl;
    } else {
      // it's group chat
      final groupPicUrl = textCollection.pictureUrl;
      if (groupPicUrl != null) {
        url = groupPicUrl;
      }
    }

    final showGroupAvatars = collectionType == COLLECTION_TYPE.GROUP_MESSAGE &&
        text.value.collection!.pictureUrl == null;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              final hasUnread = controller.isUnread(text);
              return Container(
                width: 9.0,
                height: 9.0,
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
                          size: 9,
                          color:
                              hasUnread ? Colors.black : Colors.grey.shade500,
                        ),
                      ),
              );
            }),
            const SizedBox(width: 4),
            Visibility(
              visible: showGroupAvatars,
              replacement: ProfileImage(
                radius: 20,
                uuid: id,
                onTap: () => controller.navigateToChat(text: text, id: id),
                url: url,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 20,
                child: ClipOval(
                  child: GroupCircleAvatar(
                    height: 32.75,
                    width: 32.75,
                    users: [
                      ...text.value.collection!.currentUsers ?? [],
                      ...[controller.authUserStore.loggedUser!]
                    ],
                  ),
                ),
              ),
            ),
          ]),
    );
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
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                disableOnTap: true,
                maxLines: 2,
              ),
            ),
          const SizedBox(height: 10),
        ],
      );
    });
  }

  Widget title() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleWidget,
            Row(
              children: [
                if (collection.nbrTradesToday != null &&
                    collection.nbrTradesToday! > 0)
                  orderDot(),
                Text(text.value.dateCompact,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                    )),
                const SizedBox(
                  width: 3,
                ),
                Icon(
                  UniconsLine.arrow_right,
                  color: Colors.grey.shade800,
                  size: 15,
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
