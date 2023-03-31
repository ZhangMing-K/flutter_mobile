import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../app/modules/profile/modules/portfolios/views/profile_portfolio_view.dart';

import '../../../widgets_v2/portfolio_summary_card/portfolio_summary_card_shimmer.dart';
import 'account_portfolios_controller.dart';

//TODO: Migrate to Bindings api
class AccountPortfoliosMobile extends StatelessWidget {
  final AccountPortfoliosController controller = Get.put(
      AccountPortfoliosController(
        authUserStore: Get.find(),
        profilePortfolioController: Get.find(),
        userService: Get.find(),
      ),
      permanent: true);

  AccountPortfoliosMobile({Key? key}) : super(key: key);

  shimmer() {
    return Container(
        padding: const EdgeInsets.only(top: 10),
        child: const PortfolioSummaryCardShimmer());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        child: controller.profileUser$.value != null
            ? ProfilePortfoliosView(
                isAuthUser: true,
                controller: controller.profilePortfolioController,
              )
            : shimmer()));
  }
}
