import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../../iris_common.dart';

//TODO:mode to bindings
class InviteFriends extends StatelessWidget {
  late InviteFriendsController controller;

  InviteFriends({Key? key, Function? onNextCallBack}) : super(key: key) {
    controller =
        Get.put(InviteFriendsController(onNextCallBack: onNextCallBack));
  }

  Widget actionButton() {
    return Builder(builder: (context) {
      return Container(
          padding: const EdgeInsets.only(bottom: 30, right: 12, left: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: context.theme.scaffoldBackgroundColor,
                spreadRadius: 5,
                blurRadius: 3,
                offset: const Offset(0, -2), // changes position of shadow
              ),
            ],
          ),
          child: AppButtonV2(
            borderRadius: 8,
            height: 50,
            onPressed: () async {
              await controller.submit();
            },
            width: double.maxFinite,
            child: const DefaultTextTitle(
              textTitle: 'Almost there!',
              fontSize: TextUnit.large,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            buttonType: APP_BUTTON_TYPE.SOLID,
          ));
    });
  }

  Widget body() {
    return Obx(() {
      final bool inSearch = controller.searchTerm$.value.isNotEmpty == true;

      return Container(
        child: controller.noContacts$.value == true
            ? empty()
            : controller.apiStatus$.value != API_STATUS.PENDING ||
                    inSearch == true
                ? Builder(builder: (context) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.85,
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Flexible(
                            child: listView(),
                          )
                        ]));
                  })
                : Builder(builder: (context) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.80,
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              IrisLoading(
                                  loadingText: 'Finding your contacts :)')
                            ]));
                  }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: main(),
    );
  }

  Widget connectContactsButton() {
    return Container(
        padding: const EdgeInsets.only(bottom: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: AppButtonV2(
          borderRadius: 8,
          height: 50,
          onPressed: () async {
            await controller.syncContacts();
          },
          width: double.maxFinite,
          child: Builder(builder: (context) {
            return DefaultTextTitle(
              textTitle: 'Connect your contacts',
              fontSize: TextUnit.large,
              fontWeight: FontWeight.w500,
              color: context.theme.primaryColor,
            );
          }),
          buttonType: APP_BUTTON_TYPE.OUTLINE,
        ));
  }

  Widget empty() {
    return Builder(builder: (context) {
      return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.only(top: 20, right: 12, left: 12),
          child: Obx(() {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IrisEmpty(emptyText: controller.emptyText$.value),
                  const SizedBox(height: 12),
                  connectContactsButton()
                ]);
          }));
    });
  }

  Widget header() {
    return Column(
      children: [
        title(),
        if (controller.onNextCallBack == null) pendingInvitesRow(),
        searchField(),
      ],
    );
  }

  Widget inviteButton(UserContact user) {
    return AppButtonV2(
      onPressed: () => controller.invite(contact: user),
      buttonType: APP_BUTTON_TYPE.OUTLINE,
      borderRadius: 4,
      height: 30,
      width: 70,
      child: Builder(builder: (context) {
        return DefaultTextTitle(
          textTitle: 'Invite',
          fontSize: TextUnit.extraSmall,
          fontWeight: FontWeight.w500,
          color: context.theme.primaryColor,
        );
      }),
    );
  }

  Widget listView() {
    return Obx(() {
      return IrisListView(
        onRefresh: () async => debugPrint('refreshed'),
        itemCount: controller.userContacts$.length,
        widgetLoader: const ShimmerScroll(),
        header: header(),
        apiStatus: controller.searchApiStatus$.value,
        emptyWidget: noUsers(),
        loadMore: controller.loadMore,
        builder: (BuildContext context, int index) {
          final data = controller.userContacts$[index];
          return Column(
            children: [
              userPannel(user: data),
              if (index != controller.userContacts$.length - 1) const Divider()
            ],
          );
        },
      );
    });
  }

  Widget main() {
    return IrisInstructionForm(
      actionButton: controller.onNextCallBack != null ? actionButton() : null,
      buttonOnButtom: true,
      excludeKeyboard: false,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [body()],
        ),
      ),
    );
  }

  Widget noUsers() {
    return Container(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              IrisEmpty(imagePath: Images.noItemsInFeed, emptyText: '')
            ]));
  }

  Widget numberOfFriends({int? friendCount}) {
    final String friendText = friendCount == 1 ? 'friend' : 'friends';
    final String count = friendCount.toString();
    final String completeText = '$count $friendText on Iris';
    return Container(
        padding: const EdgeInsets.only(top: 4),
        child: Builder(builder: (context) {
          return DefaultTextTitle(
            textTitle: completeText,
            color: context.theme.colorScheme.secondary,
            fontWeight: FontWeight.w300,
          );
        }));
  }

  pendingInvitesRow() {
    return Obx(() {
      final String nbrPendingInvites =
          ' (${controller.numberOfPendingInvites$.value})';
      return Container(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(children: [
          Expanded(child: Builder(builder: (context) {
            return AppButtonV2(
              width: double.infinity,
              borderRadius: 5,
              color: context.theme.hintColor,
              child: DefaultTextTitle(
                textTitle: 'See Progress',
                fontSize: ScreenUtil().setSp(TextUnit.extraSmall),
                fontWeight: FontWeight.w400,
                color: context.theme.colorScheme.secondary,
              ),
              onPressed: () => Get.toNamed(Paths.Referrals),
            );
          })),
          const SizedBox(width: 4),
          Expanded(child: Builder(builder: (context) {
            return AppButtonV2(
                width: double.infinity,
                borderRadius: 5,
                color: context.theme.hintColor,
                child: DefaultTextTitle(
                  textTitle: 'See Pending Invites$nbrPendingInvites',
                  fontSize: ScreenUtil().setSp(TextUnit.extraSmall),
                  fontWeight: FontWeight.w400,
                  color: context.theme.colorScheme.secondary,
                ),
                onPressed: () => Get.toNamed(Paths.PendingInvites));
          })),
        ]),
      );
    });
  }

  Widget searchField() {
    return Builder(builder: (context) {
      return TextField(
        onChanged: (val) => controller.searchTerm$.value = val,
        decoration: InputDecoration(
            prefixIcon: Icon(
              UniconsLine.search,
              color: context.theme.hintColor,
            ),
            hintText: 'Search by name or phone number ',
            border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                )),
            fillColor: context.theme.backgroundColor,
            filled: true),
      );
    });
  }

  Widget title() {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      child: Builder(builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DefaultTextTitle(
              bottom: SpaceUnit.small,
              top: SpaceUnit.small,
              textTitle: 'Spread the love!',
              fontSize: TextUnit.extraLarge,
              fontWeight: FontWeight.w500,
              color: context.theme.colorScheme.secondary,
              align: TextAlign.center,
            ),
            DefaultTextTitle(
              textTitle:
                  'Invite 10 friends and you can become a member of our ambassador program.',
              fontSize: TextUnit.small,
              align: TextAlign.center,
              color: context.theme.hintColor,
              fontWeight: FontWeight.w500,
            ),
          ],
        );
      }),
    );
  }

  Widget userPannel({required UserContact user}) {
    return ListTile(
      leading: Container(
          alignment: Alignment.centerLeft,
          width: 50,
          child: ProfileImage(
            url: user.profilePictureUrl,
            radius: 30,
            uuid: uuid.v4(),
          )),
      title: Builder(builder: (context) {
        return DefaultTextTitle(
          textTitle: user.fullName,
          color: context.theme.colorScheme.secondary,
          fontWeight: FontWeight.w500,
        );
      }),
      subtitle: user.friendCount != null && user.friendCount! > 0
          ? numberOfFriends(friendCount: user.friendCount)
          : null,
      trailing: inviteButton(user),
    );
  }
}
