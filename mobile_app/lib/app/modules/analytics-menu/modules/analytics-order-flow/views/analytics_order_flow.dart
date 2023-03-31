import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-order-flow/controllers/analytics_order_flow_controller.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-order-flow/controllers/analytics_order_flow_filters_controller.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-order-flow/views/analytics_order_flow_filters.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-order-flow/views/table/table_body.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-order-flow/views/table/table_head.dart';
import 'package:iris_mobile/app/modules/analytics-menu/shared/filter_applied_item/filter_applied_item.dart';
import 'package:iris_mobile/app/modules/analytics-menu/shared/heading_card/title_card.dart';
import 'package:iris_mobile/app/modules/analytics-menu/shared/placeholders/filter_empty_view.dart';
import 'package:iris_mobile/app/modules/analytics-menu/shared/trade_type/trade_type.dart';

class AnalyticsOrderFlowScreen extends GetView<AnalyticsOrderFlowController> {
  const AnalyticsOrderFlowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IrisTabView.expanded(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          showBackButton: true,
          horizontalPadding: 0,
          tabs: [
            IrisTab(
                text: 'Order flow',
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
                          if (controller.dataSource$.isNotEmpty)
                            TableHead(
                              scrollController: controller.headController,
                              handleSortData: controller.sortTradeAnalysisData,
                              sortedColumn: controller.sortColumns$.value,
                              positionType:
                                  controller.currentPositionType$.value,
                              dataSource: controller.dataSource$.toList(),
                              goldIndex: 3,
                            ),
                          if (controller.apiStatus$.value == API_STATUS.PENDING)
                            const Expanded(child: IrisLoading()),
                          Expanded(
                              child: IrisListView(
                            onRefresh: controller.onRefresh,
                            loadMore: controller.loadMore,
                            emptyWidget: Container(
                                height: Get.height / 3,
                                alignment: Alignment.center,
                                child: const FilterEmptyView()),
                            apiStatus: controller.apiStatus$.value,
                            itemCount: controller.dataSource$.isEmpty ? 0 : 1,
                            builder: (BuildContext context, int index) {
                              return TableBody(
                                  dataSource: controller.dataSource$.toList(),
                                  positionType:
                                      controller.currentPositionType$.value,
                                  scrollController: controller.bodyController);
                            },
                          ))
                        ],
                      );
                    })))
          ]),
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //       border: Border(
      //           top: BorderSide(color: Colors.grey.shade900, width: 0.0))),
      //   child: BottomNavbar(
      //     isGoldMode: true,
      //     onActiveMenuItemPressed: () => () {},
      //   ),
      // ),
    );
  }

  Widget header(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: ScreenUtil().setWidth(24)),
      Obx(() {
        return Row(
          children: [
            SizedBox(width: ScreenUtil().setWidth(12)),
            TypeWidget(
                isSelected: controller.currentPositionType$.value ==
                    POSITION_TYPE.OPTION,
                title: 'Options',
                onPressed: () {
                  controller.onPressSelector(POSITION_TYPE.OPTION);
                }),
            TypeWidget(
                isSelected: controller.currentPositionType$.value ==
                    POSITION_TYPE.EQUITY,
                title: 'Equity',
                onPressed: () {
                  controller.onPressSelector(POSITION_TYPE.EQUITY);
                }),
            TypeWidget(
                isSelected: controller.currentPositionType$.value ==
                    POSITION_TYPE.CRYPTO,
                title: 'Crypto',
                onPressed: () {
                  controller.onPressSelector(POSITION_TYPE.CRYPTO);
                }),
          ],
        );
      }),
      SizedBox(height: ScreenUtil().setWidth(8)),
      SizedBox(height: ScreenUtil().setWidth(16)),
      GestureDetector(
          onTap: () {
            final analyticsOrderFlowFiltersController =
                AnalyticsOrderFlowFiltersController();

            final bottomSheetContainer = DraggableScrollableSheet(
                minChildSize: 0.9,
                maxChildSize: 0.91,
                initialChildSize: 0.9,
                expand: true,
                builder: (context, scrollController) {
                  return CustomBottomSheet(
                    maxHeight: 0.9,
                    child: CustomScrollView(
                      controller: scrollController,
                      slivers: [
                        SliverFillRemaining(
                          child: OrderFlowFiltersScreen(
                            controller: analyticsOrderFlowFiltersController,
                            //  isGoldMember: controller.isGoldMember,
                            appliedIsGold: controller.appliedIsGold.value,
                            appliedMinPortfolio:
                                controller.appliedMinPortfolio.value,
                            appliedMinTradeAmount:
                                controller.appliedMinTradeAmount.value,
                            onApply: (bool isGold, double minPortfolio,
                                double minTradeAmount) {
                              controller.onFilterApplied(
                                  isGold, minPortfolio, minTradeAmount);
                            },
                            orderFlowController: controller,
                          ),
                        ),
                      ],
                    ),
                  );
                });

            showModalBottomSheet(
              context: Get.context!,
              builder: (context) => bottomSheetContainer,
              isScrollControlled: true,
            );
          },
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
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
                        final initialList = [
                          if (controller.getIsGoldApplied)
                            const FilterAppliedItem(title: 'Gold'),
                          if (controller.getIsMinPortfolioApplied)
                            FilterAppliedItem(
                                title:
                                    '${controller.appliedMinPortfolio.value.formatCompact()}%'),
                          if (controller.getIsMinTradeApplied)
                            FilterAppliedItem(
                                title:
                                    '\$${controller.appliedMinTradeAmount.value.formatCompact()}'),
                        ];
                        return Wrap(
                          children: [
                            ...initialList,
                            ...controller.selectedAssetList
                                .map((asset) =>
                                    FilterAppliedItem(title: asset.symbol!))
                                .toList()
                          ],
                        );
                      })
                    ],
                  ),
                ],
              ))),
      SizedBox(height: ScreenUtil().setWidth(24)),
      Row(
        children: [
          SizedBox(width: ScreenUtil().setWidth(12)),
          Container(
            width: ScreenUtil().setWidth(10),
            height: ScreenUtil().setWidth(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: IrisColor.positiveChange,
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(4)),
          Text('Bullish', style: TextStyle(fontSize: ScreenUtil().setSp(14))),
          SizedBox(width: ScreenUtil().setWidth(10)),
          Container(
            width: ScreenUtil().setWidth(10),
            height: ScreenUtil().setWidth(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: IrisColor.negativeChange,
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(4)),
          Text('Bearish', style: TextStyle(fontSize: ScreenUtil().setSp(14))),
        ],
      ),
      SizedBox(height: ScreenUtil().setWidth(24))
    ]);
  }
}
