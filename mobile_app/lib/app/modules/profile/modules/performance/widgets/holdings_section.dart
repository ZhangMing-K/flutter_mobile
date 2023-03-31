import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/profile/modules/summary/notifiers/position_list_notifier.dart';
import 'package:iris_mobile/app/modules/profile/modules/summary/views/widgets/percent_display.dart';
import 'package:iris_mobile/app/routes/pages.dart';
import 'package:unicons/unicons.dart';

import '../../summary/notifiers/pie_chart_notifier.dart';
import 'metric_display.dart';
import 'position_slide_up.dart';

class Holdings extends StatelessWidget {
  const Holdings({
    Key? key,
    required this.selectedPortfolio,
    required this.positionListNotifier,
    required this.pieChartNotifier,
    required this.firstName,
  }) : super(key: key);

  final int? selectedPortfolio;
  final PositionListNotifier positionListNotifier;
  final PieChartNotifier pieChartNotifier;
  final String firstName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Holdings',
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
          _PieChart(
            controller: pieChartNotifier,
          ),
          PositionList(
            controller: positionListNotifier,
            isFullPage: false,
            firstName: firstName,
          ),
          Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: () {
                  Get.toNamed(Paths.AllPositions);

                  /// TODO animate navigation to all positions page
                  /// the top 5 animation cards will be the same on the next page. would be nice to have them hero animate to the next page
                },
                child: const Text('See all positions'),
              )
            ],
          )
        ],
      ),
    );
  }
}

class PositionList extends StatelessWidget {
  const PositionList({
    Key? key,
    required this.controller,
    required this.isFullPage,
    required this.firstName,
  }) : super(key: key);

  final PositionListNotifier controller;
  final bool isFullPage;
  final String firstName;

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      onLoading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: IrisLoading(),
      ),
      (state) => AnimatedCrossFade(
        crossFadeState: CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 300),
        firstChild: const SizedBox(
          height: 200,
          child: Center(
            child: IrisLoading(
              size: 50,
            ),
          ),
        ),
        secondChild: Column(
          children: state!.summarizedPositions!.map((position) {
            return _HoldingsCard(
              positionSummary: position,
              firstName: firstName,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _PieChart extends StatelessWidget {
  const _PieChart({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PieChartNotifier controller;

  @override
  Widget build(BuildContext context) {
    Color equityColor = Colors.blue;
    Color optionsColor = Colors.yellow;
    Color cryptoColor = Colors.purple;
    return controller.obx(
        onLoading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: IrisLoading(),
        ), (state) {
      final typeSummary = state!.positionTypeSummary;
      return AnimatedCrossFade(
        crossFadeState: CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 300),
        firstChild: const SizedBox(
          height: 200,
          child: Center(
            child: IrisLoading(
              size: 50,
            ),
          ),
        ),
        secondChild: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: PieChart(
                PieChartData(
                  startDegreeOffset: 90,
                  centerSpaceRadius: 50,
                  sections: [
                    PieChartSectionData(
                      showTitle: false,
                      value: typeSummary?.equityPercent,
                      color: equityColor,
                      radius: 25,
                    ),
                    PieChartSectionData(
                      showTitle: false,
                      value: typeSummary?.optionPercent,
                      color: optionsColor,
                      radius: 25,
                    ),
                    PieChartSectionData(
                      showTitle: false,
                      value: typeSummary?.cryptoPercent,
                      color: cryptoColor,
                      radius: 25,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ChartLegendItem(
                  label: 'Equities',
                  color: equityColor,
                  percent: typeSummary?.equityPercent,
                ),
                _ChartLegendItem(
                  label: 'Options',
                  color: optionsColor,
                  percent: typeSummary?.optionPercent,
                ),
                _ChartLegendItem(
                  label: 'Crypto',
                  color: cryptoColor,
                  percent: typeSummary?.cryptoPercent,
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}

class _ChartLegendItem extends StatelessWidget {
  const _ChartLegendItem({
    Key? key,
    required this.label,
    required this.color,
    required this.percent,
  }) : super(key: key);
  final String label;
  final Color color;
  final double? percent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(20)),
          ),
          const SizedBox(width: 8),
          if (percent != null) ...[
            PercentDisplay(
              percent: percent,
              showDecimal: false,
            ),
            const SizedBox(width: 4),
          ],
          Text(label),
        ],
      ),
    );
  }
}

///TODO will want to put this widget in its own file, so it can be used on the "See all positions" page which has not been built yet
//TODO move to it's own file
class _HoldingsCard extends StatelessWidget {
  const _HoldingsCard({
    Key? key,
    required this.positionSummary,
    required this.firstName,
  }) : super(key: key);

  final PositionsSummaryItem positionSummary;
  final String firstName;

  @override
  Widget build(BuildContext context) {
    return IrisCard(
        onTap: () {
          Get.bottomSheet(
            isScrollControlled: true,
            BottomSheet(
              onClosing: () {},
              //TODO build the complete bottom sheet
              builder: (context) {
                return IrisBottomSheetSingleScroll(
                  //  backgroundColor: context.theme.backgroundColor,
                  child: PositionSlideUp(
                    positionSummary: positionSummary,
                    firstName: firstName,
                  ),
                );
              },
              enableDrag: false,
            ),
          );
        },
        contentPadding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppAssetImage(
                    asset: positionSummary.asset ?? const Asset(),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        positionSummary.symbol ?? '',
                        style: Theme.of(context).custom.textTheme.h5Bold,
                      ),
                      SizedBox(
                        width: context.width / 3,
                        child: Text(
                          positionSummary.asset?.name ?? '',
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                  color: context
                                      .theme.custom.colorScheme.grayText),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      MetricDisplay(
                        label: 'Today',
                        percent: positionSummary.todayProfitLossPercent ?? 0,
                        labelSize: 12,
                        percentSize: 14,
                      ),
                      const SizedBox(width: 8),
                      MetricDisplay(
                        label: 'Total',
                        percent: positionSummary.profitLossPercent ?? 0,
                        labelSize: 14,
                        percentSize: 18,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.grey.withOpacity(.3),
            ),
            Row(
              children: [
                _IconStat(
                  value: (positionSummary.relativePositionValue! * 100).toInt(),
                  isPercent: true,
                  icon: UniconsLine
                      //TODO create use IrisIcon.pie_chart (or whatever the proper name is, see Figma)
                      .chart_pie_alt, //TODO create use IrisIcon.pie_chart
                ),
                _IconStat(
                  value: positionSummary.totalTransactionCount ?? 0,
                  rotate: true,
                  //TODO create use IrisIcon.transaction (or whatever the proper name is, see Figma)
                  icon: UniconsLine
                      .exchange, //TODO find and use proper Icon. this one is the wrong orientation
                ),
                _IconStat(
                  value: positionSummary.postCount ?? 0,
                  //TODO create use IrisIcon.post (or whatever the proper name is, see Figma)
                  icon: UniconsLine.list_ul, //TODO find and use proper Icon
                ),
                _IconStat(
                  value: positionSummary.dueDiligenceCount ?? 0,
                  //TODO create use IrisIcon.due_diligence (or whatever the proper name is, see Figma)
                  icon: UniconsLine.subject, //TODO find and use proper Icon
                ),
              ],
            ),
          ],
        ));
  }
}

class _IconStat extends StatelessWidget {
  const _IconStat({
    Key? key,
    required this.value,
    this.isPercent = false,
    required this.icon,
    this.rotate = false,
  }) : super(key: key);

  final int value;
  final bool isPercent;
  final IconData icon;
  final bool rotate;

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).custom.colorScheme.grayText;
    if (value < 1) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          RotatedBox(
            quarterTurns: rotate ? 1 : 0,
            child: Icon(
              icon,
              color: color,
              size: 14,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '${value.compactNumber()}${isPercent ? '%' : ''}',
            style: TextStyle(color: color, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
