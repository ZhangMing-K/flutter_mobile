import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class ChannelTileController extends GetxController {
  Workers? workers;

  Rx<Workspace?> workspace$ = Rx<Workspace?>(null);

  final WorkspaceService workspaceService = Get.find();

  final Events events = Get.find();

  @override
  onInit() {
    super.onInit();
    workers = Workers([
      ever(events.workspaceBotUpdate, onWorkspaceBotUpdate),
      ever(events.workspacePermissionUpdate, onWorkspacePermissionUpdate),
      ever(events.workspacePortfoliosUpdated, onWorkspacePortfoliosUpdated),
    ]);
  }

  onWorkspaceBotUpdate(WorkspaceBotUpdateEvent? event) {
    if (event!.workspace!.workspaceKey == workspace$.value!.workspaceKey) {
      workspace$.value =
          workspace$.value!.copyWith(botEnabled: event.workspace!.botEnabled);
    }
  }

  onWorkspacePermissionUpdate(WorkspacePermissionUpdateEvent? event) {
    if (event!.workspace!.workspaceKey == workspace$.value!.workspaceKey) {
      workspace$.value = workspace$.value!.copyWith(
          orderPostingPermission: event.workspace!.orderPostingPermission);
    }
  }

  onWorkspacePortfoliosUpdated(WorkspacePortfoliosUpdatedEvent? event) async {
    if (event!.workspaceKey == workspace$.value!.workspaceKey) {
      final List<Portfolio> portfolios = [...event.portfolios!];
      workspace$.value =
          workspace$.value!.copyWith(authUserPortfolios: portfolios);
    }
  }

  setWorkspace(Workspace workspace) {
    workspace$.value = workspace;
  }

  updateWorkspace(
      {bool? botEnabled,
      required int workspaceKey,
      ORDER_POSTING_PERMISSIONS? orderPostingPermission}) async {
    workspace$.value = workspace$.value!.copyWith(botEnabled: botEnabled);
    await workspaceService.updateWorkspace(
        workspaceKey: workspaceKey,
        orderPostingPermission: orderPostingPermission,
        botEnabled: botEnabled);

    events.workspaceBotUpdate(
        WorkspaceBotUpdateEvent(workspace: workspace$.value));
  }
}
