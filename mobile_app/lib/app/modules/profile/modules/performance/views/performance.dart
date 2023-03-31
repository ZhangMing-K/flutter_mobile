import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/institution/classes/connect_institution_arts.dart';
import 'package:iris_mobile/app/modules/profile/controllers/profile_controller.dart';

import '../widgets/holdings_section.dart';
import '../widgets/metric_display.dart';
import '../widgets/portfolio_selector.dart';

class Performance extends StatelessWidget {
  const Performance({
    Key? key,
    required this.user$,
    required this.controller,
  }) : super(key: key);
  final Rx<User> user$;
  final ProfileController controller;

  Widget connectButton() {
    if (!controller.isAuthUser) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Builder(builder: (context) {
        return SizedBox(
          width: context.width * 0.75,
          height: 45,
          child: ElevatedButton(
            onPressed: () async {
              var args = ConnectInstitutionArgs(
                  from: INSTITUTION_CONNECTED_FROM.PROFILE);
              await Get.toNamed(Paths.InstitutionConnectLanding,
                  arguments: args);

              controller.profileSummaryController.refreshData();
              controller.portfoliosNotifier.updatePortfolios();
            },
            child: const Text(
              'Connect Portfolio',
              style: TextStyle(
                color: Colors.white, //context.theme.colorScheme.secondary,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget noPortfolios() {
    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: 180,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height: 10),
              Image.asset(
                Images.suitcase,
                height: 34,
                color: IrisColor.primaryColor,
              ),
              const Text(
                'No Portfolios Connected',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        const SizedBox(height: 10),
        connectButton(),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = controller.portfoliosNotifier;
    return notifier.obx(onLoading: const IrisLoading(), onEmpty: noPortfolios(),
        (state) {
      return Obx(() {
        final user = user$.value;
        final points = controller.selectedPortfolio?.snapshot;
        final userPoints = user.temporarySnapshotHistoricalPoints;

        return ListView(
          children: [
            PortfolioSelector(
              user: user,
              selectedPortfolio: controller.portfolioSelectedKey.value,
              onSelected: controller.onSelected,
              portfolios: state ?? [],
              isAuthUser: controller.isAuthUser,
              onConnect: () {
                controller.profileSummaryController.refreshData();
                controller.portfoliosNotifier.updatePortfolios();
              },
            ),

            PerformanceMetrics(
              dayPercent: points?.dayPercent ?? userPoints?.dayPercent ?? 0.0,
              threeMonthPercent: points?.threeMonthPercent ??
                  userPoints?.threeMonthPercent ??
                  0.0,
              weekPercent:
                  points?.weekPercent ?? userPoints?.weekPercent ?? 0.0,
              yearPercent:
                  points?.yearPercent ?? userPoints?.yearPercent ?? 0.0,
            ),
            Holdings(
              selectedPortfolio: controller.portfolioSelectedKey.value,
              pieChartNotifier: controller.pieChartNotifier,
              positionListNotifier: controller.positionListNotifier,
              firstName: user.firstName ?? '',
            ),
            // RecentlyTraded(
            //   orders:
            //       controller.selectedPortfolio?.orders ?? user.orders ?? [],
            // ),
            //TODO Most Profitable Trades
            //TODO Watchlist Biggest movers
          ],
        );
      });
    });
  }
}

//TODO extract to its own file
class PerformanceMetrics extends StatelessWidget {
  const PerformanceMetrics({
    Key? key,
    required this.dayPercent,
    required this.weekPercent,
    required this.threeMonthPercent,
    required this.yearPercent,
  }) : super(key: key);

  final double dayPercent;
  final double weekPercent;
  final double threeMonthPercent;
  final double yearPercent;

  @override
  Widget build(BuildContext context) {
    //TODO use real data from the 'temporaryHistoricalData' from a controller
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 24.0,
        left: 8,
        right: 8,
        top: 26,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MetricDisplay(
              label: 'Today',
              //TODO use real data from the 'temporaryHistoricalData' from a controller
              percent: dayPercent,
              percentSize: 20,
              labelSize: 13,
            ),
            const VerticalDivider(width: .5),
            //TODO change the color of the divider to the proper color (once aaron picks one)
            MetricDisplay(
              label: 'Week',
              //TODO use real data from the 'temporaryHistoricalData' from a controller
              percent: weekPercent,
              percentSize: 20,
              labelSize: 13,
            ),
            const VerticalDivider(width: .5),
            //TODO change the color of the divider to the proper color (once aaron picks one)
            MetricDisplay(
              label: 'Three Month',
              //TODO use real data from the 'temporaryHistoricalData' from a controller
              percent: threeMonthPercent,
              percentSize: 20,
              labelSize: 13,
            ),
            const VerticalDivider(width: .5),
            //TODO change the color of the divider to the proper color (once aaron picks one)
            MetricDisplay(
              label: 'Year',
              //TODO use real data from the 'temporaryHistoricalData' from a controller
              percent: yearPercent,
              percentSize: 20,
              labelSize: 13,
            ),
          ],
        ),
      ),
    );
  }
}
