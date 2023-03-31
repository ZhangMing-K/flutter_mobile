import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:unicons/unicons.dart';

import 'workspace_pannel_controller.dart';

//TODO: move to bindings
class WorkspacePannel extends StatelessWidget {
  Workspace? workspace;
  IAuthUserService authUserStore = Get.find();
  late WorkspacePannelController controller;
  WorkspacePannel({this.workspace}) {
    controller = Get.put(WorkspacePannelController(workspace: workspace),
        tag:
            '${workspace!.workspaceKey.toString()}-${workspace!.authUserPermissionLevel}',
        permanent: false);
  }

  addPortfolio(BuildContext context) {
    const String title = 'Add a portfolio';

    return PannelTile(
      text: title,
      color: context.theme.colorScheme.secondary,
      leading: const Icon(UniconsLine.fire),
      trailing: const Icon(UniconsLine.plus_circle),
      textAlignment: Alignment.centerLeft,
      onTap: () {
        controller.adminView$.value = false;
      },
    );
  }

  authUserPortfolios(BuildContext context) {
    return IrisAccordion(
        margin: EdgeInsets.zero,
        showAccordion: true,
        titleChild: Container(
            padding: const EdgeInsets.only(
              left: 15,
            ),
            child: const Text(
              'Yours',
              style: TextStyle(fontSize: 18),
            )),
        titlePadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.only(top: 10),
        collapsedIcon: Container(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(Icons.chevron_right,
                color: context.theme.colorScheme.secondary)),
        expandedIcon: Container(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(Icons.keyboard_arrow_down,
                color: context.theme.colorScheme.secondary)),
        collapsedTitleBackgroundColor: context.theme.backgroundColor,
        expandedTitleBackgroundColor: context.theme.backgroundColor,
        contentBackgroundColor: context.theme.backgroundColor,
        contentChild: Container(
            padding: const EdgeInsets.only(top: 12),
            child: authUserPortfoliosListView(context)));
  }

  authUserPortfoliosListView(BuildContext context) {
    return ListView.separated(
      itemCount: controller.profileUser$.value!.portfolios!.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        final Portfolio portfolio =
            controller.profileUser$.value!.portfolios![index];
        final Color bottomColor =
            index != controller.profileUser$.value!.portfolios!.length - 1
                ? context.theme.backgroundColor
                : IrisColor.subTitle;
        final Color topColor = index != 0 || controller.adminView$.value == true
            ? context.theme.backgroundColor
            : IrisColor.subTitle;

        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1, color: topColor),
                    bottom: BorderSide(width: 1, color: bottomColor))),
            child: portfolioTile(context, portfolio));
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1, color: IrisColor.subTitle))),
        );
      },
    );
  }

  backButton(double width) {
    return Obx(() => controller.adminView$.value == false &&
            controller.workspace$.value!.authUserHasUpdatePermissions == true
        ? Container(
            alignment: Alignment.topCenter,
            width: width,
            child: GestureDetector(
                child: const Icon(Icons.chevron_left),
                onTap: () => {controller.adminView$.value = true}))
        : SizedBox(
            width: width,
          ));
  }

  body(BuildContext context) {
    return Column(
      children: [postingSettings(context), connectedPortfolios(context)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.workspace$.value == null) return loading(context);
      return main(context);
    });
  }

  connectedHeader(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 15, bottom: 20, top: 20),
      child: const Text('Connected Portfolios',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
    );
  }

  connectedPortfolios(BuildContext context) {
    return Obx(() => Column(
          children: [
            connectedHeader(context),
            if (controller.profileUser$.value != null)
              authUserPortfolios(context)
          ],
        ));
  }

  enableBot(BuildContext context) {
    return Obx(() {
      return ListTile(
        title: Text(
          'Enable bot in this channel',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: context.theme.colorScheme.secondary),
        ),
        trailing: Switch(
          value: controller.enableBot$.value,
          onChanged: (value) async {
            await controller.updateWorkspace(botEnabled: value);
          },
          inactiveTrackColor: IrisColor.inactive,
          activeTrackColor: IrisColor.primaryColor,
          inactiveThumbColor: IrisColor.accentColorDark,
          activeColor: IrisColor.accentColorDark,
        ),
      );
    });
  }

  header(BuildContext context) {
    const double leadingWidth = 25;
    const String subHeaderText =
        'Choose which portfolios will send real-time trades to this channel.';
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        backButton(leadingWidth),
        Text(
          controller.workspace$.value!.channelName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: leadingWidth),
      ]),
      if (controller.adminView$.value == false)
        subtitile(context, subHeaderText)
    ]);
  }

  loading(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(context.theme.primaryColor),
            ),
            const SizedBox(height: 14),
            DefaultTextTitle(
              textTitle: 'Grabbing your workspace :)',
              fontSize: TextUnit.medium,
              fontWeight: FontWeight.w400,
              color: context.theme.hintColor,
            )
          ],
        ));
  }

  main(BuildContext context) {
    return Obx(() {
      var components = [];
      if (controller.adminView$.value == true) {
        components = [
          enableBot(context),
          Container(
              child: controller.enableBot$.value == true
                  ? body(context)
                  : Container())
        ];
      } else {
        components = [nonAdminView(context)];
      }
      return Column(
        children: [header(context), ...components],
      );
    });
  }

  nonAdminView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [authUserPortfoliosListView(context)],
      ),
    );
  }

  permissionTile(
      {String? text,
      ORDER_POSTING_PERMISSIONS? postingPermission,
      BuildContext? context}) {
    final bool selected =
        controller.orderPostingPermission$.value == postingPermission;

    return ListTile(
      title: Text(
        text!,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: selected
                ? context!.theme.primaryColor
                : context!.theme.colorScheme.secondary),
      ),
      onTap: () async {
        await controller.updateWorkspace(
            orderPostingPermission: postingPermission);
      },
      trailing: Icon(selected ? Icons.check_box : Icons.check_box_outline_blank,
          color: IrisColor.primaryColor),
    );
  }

  portfolioContent(BuildContext context, Portfolio portfolio) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 12),
          child: BrokerIcon(height: 30, brokerName: portfolio.brokerName),
        ),
        Text(
          portfolio.portfolioName!,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: context.theme.colorScheme.secondary),
        ),
      ],
    );
  }

  portfolioTile(BuildContext context, Portfolio portfolio) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            portfolioContent(context, portfolio),
            Switch(
              value: controller.connectedPortfolios$
                  .contains(portfolio.portfolioKey),
              onChanged: (value) async {
                await controller.updatePortfolio(
                    portfolioKey: portfolio.portfolioKey!, connect: value);
              },
              inactiveTrackColor: IrisColor.inactive,
              activeTrackColor: IrisColor.primaryColor,
              inactiveThumbColor: IrisColor.accentColorDark,
              activeColor: IrisColor.accentColorDark,
            ),
          ],
        ),
      );
    });
  }

  postingSettings(BuildContext context) {
    return Column(
      children: [
        settingsHeader(context),
        permissionTile(
            text: 'Admins / Owners',
            context: context,
            postingPermission: ORDER_POSTING_PERMISSIONS.ADMIN_ONLY),
        permissionTile(
            text: 'All members',
            context: context,
            postingPermission: ORDER_POSTING_PERMISSIONS.EVERYONE)
      ],
    );
  }

  settingsHeader(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 15, bottom: 20, top: 20),
      child: const Text('Who can connect their portfolios?',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
    );
  }

  subtitile(BuildContext context, String text) {
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
        child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: context.theme.colorScheme.secondary, fontSize: 15)));
  }

  static openPannel({Workspace? workspace}) {
    final double maxHeight =
        workspace!.authUserHasUpdatePermissions == true ? 0.9 : 0.5;
    Get.bottomSheet(
        CustomBottomSheet(
          maxHeight: maxHeight,
          child: WorkspacePannel(
            workspace: workspace,
          ),
        ),
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: true);
  }
}
