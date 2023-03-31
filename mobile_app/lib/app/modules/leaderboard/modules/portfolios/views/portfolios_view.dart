import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iris_common/iris_common.dart';

import '../../../../../../widgets_v2/portfolio_summary_card/portfolio_summary_card_shimmer.dart';
import '../../widgets/portfolios_leaderboard_card/portfolios_leaderboard_card.dart';
import '../../widgets/portfolios_leaderboard_card/portfolios_leaderboard_card_controller.dart';
import '../controllers/portfolios_controller.dart';

class PortfoliosLeaderboardView
    extends GetView<PortfoliosLeaderboardController> {
  const PortfoliosLeaderboardView({Key? key}) : super(key: key);

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
                widgetLoader: const PortfolioSummaryCardShimmer(),
                loadMore: controller.loadMore,
                builder: (BuildContext context, int index) {
                  final PortfolioLeaderboardController portfolioController =
                      PortfolioLeaderboardController(portfolio: state[index]);
                  return PortfolioLeaderboardCard(
                      margin: const EdgeInsets.only(top: 10),
                      portfolio: state[index],
                      portfolioImage: PORTFOLIO_IMAGE.USER,
                      borderOnAuthUser: true,
                      showHighlights: true,
                      trailingButton: PORTFOLIO_TRAILING_BUTTON.SETTINGS,
                      selectedSpan: controller.currentPortfolioSelection,
                      rankNum: index + 1,
                      controller: portfolioController);
                },
              ),
            ),
          ],
        );
      },
      onLoading: const PortfolioSummaryCardShimmer(),
    );
  }
}
