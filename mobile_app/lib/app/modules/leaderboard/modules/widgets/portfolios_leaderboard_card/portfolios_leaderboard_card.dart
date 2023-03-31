import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/widgets/iris_buttons.dart';
import 'package:unicons/unicons.dart';

import '../../../../../../widgets_v2/portfolio_summary_card/widgets/trade_notification_settings/trade_notification_settings.dart';
import '../../../../../../widgets_v2/portfolio_summary_card/widgets/trade_notification_settings/trade_notification_settings_controller.dart';
import 'portfolios_leaderboard_card_controller.dart';

enum PORTFOLIO_IMAGE { USER, BROKER, NONE }

enum PORTFOLIO_TRAILING_BUTTON { NONE, FOLLOW, SETTINGS }

class PortfolioLeaderboardCard extends StatelessWidget {
  final Rx<Portfolio?>? portfolio;

  final Widget? trailing;
  final bool showRankNumber;
  final int? rankNum;
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
  final PortfolioLeaderboardController controller;

  const PortfolioLeaderboardCard(
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
      this.rankNum,
      required this.controller})
      : super(key: key);

  Portfolio? get getPortfolio {
    return portfolio?.value;
  }

  bool get isNotFollowing {
    return hasFollowButton &&
        (getPortfolio?.authUserFollowInfo!.followStatus ==
                FOLLOW_STATUS.NOT_FOLLOWING ||
            getPortfolio?.authUserFollowInfo!.followStatus ==
                FOLLOW_STATUS.PENDING);
  }

  alertsButton() {
    return StatefulBuilder(builder: (_, update) {
      return IrisBounceButton(
          duration: const Duration(milliseconds: 100),
          onPressed: () {
            HapticFeedback.lightImpact();
            // controller.setAlerts(update);
            final notificaitonController = TradeNotificationSettingsController(
                currentSetting: controller.notificationAmount.obs,
                onChangeAlert: (USER_RELATION_NOTIFICATION_AMOUNT alert) {
                  controller.setAlerts(update, alert);
                });
            IrisBottomSheet.show(
                context: _,
                initialHeight: 310,
                maxHeight: 310,
                child: (ScrollController scrollController) {
                  return TradeNotificationSettings(
                      scrollController: scrollController,
                      controller: notificaitonController);
                });
          },
          child: Container(
              padding: const EdgeInsets.all(5),
              child: (controller.isAlertAll)
                  ? SvgPicture.asset(
                      IconPath.bell_solid,
                      color: IrisColor.primaryColor,
                      height: 22,
                    )
                  : controller.isAlertLarge
                      ? const Icon(
                          FeatherIcons.bell,
                          size: 22,
                          color: IrisColor.primaryColor,
                        )
                      : const Icon(
                          FeatherIcons.bell,
                          size: 22,
                        )));
    });
  }

  @override
  build(BuildContext context) {
    if (getPortfolio!.brokerName == null) {
      return Container();
    }

    controller.setPortfolio(getPortfolio);
    return InkWell(
      onTap: controller.routeTo,
      child: Container(
        margin: margin,
        decoration: BoxDecoration(color: context.theme.scaffoldBackgroundColor),
        child: main(context),
      ),
    );
  }

  firstRow() {
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
            if (getPortfolio?.portfolioVisibilitySetting ==
                PORTFOLIO_VISIBILITY_SETTING.EVERYONE)
              const Text('visible to everyone', style: TextStyle(fontSize: 10)),
            if (getPortfolio?.snapshot?.lastUpdatedFrom != null)
              Text('${getPortfolio?.snapshot!.lastUpdatedFrom}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          ],
        ),
        trailing: getTrailing(),
      );
    });
  }

  followForVisibilityStatRow() {
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

  getFollowButton() {
    if (trailing != null) {
      return trailing;
    } else if (hasFollowButton &&
        (getPortfolio?.authUserFollowInfo!.followStatus ==
                FOLLOW_STATUS.NOT_FOLLOWING ||
            getPortfolio?.authUserFollowInfo!.followStatus ==
                FOLLOW_STATUS.PENDING)) {
      return IrisFollowButton(
        user$: getPortfolio!.user!.obs,
      );
    } else if (trailingButton == PORTFOLIO_TRAILING_BUTTON.SETTINGS &&
        getPortfolio?.authUserFollowInfo!.followStatus == FOLLOW_STATUS.ME) {
      return Builder(builder: (context) {
        return InkWell(
          onTap: () async {
            await EditPortfolioView.openPannel(
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
            alignment: Alignment.center,
            child: const Icon(Icons.settings),
          ),
        );
      });
    }
    return null;
  }

  Widget getTrailing() {
    if (getPortfolio?.authUserFollowInfo!.followStatus ==
        FOLLOW_STATUS.APPROVED) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          alertsButton(),
          const SizedBox(
            width: 5,
          ),
        ],
      );
    } else {
      return getFollowButton();
    }
  }

  image() {
    if (portfolioImage == PORTFOLIO_IMAGE.USER) {
      return ProfileImage(
          url: getPortfolio?.user!.profilePictureUrl,
          radius: 25,
          uuid: uuid.v4());
    } else if (portfolioImage == PORTFOLIO_IMAGE.BROKER) {
      return BrokerIcon(
        brokerName: getPortfolio?.brokerName,
        height: 60,
      );
    } else {
      return Container();
    }
  }

  main(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 16, top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rankNum.toString(),
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold)),
                firstRow(),
                statRow(),
                const SizedBox(height: 30),
                const Divider(
                  height: 10,
                  color: IrisColor.dateFromColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  optionsButton(BuildContext context) {
    return InkWell(
      child: Builder(builder: (context) {
        if (controller.hasAlerts) {
          return const Icon(Icons.more_vert);
        }
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
                controller.portfolio.value = controller.portfolio.value
                    ?.copyWith(authUserRelation: authUserRelation));
      },
    );
  }

  pendingSync() {
    return const Text('Pending sync...');
  }

  savedButton() {
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

  bool shouldBlur({HISTORICAL_SPAN? span}) {
    if (span != selectedSpan &&
        hasFollowButton &&
        (getPortfolio?.authUserFollowInfo!.followStatus ==
                FOLLOW_STATUS.NOT_FOLLOWING ||
            getPortfolio?.authUserFollowInfo!.followStatus ==
                FOLLOW_STATUS.PENDING)) {
      return true;
    } else {
      return false;
    }
  }

  stat({
    required HistoricalSpanDisplay spanDisplay,
    double? percentChange,
  }) {
    return Builder(
      builder: (BuildContext context) {
        Color fontColor = Colors.grey.shade500;
        FontWeight fontWeight = FontWeight.w400;
        double fontSize = 12;
        double percentFontSize = 19;
        if (selectedSpan != null) {
          percentFontSize = 17;
        }
        if (spanDisplay.span == selectedSpan && percentChange != null) {
          fontColor = context.theme.colorScheme.secondary;
          fontWeight = FontWeight.w700;
          fontSize = 14;
          percentFontSize = 23;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              spanDisplay.displaySpan,
              style: TextStyle(
                  color: fontColor, fontSize: fontSize, fontWeight: fontWeight),
            ),
            DisplayPercent(
              percent: percentChange,
              fontSize: percentFontSize,
              fontWeight: FontWeight.w600,
              roundedNumber: 0.01,
            ),
          ],
        );
      },
    );
  }

  statRow() {
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
        return tempHidden();
      }
      return pendingSync();
    }
    return statRowWidget(
        dayPercent: getPortfolio?.snapshot!.dayPercent,
        weekPercent: getPortfolio?.snapshot!.weekPercent,
        threeMonthPercent: getPortfolio?.snapshot!.threeMonthPercent,
        yearPercent: getPortfolio?.snapshot!.yearPercent);
  }

  statRowWidget(
      {double? dayPercent,
      double? weekPercent,
      double? threeMonthPercent,
      double? yearPercent}) {
    const verticalIndent = 2.0;
    return Column(
      children: [
        const SizedBox(height: 30),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              statWithDividerRow(
                  percentChange: dayPercent,
                  verticalIndent: verticalIndent,
                  span: HISTORICAL_SPAN.DAY),
              const VerticalDivider(
                endIndent: verticalIndent,
                indent: verticalIndent,
              ),
              statWithDividerRow(
                  percentChange: weekPercent,
                  verticalIndent: verticalIndent,
                  span: HISTORICAL_SPAN.WEEK),
              const VerticalDivider(
                endIndent: verticalIndent,
                indent: verticalIndent,
              ),
              statWithDividerRow(
                  percentChange: threeMonthPercent,
                  verticalIndent: verticalIndent,
                  span: HISTORICAL_SPAN.THREE_MONTH),
              const VerticalDivider(
                endIndent: verticalIndent,
                indent: verticalIndent,
              ),
              statWithDividerRow(
                  percentChange: yearPercent,
                  verticalIndent: verticalIndent,
                  span: HISTORICAL_SPAN.YEAR),
            ],
          ),
        )
      ],
    );
  }

  Widget statWithDividerRow(
      {HISTORICAL_SPAN? span, double? verticalIndent, double? percentChange}) {
    if (shouldBlur(span: span)) {
      return Row(
        children: [
          BlurFilter(
              child: stat(
                  percentChange: percentChange,
                  spanDisplay: HistoricalSpanDisplay(span: span!))),
        ],
      );
    } else {
      return Row(
        children: [
          stat(
              percentChange: percentChange,
              spanDisplay: HistoricalSpanDisplay(span: span!)),
        ],
      );
    }
  }

  tempHidden() {
    return const Text('Only Visible to Owner');
  }
}
