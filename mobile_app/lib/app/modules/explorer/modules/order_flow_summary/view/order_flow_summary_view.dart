import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_mobile/app/routes/pages.dart';

import '../../../../analytics-menu/modules/analytics-order-flow/views/table/constants.dart';
import '../../../../analytics-menu/modules/analytics-order-flow/views/widgets/order_equity_table.dart';
import '../../../../analytics-menu/modules/analytics-order-flow/views/widgets/order_option_table.dart';
import '../controller/order_flow_summary_controller.dart';

class OrderFlowSummaryView extends GetView<OrderFlowSummaryController> {
  const OrderFlowSummaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(left: 9, top: 16, bottom: 16),
                child: Text('Options order flow',
                    style: TextStyle(
                        fontSize: IrisScreenUtil.dFontSize(17),
                        fontWeight: FontWeight.w500,
                        color: context.theme.colorScheme.secondary
                            .withOpacity(0.5)))),
            OrderOptionTable(
              dataSource: controller.optionsOrderFlow,
              sortedColumn: SortColumns(sortBy: SORT_BY.TIME, orderByAsc: true),
              apiStatus: controller.apiStatusOptions$.value,
            ),
            if (controller.optionsOrderFlow.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(Paths.AnalyticsOrderFlow);
                    },
                    child: Container(
                        margin: const EdgeInsets.only(
                            top: 20, bottom: 32, left: 16, right: 16),
                        child: Text(
                          'See full options flow',
                          style: TextStyle(
                              fontSize: IrisScreenUtil.dFontSize(16),
                              color: IrisColor.primaryColor,
                              fontWeight: FontWeight.w500),
                        )),
                  )
                ],
              ),
            Container(
                margin: const EdgeInsets.only(left: 9, top: 16, bottom: 16),
                child: Text('Equity order flow',
                    style: TextStyle(
                        fontSize: IrisScreenUtil.dFontSize(17),
                        fontWeight: FontWeight.w500,
                        color: context.theme.colorScheme.secondary
                            .withOpacity(0.5)))),
            OrderEquityTable(
              dataSource: controller.equityOrderFlow,
              sortedColumn: SortColumns(sortBy: SORT_BY.TIME, orderByAsc: true),
              apiStatus: controller.apiStatusEquity$.value,
            ),
            if (controller.equityOrderFlow.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(Paths.AnalyticsOrderFlow);
                    },
                    child: Container(
                        margin: const EdgeInsets.only(
                            top: 20, bottom: 32, left: 16, right: 16),
                        child: Text(
                          'See full equity flow',
                          style: TextStyle(
                              fontSize: IrisScreenUtil.dFontSize(16),
                              color: IrisColor.primaryColor,
                              fontWeight: FontWeight.w500),
                        )),
                  )
                ],
              ),
            Container(
                margin: const EdgeInsets.only(left: 9, top: 16, bottom: 16),
                child: Text('Crypto order flow',
                    style: TextStyle(
                        fontSize: IrisScreenUtil.dFontSize(17),
                        fontWeight: FontWeight.w500,
                        color: context.theme.colorScheme.secondary
                            .withOpacity(0.5)))),
            OrderEquityTable(
              dataSource: controller.cryptoOrderFlow,
              sortedColumn: SortColumns(sortBy: SORT_BY.TIME, orderByAsc: true),
              apiStatus: controller.apiStatusCrypto$.value,
            ),
            if (controller.cryptoOrderFlow.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(Paths.AnalyticsOrderFlow);
                    },
                    child: Container(
                        margin: const EdgeInsets.only(
                            top: 20, bottom: 32, left: 16, right: 16),
                        child: Text(
                          'See full crypto flow',
                          style: TextStyle(
                              fontSize: IrisScreenUtil.dFontSize(16),
                              color: IrisColor.primaryColor,
                              fontWeight: FontWeight.w500),
                        )),
                  )
                ],
              ),
          ],
        );
      },
    );
  }
}
