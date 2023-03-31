import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/text_card/text_card.dart';

import '../../../../explorer/modules/order_flow_summary/view/order_flow_summary_view.dart';
import '../../../../explorer/modules/who_to_follow/widgets/popular_on_following.dart';
import '../controllers/posts_controller.dart';

class PostsNewView extends GetView<PostsController> {
  final Widget header;

  const PostsNewView({Key? key, required this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        return PrimaryScrollController(
          controller: controller.scrollController,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Obx(() {
                controller.recommendedList.value;
                if (controller.currentFilter.value ==
                    PUBLIC_FEED_CATEGORY.INVESTORS) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          child: header,
                        ),
                        const PopularOnFollowing()
                      ],
                    ),
                  );
                }
                return controller.currentFilter.value ==
                        PUBLIC_FEED_CATEGORY.ORDER_FLOW
                    ? SingleChildScrollView(
                        child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                            ),
                            child: header,
                          ),
                          const OrderFlowSummaryView()
                        ],
                      ))
                    : IrisListView(
                        keyboardHidesHeader: false,
                        header: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: header,
                            ),
                          ],
                        ),
                        onRefresh: controller.pullRefresh,
                        itemCount: state!.length,
                        widgetLoader: const ShimmerScroll(useSpinner: true),
                        loadMore: controller.loadMore,
                        emptyWidget: NoData(
                          text: 'Check again later for new ' +
                              controller.currentFilterString,
                          type: NO_DATA_TYPE.FIT,
                          imageHeight: 200,
                        ),
                        builder: (BuildContext context, int index) {
                          final text = state[index];
                          return Column(
                            children: [
                              TextCard(
                                showHint: true,
                                text: state[index],
                                onFollowTapped: () =>
                                    controller.reportFollow(text.value),
                              ),
                              Divider(
                                color: context.theme.backgroundColor,
                                height: 1,
                                thickness: 1,
                              )
                            ],
                          );
                        },
                      );
              }),
            ],
          ),
        );
      },
      onLoading: const ShimmerScroll(
        useSpinner: true,
      ),
    );
  }
}
