import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/widgets/app_easy_rich_text/rich_text_editor.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/rich_text/rich_text_span_builder.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/text_card/shared_text_header.dart';
import 'package:unicons/unicons.dart';

import 'text_card.dart';
import 'text_card_controller.dart';

class OrderText extends StatelessWidget {
  final TextModel? text;
  final TextCardController controller;
  final Function() onDoubleTap;
  final TEXT_CARD_DISPLAY_TYPE textCardDisplayType;
  final VoidCallback? onFollowTapped;
  final VoidCallback showMore;

  /// When `textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.STORY` the entire card will be forced into a darktheme like state. all dark colors, with light texts
  /// This approach is used instead of overriding the `Theme` to avoid the latency of that approach.
  /// The theme takes just a second to populate, so going from light to dark, you see a flash of white when the page opens and then it goes to dark.
  bool get isStory => textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.STORY;
  final Color storyTextColor = Colors.white;
  final String showMoreTag =
      ' ... <C {"type":"showMore","value":"see"}>SEE</C>';

  const OrderText({
    Key? key,
    required this.text,
    required this.controller,
    required this.onDoubleTap,
    required this.showMore,
    this.textCardDisplayType = TEXT_CARD_DISPLAY_TYPE.SUMMARY,
    required this.onFollowTapped,
  }) : super(key: key);

  String? get orderProfitLossDisplay {
    if ((text?.order?.positionEffect == POSITION_EFFECT.CLOSE ||
            ([POSITION_TYPE.OPTION, POSITION_TYPE.EQUITY]
                    .contains(text?.order?.positionType) &&
                text?.order?.closedDate != null)) &&
        text?.order?.profitLossPercentValue is double) {
      return '${text!.order!.profitLossPercentValue! >= 0 ? 'Made' : 'Lost'} ${(text?.order?.profitLossPercentValue!.abs()).formatPercentage()}';
    } else if (text?.order?.positionEffect == POSITION_EFFECT.OPEN &&
        text?.order?.closedDate == null &&
        text?.order?.profitLossPercentValue is double) {
      return '${text!.order!.profitLossPercentValue! >= 0 ? 'Up' : 'Down'} ${(text?.order?.profitLossPercentValue!.abs()).formatPercentage()}';
    } else if (text?.order?.closedDate != null) {
      return 'Closed';
    } else {
      if (text?.order?.asset?.currentPrice != null) {
        return 'Now ${text?.order?.asset!.currentPrice.formatCurrency()}';
      } else {
        return null;
      }
    }
  }

  Color orderSideColor(BuildContext context) {
    Color orderSideColor = isStory
        ? storyTextColor
        : context.theme.colorScheme.secondary; // Colors.black;
    if (text?.order?.positionEffect == POSITION_EFFECT.OPEN) {
      orderSideColor = IrisColor.buyColorV2;
    } else if (text?.order?.positionEffect == POSITION_EFFECT.CLOSE) {
      orderSideColor = IrisColor.buyColor;
    }
    return orderSideColor;
  }

  Color get profitLossColor {
    if (text?.order?.profitLossPercentValue != null &&
        text!.order!.profitLossPercentValue! > 0) {
      return IrisColor.positiveChange;
    } else if (text?.order?.profitLossPercentValue != null &&
        text!.order!.profitLossPercentValue! < 0) {
      return IrisColor.negativeChange;
    } else {
      return Colors.grey;
    }
  }

  String get likeCount {
    return text?.numberOfReactions!.toString() ?? '0';
  }

  String get commentCount {
    return text?.numberOfComments!.toString() ?? '0';
  }

  Container autoPilotOrderBadge() {
    if (text?.order?.autoPilotOrder == null) {
      return Container();
    }
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            IconPath.autoPilotIcon,
            height: 15,
          ),
          const SizedBox(width: 5),
          const Text(
            'Autopiloted ',
            style: TextStyle(fontSize: 12, color: IrisColor.dateFromColor),
          ),
          if (text!.order!.autoPilotOrder!.masterUser != null)
            UserName(
              user: text!.order!.autoPilotOrder!.masterUser!,
              fontSize: 12,
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(Paths.Text.createPath([text!.textKey]),
                  arguments: TextScreenArgs(text: text!.obs), id: 1);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                firstRow(),
                if (text!.value != null && text!.value != '') orderReason(),
                finalMain(),
                commentAndLikes(),
              ],
            ),
          )),
    );
  }

  Widget commentAndLikes() {
    return Builder(builder: (context) {
      if (textCardDisplayType != TEXT_CARD_DISPLAY_TYPE.STORY) {
        return Container();
      }
      Color color = isStory
          ? Colors.white.withOpacity(0.8)
          : context.theme.colorScheme.secondary.withOpacity(.8);
      return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              TouchableArea(
                  child: Icon(
                UniconsLine.thumbs_up,
                color: color,
                size: kIconSize,
              )),
              Text(
                likeCount,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
              const SizedBox(width: 24),
              TouchableArea(
                  child: Icon(
                UniconsLine.comment,
                size: kIconSize,
                color: color,
              )),
              Text(
                commentCount,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ],
          ));
    });
  }

  Widget content() {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      child: Container(
          color: Colors.transparent,
          // adding a container with color here fills in the negative space around the text to capture the gesture, and thereby fixes the issue of double taps not working in the middle of the card
          //  margin: EdgeInsets.only(left: 10, right: 20, bottom: 0),
          child: Column(children: [
            orderContent(),
          ])),
    );
  }

  Widget editTradeReasonButton() {
    if (textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.STORY ||
        textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.CONTENT_ONLY) {
      return Container();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 30,
          width: 50,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: IrisColor.primaryColor,
            child: InkWell(
              onTap: () {
                controller.tapEditReason();
              },
              child: const Center(
                child: Icon(
                  UniconsLine.edit_alt,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget equityInfo() {
    return Text(
      'at ${text?.order?.averagePrice.formatCurrency()}',
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
    );
  }

  Widget featured() {
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

  Widget finalMain() {
    if (text?.order?.autoPilotOrder == null) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: main(),
      );
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: kGradientBoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(2.5),
        child: main(),
      ),
    );
  }

  Widget followText() {
    if (text!.user?.authUserFollowInfo?.followStatus ==
        FOLLOW_STATUS.NOT_FOLLOWING) {
      return Row(
        children: [
          const Text('   •'),
          TextButton(
            style: ButtonStyle(
              //reduce padding and minimum size to prevent larger than intended size
              padding: MaterialStateProperty.resolveWith(
                (states) => const EdgeInsets.only(left: 12),
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize:
                  MaterialStateProperty.resolveWith((states) => Size.zero),
            ),
            child: const Text('Follow'),
            onPressed: () {
              controller.followUser();
              onFollowTapped?.call();
            },
          ),
        ],
      );
    }
    return Container();
  }

  Widget firstRow() {
    if (textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.IMAGE_SHARE) {
      return SharedTextHeader(text: text!);
    }
    final id = uuid.v4();
    return Container(
        margin: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 24,
        ),
        child: Row(
          crossAxisAlignment: (text?.order?.autoPilotOrder == null)
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            if (textCardDisplayType != TEXT_CARD_DISPLAY_TYPE.CONTENT_ONLY &&
                textCardDisplayType != TEXT_CARD_DISPLAY_TYPE.STORY)
              UserImage(
                radius: 25,
                user: text!.user!,
                brokerName: text?.order?.portfolio?.brokerName,
                id: id,
              ),
            if (textCardDisplayType != TEXT_CARD_DISPLAY_TYPE.CONTENT_ONLY &&
                textCardDisplayType != TEXT_CARD_DISPLAY_TYPE.STORY)
              Expanded(
                  child: Material(
                child: InkWell(
                    onTap: () => controller.routeToProfilePage(id),
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: UserName(
                                  shrinkText: false,
                                  heroTag: id,
                                  user: text!.user,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                              followText(),
                            ],
                          ),
                          Row(
                            children: [
                              featured(),
                              Text(
                                text!.dateFromAbb,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: IrisColor.dateFromColor),
                              ),
                            ],
                          ),
                          autoPilotOrderBadge(),
                          nbrAutoPiloted(),
                        ],
                      ),
                    )),
              )),
            if (controller.isAuthUser) editTradeReasonButton(),
            settingsButton(),
          ],
        ));
  }

  BoxDecoration kGradientBoxDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xff57D2FF), Color(0xff9D6CFF)],
        stops: [0.0, .7],
      ),
      color: Colors.black,
      borderRadius: BorderRadius.circular(10),
    );
  }

  Widget main() {
    return Builder(builder: (context) {
      return Container(
        decoration: BoxDecoration(
            color: isStory
                ? const Color(0xFF1A1C1C)
                : context.theme.backgroundColor,
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            content(),
            if ((text?.order?.linkedTradesCount != null &&
                    text?.order?.positionEffect != null &&
                    text?.order?.positionEffect == POSITION_EFFECT.OPEN &&
                    text?.order?.linkedTradesCount == 0) ||
                (text?.order?.portfolioAllocation != null &&
                    text?.order?.portfolioAllocation != 0))
              SizedBox(
                  height: 15,
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 4,
                        ),
                        if (text?.order?.portfolioAllocation != null &&
                            text?.order?.portfolioAllocation != 0)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                UniconsLine.chart_pie_alt,
                                size: 15,
                                color: context.theme.colorScheme.secondary
                                    .withOpacity(.5),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                  '${text?.order?.portfolioAllocation.formatPercentage()}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(fontWeight: FontWeight.w200)),
                              const SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                        if (text?.order?.linkedTradesCount != null &&
                            text?.order?.linkedTradesCount != 0)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                UniconsLine.link,
                                size: 15,
                                color: context.theme.colorScheme.secondary
                                    .withOpacity(.5),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                  '${text?.order?.linkedTradesCount} ${text?.order?.linkedTradesCount == 1 ? 'trade' : 'trades'}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(fontWeight: FontWeight.w200)),
                              const SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                        if (text?.order?.dailyAssetTradeStatistics?.nbrTrades !=
                            null)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                UniconsLine.users_alt,
                                size: 15,
                                color: context.theme.colorScheme.secondary
                                    .withOpacity(.5),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                '${text?.order?.dailyAssetTradeStatistics?.nbrTrades} similar',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(fontWeight: FontWeight.w200),
                              ),
                            ],
                          ),
                      ],
                    ),
                  )),
            if ((text?.order?.linkedTradesCount != null &&
                    text?.order?.positionEffect != null &&
                    text?.order?.positionEffect == POSITION_EFFECT.OPEN &&
                    text?.order?.linkedTradesCount == 0) ||
                (text?.order?.portfolioAllocation != null &&
                    text?.order?.portfolioAllocation != 0))
              Container(
                height: 12,
              )
          ],
        ),
      );
    });
  }

  Widget nbrAutoPiloted() {
    if (text?.order?.nbrAutoPiloted == null ||
        text?.order?.nbrAutoPiloted == 0) {
      return Container();
    }
    int nbr = text!.order!.nbrAutoPiloted!;
    String userWord = 'users';
    if (nbr == 1) {
      userWord = 'user';
    }
    return Container(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            IconPath.autoPilotIcon,
            height: 15,
          ),
          const SizedBox(
            width: 7,
          ),
          Text(
            '${nbr.compactNumber()} $userWord autopiloted this trade',
            style:
                const TextStyle(fontSize: 10, color: IrisColor.dateFromColor),
          ),
        ],
      ),
    );
  }

  Widget optionInfo() {
    final Order order = text!.order!;

    Color? color = isStory ? storyTextColor : null;
    if (!order.isMultiStrike && !order.hasLongOptionName) {
      return Text(
          '\$${text?.order?.strikePrice.formatCompact(nullSign: '-')} ${text?.order?.orderStrategyDisplay.capitalizeFirstApp()}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ));
    } else {
      return Row(
        children: [
          Text(
            text?.order?.orderStrategyDisplay.capitalizeFirstApp() ?? '',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          )
        ],
      );
    }
  }

  Widget orderContent() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 5,
            child: orderSideRow(),
          ),
          profitLossContainer(),
        ],
      ),
      // put increased by 50%
      const Padding(
        padding: EdgeInsets.only(bottom: 15),
      ),
    ]);
  }

  Widget orderReasonBubble() {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      child: Builder(builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          // height: 70,
          width: double.infinity,

          decoration: BoxDecoration(
              color: isStory
                  ? Colors.white12
                  : lightenColor(Theme.of(context).backgroundColor),
              borderRadius: BorderRadius.circular(10)),
          child: Builder(builder: (context) {
            return ExtendedText(
              text!.value!,
              specialTextSpanBuilder: RichTextSpanBuilder(context: context),
              style: isStory ? TextStyle(color: storyTextColor) : null,
            );
          }),
        );
      }),
    );
  }

  Widget orderReason() {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      child: Builder(builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: orderReasonText(),
        );
      }),
    );
  }

  Widget orderReasonText() {
    final TextModel post = controller.text$!.value!;
    const fontSize = 15.0;
    // Uncomment to get a dynamic text size
    // if (post.value == null) {
    //   fontSize = 20;
    // } else {
    //   if (post.value!.length < 50) {
    //     fontSize = 20;
    //   }
    // }
    const bottomMargin = 10.0;
    const topMargin = 0.0;

    return Builder(
      builder: (context) => Container(
        margin: const EdgeInsets.only(
            left: 16, right: 16, bottom: bottomMargin, top: topMargin),
        child: RichTextEditor(
          originalText: post.value,
          text: controller.isShowMore
              ? controller.cutText! + showMoreTag
              : post.value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w300,
            color:
                isStory ? storyTextColor : context.theme.colorScheme.secondary,
          ),
          showMore: showMore,
        ),
      ),
    );
  }

  Widget orderSide() {
    final Order order = text!.order!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Builder(builder: (context) {
          return Text(
            order.orderSideDisplayAction,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: orderSideColor(context),
            ),
          );
        }),
        // SizedBox(
        //   height: 20,
        // )
      ],
    );
  }

  Widget orderSideRow() {
    final Order? order = text?.order;
    final Asset? asset = order?.asset;
    return Row(
      children: [
        // SizedBox()
        if (asset != null)
          AppAssetImage(
            asset: asset,
            symbol: order?.symbol,
            height: 40,
          ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Builder(builder: (context) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!(text?.order?.hasLongOptionName ?? true))
                    Text(order?.orderSideDisplayAction ?? '',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: orderSideColor(context))),
                  Wrap(
                    runAlignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (text?.order?.hasLongOptionName ?? false)
                        Text(order?.orderSideDisplayAction ?? '',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: orderSideColor(context))),
                      Text(order?.symbol ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: isStory ? storyTextColor : null,
                          )),
                      const SizedBox(width: 3),
                      if (order?.positionType == POSITION_TYPE.OPTION)
                        optionInfo()
                      else if (order?.positionType == POSITION_TYPE.EQUITY)
                        equityInfo(),
                    ],
                  ),
                  if (text?.order?.positionType != null &&
                      text!.order!.positionType == POSITION_TYPE.OPTION &&
                      !text!.order!.isMultiExpiration)
                    Text(
                        '${text?.order?.expirationDate.formatMonthDayYear()} Exp.',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontWeight: FontWeight.w200, fontSize: 12)),
                ]);
          }),
        ),
      ],
    );
  }

  Widget profitLossBubble(String display) {
    return Material(
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: profitLossColor.withOpacity(0.3),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 6, bottom: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(display,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: profitLossColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                if (text?.order?.positionOpenTimeDisplay is String)
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
                      Text(text?.order?.positionOpenTimeDisplay ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: profitLossColor,
                            fontSize: 12,
                          )),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profitLossContainer() {
    if (orderProfitLossDisplay != null) {
      return Column(children: [
        profitLossBubble(orderProfitLossDisplay!),
      ]);
    } else {
      return Container();
    }
  }

  Widget settingsButton() {
    if (textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.STORY ||
        textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.CONTENT_ONLY) {
      return Container();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: controller.tapTrailing,
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
