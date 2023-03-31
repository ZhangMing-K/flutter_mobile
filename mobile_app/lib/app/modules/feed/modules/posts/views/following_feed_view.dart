import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_mobile/app/modules/feed/modules/posts/views/empty_following_feed_view.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/text_card/text_card.dart';
import 'package:iris_mobile/app/routes/pages.dart';

import '../../user_stories/views/user_stories_user_view.dart';
import '../controllers/following_feed_controller.dart';

class FollowingFeedView extends GetView<FollowingFeedController> {
  const FollowingFeedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        return IrisListView(
          keyboardHidesHeader: false,
          controller: controller.scrollController,
          header: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserStoriesUserView(),
              const SizedBox(height: 8),
              Divider(
                color: context.theme.backgroundColor,
                height: 1,
                thickness: 1,
              )
            ],
          ),
          onRefresh: controller.pullRefresh,
          itemCount: state!.length,
          widgetLoader: const ShimmerScroll(useSpinner: true),
          loadMore: controller.loadMore,
          emptyWidget: EmptyFollowingFeedView(
              onAfterFollow: controller.refreshFollowers,
              suggestions: controller.activePopularWithPortfolio),
          builder: (BuildContext context, int index) {
            final text = state[index];
            return Column(
              children: [
                if (text.value.symbol == FEED_SYMBOL_TYPE.WELCOME_MESSAGE)
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            'Welcome to Iris!',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 20),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Know any good investors? Invite them here to see their trades, portfolios and performance in real time! Follow 3+ people then refresh to populate your feed!',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w300),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                        ],
                      )),
                if (text.value.symbol == FEED_SYMBOL_TYPE.TEXT)
                  TextCard(
                    showHint: true,
                    text: text.value.text.obs,
                    onFollowTapped: () =>
                        controller.reportFollow(text.value.text!),
                  )
                else if (text.value.symbol ==
                    FEED_SYMBOL_TYPE.FOLLOW_SUGGESTION)
                  IrisCarrousel(
                    followSuggestion: text.value.followSuggestion!,
                  ),
                Divider(
                  color: context.theme.backgroundColor,
                  height: 1,
                  thickness: 1,
                ),
              ],
            );
          },
        );
      },
      onLoading: const IrisLoading(),
    );
  }
}
