import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class WorkspacePannelController extends BaseController {
  final UserService userService = Get.find();
  Rx<Workspace?> workspace$ = Rx<Workspace?>(null);
  final WorkspaceService workspaceService = Get.find();
  RxBool adminView$ = RxBool(false);
  RxBool addPortfoliosView$ = RxBool(false);
  final List<Portfolio> userPortfolios = [];
  RxList<int?> connectedPortfolios$ = RxList([]);
  List<int?> currentPortfolioKeys = RxList([]);
  RxBool enableBot$ = RxBool(false);
  Rx<User?> profileUser$ = Rx<User?>(null);
  Rx<ORDER_POSTING_PERMISSIONS> orderPostingPermission$ =
      Rx(ORDER_POSTING_PERMISSIONS.ADMIN_ONLY);
  final Events events = Get.find();
  Workers? workers;
  WorkspacePannelController({Workspace? workspace}) {
    workspace$.value = workspace;
    adminView$.value = workspace!.authUserHasUpdatePermissions;
    enableBot$.value = workspace.botEnabled!;
    orderPostingPermission$.value = workspace.orderPostingPermission!;
    connectedPortfolios$.value =
        workspace.authUserPortfolios!.map((e) => e.portfolioKey).toList();
  }

  getUser() async {
    final authUserKey = authUserStore.loggedUser?.userKey;
    profileUser$.value = await userService.getUserByKey(
        userKey: authUserKey, requestedFields: userRequestedFields());

    userPortfolios.assignAll(profileUser$.value!.portfolios!);
  }

  @override
  onInit() {
    super.onInit();
    workers = Workers([
      ever(events.workspaceBotUpdate, onWorkspaceBotUpdate),
    ]);
  }

  @override
  onReady() async {
    await getUser();
    super.onReady();
  }

  onWorkspaceBotUpdate(WorkspaceBotUpdateEvent? event) {
    if (event!.workspace!.workspaceKey == workspace$.value!.workspaceKey) {
      workspace$.value =
          workspace$.value!.copyWith(botEnabled: event.workspace!.botEnabled);
      enableBot$.value = workspace$.value!.botEnabled!;
    }
  }

  updatePortfolio(
      {required int portfolioKey, bool? connect, bool? mute}) async {
    PortfolioArg? arg;

    if ((!connectedPortfolios$.contains(portfolioKey) && connect == true) ||
        (connect == false && connectedPortfolios$.contains(portfolioKey))) {
      arg = PortfolioArg(connect: connect, portfolioKey: portfolioKey);
    }

    if (connect == true) {
      connectedPortfolios$.add(portfolioKey);
    } else if (connect == false) {
      connectedPortfolios$.removeWhere((key) => key == portfolioKey);
    }

    if (arg != null) {
      await workspaceService.upsertPortfoliosInWorkspace(
          portfolioArgs: [arg], workspaceKey: workspace$.value!.workspaceKey);

      final List<Portfolio> updatedConnectedPortfolios = userPortfolios
          .where(
              (element) => connectedPortfolios$.contains(element.portfolioKey))
          .toList();
      events.workspacePortfoliosUpdated(WorkspacePortfoliosUpdatedEvent(
          portfolios: updatedConnectedPortfolios,
          workspaceKey: workspace$.value!.workspaceKey));
    }
  }

  updateWorkspace(
      {bool? botEnabled,
      ORDER_POSTING_PERMISSIONS? orderPostingPermission}) async {
    if (botEnabled != null) enableBot$.value = botEnabled;
    if (orderPostingPermission != null) {
      orderPostingPermission$.value = orderPostingPermission;
    }

    final Workspace? workspace = await workspaceService.updateWorkspace(
        workspaceKey: workspace$.value!.workspaceKey,
        orderPostingPermission: orderPostingPermission,
        botEnabled: enableBot$.value);
    workspace$.value = workspace;

    if (botEnabled != null) {
      events.workspaceBotUpdate(
          WorkspaceBotUpdateEvent(workspace: workspace$.value));
    }

    if (orderPostingPermission != null) {
      events.workspacePermissionUpdate(
          WorkspacePermissionUpdateEvent(workspace: workspace$.value));
    }
  }

  userRequestedFields() {
    return '''
      userKey
      portfolios{
        brokerName
        portfolioKey
        accountId
        connectionStatus
        followStats{
          numberOfFollowers
        }
        authUserFollowInfo{
          followStatus
          watching
        }
        portfolioName
      }
    ''';
  }

  workspaceFields() {
    return '''
        workspaceKey
        name
        remoteId
        pictureUrl
        orderPostingPermission
        botEnabled
        authUserPermissionLevel
        authUserPortfolios {
          brokerName
          portfolioKey
          accountId
          connectionStatus
          portfolioName
        }
    ''';
  }
}
