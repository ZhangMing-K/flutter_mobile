import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../underlined_text_column/underlined_text_column.dart';

class AnalysisDetails extends StatelessWidget {
  final TradeAnalysis analysisData;
  final DISPLAY_UNIT displayUnit;
  const AnalysisDetails(
      {Key? key, required this.analysisData, required this.displayUnit})
      : super(key: key);

  String get panelTitle {
    return '${analysisData.symbol} Position Details';
  }

  Widget assetNameDisplay(Asset asset) {
    return Builder(builder: (context) {
      return SizedBox(
        width: 50,
        child: Text(analysisData.asset?.name ?? '',
            softWrap: true,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.theme.colorScheme.secondary.withOpacity(.75))),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            panelTitle,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          main(),
        ]);
  }

  Widget detailsRow() {
    return Row(
      children: [
        UnderlinedTextColumn(keyValues: [
          KeyValues(
              key: underlinedKey('% Gain'),
              value: underlinedValue(analysisData.gainPercentAverageInvestment
                  .formatPercentage())),
          KeyValues(
              key: underlinedKey('Trades'),
              value: underlinedValue(analysisData.transactionCount.toString())),
          KeyValues(
              key: underlinedKey('Avg. Time'),
              value: underlinedValue(
                  durationDisplay(analysisData.averageDurationMinutes!))),
        ]),
        const SizedBox(
          width: 20,
        ),
        UnderlinedTextColumn(keyValues: [
          KeyValues(
              key: underlinedKey('Avg. Invest'),
              value: underlinedValue(displayUnit == DISPLAY_UNIT.DOLLAR
                  ? analysisData.averageInvestment.formatCurrency()
                  : analysisData.averageRelativeInvestment.formatPercentage())),
          KeyValues(
              key: underlinedKey('Strategies'),
              value: underlinedValue(
                  strategiesDisplay(analysisData.orderStrategies))),
          KeyValues(
              key: underlinedKey('Status'),
              value: underlinedValue(
                  analysisData.positionClosed! ? 'Closed' : 'Open')),
        ]),
      ],
    );
  }

  String durationDisplay(double duration) {
    String unit = 'day';
    double display = duration / 1440;
    if ((duration / 1440) < 1) {
      if (duration / 60 < 1) {
        unit = 'min';
        display = duration;
      } else {
        unit = 'hr';
        display = duration / 60;
      }
    }
    return '${display.formatCompact()} $unit${display > 1 || display == 0 ? 's' : ''}';
  }

  Widget main() {
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            topRow(),
            const SizedBox(
              height: 20,
            ),
            detailsRow(),
          ],
        ));
  }

  String strategiesDisplay(List<String?>? strategies) {
    if (strategies == null || strategies.isEmpty) {
      return '';
    }
    final List<String> strats = [];
    for (String? strat in strategies) {
      if (strat == null) {
        strats.add('Eq');
      } else if (strat.contains('call')) {
        strats.add('Call');
      } else if (strat.contains('put')) {
        strats.add('Put');
      }
    }
    return strats.join('/');
  }

  Widget topRow() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UnderlinedTextColumn(keyValues: [
          KeyValues(
              key: underlinedKey('Asset'),
              value: underlinedValue(analysisData.symbol!)),
          KeyValues(
              key: underlinedKey('P/L'),
              value: underlinedValue(displayUnit == DISPLAY_UNIT.DOLLAR
                  ? analysisData.profitLossTotal.formatCurrency()
                  : analysisData.profitLossPercentPortfolio
                      .formatPercentage())),
        ]),
        const SizedBox(width: 20),
        Expanded(
            child: Container(
                alignment: Alignment.center,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // assetNameDisplay(analysisData.asset),
                      AppAssetImage(asset: analysisData.asset, height: 60)
                    ]))),
      ],
    );
  }

  Widget underlinedKey(String key) {
    return Builder(builder: (context) {
      return Text(
        key,
        style: TextStyle(
            fontSize: 11,
            color: context.theme.colorScheme.secondary.withOpacity(0.7),
            fontWeight: FontWeight.w200),
      );
    });
  }

  Widget underlinedValue(String value) {
    return Text(value,
        style: const TextStyle(
          fontSize: 13,
        ));
  }
}
