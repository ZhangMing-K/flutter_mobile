import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import 'constants.dart';

class TableBody extends StatelessWidget {
  final List<AssetOverviewItem>? dataSource;

  final ScrollController? scrollController;
  final OVERVIEW_ORDER_BY? selectedOrder;

  final SENTIMENT_TYPE? sentimentType;
  const TableBody({
    Key? key,
    this.dataSource,
    this.scrollController,
    this.sentimentType = SENTIMENT_TYPE.BULLISH,
    this.selectedOrder = OVERVIEW_ORDER_BY.ALL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TableBodyController>(
        init: TableBodyController(),
        global: false,
        builder: (controller) {
          return Row(
            children: [
              SizedBox(
                width: staticWidth,
                child: ListView(
                  controller: controller._headController,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  children: List.generate(dataSource!.length, (index) {
                    final ta = dataSource![index];
                    return tradeAnalysisFixedItem(ta, index);
                  }),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: ClampingScrollPhysics()),
                  child: SizedBox(
                    width: tableWidth.fold(0, (p, c) => p! + c),
                    child: ListView(
                      controller: controller._bodyController,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      children: List.generate(dataSource!.length, (y) {
                        final item = dataSource![y];
                        return Row(children: [
                          tradeAnalysisItem(
                            item,
                            y,
                          )
                        ]);
                      }),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget cell(
      {Widget? contents,
      double? width,
      Color color = Colors.transparent,
      Alignment alignment = Alignment.center}) {
    return Container(
      width: width ?? 120,
      height: 50,
      alignment: alignment,
      child: contents,
      color: color,
    );
  }

  Widget tradeAnalysisFixedItem(AssetOverviewItem ta, int index) {
    return Builder(builder: (context) {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          color: index % 2 == 0
              ? context.theme.backgroundColor
              : context.theme.dialogBackgroundColor,
          height: 50,
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppAssetImage(
                asset: ta.asset,
                height: 35,
              ),
              cell(
                  contents: Text(ta.asset?.symbol ?? '',
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold)),
                  width: 40,
                  alignment: Alignment.centerLeft),
            ],
          ));
    });
  }

  Widget tradeAnalysisItem(AssetOverviewItem ta, int index) {
    return Builder(builder: (context) {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          color: index % 2 == 0
              ? context.theme.backgroundColor
              : context.theme.dialogBackgroundColor,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cell(
                contents: Text(sentimentType == SENTIMENT_TYPE.BULLISH
                    ? selectedOrder == OVERVIEW_ORDER_BY.ALL
                        ? ta.pctInvestorsTotalBull.formatPercentage()
                        : ta.pctInvestorsTotalBullTop.formatPercentage()
                    : selectedOrder == OVERVIEW_ORDER_BY.ALL
                        ? ta.pctInvestorsTotalBear.formatPercentage()
                        : ta.pctInvestorsTotalBearTop.formatPercentage()),
              ),
              cell(
                  contents: Text(
                      '\$${sentimentType == SENTIMENT_TYPE.BULLISH ? selectedOrder == OVERVIEW_ORDER_BY.ALL ? ta.amtInvestedBull.formatCompact() : ta.amtInvestedBullTop.formatCompact() : selectedOrder == OVERVIEW_ORDER_BY.ALL ? ta.amtInvestedBear.formatCompact() : ta.amtInvestedBearTop.formatCompact()}')),
              cell(
                contents: Text(
                  sentimentType == SENTIMENT_TYPE.BULLISH
                      ? selectedOrder == OVERVIEW_ORDER_BY.ALL
                          ? ta.pctInvestorsBull.formatPercentage()
                          : ta.pctInvestorsBullTop.formatPercentage() +
                              ' Bullish'
                      : selectedOrder == OVERVIEW_ORDER_BY.ALL
                          ? ta.pctInvestorsBear.formatPercentage()
                          : ta.pctInvestorsBearTop.formatPercentage() +
                              ' Bearish',
                ),
              ),
            ],
          ));
    });
  }
}

class TableBodyController extends GetxController {
  late LinkedScrollControllerGroup _controllers;
  ScrollController? _headController;
  ScrollController? _bodyController;
  TableBodyController();

  @override
  void onInit() {
    _controllers = LinkedScrollControllerGroup();
    _headController = _controllers.addAndGet();
    _bodyController = _controllers.addAndGet();
    super.onInit();
  }
}
