import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:unicons/unicons.dart';

import '../../../../../../widgets_v2/portfolio_summary_card/portfolio_summary_card.dart';
import '../../../../../../widgets_v2/portfolio_summary_card/portfolio_summary_card_controller.dart';
import '../../../../../../widgets_v2/portfolio_summary_card/portfolio_summary_card_shimmer.dart';
import '../controllers/portfolios_controller.dart';

class PortfoliosView extends GetView<PortfoliosController> {
  const PortfoliosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        return Column(
          children: [
            Expanded(
              child: IrisListView(
                header: const SelectorBar(),
                key: controller.listviewController,
                onRefresh: controller.pullRefresh,
                itemCount: state!.length,
                widgetLoader: const PortfolioSummaryCardShimmer(),
                loadMore: controller.loadMore,
                builder: (BuildContext context, int index) {
                  return PortfolioSummaryCard(
                    margin: const EdgeInsets.only(top: 10),
                    portfolio: state[index],
                    portfolioImage: PORTFOLIO_IMAGE.USER,
                    borderOnAuthUser: true,
                    showHighlights: true,
                    trailingButton: PORTFOLIO_TRAILING_BUTTON.SETTINGS,
                    controller:
                        PortfolioSummaryController(portfolio: state[index]),
                  );
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

class SelectorBar extends GetView<PortfoliosController> {
  const SelectorBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              header(context),
              StatefulBuilder(builder: (_, update) {
                return IrisBounceButton(
                  duration: const Duration(milliseconds: 100),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    controller.toggleSaved();
                    update(() {});
                  },
                  child: Builder(builder: (context) {
                    if (controller.saved) {
                      return SvgPicture.asset(
                        IconPath.bookmark_solid,
                        color: IrisColor.primaryColor,
                        height: 24,
                      );
                    }

                    return Icon(
                      UniconsLine.bookmark,
                      color: context.theme.colorScheme.secondary,
                    );
                  }),
                );
              }),
            ],
          ),
          const IrisChipChoice(),
        ],
      ),
    );
  }

  Widget header(BuildContext context) {
    return Row(
      children: [
        ...List.generate(controller.feedSelection.length, (index) {
          return Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              ChoiceChip(
                  label: Text(controller
                      .feedSelectionToString(controller.feedSelection[index])),
                  selected: controller.getCurrentCategoryIndex() == index,
                  selectedColor: context.theme.primaryColor,
                  labelStyle: const TextStyle(color: Colors.white),
                  onSelected: (bool selected) {
                    HapticFeedback.lightImpact();
                    controller.changeCategory(controller.feedSelectionToString(
                        controller.feedSelection[index]));
                  }),
            ],
          );
        }),
      ],
    );
  }
}
