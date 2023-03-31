import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:unicons/unicons.dart';

import 'group_details_controller.dart';
import 'group_details_sheet/group_settings_sheet.dart';
import 'group_details_user_item_controller.dart';

class GroupDetailsView extends GetWidget<GroupDetailsController> {
  const GroupDetailsView({Key? key}) : super(key: key);

  int? get authUserKey => controller.authUserStore.loggedUser?.userKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(controller.isPrivateMessage ? 'Chat Details' : 'Group Details',
                style: TextStyle(
                  color: context.theme.colorScheme.secondary,
                )),
      ),
      body: Obx(() {
        controller.getTextCollection?.value;
        return Container(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: Center(
                            child: profile(),
                          ),
                        ),
                        if (!controller.isPrivateMessage)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: IrisColor.primaryColor,
                              child: InkWell(
                                onTap: () {
                                  controller.changeProfilePic();
                                },
                                child: const Center(
                                  child: Icon(
                                    UniconsLine.edit_alt,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Center(
                  child: EditableText(
                    autofocus: false,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    backgroundCursorColor: Colors.amber,
                    cursorColor: Colors.green,
                    style: TextStyle(
                      fontSize: 20,
                      color: context.theme.colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                    focusNode: FocusNode(),
                    controller:
                        TextEditingController(text: controller.username),
                    onSubmitted: (val) {
                      controller.changeGroupName(val);
                    },
                  ),
                ),

                const SizedBox(height: 20.0),
                Center(
                  child: EditableText(
                    autofocus: false,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    backgroundCursorColor: Colors.amber,
                    cursorColor: Colors.green,
                    style: TextStyle(
                        color: context.theme.colorScheme.secondary
                            .withOpacity(0.7)),
                    focusNode: FocusNode(),
                    controller: TextEditingController(
                      text: controller.status,
                    ),
                    onSubmitted: (val) {
                      controller.changeDescription(val);
                      Get.focusScope!.unfocus();
                    },
                  ),
                ),
                const SizedBox(height: 12.0),
                settings(),
                const SizedBox(height: 40.0),
                members(),
                const SizedBox(height: 16.0),
                leaveChat(),
                const SizedBox(height: 16.0),
                // reportChat(context),
                const SizedBox(height: 36.0),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget leaveChat() {
    if (controller.isPrivateMessage) {
      return Container();
    }
    return Column(children: [
      InkWell(
        child: Row(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                width: 50,
                child: IconButton(
                  icon: const Icon(UniconsLine.sign_out_alt),
                  iconSize: 30,
                  color: const Color.fromRGBO(225, 82, 65, 1.0),
                  onPressed: () {},
                )),
            const SizedBox(
              width: 16.0,
            ),
            const DefaultTextTitle(
              textTitle: 'Leave chat',
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(225, 82, 65, 1.0),
            ),
          ],
        ),
        onTap: () {
          controller.onLeaveChat();
        },
      ),
      Container(
        padding: const EdgeInsets.only(left: 12.0),
        child: Builder(
          builder: (context) => Text(
            'Once you leave, you will not be able to see these group messages unless someone invites you back in.',
            style: TextStyle(
              color: context.theme.colorScheme.secondary.withOpacity(0.7),
            ),
          ),
        ),
      )
    ]);
  }

  Widget members() {
    final currentCollection = controller.getCollection;
    if (currentCollection?.collectionType == COLLECTION_TYPE.GROUP_MESSAGE) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            const Text('Members',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(width: 4.0),
            Text(controller.numberOfCurrentUsers.toString())
          ],
        ),
        const SizedBox(height: 30),
        InkWell(
            onTap: () {
              controller.onShowInvitePage();
            },
            child: Row(
              children: [
                Container(
                    alignment: Alignment.topCenter,
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: IrisColor.primaryColor,
                    ),
                    child: IconButton(
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 2),
                        child: Icon(
                          UniconsLine.user_plus,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        controller.onShowInvitePage();
                      },
                    )),
                const SizedBox(width: 16),
                const DefaultTextTitle(
                  textTitle: 'Invite people',
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ],
            )),
        ListView.builder(
          itemCount: controller.getCurrentUsers.length,
          shrinkWrap: true,
          addAutomaticKeepAlives: false,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final data = controller.getCurrentUsers[index];
            final GroupDetailsUserItemController userController =
                GroupDetailsUserItemController(user: data.obs);
            return userItem(user: data, userController: userController);
          },
        )
      ]);
    }
    return Container();
  }

  Widget profile() {
    final avatar = controller.avatarUrl;
    final currentCollection = controller.getCollection;

    if (currentCollection?.collectionType == COLLECTION_TYPE.PRIVATE_MESSAGE) {
      if (avatar.isEmpty) {
        return ProfileImage(
          radius: 50,
          uuid: uuid.v4(),
          url: Fallback.user.profilePictureUrl,
        );
      }
      return ProfileImage(
        radius: 50,
        showFullScreen: true,
        uuid: uuid.v4(),
        onTap: null,
        //controller.changeProfilePic,
        url: avatar,
      );
    } else if (currentCollection?.collectionType ==
        COLLECTION_TYPE.GROUP_MESSAGE) {
      final listUser = currentCollection?.currentUsers ?? <User>[];

      return Visibility(
        visible: controller.avatarUrl.isEmpty,
        replacement: ProfileImage(
          radius: 50,
          uuid: uuid.v4(),
          showFullScreen: true,
          onTap: null,
          //controller.changeProfilePic,
          url: avatar,
        ),
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.blue,
          child: ClipOval(
            child: GroupCircleAvatar(
              height: 100,
              width: 100,
              users: [
                ...listUser,
                ...[controller.authUserStore.loggedUser!]
              ],
            ),
          ),
        ),
      );
    } else {
      return ProfileImage(
        radius: 50,
        uuid: controller.id ?? uuid.v4(),
        url: avatar,
      );
    }
  }

  Widget reportChat() {
    return Column(children: [
      InkWell(
        child: Row(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                width: 50,
                child: IconButton(
                  icon: const Icon(UniconsLine.exclamation),
                  iconSize: 30,
                  color: const Color.fromRGBO(225, 82, 65, 1.0),
                  onPressed: () {},
                )),
            const SizedBox(
              width: 16.0,
            ),
            const DefaultTextTitle(
              textTitle: 'Report chat',
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(225, 82, 65, 1.0),
            ),
          ],
        ),
        onTap: () {},
      ),
      Container(
        padding: const EdgeInsets.only(left: 12.0),
        child: Builder(
          builder: (context) => Text(
            'Report offensive and inappropriate behavior. Iris in a safe platform, and we want to keep it that way.',
            style: TextStyle(
              color: context.theme.colorScheme.secondary.withOpacity(0.7),
            ),
          ),
        ),
      )
    ]);
  }

  Widget settings() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Settings',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(FeatherIcons.bell),
                    onPressed: () {},
                    padding: const EdgeInsets.all(0.0),
                    alignment: Alignment.centerLeft,
                    iconSize: 24,
                  ),
                  const Text('Notifications',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                ],
              ),
              CupertinoSwitch(
                value: controller.isNotificationsOn,
                onChanged: (bool value) {
                  controller.setNotificationSetting(value);
                },
                activeColor: IrisColor.primaryColor,
              ),
            ],
          ),
        ],
      ),
    ]);
  }

  Widget userItem(
      {required User user,
      required GroupDetailsUserItemController userController}) {
    final id = uuid.v4();
    return Builder(
        builder: (context) => ListTile(
              contentPadding:
                  const EdgeInsets.only(left: 0, right: 0, top: 4.0),
              onTap: () {
                user.routeToFromProfilePicture(null, id);
              },
              leading: Container(
                  alignment: Alignment.centerLeft,
                  width: 50,
                  child: AbsorbPointer(
                    child: ProfileImage(
                      url: user.profilePictureUrl,
                      radius: 30,
                      uuid: id,
                      onTap: () {
                        user.routeToFromProfilePicture(null, id);
                      },
                    ),
                  )),
              title: AbsorbPointer(
                child: UserName(
                  user: user,
                  fontWeight: FontWeight.w500,
                  route: true,
                ),
              ),
              subtitle: Obx(() {
                final status = userController.userStatus;
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
              }),
              trailing: authUserKey != user.userKey
                  ? IconButton(
                      icon: const Icon(UniconsLine.ellipsis_v),
                      onPressed: () {
                        IrisBottomSheet.show(
                            context: context,
                            initialHeight: 150,
                            maxHeight: 150,
                            child: (ScrollController scrollController) {
                              return GroupSettingsSheet(user: user);
                            });
                      },
                    )
                  : null,
            ));
  }
}
