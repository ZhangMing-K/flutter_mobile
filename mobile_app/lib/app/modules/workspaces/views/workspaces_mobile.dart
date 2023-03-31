import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/workspaces_controller.dart';
import '../modules/category_tile/views/category_tile.dart';
import '../modules/channel_tile/views/channel_tile.dart';
import '../shared/workspaces_utils.dart';
import 'disabled_workspace.dart';
import 'parent_workspaces_scroll.dart';
import 'workspace_integration.dart';
import 'workspaces_empty.dart';

class WorkspacesMobile extends GetView<WorkspacesController> {
  @override
  final String tag =
      '${WorkspacesUtils.getCurrentWorkspaceSource} ${WorkspacesUtils.getCurrentProfileKey}';

  WorkspacesMobile({Key? key}) : super(key: key);

  addBotTile(BuildContext context) {
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        title: DefaultTextTitle(
            textTitle: 'Add Iris Bot to server',
            fontSize: TextUnit.small,
            fontWeight: FontWeight.w500,
            align: TextAlign.left,
            color: context.theme.hintColor),
        onTap: () async => await controller.workspaceAuth(bot: true),
        trailing: Icon(
          Icons.add_circle_outline,
          color: context.theme.hintColor,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        title: 'Discord',
      ),
      body: main(context),
    );
  }

  channelHeader(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
        child: Row(children: [
          Text('Categories / Channels',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: context.theme.colorScheme.secondary)),
          Container(
              padding: const EdgeInsets.only(left: 6),
              child: GestureDetector(
                  onTap: () async => controller.workspaceAuth(bot: false),
                  child: Icon(
                    Icons.sync,
                    size: 20,
                    color: context.theme.hintColor,
                  )))
        ]));
  }

  channelsContent(BuildContext context) {
    return Obx(() {
      final int channelsCount = controller.workspaceChildren$.length;
      return Container(
          alignment: Alignment.topLeft,
          height: MediaQuery.of(context).size.height * 0.79,
          child: IrisListView(
            header: header(context),
            shrinkWrap: true,
            emptyWidget: Container(
                padding: const EdgeInsets.only(top: 12),
                child: WorkspacesEmpty(
                  imageSize: 100,
                  enableResync: true,
                  emptyText:
                      'Looks like there are no channels enabled in this workspace :(',
                )),
            onRefresh: () async => debugPrint('need to implement'),
            itemCount: controller.selectedWorkspace$.value!.botEnabled == true
                ? channelsCount
                : 1,
            loadMore: controller.loadMoreChildren,
            builder: (BuildContext context, int index) {
              if (controller.selectedWorkspace$.value!.botEnabled != true) {
                return DisabledWorkspaceView();
              }

              final Workspace workspace = controller.workspaceChildren$[index];
              final double leftPadding;

              if (workspace.workspaceType == WORKSPACE_TYPE.TEXT) {
                leftPadding = 12;
              } else {
                leftPadding = 0;
              }

              return Container(
                padding:
                    EdgeInsets.only(top: 24, bottom: 24, left: leftPadding),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: (workspace.workspaceType == WORKSPACE_TYPE.TEXT)
                    ? ChannelTile(
                        workspace: workspace,
                        key: Key('${workspace.workspaceKey}'),
                      )
                    : CategoryTile(
                        workspace: workspace,
                        showContent: index == 0,
                        key: Key('${workspace.workspaceKey}')),
                decoration: index != channelsCount - 1
                    ? const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: IrisColor.subTitle)))
                    : null,
              );
            },
          ));
    });
  }

  Icon getIcon(PERMISSION_LEVEL? permissionLevel) {
    switch (permissionLevel) {
      case PERMISSION_LEVEL.ADMIN:
        return const Icon(Icons.shield);
      default:
        return const Icon(Icons.shield);
    }
  }

  header(BuildContext context) {
    return Column(
      children: [
        ParentWorkspacesScrollView(),
        if (controller.selectedWorkspace$.value!.botEnabled == true)
          channelHeader(context)
      ],
    );
  }

  iconWithText(Icon icon, String text, BuildContext context) {
    return Row(children: [
      DefaultTextTitle(
          textTitle: text,
          fontSize: TextUnit.small,
          fontWeight: FontWeight.w500,
          align: TextAlign.left,
          color: context.theme.colorScheme.secondary),
      icon
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
              textTitle: 'Grabbing your workspaces :)',
              fontSize: TextUnit.medium,
              fontWeight: FontWeight.w400,
              color: context.theme.hintColor,
            )
          ],
        ));
  }

  main(BuildContext context) {
    return Obx(() {
      final bool needsIntegration = controller.integration$.value == null;

      if (controller.apiStatus$.value == API_STATUS.PENDING) {
        return loading(context);
      }

      if (controller.setPermissionsView$.value == true) {
        return setPermissionsView(context);
      }

      if (needsIntegration) {
        return WorkspaceIntegrationView();
      } else {
        return workspacesView(context);
      }
    });
  }

  permissionForm(BuildContext context) {
    return Column(
      children: [
        permissionsPill(
            ORDER_POSTING_PERMISSIONS.EVERYONE, 'All members', context),
        DefaultTextTitle(
          textTitle: 'or',
          bottom: SpaceUnit.small,
          top: SpaceUnit.small,
          fontSize: TextUnit.small,
          fontWeight: FontWeight.w500,
          align: TextAlign.center,
          color: context.theme.hintColor,
        ),
        permissionsPill(ORDER_POSTING_PERMISSIONS.ADMIN_ONLY,
            'Admins / Owners only', context)
      ],
    );
  }

  permissionsPill(
      ORDER_POSTING_PERMISSIONS value, String text, BuildContext context) {
    return Obx(() {
      final bool selected = controller.orderPostingPermission$.value == value;

      return GestureDetector(
          onTap: () => {
                HapticFeedback.lightImpact(),
                controller.orderPostingPermission$.value = value
              },
          child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                  border: selected
                      ? Border.all(color: IrisColor.primaryColor, width: 3)
                      : null),
              child: DefaultTextTitle(
                textTitle: text,
                fontSize: TextUnit.large,
                fontWeight: FontWeight.w500,
                align: TextAlign.center,
                color: context.theme.colorScheme.secondary,
              )));
    });
  }

  portfoliosRow({required List<Portfolio> portfolios}) {
    final List<Widget> images = [];
    for (var portfolio in portfolios) {
      images.add(BrokerIcon(height: 20, brokerName: portfolio.brokerName));
      images.add(const SizedBox(width: 6));
    }
    return Row(
      children: [...images],
    );
  }

  resync(BuildContext context) {
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        title: DefaultTextTitle(
            textTitle: 'Something wrong? Try resyncing your workspaces',
            fontSize: TextUnit.small,
            fontWeight: FontWeight.w500,
            align: TextAlign.left,
            color: context.theme.hintColor),
        onTap: () async => await controller.resyncWorkspaces(),
        trailing: Icon(
          Icons.sync,
          color: context.theme.hintColor,
        ));
  }

  setPermissionsView(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultTextTitle(
            // bottom: SpaceUnit.small,
            top: SpaceUnit.extraLarge,
            textTitle: 'Who should be allowed to use the bot you just added?',
            fontSize: TextUnit.large,
            fontWeight: FontWeight.w500,
            align: TextAlign.center,
            color: context.theme.colorScheme.secondary,
          ),
          permissionForm(context),
          SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () async {
                  await controller.setWorkspacePermissions();
                },
                child: Text(
                  'Next',
                  style: TextStyle(
                      color: context.theme.colorScheme.secondary, fontSize: 16),
                ),
              ))
        ],
      ),
    );
  }

  statusHeader(
      BuildContext context, PERMISSION_LEVEL? permissionLevel, Icon icon) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultTextTitle(
              textTitle: controller.selectedWorkspace$.value!.name,
              fontSize: TextUnit.small,
              fontWeight: FontWeight.w500,
              align: TextAlign.left,
              color: context.theme.colorScheme.secondary),
          if (permissionLevel == PERMISSION_LEVEL.ADMIN ||
              permissionLevel == PERMISSION_LEVEL.OWNER)
            iconWithText(icon, getPermissionLevel(permissionLevel), context)
        ],
      ),
    );
  }

  workspaceHeader(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 12),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DefaultTextTitle(
                textTitle: 'Connect your Portfolios',
                fontSize: TextUnit.large,
                fontWeight: FontWeight.w500,
                align: TextAlign.center,
                color: context.theme.colorScheme.secondary),
          ],
        ));
  }

  workspaces(BuildContext context) {
    return Obx(() {
      final List<Workspace>? workspaces =
          controller.profileUser$.value?.workspaces;
      if (workspaces!.isEmpty) {
        return WorkspacesEmpty(
          emptyText:
              "Sorry! It looks like you aren't apart of any Discord servers.  Would you like to resync?",
          enableAddBot: true,
          enableResync: true,
        );
      }
      return SingleChildScrollView(child: channelsContent(context));
    });
  }

  workspacesView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Container(child: workspaces(context))),
      ],
    );
  }
}
