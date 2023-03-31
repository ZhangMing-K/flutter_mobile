import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/pending_invites_controller.dart';

class PendingInvitesMobile extends GetWidget<PendingInvitesController> {
  const PendingInvitesMobile({Key? key}) : super(key: key);

  body(BuildContext context) {
    return Obx(() {
      return Container(
        child: controller.noPendingInvites$.value == true
            ? empty(context)
            : controller.apiStatus$.value != API_STATUS.PENDING
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Flexible(
                        child: listView(context),
                      )
                    ]))
                : const IrisLoading(
                    loadingText: 'Getting your pending invites :)'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        title: 'Pending Invites',
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: body(context)),
    );
  }

  empty(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 20, right: 12, left: 12),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              IrisEmpty(emptyText: 'You have no pending invites'),
            ]));
  }

  inviteButton(BuildContext context, UserContact user) {
    return AppButtonV2(
      onPressed: () => controller.sendReminder(contact: user),
      buttonType: APP_BUTTON_TYPE.OUTLINE,
      borderRadius: 4,
      height: 30,
      width: 140,
      child: DefaultTextTitle(
        textTitle: 'Send Reminder',
        fontSize: TextUnit.extraSmall,
        fontWeight: FontWeight.w500,
        color: context.theme.primaryColor,
      ),
    );
  }

  Widget listView(BuildContext context) {
    return IrisListView(
      onRefresh: () async => debugPrint('refreshed'),
      itemCount: controller.pendingInvites$.length,
      widgetLoader: const ShimmerScroll(),
      loadMore: controller.loadMore,
      builder: (BuildContext context, int index) {
        final data = controller.pendingInvites$[index];
        return Column(
          children: [
            userPannel(user: data, context: context),
            if (index != controller.pendingInvites$.length - 1) const Divider()
          ],
        );
      },
    );
  }

  Widget userPannel(
      {required UserContact user, required BuildContext context}) {
    return ListTile(
      leading: Container(
          alignment: Alignment.centerLeft,
          width: 50,
          child: ProfileImage(
            url: user.profilePictureUrl,
            radius: 30,
            uuid: uuid.v4(),
          )),
      title: DefaultTextTitle(
          fontWeight: FontWeight.w500,
          color: context.theme.colorScheme.secondary,
          textTitle: user.fullName),
      subtitle: DefaultTextTitle(
          fontWeight: FontWeight.w300,
          color: context.theme.colorScheme.secondary,
          textTitle: 'Already Invited'),
      trailing: inviteButton(context, user),
    );
  }
}
