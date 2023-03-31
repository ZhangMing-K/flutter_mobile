import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class AddPortfoliosController extends GetxController {
  int? collectionKey;
  final UserService userService = Get.find();
  final List<Portfolio> userPortfolios = [];
  final CollectionService collectionService = Get.find();
  final IAuthUserService authUserStore = Get.find();
  Rx<User?> profileUser$ = Rx(null);
  RxList<int?> selectedPortfolios$ = RxList([]);
  Rx<API_STATUS> apiStatus$ = Rx(API_STATUS.NOT_STARTED);
  final Events events = Get.find();

  AddPortfoliosController({required this.collectionKey}) {
    collectionKey = collectionKey;
  }

  addOrRemovePortfolio(portfolioKey) {
    final bool contains = selectedPortfolios$.contains(portfolioKey);
    if (contains) {
      selectedPortfolios$.removeWhere((key) => key == portfolioKey);
    } else {
      selectedPortfolios$.add(portfolioKey);
    }
  }

  getPortfolios() async {
    final authUserKey = authUserStore.loggedUser?.userKey;

    final List<Collection>? collections =
        await collectionService.getCollections(collectionKeys: [collectionKey]);
    if (collections == null) return;
    final Collection currentCollection = collections
        .firstWhere((element) => element.collectionKey == collectionKey);

    userPortfolios.assignAll(currentCollection.currentPortfolios!
        .where((element) => element.user!.userKey == authUserKey)
        .toList());
    selectedPortfolios$
        .assignAll(userPortfolios.map((e) => e.portfolioKey).toList());
  }

  getUser() async {
    final authUserKey = authUserStore.loggedUser?.userKey;
    profileUser$.value = await userService.getUserByKey(
        userKey: authUserKey, requestedFields: userRequestedFields());
  }

  @override
  onReady() async {
    await getUser();
    await getPortfolios();
    super.onReady();
  }

  submit() async {
    apiStatus$.value = API_STATUS.PENDING;

    final List<int?> currentPortfolioKeys =
        userPortfolios.map((e) => e.portfolioKey).toList();
    final List<Portfolio>? portfoliosToRemove = profileUser$.value?.portfolios
        ?.where((portfolio) =>
            !selectedPortfolios$.contains(portfolio.portfolioKey) &&
            currentPortfolioKeys.contains(portfolio.portfolioKey))
        .toList();
    final List<Portfolio>? portfoliosToAdd = profileUser$.value?.portfolios
        ?.where((portfolio) =>
            selectedPortfolios$.contains(portfolio.portfolioKey) &&
            !currentPortfolioKeys.contains(portfolio.portfolioKey))
        .toList();

    if (portfoliosToAdd != null && portfoliosToAdd.isNotEmpty) {
      await collectionService.collectionAddEntities(
          collectionKey: collectionKey,
          entityType: COLLECTION_REQUEST_ENTITY_TYPE.PORTFOLIO,
          entityKeys: portfoliosToAdd.map((e) => e.portfolioKey).toList());
      for (var element in portfoliosToAdd) {
        userPortfolios.add(element);
      }
      events.portfoliosAdded(PortfoliosAddedEvent(portfolios: portfoliosToAdd));
    }

    if (portfoliosToRemove != null && portfoliosToRemove.isNotEmpty) {
      await collectionService.collectionRemoveEntities(
          collectionKey: collectionKey,
          entityType: COLLECTION_REQUEST_ENTITY_TYPE.PORTFOLIO,
          entityKeys: portfoliosToRemove.map((e) => e.portfolioKey).toList());

      for (var element in portfoliosToRemove) {
        userPortfolios.removeWhere((userPortfolio) =>
            userPortfolio.portfolioKey == element.portfolioKey);
      }
      events.portfoliosRemoved(
          PortfoliosRemovedEvent(portfolios: portfoliosToRemove));
    }

    Get.back();
  }

  // TODO: PUT IT ON REPOSITORY
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
      suspendedAt
      authUserRelation {
        hideAt
        userKey
        entityKey
        watchedAt
        mutedAt
        blockedAt
        savedAt
        notificationAmount  
      }
      integrations(input: {sources: ${getSocialsInput()}}) {
        integrationKey
        source
        username
        token
      }
      authUserFollowInfo{
        followStatus
        until
      }
      followStats{
        numberOfFollowers
        numberFollowing
        numberOfPortfoliosFollowing
        entityType
        lookupKey
      }
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
        snapshot(input: {mostRecent: true}){
          dayPercent
          weekPercent
          threeMonthPercent
          yearPercent
          allPercent
          lastUpdatedAt
        }
        portfolioName
      }
    ''';
  }
}
