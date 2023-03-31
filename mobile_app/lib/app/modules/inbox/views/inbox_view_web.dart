import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/pages.dart';
import '../../feed/shared/widgets/rails/nav_rails.dart';
import '../controllers/inbox_controller.dart';
import '../shared/widgets/inbox_card_web.dart';
import '../shared/widgets/no_messages.dart';

class InboxScreenWeb extends StatelessWidget {
  const InboxScreenWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InboxScreenWrapper(
      child: Container(
          // decoration: BoxDecoration(
          //   borderRadius: kBorderRadius,
          //   color: context.theme.backgroundColor,
          // ),
          ),
    );
  }
}

class InboxScreenWrapper extends GetView<InboxController> {
  final Widget child;
  const InboxScreenWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NavRail(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        title: SizedBox(
          height: 40,
          child: Row(
            children: [
              Image.asset(Images.irisWhiteLogo),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                // LeaderboardBar(),
                // NotificationBell(),

                toInviteFriends(),
                const SizedBox(
                  width: 10,
                ),
                toGroupChat(),
              ],
            ),
          )
        ],
        body: Container(
          margin: const EdgeInsets.only(top: 30),
          padding: EdgeInsets.symmetric(horizontal: context.width / 35),
          child: content(context),
          // IrisTabView.expanded(
          //   tabs: [
          //     IrisTab(
          //       text: 'Messages',
          //       body: content(),
          //     )
          //   ],
          //   actions: [
          //     Row(
          //       children: [
          //         toInviteFriends(),
          //         SizedBox(
          //           width: 10,
          //         ),
          //         toGroupChat()
          //       ],
          //     )
          //   ],
          //   backgroundColor: context.theme.scaffoldBackgroundColor,
          // ),
        ),
      ),
    );
  }

  Widget content(BuildContext context) {
    return controller.obx((state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 360,
            decoration: BoxDecoration(
              borderRadius: kBorderRadius,
              color: context.theme.backgroundColor,
            ),
            height: double.infinity,
            child: IrisListView(
              // onRefresh: controller.pullRefresh,
              itemCount: state!.length,
              widgetLoader: const ShimmerScroll(),
              loadMore: controller.loadMore,
              builder: (BuildContext context, int index) {
                final text = state[index];
                return InboxCardWeb(
                  text: text,
                  isLast: index == state.length - 1,
                  isFirst: index == 0,
                );
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Builder(builder: (context) {
              return child;
            }),
          ),
        ],
      );
    }, onLoading: const ShimmerScroll(), onEmpty: const NoMessagesInbox());
  }

  Widget toGroupChat() {
    return IconButton(
      icon: Image.asset(
        IconPath.groupChat,
        width: 20,
      ),
      onPressed: () {
        controller.openPannel();
      },
    );
  }

  toInviteFriends() {
    return GestureDetector(
      child: Image.asset(
        IconPath.inviteStar,
        height: 20,
      ),
      onTap: () {
        ///copied from LogoAppBar implementation
        final IAuthUserService authUserStore = Get.find();
        final authUser = authUserStore.loggedUser;
        final bool syncedNumber =
            authUser?.phoneNumber != null && authUser!.phoneNumber!.isNotEmpty;
        if (!syncedNumber) {
          Get.toNamed(Paths.MfaContactConnect);
        } else {
          Get.toNamed(Paths.ExploreFriends);
        }
      },
    );
  }
}
