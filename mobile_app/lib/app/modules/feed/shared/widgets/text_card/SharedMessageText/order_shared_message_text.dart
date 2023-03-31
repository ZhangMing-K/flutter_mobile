import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/rich_text/rich_text_span_builder.dart';
import 'package:unicons/unicons.dart';

class SharedTextOrder extends StatelessWidget {
  final TextModel? text;
  final double scaleFactor;
  final bool? compact;
  final bool? showFulFilledAt;
  final bool isCancellable;
  final Function()? onCancelSharingOrder;
  final Function()? onTap;
  const SharedTextOrder({
    Key? key,
    required this.text,
    this.isCancellable = false,
    this.scaleFactor = 1.0,
    this.onCancelSharingOrder,
    this.compact,
    this.showFulFilledAt,
    this.onTap,
  }) : super(key: key);

  String? get orderProfitLossDisplay {
    if ((text?.order?.positionEffect == POSITION_EFFECT.CLOSE ||
            ([POSITION_TYPE.OPTION, POSITION_TYPE.EQUITY]
                    .contains(text?.order?.positionType) &&
                text!.order!.closedDate != null)) &&
        text?.order?.profitLossPercentValue is double) {
      return '${text!.order!.profitLossPercentValue! >= 0 ? 'Made' : 'Lost'} ${(text!.order!.profitLossPercentValue!.abs()).formatPercentage()}';
    } else if (text?.order?.positionEffect == POSITION_EFFECT.OPEN &&
        text?.order?.closedDate == null &&
        text!.order!.profitLossPercentValue is double) {
      return (text!.order!.profitLossPercentValue!.abs()).formatPercentage();
    } else if (text!.order!.closedDate != null) {
      return 'Closed';
    } else {
      if (text?.order?.asset?.currentPrice != null) {
        return 'Now ${text!.order!.asset!.currentPrice.formatCurrency()}';
      } else {
        return null;
      }
    }
  }

  get orderSideColor {
    if (text!.order!.positionEffect == POSITION_EFFECT.OPEN) {
      return IrisColor.buyColorV2;
    } else if (text!.order!.positionEffect == POSITION_EFFECT.CLOSE) {
      return IrisColor.sellColor;
    }
    return Colors.black;
  }

  Color get profitLossColor {
    if (text!.order!.profitLossPercentValue != null &&
        text!.order!.profitLossPercentValue! > 0) {
      return IrisColor.positiveChange;
    } else if (text!.order!.profitLossPercentValue != null &&
        text!.order!.profitLossPercentValue! < 0) {
      return IrisColor.negativeChange;
    } else {
      return Colors.grey;
    }
  }

  @override
  build(BuildContext context) {
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
            if (onTap != null) {
              onTap!();
            } else {
              Get.toNamed(Paths.Text.createPath([text!.textKey]),
                  arguments: TextScreenArgs(text: text!.obs), id: 1);
            }
          },
          child: Column(
            children: [
              if (showFulFilledAt == true) fulfilledDate(),
              Container(
                padding: const EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: onTap != null
                      ? context.theme.hoverColor
                      : context.theme.backgroundColor,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        if (compact != true)
                          InkWell(
                              onTap: () {
                                if (onTap != null) {
                                  onTap!();
                                } else {
                                  Get.toNamed(
                                      Paths.Text.createPath([text!.textKey]),
                                      arguments:
                                          TextScreenArgs(text: text!.obs),
                                      id: 1);
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 0),
                                child: Row(children: [
                                  ProfileImage(
                                    onTap: () {
                                      if (onTap != null) {
                                        onTap!();
                                      } else {
                                        Get.toNamed(
                                            Paths.Text.createPath(
                                                [text!.textKey]),
                                            arguments:
                                                TextScreenArgs(text: text!.obs),
                                            id: 1);
                                      }
                                    },
                                    radius: 25,
                                    url: text!.user!.profilePictureUrl,
                                    uuid: uuid.v4(),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            UserName(
                                              user: text!.user,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15 * scaleFactor,
                                              route: false,
                                            ),
                                            featured(),
                                          ],
                                        ),
                                        Text(text!.dateFrom,
                                            style: TextStyle(
                                                fontSize: 12 * scaleFactor,
                                                color: Colors.grey.shade600))
                                      ]),
                                ]),
                              )),
                        Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Column(children: [
                              content(),
                              if (text!.value != null && text!.value != '')
                                orderReason(),
                            ])),
                      ],
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
        if (isCancellable)
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () {
                if (onCancelSharingOrder != null) {
                  onCancelSharingOrder!();
                }
              },
              child: const Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 8.0,
                  backgroundColor: Colors.red,
                  child: Icon(Icons.close, color: Colors.white, size: 12.0),
                ),
              ),
            ),
          ),
      ],
    );
  }

  content() {
    return GestureDetector(
      child: Container(
          color: Colors.transparent,
          // margin: EdgeInsets.only(left: 0, right: 0, bottom: 0),
          child: orderContent()),
    );
  }

  Widget equityInfo() {
    return Text(
      text!.order!.averagePrice.formatCurrency(),
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13 * scaleFactor),
    );
  }

  featured() {
    if (text!.featuredAt == null) {
      return Container();
    }
    return Row(
      children: const [
        Icon(
          Icons.star,
          size: 15,
          color: IrisColor.gold,
        ),
        SizedBox(
          width: 3,
        ),
      ],
    );
  }

  fulfilledDate() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
          '${text!.order!.fullfilledAt.formatYmd()} - ${text!.order!.fullfilledAt.formatTimeStandardToLocal()}',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.grey.shade600)),
    );
  }

  Widget optionInfo() {
    final Order order = text!.order!;

    if (!order.isMultiStrike && !order.hasLongOptionName) {
      return Text(
          '\$${text!.order!.strikePrice.formatCompact(nullSign: '-')} ${text!.order!.orderStrategyDisplay.capitalizeFirstApp()}',
          style: TextStyle(
              fontSize: 13 * scaleFactor, fontWeight: FontWeight.bold));
    } else {
      return Row(
        children: [
          Text(
            text!.order!.orderStrategyDisplay.capitalizeFirstApp(),
            style: TextStyle(
                fontSize: 11 * scaleFactor, fontWeight: FontWeight.bold),
          )
        ],
      );
    }
  }

  Widget orderContent() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const Padding(
        padding: EdgeInsets.only(top: 10),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(flex: 4, child: orderSideRow()),
          profitLossContainer(),
        ],
      ),
      const Padding(
        padding: EdgeInsets.only(bottom: 10),
      ),
    ]);
  }

  orderReason() {
    return Builder(builder: (context) {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        // height: 70,
        width: double.infinity,

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).hoverColor),
        child: Builder(builder: (context) {
          return ExtendedText(
            text!.value!,
            specialTextSpanBuilder: RichTextSpanBuilder(context: context),
          );
        }),
      );
    });
  }

  orderSide() {
    final Order order = text!.order!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(order.orderSideDisplayAction,
            style: TextStyle(
                fontSize: 20 * scaleFactor,
                fontWeight: FontWeight.w700,
                color: orderSideColor)),
      ],
    );
  }

  orderSideRow() {
    final Order order = text!.order!;
    final Asset? asset = order.asset;

    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      // SizedBox()
      AppAssetImage(
        asset: asset,
        symbol: order.symbol,
        height: 40,
      ),
      const SizedBox(
        width: 10,
      ),
      Flexible(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!text!.order!.hasLongOptionName)
                Text(order.orderSideDisplayAction,
                    style: TextStyle(
                        fontSize: 13 * scaleFactor,
                        fontWeight: FontWeight.w700,
                        color: orderSideColor)),
              Wrap(
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (text!.order!.hasLongOptionName)
                    Text('${order.orderSideDisplayAction} ',
                        style: TextStyle(
                            fontSize: 13 * scaleFactor,
                            fontWeight: FontWeight.w700,
                            color: orderSideColor)),
                  Text(order.symbol!,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13 * scaleFactor)),
                  const SizedBox(width: 3),
                  if (order.positionType == POSITION_TYPE.OPTION)
                    optionInfo()
                  else
                    equityInfo(),
                ],
              ),
              if (text!.order!.positionType == POSITION_TYPE.OPTION &&
                  !text!.order!.isMultiExpiration)
                Text('Exp: ${text!.order!.expirationDate.formatMonthDayYear()}',
                    style: TextStyle(
                        fontSize: 12 * scaleFactor,
                        color: Colors.grey.shade600)),
            ]),
      )
    ]);
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
                    left: 20, right: 20, top: 7, bottom: 7),
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
                                  fontSize: 16 * scaleFactor,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      if (text!.order!.positionOpenTimeDisplay is String)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                UniconsLine.clock,
                                color: profitLossColor,
                                size: 12,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(text!.order!.positionOpenTimeDisplay!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: profitLossColor,
                                    fontSize: 12 * scaleFactor,
                                  )),
                            ])
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
    if ((text?.order?.positionEffect == POSITION_EFFECT.CLOSE ||
            (text?.order?.positionType == POSITION_TYPE.OPTION &&
                text!.order!.closedDate != null)) &&
        text?.order?.profitLossPercentValue is double) {
      return null;
    } else if (text?.order?.positionEffect == POSITION_EFFECT.OPEN &&
        text?.order?.closedDate == null &&
        text!.order!.profitLossPercentValue is double) {
      return Icon(
          text!.order!.profitLossPercentValue! >= 0
              ? UniconsLine.arrow_up
              : UniconsLine.arrow_down,
          color: profitLossColor,
          size: 20);
    } else if (text!.order!.closedDate != null) {
      return null;
    } else {
      return null;
    }
  }

  settingsButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {},
          child: SizedBox(
              height: 30,
              width: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.more_horiz,
                    color: Colors.grey,
                  ),
                ],
              )),
        )
      ],
    );
  }
}
