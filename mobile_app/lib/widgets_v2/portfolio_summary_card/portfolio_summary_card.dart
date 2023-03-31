import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/widgets/iris_buttons.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:unicons/unicons.dart';

import 'portfolio_summary_card_controller.dart';
import 'widgets/horizontal_highlights.dart';

enum PORTFOLIO_IMAGE { USER, BROKER, NONE }

enum PORTFOLIO_TRAILING_BUTTON { NONE, FOLLOW, SETTINGS }

class PortfolioSummaryCard extends StatelessWidget {
  final Rx<Portfolio?>? portfolio;

  final Widget? trailing;
  final bool showRankNumber;
  final bool showNumberOfFollowers;
  final bool showInvestorName;
  final bool showHighlights;
  final bool borderOnAuthUser;
  final bool hasFollowButton;
  final PORTFOLIO_IMAGE portfolioImage;
  final PORTFOLIO_TRAILING_BUTTON trailingButton;
  final Widget? profileIcon;
  final Function? refreshParent;
  final EdgeInsets? margin;
  final Function? onFollow;
  final HISTORICAL_SPAN? selectedSpan;
  final PortfolioSummaryController controller;

  const PortfolioSummaryCard(
      {Key? key,
      required this.portfolio,
      this.trailing,
      this.refreshParent,
      this.onFollow,
      this.showRankNumber = false,
      this.showNumberOfFollowers = false,
      this.profileIcon,
      this.portfolioImage = PORTFOLIO_IMAGE.USER,
      this.borderOnAuthUser = true,
      this.showInvestorName = true,
      this.showHighlights = false,
      this.trailingButton = PORTFOLIO_TRAILING_BUTTON.FOLLOW,
      this.margin,
      this.hasFollowButton = true,
      this.selectedSpan,
      required this.controller})
      : super(key: key);

  Portfolio? get getPortfolio {
    return portfolio?.value;
  }

  @override
  Widget build(BuildContext context) {
    if (getPortfolio?.brokerName == null) {
      return Container();
    }

    controller.setPortfolio(getPortfolio);
    return InkWell(
      onTap: controller.routeTo,
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          // border: (controller.isAuthUser && widget.borderOnAuthUser)
          //     ? Border(
          //         top: BorderSide(color: context.theme.primaryColor, width: 2),
          //         bottom:
          //             BorderSide(color: context.theme.primaryColor, width: 2))
          //     : null,
        ),
        child: main(context),
      ),
    );
  }

  Widget firstRow() {
    return Builder(builder: (BuildContext context) {
      return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        leading: image(),
        title: Text(
          getPortfolio?.portfolioName ?? '',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: context.theme.colorScheme.secondary),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showInvestorName)
              UserName(
                user: getPortfolio?.user,
                fontSize: 13,
              ),
            // if (getPortfolio?.portfolioVisibilitySetting ==
            //     PORTFOLIO_VISIBILITY_SETTING.EVERYONE)
            //   const Text('visible to everyone', style: TextStyle(fontSize: 10)),
            if (getPortfolio?.snapshot?.lastUpdatedFrom != null)
              Text('Synced ${getPortfolio?.snapshot!.lastUpdatedFrom}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          ],
        ),
        trailing: (getTrailing(context) == null) ? null : getTrailing(context),
      );
    });
  }

  Widget followForVisibilityStatRow() {
    return Stack(children: [
      BlurFilter(
        child: statRowWidget(
            dayPercent: 1.2,
            weekPercent: .35,
            threeMonthPercent: -.45,
            yearPercent: .32),
      ),
    ]);
  }

  Widget? getFollowButton() {
    if (trailing != null) {
      return trailing;
    } else if (hasFollowButton &&
        (getPortfolio?.authUserFollowInfo!.followStatus ==
                FOLLOW_STATUS.NOT_FOLLOWING ||
            getPortfolio?.authUserFollowInfo!.followStatus ==
                FOLLOW_STATUS.PENDING)) {
      return IrisFollowButton(
        followingAction: FOLLOWING_ACTION.MESSAGE,
        user$: getPortfolio!.user!.obs,
      );
    } else if (trailingButton == PORTFOLIO_TRAILING_BUTTON.SETTINGS &&
        getPortfolio?.authUserFollowInfo!.followStatus == FOLLOW_STATUS.ME) {
      return Builder(builder: (context) {
        return InkWell(
          onTap: () async {
            final result = await EditPortfolioView.openPannel(
              portfolio: getPortfolio,
            );

            //this is commented out for a reason please contact Brian Schardt before you edit this.
            // ProfilePortfolioController? profilePortfolioController = Get.find();
            // if (profilePortfolioController != null) {
            //   ///if user edited and confirmed
            //   if (result is Portfolio) {
            //     profilePortfolioController.updatePortfolios(
            //         userKey: result.userKey);
            //   } else if (result is bool) {
            //     ///if user deleted portfolio
            //     profilePortfolioController.updatePortfolios(
            //         userKey: widget.portfolio!.value!.userKey);
            //   }
            // }
          },
          child: Container(
            height: 50,
            width: 50,
            alignment: Alignment.centerRight,
            child: const Icon(Icons.settings),
          ),
        );
      });
    }
    return null;
  }

  List<HighlightData> getHighlightData() {
    return [
      if (getPortfolio?.orders != null && getPortfolio!.orders!.isNotEmpty)
        HighlightData(
          title: 'Most Recent Trade',
          titleQualifier: getPortfolio?.orders?.first.fullfilledAt != null
              ? Moment.now().from(getPortfolio!.orders!.first.fullfilledAt!)
              : null,
          orderGroupUUIDS: [getPortfolio?.orders?.first.orderGroupUUID],
          symbol: '${getPortfolio?.orders?.first.symbol}',
          orderSide: getPortfolio?.orders?.first.orderSide,
          asset: getPortfolio?.orders?.first.asset,
          valueLabel: 'Total return',
          value: getPortfolio?.orders?.first.profitLossPercent,
        ),
      if (getPortfolio?.openPositions != null &&
          getPortfolio!.openPositions!.isNotEmpty &&
          getPortfolio?.openPositions?.first.totalAmountOpen != null)
        HighlightData(
          title: 'Largest Holding',
          orderGroupUUIDS: getPortfolio?.openPositions?.first.orderGroupUUIDS,
          symbol: getPortfolio?.openPositions?.first.symbol,
          asset: getPortfolio?.openPositions?.first.asset,
          valueLabel: 'Total return',
          value: getPortfolio?.openPositions?.first.profitLossPercentTotal,
        ),
      if (portfolio != null &&
          getPortfolio?.tradeAnalysis != null &&
          getPortfolio!.tradeAnalysis!.isNotEmpty &&
          getPortfolio?.tradeAnalysis?.first != null &&
          getPortfolio?.tradeAnalysis?.first.profitLossPercentTotal != null)
        HighlightData(
          title: 'Best Trade',
          titleQualifier: '(YTD)',
          orderGroupUUIDS: getPortfolio?.tradeAnalysis?.first.orderGroupUUIDS,
          symbol: getPortfolio?.tradeAnalysis?.first.symbol,
          asset: getPortfolio?.tradeAnalysis?.first.asset,
          valueLabel: 'Total return',
          value: getPortfolio?.tradeAnalysis?.first.profitLossPercentTotal,
        ),
    ];
  }

  Widget? getTrailing(BuildContext context) {
    if (getPortfolio?.authUserFollowInfo!.followStatus ==
        FOLLOW_STATUS.APPROVED) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 5,
          ),
          // savedButton(),
          // SizedBox(
          //   width: 5,
          // ),
          optionsButton(context),
        ],
      );
    } else {
      return getFollowButton();
    }
  }

  Widget image() {
    if (portfolioImage == PORTFOLIO_IMAGE.USER) {
      return ProfileImage(
          url: getPortfolio?.user!.profilePictureUrl,
          radius: 25,
          uuid: uuid.v4());
    } else if (portfolioImage == PORTFOLIO_IMAGE.BROKER) {
      return BrokerIcon(
        brokerName: getPortfolio?.brokerName,
        height: 45,
      );
    } else {
      return Container();
    }
  }

  Widget main(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: Column(
              children: [
                firstRow(),
                statRow(),
                const Divider(
                  height: 10,
                  color: Colors.transparent,
                ),
                Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('See positions',
                            style: TextStyle(
                                color: IrisColor.primaryColor,
                                fontSize: IrisScreenUtil.dFontSize(16),
                                fontWeight: FontWeight.w600))
                      ],
                    )),
              ],
            ),
          ),
          if (showHighlights)
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: HorizontalHighlights(
                backgroundColor: context.theme.cardColor,
                columns: getHighlightData(),
              ),
            )
        ],
      ),
    );
  }

  Widget optionsButton(BuildContext context) {
    return InkWell(
      child: Builder(builder: (context) {
        return const Icon(Icons.more_vert);
      }),
      onTap: () async {
        FollowerView.openPannel(
            portfolioKey: getPortfolio?.portfolioKey,
            userKey: getPortfolio?.user?.userKey,
            context: context,
            pannelActions: controller.panelActions,
            refreshParent: (
                    {FOLLOW_ACTION actionType = FOLLOW_ACTION.REMOVE,
                    UserRelation? authUserRelation,
                    int? portfolioKey,
                    int? userKey}) =>
                controller.portfolio?.value = controller.portfolio?.value
                    ?.copyWith(authUserRelation: authUserRelation));
      },
    );
  }

  Widget savedButton() {
    return StatefulBuilder(builder: (_, update) {
      return IrisBounceButton(
          duration: const Duration(milliseconds: 100),
          onPressed: () {
            HapticFeedback.lightImpact();
            controller.markSaved(update);
            update(() {});
          },
          child: (controller.isSaved)
              ? SvgPicture.asset(
                  IconPath.bookmark_solid,
                  color: IrisColor.primaryColor,
                  height: 24,
                )
              : const Icon(UniconsLine.bookmark, size: 24));
    });
  }

  Widget stat(
      {required HistoricalSpanDisplay spanDisplay, double? percentChange}) {
    return Builder(
      builder: (BuildContext context) {
        Color fontColor = Colors.grey.shade500;
        FontWeight fontWeight = FontWeight.w400;
        double fontSize = 14;
        double percentFontSize = 20;
        if (selectedSpan != null) {
          percentFontSize = 18;
        }
        if (spanDisplay.span == selectedSpan && percentChange != null) {
          fontColor = context.theme.colorScheme.secondary;
          fontWeight = FontWeight.w700;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DisplayPercent(
              percent: percentChange,
              fontSize: IrisScreenUtil.dFontSize(percentFontSize),
              fontWeight: FontWeight.w600,
              roundedNumber: 0.01,
              useArrow: false,
            ),
            Text(
              spanDisplay.displaySpan,
              style: TextStyle(
                  color: fontColor,
                  fontSize: IrisScreenUtil.dFontSize(fontSize),
                  fontWeight: fontWeight),
            )
          ],
        );
      },
    );
  }

  Widget statRow() {
    if (getPortfolio?.snapshot == null) {
      if (getPortfolio?.portfolioVisibilitySetting ==
              PORTFOLIO_VISIBILITY_SETTING.FOLLOWERS &&
          (!getPortfolio!.isAuthUser &&
              getPortfolio!.authUserFollowInfo!.followStatus !=
                  FOLLOW_STATUS.APPROVED)) {
        return followForVisibilityStatRow();
      } else if (getPortfolio?.portfolioVisibilitySetting ==
              PORTFOLIO_VISIBILITY_SETTING.ONLY_ME &&
          !getPortfolio!.isAuthUser) {
        return const Text('Only Visible to Owner');
      }
      return const Text('Pending sync...');
    } else if (getPortfolio?.connectionStatus != CONNECTION_STATUS.CONNECTED) {
      return Column(children: [
        const Text('Disconnected'),
        const SizedBox(
          height: 15,
        ),
        if (controller.isAuthUser) reconnectButton(),
      ]);
    }
    return statRowWidget(
        dayPercent: getPortfolio?.snapshot!.dayPercent,
        weekPercent: getPortfolio?.snapshot!.weekPercent,
        threeMonthPercent: getPortfolio?.snapshot!.threeMonthPercent,
        yearPercent: getPortfolio?.snapshot!.yearPercent);
  }

  Widget reconnectButton() {
    return Builder(builder: (context) {
      return SizedBox(
          height: 44 * context.textScaleFactor,
          width: double.infinity,
          child: OutlinedButton(
            onPressed: controller.reconnect,
            style: ButtonStyle(
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              enableFeedback: true,
            ),
            child: Text(
              'Reconnect portfolio',
              style: TextStyle(
                  fontSize: IrisScreenUtil.dFontSize(14),
                  color: context.theme.colorScheme.secondary),
            ),
          ));
    });
  }

  Widget statRowWidget(
      {double? dayPercent,
      double? weekPercent,
      double? threeMonthPercent,
      double? yearPercent}) {
    const verticalIndent = 2.5;
    return Column(
      children: [
        const Divider(
          height: 20,
          color: Colors.transparent,
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              stat(
                  percentChange: dayPercent,
                  spanDisplay:
                      HistoricalSpanDisplay(span: HISTORICAL_SPAN.DAY)),
              const VerticalDivider(
                endIndent: verticalIndent,
                indent: verticalIndent,
              ),
              stat(
                  percentChange: weekPercent,
                  spanDisplay:
                      HistoricalSpanDisplay(span: HISTORICAL_SPAN.WEEK)),
              const VerticalDivider(
                endIndent: verticalIndent,
                indent: verticalIndent,
              ),
              stat(
                  percentChange: threeMonthPercent,
                  spanDisplay:
                      HistoricalSpanDisplay(span: HISTORICAL_SPAN.THREE_MONTH)),
              const VerticalDivider(
                endIndent: verticalIndent,
                indent: verticalIndent,
              ),
              stat(
                  percentChange: yearPercent,
                  spanDisplay:
                      HistoricalSpanDisplay(span: HISTORICAL_SPAN.YEAR)),
            ],
          ),
        )
      ],
    );
  }
}
