import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../widgets_v2/portfolio_summary_card/portfolio_summary_card.dart';
import '../../../../../widgets_v2/portfolio_summary_card/portfolio_summary_card_controller.dart';
import '../../../../../widgets_v2/portfolio_summary_card/portfolio_summary_card_shimmer.dart';
import '../../../../routes/pages.dart';
import '../../../institution/classes/connect_institution_arts.dart';

class PortfoliosSummary extends StatelessWidget {
  final List<Portfolio> portfolios;
  final Function? onConnect;
  final bool isAuthUser;
  const PortfoliosSummary(
      {Key? key,
      required this.portfolios,
      this.isAuthUser = false,
      this.onConnect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (portfolios.isNotEmpty) ...portfolioCards(context),
        if (portfolios.isEmpty) noPortfolios(context),
        const SizedBox(
          height: 70,
        ),
      ],
    );
  }

  Widget connectButton() {
    if (isAuthUser) {
      return Builder(builder: (context) {
        return AppButtonV2(
          onPressed: selectBroker,
          child: const Text(
            'Connect Portfolio',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          height: 50,
          width: context.width * 0.75,
          buttonType: APP_BUTTON_TYPE.SOLID,
        );
      });
    }
    return Container();
  }

  Widget noPortfolios(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          color: context.theme.backgroundColor,
          height: 180,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height: 10),
              Image.asset(
                Images.suitcase,
                height: 34,
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

  List<Widget> portfolioCards(BuildContext context) {
    final List<Widget> portfolioCards = [];
    for (var element in portfolios) {
      portfolioCards.add(PortfolioSummaryCard(
        showNumberOfFollowers: true,
        portfolio: Rx(element),
        portfolioImage: PORTFOLIO_IMAGE.BROKER,
        borderOnAuthUser: false,
        showInvestorName: false,
        showHighlights: true,
        trailingButton: PORTFOLIO_TRAILING_BUTTON.SETTINGS,
        margin: const EdgeInsets.only(top: 10),
        controller: PortfolioSummaryController(portfolio: element.obs),
      ));
    }
    portfolioCards.add(const SizedBox(height: 10));
    portfolioCards.add(connectButton());
    return portfolioCards;
  }

  selectBroker() async {
    var args = ConnectInstitutionArgs(from: INSTITUTION_CONNECTED_FROM.PROFILE);
    await Get.toNamed(Paths.InstitutionConnectLanding, arguments: args);
    onConnect!();
  }

  shimmer() {
    return const PortfolioSummaryCardShimmer();
  }
}
