import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../portfolio_summary_card/portfolio_summary_card_shimmer.dart';
import '../portfolio_preview.dart';
import 'add_portfolio_to_workspace_controller.dart';

//TODO: move to bindings
class AddPortfoliosToWorkspaceView extends StatelessWidget {
  Workspace? workspace;

  int? authUserKey;
  late AddPortfolioToWorkspaceController controller;
  AddPortfoliosToWorkspaceView({this.workspace, this.authUserKey}) {
    controller = Get.put(
        AddPortfolioToWorkspaceController(workspace: workspace!),
        tag: '${workspace!.workspaceKey.toString()}-${authUserKey.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List<Widget> components = [];
      final bool? noPortfolios =
          controller.profileUser$.value?.portfolios?.isEmpty;

      if (noPortfolios == false) {
        components.assignAll([content(context), submit(context)]);
      } else {
        components.assignAll([empty(context)]);
      }

      return Container(
          padding: const EdgeInsets.only(left: 12, right: 14),
          child: controller.profileUser$.value?.portfolios == null ||
                  controller.workspace$.value == null
              ? const PortfolioSummaryCardShimmer()
              : Column(
                  mainAxisAlignment: noPortfolios!
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.spaceBetween,
                  children: [...components],
                ));
    });
  }

  Widget content(BuildContext context) {
    return SizedBox(
        height: 160,
        child: ListView.separated(
          itemCount: controller.profileUser$.value!.portfolios!.length,
          itemBuilder: (BuildContext context, int index) {
            final Portfolio portfolio =
                controller.profileUser$.value!.portfolios![index];

            return portfolioCard(portfolio, context);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 12,
            );
          },
        ));
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

  Widget portfolioCard(Portfolio portfolio, BuildContext context) {
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

  Widget submit(BuildContext context) {
    final Workspace? workspace = controller.workspace$.value;

    final String? warningText = workspace?.authUserMayAddPortfolio != true &&
            workspace?.authUserHasUpdatePermissions == true
        ? 'Must Enable the Iris bot before adding your portfolio'
        : workspace?.orderPostingPermission ==
                    ORDER_POSTING_PERMISSIONS.ADMIN_ONLY &&
                workspace?.authUserHasUpdatePermissions != true
            ? 'This workspace is currently enabled for Admins or Owners only'
            : workspace?.authUserHasUpdatePermissions != true &&
                    workspace?.botEnabled != true
                ? 'The Iris Bot has been disabled for this workspace'
                : null;
    return Obx(() {
      return Container(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(children: [
          if (warningText != null) warning(context, warningText),
          Container(
              padding: const EdgeInsets.only(top: 12),
              child: AppButtonV2(
                onPressed: () async {
                  await controller.submit();
                },
                child: const Text('Add Your Portfolios'),
                height: 40,
                width: 300,
                disabled:
                    controller.workspace$.value!.authUserMayAddPortfolio !=
                        true,
                buttonType: APP_BUTTON_TYPE.SOLID,
              ))
        ]),
      );
    });
  }

  DefaultTextTitle warning(BuildContext context, String text) {
    return DefaultTextTitle(
      textTitle: text,
      fontSize: TextUnit.extraSmall,
      fontWeight: FontWeight.w500,
      align: TextAlign.center,
      color: context.theme.hintColor,
    );
  }
}
