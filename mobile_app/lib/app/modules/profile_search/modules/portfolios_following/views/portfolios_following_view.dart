import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iris_common/iris_common.dart';

import '../../widgets.dart';
import '../controllers/portfolios_following_controller.dart';

class PortfoliosFollowingView extends GetView<PortfoliosFollowingController> {
  final Function? onUpdate;
  const PortfoliosFollowingView({Key? key, this.onUpdate}) : super(key: key);

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
                widgetLoader: const ShimmerScroll(),
                loadMore: controller.loadMore,
                builder: (BuildContext context, int index) {
                  return ProfileSearchPortfolioList(
                      portfolio: state[index],
                      user: state[index].user,
                      removeAction: (portfolioKey) async {
                        final originNum = controller.profileUser.value
                            ?.followStats!.numberOfPortfoliosFollowing;
                        int newFollowingNum = 0;
                        if (originNum != null && originNum > 0) {
                          newFollowingNum = originNum - 1;
                        }
                        await controller.onRemovePortfolio(
                            portfolioKey, newFollowingNum);
                        if (onUpdate != null) {
                          onUpdate!('portfoliosFollowing', newFollowingNum);
                        }
                      },
                      editFunctionality: controller.profileUser.value
                                  ?.authUserFollowInfo?.followStatus ==
                              FOLLOW_STATUS.ME
                          ? true
                          : false,
                      profileUser: controller.profileUser.value);
                },
              ),
            ),
          ],
        );
      },
      onLoading: const ShimmerScroll(),
      onEmpty: NoData(
        text: 'No users match your search',
        backgroundColor: null,
        type: NO_DATA_TYPE.FIT,
        image: Image.asset(Images.noItemsInFeed, width: 300, height: 300),
      ),
    );
  }
}
