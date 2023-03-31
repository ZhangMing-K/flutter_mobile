import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iris_common/iris_common.dart';
import '../../widgets.dart';
import '../controllers/following_controller.dart';

class FollowingView extends StatelessWidget {
  final Function? onUpdate;
  final FollowingController controller;
  const FollowingView({this.onUpdate, required this.controller, Key? key})
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
                        removeAction: (userKey) {
                          final numberFollowing = controller
                              .profileUser.value?.followStats?.numberFollowing;
                          int newFollowingNum = 0;
                          if (numberFollowing != null && numberFollowing > 0) {
                            newFollowingNum = numberFollowing - 1;
                          }
                          controller.onRemoveFollowing(
                              userKey, newFollowingNum);
                          if (onUpdate != null) {
                            onUpdate!('following', newFollowingNum);
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
            text: controller.profileUser.value?.followStats?.numberFollowing !=
                        null &&
                    controller
                            .profileUser.value!.followStats!.numberFollowing! >
                        0
                ? 'Sorry, no users match your search'
                : 'You currently are not following anyone.',
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
