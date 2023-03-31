import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/rich_text/rich_text_span_builder.dart';
import 'package:unicons/unicons.dart';

class RecentOrderText extends StatelessWidget {
  final Order? order;
  final String? value;

  const RecentOrderText({
    Key? key,
    required this.order,
    this.value,
  }) : super(key: key);

  String? get orderProfitLossDisplay {
    if ((order?.positionEffect == POSITION_EFFECT.CLOSE ||
            ([POSITION_TYPE.OPTION, POSITION_TYPE.EQUITY]
                    .contains(order?.positionType) &&
                order!.closedDate != null)) &&
        order?.profitLossPercentValue is double) {
      return '${order!.profitLossPercentValue! >= 0 ? 'Made' : 'Lost'} ${(order!.profitLossPercentValue!.abs()).formatPercentage()}';
    } else if (order?.positionEffect == POSITION_EFFECT.OPEN &&
        order?.closedDate == null &&
        order!.profitLossPercentValue is double) {
      return (order!.profitLossPercentValue!.abs()).formatPercentage();
    } else if (order!.closedDate != null) {
      return 'Closed';
    } else {
      if (order?.asset?.currentPrice != null) {
        return 'Now ${order!.asset!.currentPrice.formatCurrency()}';
      } else {
        return null;
      }
    }
  }

  get orderSideColor {
    Color orderSideColor = Colors.black;
    if (order!.positionEffect == POSITION_EFFECT.OPEN) {
      orderSideColor = IrisColor.buyColorV2;
    } else if (order!.positionEffect == POSITION_EFFECT.CLOSE) {
      orderSideColor = IrisColor.sellColor;
    }
    return orderSideColor;
  }

  Color get profitLossColor {
    if (order!.profitLossPercentValue != null &&
        order!.profitLossPercentValue! > 0) {
      return IrisColor.positiveChange;
    } else if (order!.profitLossPercentValue != null &&
        order!.profitLossPercentValue! < 0) {
      return IrisColor.negativeChange;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 3),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    // color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                    color: Theme.of(context).hoverColor),
                child: Column(children: [
                  content(),
                  if (value != null && value != '') orderReason(),
                ])),
          ],
        ))
      ],
    );
  }

  content() {
    return GestureDetector(
      child: Container(
          color: Colors.transparent,
          //this is gonna sound crazy, but adding a color here fixes the issue of double taps not working in the middle of the card
          margin: const EdgeInsets.only(left: 10, right: 20, bottom: 0),
          child: Column(children: [
            // orderType(),
            const SizedBox(
              height: 5,
            ),
            orderContent(),
          ])),
    );
  }

  Widget equityInfo() {
    return Text(
      order!.averagePrice.formatCurrency(),
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
    );
  }

  fulfilledDate() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
          '${order!.fullfilledAt.formatYmd()} - ${order!.fullfilledAt.formatTimeStandardToLocal()}',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.grey.shade600)),
    );
  }

  Widget optionInfo() {
    if (order == null) return Container();

    if (order!.isMultiStrike && order!.hasLongOptionName) {
      return Row(
        children: [
          Text('\$${order!.strikePrice.formatCompact(nullSign: '-')}',
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(
            ' ${order!.orderStrategyDisplay.capitalizeFirstApp()}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      );
    } else {
      return Row(
        children: [
          Text(
            order!.orderStrategyDisplay.capitalizeFirstApp(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          )
        ],
      );
    }
  }

  Widget orderContent() {
    final Asset? asset = order!.asset;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: AppAssetImage(
              asset: asset,
              symbol: order!.symbol,
              height: 40,
            ),
          ),
          Flexible(flex: 4, child: orderSideRow()),
          Flexible(flex: 3, child: profitLossContainer()),
        ],
      ),
      const Padding(
        padding: EdgeInsets.only(bottom: 15),
      ),
    ]);
  }

  orderReason() {
    return Builder(builder: (context) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        // height: 70,
        width: double.infinity,

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).backgroundColor),
        child: Builder(builder: (context) {
          return ExtendedText(
            value!,
            specialTextSpanBuilder: RichTextSpanBuilder(context: context),
          );
        }),
      );
    });
  }

  Widget orderSide() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(order!.orderSideDisplayAction,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: orderSideColor)),
      ],
    );
  }

  orderSideRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox()

        const SizedBox(
          width: 10,
        ),
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!order!.hasLongOptionName)
                Text(order!.orderSideDisplayAction,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: orderSideColor)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (order!.hasLongOptionName)
                    Text('${order!.orderSideDisplayAction} ',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: orderSideColor)),
                  Text(order!.symbol!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 18)),
                  const SizedBox(width: 3),
                ],
              ),
              if (order!.positionType == POSITION_TYPE.OPTION)
                optionInfo()
              else
                equityInfo(),
              if (order!.positionType == POSITION_TYPE.OPTION &&
                  !order!.isMultiExpiration)
                Text('${order!.expirationDate.formatMonthDayYear()} Exp.',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.grey.shade600)),
            ]),
      ],
    );
  }

  Widget profitLossBubble(display) {
    final lossIcon = profitLossIcon();
    return InkWell(
        child: Container(
            decoration: BoxDecoration(
              color: profitLossColor.withOpacity(0.3),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Container(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 6, bottom: 6),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (lossIcon != null) lossIcon,
                          Text(display,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: profitLossColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      if (order!.positionOpenTimeDisplay is String)
                        Text(order!.positionOpenTimeDisplay!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: profitLossColor,
                              fontSize: 12,
                            )),
                    ]))));
  }

  Widget profitLossContainer() {
    if (orderProfitLossDisplay != null) {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        profitLossBubble(orderProfitLossDisplay),
      ]);
    } else {
      return Container();
    }
  }

  profitLossIcon() {
    if ((order?.positionEffect == POSITION_EFFECT.CLOSE ||
            (order?.positionType == POSITION_TYPE.OPTION &&
                order!.closedDate != null)) &&
        order?.profitLossPercentValue is double) {
      return null;
    } else if (order?.positionEffect == POSITION_EFFECT.OPEN &&
        order?.closedDate == null &&
        order!.profitLossPercentValue is double) {
      return Icon(
          order!.profitLossPercentValue! >= 0
              ? UniconsLine.arrow_up
              : UniconsLine.arrow_down,
          color: profitLossColor,
          size: 20);
    } else if (order!.closedDate != null) {
      // return 'Closed';
      return null;
    } else {
      // if (text?.order?.asset?.currentPrice != null)
      //   return 'Now ${order!.asset!.currentPrice.formatCurrency()}';
      // else
      //   return null;
      return null;
    }
  }
}
