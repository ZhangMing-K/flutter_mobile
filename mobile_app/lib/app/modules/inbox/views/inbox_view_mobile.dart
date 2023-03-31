import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/pages.dart';
import '../controllers/inbox_controller.dart';
import '../shared/widgets/inbox_card.dart';
import '../shared/widgets/no_messages.dart';

class InboxScreenMobile extends GetView<InboxController> {
  const InboxScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IrisTabView.expanded(
        showBackButton: true,
        horizontalPadding: 0,
        tabs: [
          IrisTab(
            text: 'Messages',
            body: content(),
          )
        ],
        actions: [
          Row(
            children: [
              toInviteFriends(),
              const SizedBox(
                width: 10,
              ),
              toGroupChat()
            ],
          )
        ],
        backgroundColor: context.theme.scaffoldBackgroundColor,
      ),
    );
  }

  Widget content() {
    return controller.obx(
      (state) {
        return IrisListView(
          // onRefresh: controller.pullRefresh,
          itemCount: state!.length,
          widgetLoader: const ShimmerScroll(useSpinner: true),
          loadMore: controller.loadMore,
          builder: (BuildContext context, int index) {
            final text = state[index];

            return InboxCard(
              text: text,
              isLast: index == state.length - 1,
              isFirst: index == 0,
            );
          },
        );
      },
      onLoading: const ShimmerScroll(useSpinner: true),
      onEmpty: const NoMessagesInbox(),
    );
  }

  Widget toGroupChat() {
    return IconButton(
      icon: Builder(builder: (context) {
        return Image.asset(
          IconPath.groupChat,
          color: context.isDarkMode ? null : IrisColor.irisBlueLight,
          width: 20,
        );
      }),
      onPressed: () {
        controller.openPannel();
      },
    );
  }

  Widget toInviteFriends() {
    return Builder(builder: (context) {
      return GestureDetector(
        child: Image.asset(
          IconPath.inviteStar,
          color: context.isDarkMode ? null : IrisColor.irisBlueLight,
          height: 20,
        ),
        onTap: () {
          ///copied from LogoAppBar implementation
          final IAuthUserService authUserStore = Get.find();
          final authUser = authUserStore.loggedUser;
          final bool syncedNumber = authUser?.phoneNumber != null &&
              authUser!.phoneNumber!.isNotEmpty;
          if (!syncedNumber) {
            Get.toNamed(Paths.MfaContactConnect);
          } else {
            Get.toNamed(Paths.ExploreFriends);
          }
        },
      );
    });
  }
}
