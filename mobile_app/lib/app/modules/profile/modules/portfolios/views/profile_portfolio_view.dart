import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../widgets_v2/portfolio_summary_card/portfolio_summary_card.dart';
import '../../../../../../widgets_v2/portfolio_summary_card/portfolio_summary_card_controller.dart';
import '../../../../../routes/pages.dart';
import '../../../../institution/classes/connect_institution_arts.dart';
import '../../summary/notifiers/portfolios_notifier.dart';

class ProfilePortfoliosView extends StatelessWidget {
  final Function? onConnect;
  final bool isAuthUser;
  final PortfoliosNotifier controller;

  const ProfilePortfoliosView({
    Key? key,
    this.isAuthUser = false,
    this.onConnect,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        return Column(
          children: [
            const SizedBox(height: 0),
            // Obx(
            //   () => controller.showDiscordButton.value
            //       ? IrisProgressButton(
            //           color: IrisColor.discordColor,
            //           title: 'Add real-time trades to your channels!',
            //           leading: Image.asset(
            //             Images.discordLogo,
            //             width: 40,
            //             height: 40,
            //           ),
            //           countDown: controller.discordCountdown.value,
            //           onCancel: controller.discordCancelPressed,
            //           onTap: controller.discordButtonPressed,
            //         )
            //       : Container(),
            // ),
            Expanded(
              child: IrisListView(
                onRefresh: controller.pullRefresh,
                itemCount: state!.length,
                widgetLoader: const IrisLoading(),
                emptyWidget: noPortfolios(),
                builder: (BuildContext context, int index) {
                  if (index < state.length) {
                    return Column(
                      children: [
                        PortfolioSummaryCard(
                          showNumberOfFollowers: false,
                          portfolio: Rx(state[index]),
                          portfolioImage: PORTFOLIO_IMAGE.BROKER,
                          borderOnAuthUser: false,
                          showInvestorName: false,
                          showHighlights: false,
                          trailingButton: PORTFOLIO_TRAILING_BUTTON.SETTINGS,
                          hasFollowButton: false,
                          onFollow: () {
                            controller.fetchPortfolio();
                          },
                          controller: PortfolioSummaryController(
                              portfolio: state[index].obs),
                        ),
                        if (index == state.length - 1)
                          connectButton()
                        else
                          Divider(
                            color: context.theme.backgroundColor,
                            height: 1,
                            thickness: 1,
                          ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget connectButton() {
    if (isAuthUser) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Builder(builder: (context) {
          return SizedBox(
            width: context.width * 0.75,
            height: 45,
            child: ElevatedButton(
              onPressed: selectBroker,
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
    return Container();
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

  selectBroker() async {
    var args = ConnectInstitutionArgs(from: INSTITUTION_CONNECTED_FROM.PROFILE);
    await Get.toNamed(Paths.InstitutionConnectLanding, arguments: args);
    onConnect!();
  }
}
