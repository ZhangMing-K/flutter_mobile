import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iris_common/iris_common.dart';

import '../../../../../../widgets_v2/portfolio_analysis/portfolio_analysis.dart';
import '../controllers/overview_controller.dart';

class OverviewView extends GetView<OverviewController> {
  const OverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final portfolio = controller.portfolio$.value;
      if (portfolio != null) {
        return Column(
          children: [
            Expanded(
                child: IrisListView(
                    itemCount: 1,
                    shrinkWrap: true,
                    loadMore: null,
                    onRefresh: () async {},
                    builder: (context, index) {
                      return PortfolioAnalysis(
                          portfolioKey: portfolio.portfolioKey,
                          isAuthUser: portfolio.isAuthUser);
                    })),
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
