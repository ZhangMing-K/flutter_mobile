import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'analysis_details.dart';

class PortfolioAnalysisTable extends StatelessWidget {
  final List<TradeAnalysis> dataSource;
  final DISPLAY_UNIT displayUnit;

  final Function({SORT_BY? sortBy})? handleSortData;
  final SortColumns? sortedColumn;
  const PortfolioAnalysisTable(
      {Key? key,
      required this.dataSource,
      required this.displayUnit,
      this.handleSortData,
      this.sortedColumn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildGrid();
  }

  Widget buildGrid() {
    return Obx(() {
      return Column(
        children: [
          Divider(
            color: Colors.black.withOpacity(0.4),
            height: 0.5,
          ),
          topRow(),
          Divider(
            color: Colors.black.withOpacity(0.4),
            height: 0.5,
          ),
          if (dataSource.isEmpty)
            const Text('no data')
          else
            ...dataSource.map((TradeAnalysis ta) => tradeAnalysisRow(ta))
        ],
      );
    });
  }

  Widget cell(
      {Widget? contents,
      double? width,
      Alignment alignment = Alignment.centerLeft}) {
    return Container(
      width: width,
      alignment: alignment,
      child: contents,
    );
  }

  getColor(val) {
    if (val >= 0) {
      return IrisColor.positiveChange;
    } else {
      return IrisColor.negativeChange;
    }
  }

  Widget headerItem(
      {String? text,
      double? width,
      SORT_BY? sortBy,
      Alignment alignment = Alignment.center}) {
    return Builder(builder: (context) {
      return InkWell(
          onTap: () {
            handleSortData!(sortBy: sortBy);
          },
          child: Container(
              width: width,
              alignment: alignment,
              child: Row(
                children: [
                  Text(text!,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          // color: Colors.black.withOpacity(0.4)
                          color: context.theme.colorScheme.secondary
                              .withOpacity(0.4))),
                  if (sortedColumn!.sortBy == sortBy)
                    Icon(
                      sortedColumn!.orderByAsc!
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 14,
                    )
                ],
              )));
    });
  }

  void onCellTap(BuildContext context, TradeAnalysis data) {
    final BaseController baseController = Get.find();
    baseController.openPanel(
      child: AnalysisDetails(analysisData: data, displayUnit: displayUnit),
      context: context,
    );
  }

  Widget topRow() {
    return Builder(builder: (context) {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          height: 55,
          color: context.theme.backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 45),
              headerItem(text: 'Symbol', sortBy: SORT_BY.SYMBOL),
              headerItem(
                  text: 'Gain',
                  sortBy: SORT_BY.GAIN,
                  alignment: Alignment.center),
              headerItem(text: '% Avg. Invest', sortBy: SORT_BY.PERCENT_GAIN),
              headerItem(text: 'Trades', sortBy: SORT_BY.TRADE_COUNT),
            ],
          ));
    });
  }

  Widget tradeAnalysisItem(TradeAnalysis ta) {
    return Builder(builder: (context) {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          height: 55,
          color: context.theme.backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppAssetImage(asset: ta.asset),
              cell(
                  contents: Text(ta.symbol ?? '',
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                  width: 45,
                  alignment: Alignment.centerLeft),
              if (displayUnit == DISPLAY_UNIT.DOLLAR)
                cell(
                  contents: valueCell(ta.profitLossTotal.formatCurrency()),
                  width: context.width / 5,
                )
              else
                cell(
                  contents: valueCell(
                      ta.profitLossPercentPortfolio.formatPercentage()),
                  width: context.width / 5,
                ),
              cell(
                contents: valueCell(
                    ta.gainPercentAverageInvestment.formatPercentage()),
                width: context.width / 5,
              ),
              Text('${ta.transactionCount}'),
            ],
          ));
    });
  }

  Widget tradeAnalysisRow(TradeAnalysis tradeAnalysis) {
    return Builder(builder: (context) {
      return InkWell(
          onTap: () => onCellTap(context, tradeAnalysis),
          child: Column(
            children: [
              tradeAnalysisItem(tradeAnalysis),
              Divider(
                color: context.theme.colorScheme.secondary.withOpacity(0.4),
                height: 0.5,
              ),
            ],
          ));
    });
  }

  Widget valueCell(String value) {
    return Text(value,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 13,
            color:
                getColor(double.parse(value.replaceAll(RegExp(r'[$,%]'), ''))),
            fontWeight: FontWeight.bold));
  }
}

enum SORT_BY { SYMBOL, GAIN, PERCENT_GAIN, TRADE_COUNT }

class SortColumns {
  SORT_BY? sortBy;
  bool? orderByAsc;
  SortColumns({this.sortBy, this.orderByAsc});
}
