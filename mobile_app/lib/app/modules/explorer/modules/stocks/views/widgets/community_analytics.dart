import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../routes/pages.dart';
import '../../../who_to_follow/widgets/explorer_header.dart';
import '../../controllers/stocks_controller.dart';

class AssetCard extends StatelessWidget {
  final TradeAnalysis trade;
  const AssetCard({Key? key, required this.trade}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppAssetImage(asset: trade.asset),
            Text(
              trade.symbol ?? '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (trade.asset?.quote?.changePercent != null)
              cell(
                  contents: valueCell(
                      '${trade.asset!.quote!.changePercent! >= 0 ? '+' : '-'}${trade.asset!.quote!.changePercent!.abs().formatPercentage()}',
                      positive: trade.asset!.quote!.changePercent! >= 0,
                      fontSize: 18),
                  width: 60,
                  alignment: Alignment.centerLeft)
            else
              cell(
                  contents: const Text('-'),
                  width: 60,
                  alignment: Alignment.centerLeft)
          ],
        ));
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

  getColor(bool positive) {
    if (positive) {
      return IrisColor.positiveChange;
    } else {
      return IrisColor.negativeChange;
    }
  }

  Widget valueCell(String value,
      {required bool positive, double fontSize = 12}) {
    return Text(value,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: fontSize,
            color: getColor(positive),
            fontWeight: FontWeight.bold));
  }
}

class CommunityAnalyticsView extends GetView<StocksController> {
  const CommunityAnalyticsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.only(
              left: 6,
              top: 35,
            ),
            child: const Text(
              'Stocks/Crypto',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            )),
        const ExplorerHeader(text: 'Iris Community Analytics'),
        Row(
          children: [
            MostBearishOrBullishCard(
                title: 'Most Bullish', tradeList: controller.mostBullish$),
            MostBearishOrBullishCard(
                title: 'Most Bearish', tradeList: controller.mostBearish$),
          ],
        ),
      ],
    );
  }
}

class MostBearishOrBullishCard extends StatelessWidget {
  final List<TradeAnalysis> tradeList;
  final String title;
  const MostBearishOrBullishCard(
      {Key? key, required this.title, required this.tradeList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Paths.Trending);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: kBorderRadius,
          color: context.theme.backgroundColor,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(10),
        width: (Get.width - 44) / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: tradeList.length,
                  itemBuilder: (context, index) {
                    return AssetCard(trade: tradeList[index]);
                  });
            })
          ],
        ),
      ),
    );
  }
}
