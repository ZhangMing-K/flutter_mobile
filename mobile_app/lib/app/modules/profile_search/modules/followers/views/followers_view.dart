import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iris_common/iris_common.dart';

import '../../widgets.dart';
import '../controllers/followers_controller.dart';

class FollowersView extends StatelessWidget {
  final Function? onUpdate;
  final FollowersController controller;
  const FollowersView({this.onUpdate, required this.controller, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) {
          return Column(
            children: [
              Expanded(
                child: IrisListView(
                  onRefresh: controller.pullRefresh,
                  itemCount: state!.length,
                  widgetLoader: const ShimmerScroll(isScrollable: false),
                  loadMore: controller.loadMore,
                  builder: (BuildContext context, int index) {
                    return ProfileSearchUserTile(
                        user: state[index],
                        profileUser: controller.profileUser.value,
                        removeFunctionality: controller.profileUser.value
                                    ?.authUserFollowInfo?.followStatus ==
                                FOLLOW_STATUS.ME
                            ? true
                            : false,
                        editFunctionality: controller.profileUser.value
                                    ?.authUserFollowInfo?.followStatus ==
                                FOLLOW_STATUS.ME
                            ? true
                            : false,
                        removeAction: (userKey) async {
                          final followerNumber = controller.profileUser.value
                              ?.followStats?.numberOfFollowers;
                          int newFollowerNum = 0;
                          if (followerNumber != null && followerNumber > 0) {
                            newFollowerNum = followerNumber - 1;
                          }
                          await controller.onFollowerRemove(
                              userKey, newFollowerNum);
                          if (onUpdate != null) {
                            onUpdate!('follower', newFollowerNum);
                          }
                        });
                  },
                ),
              ),
            ],
          );
        },
        onLoading: const ShimmerScroll(),
        onEmpty: Obx(() {
          return NoData(
            text:
                controller.profileUser.value?.followStats?.numberOfFollowers !=
                            null &&
                        controller.profileUser.value!.followStats!
                                .numberOfFollowers! >
                            0
                    ? 'Sorry, no users match your search'
                    : 'Sorry, you currently have no followers.',
            backgroundColor: null,
            type: NO_DATA_TYPE.FIT,
            image: Image.asset(Images.noItemsInFeed, width: 300, height: 300),
          );
        }));
  }
}

class ShimmerScroll extends StatelessWidget {
  final bool isScrollable;
  const ShimmerScroll({
    Key? key,
    this.isScrollable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        addAutomaticKeepAlives: false,
        itemCount: isScrollable ? 6 : 3,
        shrinkWrap: true,
        physics: isScrollable
            ? const BouncingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return const ListTileShimmer();
        });
  }
}
