import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../views/private_channels_warning_dialog.dart';

class WorkspacesController extends GetxController
    with StateMixin<List<Workspace>> {
  int? authUserKey;
  int workspacesOffset = 0;
  int childrenOffset = 0;
  WORKSPACE_SOURCE? workspaceSource;
  Rx<Integration?> integration$ = Rx<Integration?>(null);
  List<Workspace> workspaces = [];
  Rx<ORDER_POSTING_PERMISSIONS> orderPostingPermission$ =
      Rx(ORDER_POSTING_PERMISSIONS.EVERYONE);
  Rx<User?> profileUser$ = Rx<User?>(null);
  Rx<API_STATUS> apiStatus$ = Rx(API_STATUS.NOT_STARTED);
  Rx<API_STATUS> childLoadApiStatus$ = Rx(API_STATUS.NOT_STARTED);
  final UserService userService = Get.find();
  final WorkspaceService workspaceService = Get.find();
  RxBool setPermissionsView$ = RxBool(false);
  Rx<Workspace?> selectedWorkspace$ = Rx<Workspace?>(null);
  String? workspaceToEnableRemoteId;
  RxList<Workspace> workspaceChildren$ = <Workspace>[].obs;
  Workers? workers;
  final scrollController = ScrollController();
  final Events events = Get.find();
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  WorkspacesController(
      {this.authUserKey, this.workspaceSource, Integration? integration}) {
    integration$.value = integration;
  }

  Future<List<Workspace>> getChildren() async {
    final bool getAllWorkspaces =
        selectedWorkspace$.value!.authUserHasUpdatePermissions;
    final User? userWithChildWorkspaces = await userService.getUserByKey(
        userKey: authUserKey,
        requestedFields:
            workspaceReqFields(getAllWorkspaces: getAllWorkspaces));
    if (userWithChildWorkspaces == null) return <Workspace>[];

    final children = userWithChildWorkspaces.childWorkspaces
        ?.where((element) =>
            (element.workspaceType == WORKSPACE_TYPE.TEXT) ||
            element.workspaceType == WORKSPACE_TYPE.CATEGORY &&
                element.authUserChildren!.isNotEmpty)
        .toList();
    return children ?? <Workspace>[];
  }

  getOrderPostingPermissionText(ORDER_POSTING_PERMISSIONS permission) {
    switch (permission) {
      case ORDER_POSTING_PERMISSIONS.ADMIN_ONLY:
        return 'Admins only';
      case ORDER_POSTING_PERMISSIONS.EVERYONE:
        return 'Guild members';
      default:
    }
  }

  getUser() async {
    profileUser$.value = await userService.getUserByKey(
        userKey: authUserKey, requestedFields: userRequestedFields());
    if (profileUser$.value?.workspaces != null &&
        profileUser$.value!.workspaces!.isNotEmpty) {
      selectedWorkspace$.value = profileUser$.value?.workspaces![0];
    }
  }

  Future<List<Workspace>> getWorkspaces() async {
    final User? user = await userService.getUserByKey(
        userKey: authUserKey, requestedFields: userRequestedFields());

    return user?.workspaces != null ? user!.workspaces!.toList() : [];
  }

  Future<void> loadMore() async {
    workspacesOffset += 10;
    final List<Workspace> workspaces = await getWorkspaces();
    final List<Workspace> allWorkspaces = [
      ...profileUser$.value!.workspaces!,
      ...workspaces
    ];
    profileUser$.value =
        profileUser$.value!.copyWith(workspaces: allWorkspaces);
  }

  Future<void> loadMoreChildren() async {
    childrenOffset += 10;
    final List<Workspace> workspaces = await getChildren();
    final List<Workspace> allWorkspaces = [
      ...workspaceChildren$,
      ...workspaces
    ];

    workspaceChildren$.clear();
    workspaceChildren$.assignAll(allWorkspaces);
  }

  String oauthUrl(bool bot) {
    return bot
        ? ENV.GRAPHQL_API_URL!.replaceAll('graphql', 'social/discord/auth/bot')
        : ENV.GRAPHQL_API_URL!.replaceAll('graphql', 'social/discord/auth');
  }

  @override
  void onInit() {
    workers = Workers([
      ever(selectedWorkspace$, onWorkspaceChanged),
    ]);
    onPage();
    super.onInit();
  }

  onPage() async {
    apiStatus$.value = API_STATUS.PENDING;
    await getUser();
    apiStatus$.value = API_STATUS.FINISHED;
  }

  onWorkspaceChanged(workspace) async {
    childLoadApiStatus$.value = API_STATUS.PENDING;
    await resetChildren();
    childLoadApiStatus$.value = API_STATUS.FINISHED;
  }

  resetChildren() async {
    childrenOffset = 0;
    final children = await getChildren();
    workspaceChildren$.clear();
    workspaceChildren$.assignAll(children);
  }

  resyncWorkspaces() async {
    await overlayLoader(
      context: Get.overlayContext!,
      asyncFunction: () async {
        workspacesOffset = 0;
        await workspaceService.workspacesSync(
            integrationKey: integration$.value!.integrationKey);
        await getUser();
        await resetChildren();
      },
      opacity: .7,
      loaderColor: Get.context!.theme.primaryColor,
    );
  }

  Future<void> setPrivateChannelDialog() async {
    if (selectedWorkspace$.value!.nbrWorkspacesWithoutBot! > 0) {
      await Get.dialog(
          PrivateChannelsWarningDialog(
            isParentWorkspace: true,
            nbrWorkspaceWithoutBot:
                selectedWorkspace$.value!.nbrWorkspacesWithoutBot!,
            workspacesWithoutBot:
                selectedWorkspace$.value!.workspacesWithoutBot,
          ),
          barrierDismissible: true);
    }
  }

  setWorkspacePermissions() async {
    if (workspaceToEnableRemoteId == null) return;

    final Workspace? enabledWorkspace = profileUser$.value!.workspaces!
        .firstWhereOrNull(
            (workspace) => workspace.remoteId == workspaceToEnableRemoteId);

    if (enabledWorkspace == null) return;

    await workspaceService.updateWorkspace(
        workspaceKey: enabledWorkspace.workspaceKey,
        orderPostingPermission: orderPostingPermission$.value,
        setPermissionAsDefault: true);
    setPermissionsView$.value = false;

    await setPrivateChannelDialog();
  }

  updateWorkspace(
      {bool? botEnabled,
      required int workspaceKey,
      ORDER_POSTING_PERMISSIONS? orderPostingPermission}) async {
    debugPrint('UPDAted');
    final Workspace? workspace = await workspaceService.updateWorkspace(
        workspaceKey: workspaceKey,
        orderPostingPermission: orderPostingPermission,
        botEnabled: botEnabled);

    events.workspaceUpdate(WorkspaceUpdateEvent(workspace: workspace));
  }

  updateWorkspaceBot(Workspace workspace, bool botEnabled) {
    workspace = workspace.copyWith(botEnabled: botEnabled);
  }

  userRequestedFields() {
    return '''
      userKey
      firstName
      lastName
      profilePictureUrl
      avatar {
        avatarKey
        avatarName
        code
        url
      }
      workspaces(input: {limit: 10, offset: $workspacesOffset, source: [${describeEnum(workspaceSource!)}]}) {
        workspaceKey
        name
        authUserPermissionLevel
        remoteId
        pictureUrl
        orderPostingPermission
        botEnabled
        nbrWorkspacesWithoutBot
        workspacesWithoutBot(input: {limit: 3, offset: 0}) {
          name
          workspaceKey
          remoteId
        }
      }
    ''';
  }

  Future<void> workspaceAuth({bool? bot}) async {
    try {
      final res = await Get.to(
          () => OauthWebViewContainer(
                url: oauthUrl(bot!),
                socialSource: SOCIAL_SOURCE.DISCORD,
              ),
          transition: Transition.cupertino);
      if (res != null) {
        apiStatus$.value = API_STATUS.PENDING;
        if (res['guildId'] != null) {
          workspaceToEnableRemoteId = res['guildId'];
          setPermissionsView$.value = true;
        }

        final integrations = await workspaceService.workspaceConnect(
            token: res['code'],
            source: workspaceSource!,
            orderPostingPermission: orderPostingPermission$.value,
            guildId: res['guildId']);

        if (integrations == null) {
          return;
        }

        final Integration? integration = integrations.firstWhereOrNull(
            (element) =>
                element.source == convertWorkspaceToSocial(workspaceSource));
        integration$.value = integration;
        workspacesOffset = 0;
        childrenOffset = 0;
        await getUser();
        await resetChildren();
        if (workspaceToEnableRemoteId != null) {
          selectedWorkspace$.value = profileUser$.value!.workspaces!.firstWhere(
              (element) => element.remoteId == workspaceToEnableRemoteId);
        }
        apiStatus$.value = API_STATUS.FINISHED;
      }
    } catch (err) {
      debugPrint(err.toString());
      setPermissionsView$.value = false;
      apiStatus$.value = API_STATUS.FINISHED;
    }
  }

  workspaceReqFields({bool? getAllWorkspaces}) {
    final String onlyShowEnabled = getAllWorkspaces == true
        ? ''
        : '''
    botEnabled: true
    ''';
    return '''
      childWorkspaces(input: {limit: 10, offset: $childrenOffset, parentWorkspaceKey: ${selectedWorkspace$.value!.workspaceKey}, $onlyShowEnabled, source: [${describeEnum(workspaceSource!)}]}) {
        workspaceKey
        name
        remoteId
        pictureUrl
        orderPostingPermission
        botEnabled
        authUserPermissionLevel
        workspaceType
        botJoinedAt
        authUserPortfolios {
          brokerName
          portfolioKey
          accountId
          connectionStatus
          portfolioName
        }
        authUserChildren(input: {limit: 50, offset: 0, $onlyShowEnabled}) {
          workspaceKey
          name
          remoteId
          pictureUrl
          parentKey
          botJoinedAt
          orderPostingPermission
          botEnabled
          authUserPermissionLevel
          workspaceType
          authUserPortfolios {
            brokerName
            portfolioKey
            accountId
            connectionStatus
            portfolioName
          }
        }
      }
    ''';
  }
}
