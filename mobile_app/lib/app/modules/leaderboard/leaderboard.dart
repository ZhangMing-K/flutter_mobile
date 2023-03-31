import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:unicons/unicons.dart';

import 'controllers/leaderboard_controller.dart';
import 'modules/portfolios/views/portfolios_view.dart';

class LeaderboardScreen extends GetView<LeaderboardController> {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, _) {
        return [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: const SliverToBoxAdapter(
              child: SelectorBar(),
            ),
          ),
        ];
      },
      body: const PortfoliosLeaderboardView(),
    );
  }
}

class SelectorBar extends GetView<LeaderboardController> {
  const SelectorBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              StatefulBuilder(builder: (_, update) {
                return IrisBounceButton(
                  duration: const Duration(milliseconds: 100),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    controller.toggleType();
                    update(() {});
                  },
                  child: Builder(builder: (context) {
                    if (controller.isLocalLeadeboard.value) {
                      return Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                            color: context.theme.backgroundColor,
                            border: Border.all(
                                color: context.theme.backgroundColor, width: 2),
                            borderRadius: BorderRadius.circular(17)),
                        child: Icon(
                          Icons.people,
                          color: context.theme.colorScheme.secondary,
                          size: 26,
                        ),
                      );
                    }
                    return Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                          color: context.theme.backgroundColor,
                          border: Border.all(
                              color: context.theme.backgroundColor, width: 2),
                          borderRadius: BorderRadius.circular(17)),
                      child: Icon(
                        UniconsLine.globe,
                        color: context.theme.colorScheme.secondary,
                        size: 26,
                      ),
                    );
                  }),
                );
              }),
              // Obx(() => header(context)),
              header(context),
            ],
          ),
          const IrisChipChoice(),
        ],
      ),
    );
  }

  header(BuildContext context) {
    return StatefulBuilder(builder: (_, update) {
      return Row(
        children: [
          ...List.generate(controller.feedSelection.length, (index) {
            return Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                ChoiceChip(
                    label: Text(controller.feedSelectionToString(
                        controller.feedSelection[index])),
                    selected: controller.getCurrentCategoryIndex() == index,
                    selectedColor: context.isDarkMode
                        ? context.theme.backgroundColor
                        : context.theme.primaryColor,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: context.theme.backgroundColor,
                        width: 2,
                      ),
                      borderRadius: kBorderRadius * 2,
                    ),
                    labelStyle: const TextStyle(color: Colors.white),
                    onSelected: (bool selected) {
                      HapticFeedback.lightImpact();
                      controller.changeCategory(
                          controller.feedSelectionToString(
                              controller.feedSelection[index]));
                      update(() {});
                    }),
              ],
            );
          }),
        ],
      );
    });
  }
}
