import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class PositionCardV2 extends StatelessWidget {
  final PositionModel position;

  const PositionCardV2({Key? key, required this.position}) : super(key: key);

  Color get percentGainColor {
    if (position.todayReturnPercentageDisplay! >= 0) {
      return IrisColor.positiveChange;
    } else {
      return IrisColor.negativeChange;
    }
  }

  Widget assetName() {
    return Builder(builder: (context) {
      return InkWell(
        onTap: () {
          if (position.asset != null) {
            //  AssetViewBottomSheet.open(assetKey: position.asset!.assetKey);
          }
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${position.symbol}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              optionInfo(),
              // Text(
              //   ' ${position.todayReturnPercentage >= 0 ? '+' : ''}${position?.todayReturnPercentage?.formatPercentage()} today',
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       color: percentGainColor,
              //       fontSize: 12),
              // ),
            ],
          ),
          if (position.positionType == POSITION_TYPE.OPTION)
            Text(
              '${position.optionInfo!.expiresAt.formatMonthDayYear()} Exp',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500),
            )
        ]),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (position.orderGroupUUID != null) {
            Get.toNamed(
              '/focused-feed',
              arguments: {
                'focusedFeedArguments': {
                  'orderGroupUUIDS': [position.orderGroupUUID]
                }
              },
              id: 1,
            );
          }
        },
        child: Container(
          height: 120,
          width: double.infinity,
          color: context.theme.scaffoldBackgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          // color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [firstRow(), secondRow()],
          ),
        ));
  }

  Widget firstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            AppAssetImage(
              asset: position.asset,
              symbol: position.symbol,
            ),
            const SizedBox(
              width: 8,
            ),
            assetName()
          ],
        ),
        Column(
          children: [
            DisplayPercent(
              percent: position.todayReturnPercentageDisplay,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            const Text('Today'),
          ],
        )
      ],
    );
  }

  Widget optionInfo() {
    if (position.positionType != POSITION_TYPE.OPTION) {
      return Container();
    }

    String? optionTypeName =
        describeEnum(position.optionType!).toLowerCase().capitalizeFirst;
    if (position.averageBuyPrice! < 0) optionTypeName = 'Short $optionTypeName';
    return Row(children: [
      Text(' \$${position.optionInfo!.strikePrice.formatCompact()} ',
          style: const TextStyle(fontWeight: FontWeight.w700)),
      Text(optionTypeName!,
          style: const TextStyle(fontWeight: FontWeight.w700)),
    ]);
  }

  Widget secondRow() {
    var avgBuyPrice = position.averageBuyPrice;
    avgBuyPrice ??= 0;
    final direction = avgBuyPrice < 0 ? 'Sell' : 'Buy';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        stat(
            title: 'Avg. $direction Price',
            value: avgBuyPrice.abs().formatCurrency()),
        stat(
            title: 'Current Price',
            value: position.currentPrice.formatCurrency()),
        stat(
            title: '% of Portfolio',
            value: position.percentOfPortfolio.formatPercentage()),
        stat(
          title: 'Total Change',
          // value: position?.returnPercentage?.formatPercentage()
          child: DisplayPercent(
            percent: position.returnPercentageDisplay,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }

  Widget stat({required String title, String? value, Widget? child}) {
    return Column(
      children: [
        if (value != null)
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
        if (child != null) child,
        Text(
          title,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}
