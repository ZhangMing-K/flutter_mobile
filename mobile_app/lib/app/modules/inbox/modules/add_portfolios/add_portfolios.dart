import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import '../../../../../widgets_v2/pannels/portfolio_preview.dart';
import '../../../../../widgets_v2/portfolio_summary_card/portfolio_summary_card_shimmer.dart';
import 'add_portfolios_controller.dart';

//TODO: Move to Bindings
class AddPortfoliosView extends StatelessWidget {
  int? collectionKey;
  int? userKey;
  late AddPortfoliosController controller;

  AddPortfoliosView(
      {Key? key, required this.collectionKey, required this.userKey})
      : super(key: key) {
    controller = Get.put(AddPortfoliosController(collectionKey: collectionKey),
        tag: collectionKey.toString() + userKey.toString());
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> components = [];

    return Obx(() {
      final bool? noPortfolios =
          controller.profileUser$.value?.portfolios?.isEmpty;

      if (noPortfolios == false) {
        components.assignAll([content(context), submit()]);
      } else {
        components.assignAll([empty(context)]);
      }
      return Container(
          padding: const EdgeInsets.only(left: 12, right: 14),
          child: controller.profileUser$.value?.portfolios == null
              ? shimmer()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [...components],
                ));
    });
  }

  Widget content(BuildContext context) {
    return ListView(
      children: [
        instructions(context),
        ...portfolios(),
      ],
      shrinkWrap: true,
    );
  }

  Widget empty(BuildContext context) {
    return ListTile(
        title: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              'No Portfolios attached',
              textAlign: TextAlign.center,
              style: TextStyle(color: context.theme.colorScheme.secondary),
            )),
        subtitle: Image.asset(
          Images.noItemsInFeed,
          height: 180,
        ));
  }

  Widget instructions(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
        width: double.infinity,
        child: Text(
          'Please select the portfolios you would like to add to this chat',
          style: TextStyle(color: context.theme.iconTheme.color),
        ));
  }

  Widget portfolioCard(Portfolio portfolio) {
    return Obx(() {
      final bool isSelected =
          controller.selectedPortfolios$.contains(portfolio.portfolioKey);
      return PortfolioPreview(
        portfolio: portfolio,
        selected: isSelected,
        addFunctionality: true,
        onTap: () => controller.addOrRemovePortfolio(portfolio.portfolioKey),
      );
    });
  }

  List<Widget> portfolios() {
    final List<Widget> portfolios = [];
    controller.profileUser$.value?.portfolios?.forEach((portfolio) {
      portfolios.add(portfolioCard(portfolio));
      portfolios.add(const SizedBox(height: 10));
    });
    return portfolios;
  }

  Widget preview(portfolio) {
    return Row(
      children: [
        BrokerIcon(
          brokerName: portfolio.brokerName,
        ),
        const SizedBox(width: 10),
        Text(
          portfolio.portfolioName ?? '',
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget shimmer() {
    return const PortfolioSummaryCardShimmer();
  }

  Widget submit() {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppButtonV2(
        onPressed: () async {
          await controller.submit();
        },
        child: const Text('Add Your Portfolios'),
        height: 40,
        width: 300,
        buttonType: APP_BUTTON_TYPE.SOLID,
      ),
    );
  }
}
