import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../../../../routes/pages.dart';
import '../../../shared/widgets/message_appbar.dart';
import '../../../views/inbox_view_web.dart';
import '../controllers/chat_controller.dart';
import '../modules/messages/messages_view.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.responsiveValue(
      mobile: ChatScreenMobile(
        key: key,
      ),
      tablet: const ChatScreenWeb(),
    )!;
  }
}

class ChatScreenMobile extends GetWidget<ChatController> {
  const ChatScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      color: context.theme.scaffoldBackgroundColor,
      padding: EdgeInsets.only(bottom: context.isKeyboardOpen ? 0 : 15),
      child: Scaffold(
        //  resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Obx(() => ChatBar(
                onAppBarTap: controller.onChatBarTapped,
                color: context.theme.scaffoldBackgroundColor,
                actions: [
                  IconButton(
                    icon: const Icon(UniconsLine.ellipsis_v),
                    onPressed: () {
                      Get.toNamed(
                        Paths.GroupDetails.createPath(
                            [controller.collectionKey!]),
                        id: 1,
                      );
                    },
                  )
                ],
                name: controller.chatname.value,
                profile: Obx(() => AbsorbPointer(child: profile())),
                hasSubtitle: controller.chatbarSubtitle.isNotEmpty,
                status: Obx(() {
                  final status = controller.chatbarSubtitle;
                  return Text(
                    GetUtils.capitalizeFirst(status)!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(13),
                      fontWeight: FontWeight.w300,
                    ),
                  );
                }),
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: IrisTabView(
            indicatorColor: context.theme.colorScheme.secondary,
            labelColor: context.theme.colorScheme.secondary,
            backgroundColor: context.theme.scaffoldBackgroundColor,
            keyboardHidesTabbar: true,
            hideTab: true,
            tabs: [
              IrisTab(
                text: '',
                body: MessagesView(
                  controller: controller,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget? orderDot() {
    if (controller.currentCollection$.nbrTradesToday == null) {
      return null;
    }
    if (controller.currentCollection$.nbrTradesToday! > 0) {
      return Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.grey.shade600,
            shape: BoxShape.circle,
          ));
    }
    return null;
  }

  Widget profile() {
    final avatar = controller.avatarUrl;

    final currentCollection = controller.currentCollection$;

    if (currentCollection.collectionType == COLLECTION_TYPE.PRIVATE_MESSAGE) {
      return ProfileImage(
        radius: 20,
        uuid: controller.id,
        onTap: controller.onChatBarTapped,
        url: avatar,
      );
    } else if (currentCollection.collectionType ==
        COLLECTION_TYPE.GROUP_MESSAGE) {
      final listUser = currentCollection.currentUsers ?? <User>[];

      return Visibility(
        visible: controller.avatarUrl.isEmpty,
        replacement: ProfileImage(
          radius: 20,
          uuid: controller.id,
          onTap: controller.onChatBarTapped,
          url: avatar,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 1, right: 3, bottom: 5),
          child: CircleAvatar(
            radius: 20,
            child: ClipOval(
              child: GroupCircleAvatar(
                users: [
                  ...listUser,
                  ...[controller.authUserStore.loggedUser!]
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return ProfileImage(
        radius: 20,
        uuid: controller.id.toString(),
        url: avatar,
      );
    }
  }
}

class ChatScreenWeb extends GetWidget<ChatController> {
  const ChatScreenWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InboxScreenWrapper(
      child: Container(
        color: context.theme.scaffoldBackgroundColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Obx(() => ChatBar(
                    onAppBarTap: controller.onChatBarTapped,
                    color: context.theme.scaffoldBackgroundColor,
                    actions: [
                      IconButton(
                        icon: const Icon(UniconsLine.ellipsis_v),
                        onPressed: () {
                          Get.toNamed(
                              Paths.GroupDetails.createPath(
                                  [controller.collectionKey!]),
                              id: 1);
                        },
                      )
                    ],
                    name: controller.chatname.value,
                    profile: Obx(() => profile()),
                    hasSubtitle: controller.chatbarSubtitle.isNotEmpty,
                    status: Obx(() {
                      final status = controller.chatbarSubtitle;
                      return AutoSizeText(
                        GetUtils.capitalizeFirst(status)!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(13),
                          fontWeight: FontWeight.w300,
                        ),
                      );
                    }),
                  )),
            ),
            body: getView(),
          ),
        ),
      ),
    );
  }

  Widget getView() {
    return Builder(
      builder: (context) => IrisTabView(
        indicatorColor: context.theme.colorScheme.secondary,
        labelColor: context.theme.colorScheme.secondary,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        tabs: [
          IrisTab(
            text: 'Messages',
            body: MessagesView(
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }

  Widget? orderDot() {
    if (controller.currentCollection$.nbrTradesToday == null) {
      return null;
    }
    if (controller.currentCollection$.nbrTradesToday! > 0) {
      return Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.grey.shade600,
            shape: BoxShape.circle,
          ));
    }
    return null;
  }

  Widget profile() {
    final avatar = controller.avatarUrl;

    final currentCollection = controller.currentCollection$;

    if (currentCollection.collectionType == COLLECTION_TYPE.PRIVATE_MESSAGE) {
      return ProfileImage(
        radius: 20,
        uuid: controller.id,
        onTap: controller.onChatBarTapped,
        url: avatar,
      );
    } else if (currentCollection.collectionType ==
        COLLECTION_TYPE.GROUP_MESSAGE) {
      final listUser = currentCollection.currentUsers ?? <User>[];

      return Visibility(
        visible: controller.avatarUrl.isEmpty,
        replacement: ProfileImage(
          radius: 20,
          uuid: controller.id,
          onTap: controller.onChatBarTapped,
          url: avatar,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 1, right: 3, bottom: 5),
          child: CircleAvatar(
            radius: 20,
            child: ClipOval(
              child: GroupCircleAvatar(
                users: [
                  ...listUser,
                  ...[controller.authUserStore.loggedUser!]
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return ProfileImage(
        radius: 20,
        uuid: controller.id.toString(),
        url: avatar,
      );
    }
  }
}
