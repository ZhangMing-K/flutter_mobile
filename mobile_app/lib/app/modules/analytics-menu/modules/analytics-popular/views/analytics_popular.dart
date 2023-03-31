import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-popular/controllers/analytics_popular_controller.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-popular/controllers/analytics_popular_filters_controller.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-popular/views/analytics_popular_filters.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-popular/views/asset_analysis_shimmer.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-popular/views/table/table_body.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-popular/views/table/table_head.dart';
import 'package:iris_mobile/app/modules/analytics-menu/shared/filter_applied_item/filter_applied_item.dart';
import 'package:iris_mobile/app/modules/analytics-menu/shared/heading_card/title_card.dart';
import 'package:iris_mobile/app/modules/analytics-menu/shared/placeholders/filter_empty_view.dart';
import 'package:iris_mobile/app/modules/analytics-menu/shared/trade_type/trade_type.dart';

class AnalyticsPopularScreen extends GetView<AnalyticsPopularController> {
  const AnalyticsPopularScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: IrisTabView.expanded(
            showBackButton: true,
            backgroundColor: context.theme.scaffoldBackgroundColor,
            tabs: [
              IrisTab(
                  text: 'Popular',
                  body: NestedScrollView(
                      controller: ScrollController(),
                      headerSliverBuilder: (context, _) {
                        return [
                          SliverOverlapAbsorber(
                            handle:
                                NestedScrollView.sliverOverlapAbsorberHandleFor(
                                    context),
                            sliver: SliverToBoxAdapter(
                                child: Container(
                              padding: const EdgeInsets.all(0),
                              foregroundDecoration: const BoxDecoration(),
                              child: Column(
                                children: [header(context)],
                              ),
                            )),
                          ),
                        ];
                      },
                      body: Obx(() {
                        return Column(
                          children: [
                            if (controller.currentSentimentData$.isNotEmpty)
                              TableHead(
                                scrollController: controller.headController,
                                handleSortData:
                                    controller.sortTradeAnalysisData,
                                sortedColumn: controller.sortColumns$.value,
                                dataSource:
                                    controller.currentSentimentData$.toList(),
                                sentimentType:
                                    controller.currentSentimentType$.value,
                              ),
                            if (controller.currentApiStatus$.value ==
                                API_STATUS.PENDING)
                              const AnalyticsShimmer(),
                            Expanded(
                                child: IrisListView(
                              onRefresh: controller.onRefresh,
                              loadMore: controller.loadMore,
                              emptyWidget: const FilterEmptyView(),
                              apiStatus: controller.currentApiStatus$.value,
                              itemCount:
                                  controller.currentSentimentData$.isEmpty
                                      ? 0
                                      : 1,
                              builder: (BuildContext context, int index) {
                                return TableBody(
                                    dataSource: controller.currentSentimentData$
                                        .toList(),
                                    sentimentType:
                                        controller.currentSentimentType$.value,
                                    selectedOrder: controller.getIsGoldApplied
                                        ? OVERVIEW_ORDER_BY.TOP
                                        : OVERVIEW_ORDER_BY.ALL,
                                    scrollController:
                                        controller.bodyController);
                              },
                            ))
                          ],
                        );
                      })))
            ]));
  }

  Widget header(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: ScreenUtil().setWidth(24)),
      Container(
          color: context.theme.backgroundColor,
          height: ScreenUtil().setWidth(53),
          child: Obx(() {
            return Row(
              children: [
                TypeWidget(
                    total: 2,
                    isSelected: controller.currentSentimentType$.value ==
                        SENTIMENT_TYPE.BULLISH,
                    title: 'Bullish',
                    onPressed: () {
                      controller.onPressSelector(SENTIMENT_TYPE.BULLISH);
                    }),
                TypeWidget(
                    total: 2,
                    isSelected: controller.currentSentimentType$.value ==
                        SENTIMENT_TYPE.BEARISH,
                    title: 'Bearish',
                    onPressed: () {
                      controller.onPressSelector(SENTIMENT_TYPE.BEARISH);
                    }),
              ],
            );
          })),
      SizedBox(
        height: ScreenUtil().setWidth(12),
      ),
      Container(
          margin: EdgeInsets.only(right: ScreenUtil().setWidth(12)),
          child: GestureDetector(
              onTap: () {
                final popularFiltersController =
                    AnalyticsPopularFiltersController();
                final bottomSheetContainer = CustomBottomSheet(
                  maxHeight: 0.5,
                  child: PopularFiltersScreen(
                    controller: popularFiltersController,
                    isGoldMember: controller.isGoldMember,
                    appliedIsGold: controller.appliedIsGold.value,
                    onApply: (bool isGold) {
                      controller.onFilterApplied(isGold);
                    },
                  ),
                );
                Get.bottomSheet(bottomSheetContainer, isScrollControlled: true);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      HeadingTitleWidget(
                        title: 'Filters',
                        marginLeft: ScreenUtil().setWidth(12),
                        isDisabled: true,
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(8),
                      ),
                      Obx(() {
                        if (controller.getIsGoldApplied) {
                          return const FilterAppliedItem(title: 'Gold');
                        }
                        return Container();
                      }),
                    ],
                  ),
                  spanSelector(context)
                ],
              ))),
      SizedBox(height: ScreenUtil().setWidth(16))
    ]);
  }

  Widget spanSelector(BuildContext context) {
    return Obx(() {
      return DropdownButton(
        dropdownColor: context.theme.backgroundColor,
        // dropdownColor: context.theme.colorScheme.secondary,
        value: controller.currentSelectedSpan$.value,
        icon: Image.asset(
          IconPath.downBlackArrow,
          width: ScreenUtil().setWidth(15),
          height: ScreenUtil().setWidth(9),
          color: context.theme.colorScheme.secondary,
        ),
        disabledHint: Text(
          'Disabled',
          style: TextStyle(fontSize: ScreenUtil().setSp(14)),
          textAlign: TextAlign.center,
        ),
        style: TextStyle(
            color: context.textTheme.bodyText1!.color,
            fontSize: ScreenUtil().setSp(14)),
        underline: Container(),
        onChanged: (String? span) {
          controller.refreshBySpan(span!);
        },
        items: controller.spans.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    });
  }
}
