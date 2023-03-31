import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../../../../../widgets_v2/portfolio_summary_card/portfolio_summary_card.dart';
import '../../../../../../widgets_v2/portfolio_summary_card/portfolio_summary_card_controller.dart';
import '../../../../../../widgets_v2/portfolio_summary_card/portfolio_summary_card_shimmer.dart';
import '../controllers/day_controller.dart';

class DayView extends GetView<DayController> {
  const DayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            IrisListView(
              key: controller.listviewController,
              onRefresh: controller.pullRefresh,
              itemCount: state!.length,
              widgetLoader: Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: const PortfolioSummaryCardShimmer()),
              loadMore: controller.loadMore,
              builder: (BuildContext context, int index) {
                return Container(
                    child: PortfolioSummaryCard(
                        portfolio: Rx(state[index]!),
                        controller: PortfolioSummaryController(
                            portfolio: state[index]!.obs),
                        showRankNumber: true,
                        refreshParent: controller.refreshEntities),
                    margin: const EdgeInsets.only(top: 8));
              },
            ),
          ],
        );
      },
      onLoading: Container(
          margin: const EdgeInsets.only(top: 8),
          child: const PortfolioSummaryCardShimmer()),
    );
  }
}
