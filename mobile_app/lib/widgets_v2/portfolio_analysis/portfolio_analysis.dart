import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'portfolio_analysis_controller.dart';
import 'portfolio_analysis_shimmer.dart';
import 'widgets/portfolio_analysis_table.dart';
import 'widgets/table_values_faq.dart';
import 'widgets/trade_analysis_chart.dart';

class PortfolioAnalysis extends StatelessWidget {
  DISPLAY_UNIT? displayUnit;
  bool? isAuthUser;
  final int? userKey;
  final int? portfolioKey;
  final String? symbol;
  late PortfolioAnalysisController c;
  double? containerWidth;
  late double containerHeight;
  late BuildContext buildContext;
  PortfolioAnalysis(
      {this.userKey,
      this.portfolioKey,
      this.symbol,
      this.displayUnit,
      this.isAuthUser}) {
    c = Get.put(
        PortfolioAnalysisController(
          userKey: userKey,
          portfolioKey: portfolioKey,
          symbol: symbol,
          displayUnit: displayUnit,
          isAuthUser: isAuthUser,
        ),
        tag: portfolioKey.toString());
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    containerWidth = MediaQuery.of(context).size.width;
    containerHeight = MediaQuery.of(context).size.height;
    //  c.initContext(context: context);

    return Obx(() {
      if (c.dataSource$.isNotEmpty) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              topRow(context),
              positionTypeAnalysisWidget(),
              controlsRow(context),
              if (c.dataSource$.isNotEmpty)
                PortfolioAnalysisTable(
                  dataSource: c.dataSource$,
                  displayUnit: c.displayUnitToggle$.value,
                  handleSortData: c.sortTradeAnalysisData,
                  sortedColumn: c.sortColumns$.value,
                )
              else
                Container(
                  height: containerHeight * .25,
                  alignment: Alignment.center,
                  child: const Text('No positions found matching your search'),
                )
            ]);
      } else {
        return const PortfolioAnalysisShimmer();
      }
    });
  }

  Widget controls(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        toggleRealized(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 35,
              width: 85,
              padding: const EdgeInsets.only(left: 15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: positionTypeSelector(context),
            ),
            const SizedBox(width: 20),
            Container(
              height: 35,
              width: 80,
              padding: const EdgeInsets.only(left: 15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                // color: Colors.white
              ),
              child: spanSelector(context),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
      ],
    );
  }

  Widget controlsRow(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          controls(context),
        ],
      ),
    );
  }

  Color getValueColor(double val) {
    return val >= 0 ? IrisColor.positiveChange : IrisColor.negativeChange;
  }

  positionTypeAnalysisWidget() {
    return Builder(builder: (context) {
      return Container(
        width: containerWidth,
        decoration: BoxDecoration(color: context.theme.backgroundColor),
        height: 140,
        child: summaryViewSection(),
      );
    });
  }

  Widget positionTypeSelector(BuildContext context) {
    return Obx(() {
      return DropdownButton(
        dropdownColor: context.theme.backgroundColor,
        value: c.selectedSpecificPositionType$.value,
        icon: Image.asset(
          IconPath.downBlackArrow,
          width: 11,
          height: 6,
        ),
        disabledHint: const Text(
          'Disabled',
          style: TextStyle(fontSize: 10),
          textAlign: TextAlign.center,
        ),
        style: TextStyle(
          color: context.textTheme.bodyText1!.color,
          fontSize: 12,
        ),
        underline: Container(),
        onChanged: c.refreshByPositionType,
        items: c.positionTypes.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    });
  }

  Widget spanSelector(BuildContext context) {
    return Obx(() {
      return DropdownButton(
        dropdownColor: context.theme.backgroundColor,
        value: c.selectedSpan$.value,
        icon: Image.asset(
          IconPath.downBlackArrow,
          width: 11,
          height: 6,
        ),
        disabledHint: const Text(
          'Disabled',
          style: TextStyle(fontSize: 10),
          textAlign: TextAlign.center,
        ),
        style: TextStyle(
          color: context.textTheme.bodyText1!.color,
          fontSize: 12,
        ),
        underline: Container(),
        onChanged: c.refreshBySpan,
        items: c.spans.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    });
  }

  Widget summaryViewSection() {
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              // Container
              TradeAnalysisChart(
                chartData: c.positionTypeAnalysis$.value,
                displayUnit: c.displayUnitToggle$.value,
                onRendered: (item) => c.onTradeAnalysisChartRender(item),
              )
            ],
          )
        ],
      );
    });
  }

  Widget tableLegend() {
    return InkWell(
      child: Icon(
        Icons.help_outline_rounded,
        size: 18,
        color: Colors.lightBlue.withOpacity(0.7),
      ),
      onTap: () {
        final BaseController baseController = Get.find();
        baseController.openPanel(
          child: tableLegendValues(),
          openPanelPosition: .5,
          context: buildContext,
        );
      },
    );
  }

  Widget tableLegendValues() {
    return Obx(() {
      return TableValuesFAQ(
        panelTitle: 'Table Legend',
        faqItems: [
          FAQItem(
              title: null,
              answer:
                  'Please note that these results have been calculated from the orders placed within the specified time-span, not from historical portfolio balance. These results only include long positions with options and equities - no short positions or complex option strategies are included in these calculations.'),
          if (c.displayUnitToggle$.value == DISPLAY_UNIT.DOLLAR)
            FAQItem(
                title: '🔒 Gain',
                answer:
                    'This represents the total realized profit/loss for given ticker in specified time-span and position-type (equities, options, etc.)')
          else
            FAQItem(
                title: 'Gain (% of portfolio balance)',
                answer:
                    'This represents the total realized profit/loss for given ticker in specified time-span and position-type (equities, options, etc.)'),
          FAQItem(
              title: '% of Average Investment',
              answer:
                  'Represents the profit/loss percentage relative to the average investment in a given ticker over specified period of time.\nExample: investor "A" spends \$10,000 on \$TSLA calls in March 2020. His average investment was \$1,000, and he closed each of those posiitons for a 5,000% gain (in order to buy a fleet of lambos), his "% Avg Invest" would be 5,000% (1,000 x 50 / 1,000 = 50.0 = 5,000%)'),
          FAQItem(
              title: 'Trades',
              answer:
                  'Total number of trades for given ticker according to the specified search inputs.'),
        ],
      );
    });
  }

  Widget toggleDisplayUnit() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Transform.scale(
              scale: 0.85,
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Switch(
                      value: c.displayUnitToggleBool$.value,
                      onChanged: c.refresheByDisplayUnit,
                      activeColor: Colors.white,
                      activeTrackColor: IrisColor.buyColor.withOpacity(0.75),
                      inactiveTrackColor: IrisColor.buyColor.withOpacity(0.5),
                      inactiveThumbColor: IrisColor.buyColor,
                    ),
                    Text('(${c.displayUnitToggleBool$.value ? '\$' : '%'})',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: c.totalPercentProfitLoss$.value! >= 0
                                ? IrisColor.positiveChange
                                : IrisColor.negativeChange)),
                  ],
                ),
              ))
        ],
      );
    });
  }

  Widget toggleRealized() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(c.realized$.value ? 'Realized' : 'Total'),
          SizedBox(
            height: 35,
            // width: 60,
            child: Switch(
              value: c.realized$.value,
              onChanged: c.refreshByRealized,
              activeColor: IrisColor.buyColor,
              inactiveTrackColor: IrisColor.buyColor,
            ),
          ),
        ],
      );
    });
  }

  Widget topRow(BuildContext context) {
    return Container(
      // color: Colors.black12,
      color: context.theme.backgroundColor,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [topRowTotalText(context), totalProfitLossDisplay()],
            ),
          ],
        ),
      ),
    );
  }

  Widget topRowTotalText(BuildContext context) {
    return Obx(() {
      return SizedBox(
        height: 45,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${c.realized$.value ? 'Realized' : 'Total'} Gains',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: context.textTheme.bodyText1!.color,
                        ),
                      ),
                      const SizedBox(width: 5),
                      tableLegend(),
                    ],
                  ),
                  if (c.displayUnitToggle$.value == DISPLAY_UNIT.DOLLAR)
                    Text(
                      '🔒 Dollar amounts only visible to you.',
                      style: TextStyle(
                        fontSize: 10,
                        color: context.textTheme.bodyText1!.color!
                            .withOpacity(0.75),
                      ),
                    ),
                  if (c.displayUnitToggle$.value == DISPLAY_UNIT.PERCENT)
                    Text(
                      'Dollar amounts shown by % of portfolio.',
                      style: TextStyle(
                        fontSize: 10,
                        color: context.textTheme.bodyText1!.color!
                            .withOpacity(0.75),
                      ),
                    ),
                ],
              ),
            ]),
      );
    });
  }

  Widget totalProfitLossDisplay() {
    if (c.totalProfitLoss$.value == null) {
      return Container();
    }
    final double pl = c.displayUnitToggle$.value == DISPLAY_UNIT.DOLLAR
        ? c.totalProfitLoss$.value!
        : c.totalPercentProfitLoss$.value!;
    final String plText = c.displayUnitToggle$.value == DISPLAY_UNIT.DOLLAR
        ? pl.abs().formatCurrency()
        : pl.formatPercentage();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Image.asset(
            pl >= 0 ? IconPath.greenArrowPercent : IconPath.redArrowPercent,
            width: 14,
            height: 8,
          ),
          Text(plText,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: pl >= 0
                      ? IrisColor.positiveChange
                      : IrisColor.negativeChange))
        ]),
        if (c.isAuthUser!)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [toggleDisplayUnit()],
          ),
      ],
    );
  }
}
