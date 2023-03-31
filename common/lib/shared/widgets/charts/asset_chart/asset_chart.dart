import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iris_common/iris_common.dart';

class AssetChart extends StatelessWidget {
  final int assetKey;

  const AssetChart({Key? key, required this.assetKey}) : super(key: key);

  Widget assetChart(AssetChartController controller) {
    final asset = controller.asset$.value!;
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        AppChart(
          tag: 'asset-${asset.assetKey}',
          historicalFunction: controller.getHistorical,
          leading: AppAssetImage(
            asset: asset,
            height: 50,
          ),
          title: Text(
            asset.symbol!,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          subtitle: SizedBox(
            width: 400,
            child: Text(
              asset.name!,
              style: TextStyle(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          ),
          chartData: ChartData(dayHistorical: asset.dayHistorical),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetX<AssetChartController>(
        init: AssetChartController(assetKey: assetKey),
        tag: assetKey.toString(),
        builder: (controller) {
          final apiStatus = controller.apiStatus$.value;
          final asset = controller.asset$.value;
          if (apiStatus != API_STATUS.FINISHED && asset == null) {
            return Column(
              children: [shimmer()],
            );
          } else if (apiStatus == API_STATUS.FINISHED && asset == null) {
            return Container();
          }

          return Column(children: [
            assetChart(controller),
            fundamentals(controller),
          ]);
        });
  }

  Widget fundamentals(AssetChartController controller) {
    final assetStat = controller.asset$.value!.assetStat!;
    String dividendYield = '-';
    if (assetStat.dividendYield != null) {
      dividendYield = assetStat.dividendYield.formatPercentage();
    }

    return HorizontalInfo(columns: [
      InfoColumn(items: [
        InfoItem(
            title: 'Put/Call Ratio', value: assetStat.putCallRatio.toString()),
        InfoItem(title: 'P/E', value: assetStat.peRatio?.toString() ?? '-'),
        InfoItem(
            title: 'Mkt Cap',
            value: NumberFormat.compact().format(assetStat.marketCap ?? 0)),
      ]),
      InfoColumn(
        items: [
          InfoItem(
              title: 'Total Cash', value: assetStat.totalCash.formatCompact()),
          InfoItem(
              title: 'Current Debt',
              value: assetStat.currentDebt.formatCompact()),
          InfoItem(
              title: 'Revenue',
              value: NumberFormat.compact().format(assetStat.revenue ?? 0)),
        ],
      ),
      InfoColumn(
        items: [
          InfoItem(
              title: 'Revenue Per Share',
              value:
                  '\$${NumberFormat.compact().format(assetStat.revenuePerShare ?? 0)}'),
          InfoItem(
              title: 'Gross Profit',
              value: NumberFormat.compact().format(assetStat.grossProfit ?? 0)),
          InfoItem(
              title: 'EBITDA',
              value: NumberFormat.compact().format(assetStat.ebitda ?? 0)),
        ],
      ),
      InfoColumn(
        items: [
          InfoItem(title: 'Beta', value: assetStat.beta?.toString() ?? '-'),
          InfoItem(title: 'EPS', value: assetStat.ttmEPS?.toString() ?? '-'),
          InfoItem(title: 'Yield', value: dividendYield),
        ],
      )
    ]);
  }

  Widget shimmer() {
    return Column(
      children: const [
        HistoricalChartShimmer(),
      ],
    );
  }
}
