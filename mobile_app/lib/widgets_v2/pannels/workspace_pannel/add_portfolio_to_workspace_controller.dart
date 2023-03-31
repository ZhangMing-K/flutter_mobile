import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class AddPortfolioToWorkspaceController extends GetxController {
  Rx<Workspace?> workspace$ = Rx<Workspace?>(null);
  final IAuthUserService authUserStore = Get.find();
  final WorkspaceService workspaceService = Get.find();
  final UserService userService = Get.find();
  final List<Portfolio> userPortfolios = [];
  Rx<User?> profileUser$ = Rx<User?>(null);
  RxList<int?> selectedPortfolios$ = RxList([]);
  Rx<API_STATUS> apiStatus$ = Rx(API_STATUS.NOT_STARTED);
  final Events events = Get.find();
  Workers? workers;
  AddPortfolioToWorkspaceController({required Workspace workspace}) {
    userPortfolios.assignAll(workspace.authUserPortfolios!);
    selectedPortfolios$
        .assignAll(userPortfolios.map((e) => e.portfolioKey).toList());

    workspace$.value = workspace;
  }

  addOrRemovePortfolio(portfolioKey) {
    final bool contains = selectedPortfolios$.contains(portfolioKey);
    if (contains) {
      selectedPortfolios$.removeWhere((key) => key == portfolioKey);
    } else {
      selectedPortfolios$.add(portfolioKey);
    }
  }

  getUser() async {
    final authUserKey = authUserStore.loggedUser!.userKey;
    profileUser$.value = await userService.getUserByKey(
        userKey: authUserKey, requestedFields: userRequestedFields());
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
    workspace$.value =
        workspace$.value!.copyWith(botEnabled: event!.workspace!.botEnabled);
  }

  submit() async {
    apiStatus$.value = API_STATUS.PENDING;

    final List<int?> currentPortfolioKeys =
        userPortfolios.map((e) => e.portfolioKey).toList();

    final List<PortfolioArg> portfoliosToUpdate = [];
    final List<Portfolio> workspaceUserPortfolios = [];
    for (var portfolio in profileUser$.value!.portfolios!) {
      {
        if (!selectedPortfolios$.contains(portfolio.portfolioKey) &&
            currentPortfolioKeys.contains(portfolio.portfolioKey)) {
          userPortfolios.removeWhere(
              (element) => element.portfolioKey == portfolio.portfolioKey);
          portfoliosToUpdate.add(PortfolioArg(
              connect: false, portfolioKey: portfolio.portfolioKey));
        }
        if (selectedPortfolios$.contains(portfolio.portfolioKey) &&
            !currentPortfolioKeys.contains(portfolio.portfolioKey)) {
          userPortfolios.add(portfolio);
          portfoliosToUpdate.add(PortfolioArg(
              connect: true, portfolioKey: portfolio.portfolioKey));
        }
        if (selectedPortfolios$.contains(portfolio.portfolioKey)) {
          workspaceUserPortfolios.add(portfolio);
        }
      }
    }

    await workspaceService.upsertPortfoliosInWorkspace(
        portfolioArgs: portfoliosToUpdate,
        workspaceKey: workspace$.value!.workspaceKey);

    events.workspacePortfoliosUpdated(WorkspacePortfoliosUpdatedEvent(
        portfolios: workspaceUserPortfolios,
        workspaceKey: workspace$.value!.workspaceKey));
    Get.back();
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
      description
      email
      username
      verifiedAt
      verifiedText
      firstOrderAt
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
}
