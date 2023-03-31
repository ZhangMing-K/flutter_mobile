import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../modules/portfolios/controllers/portfolios_controller.dart';

class LeaderboardController extends GetxController {
  final IFeedRepository repository;
  final PortfoliosLeaderboardController portfoliosLeaderboardController;
  final IrisEvent irisEvent;
  RxBool isLocalLeadeboard = true.obs;

  /// Current feed category. It receives the default value
  HISTORICAL_SPAN currentPortfolioSelection = HISTORICAL_SPAN.DAY;

  List<HISTORICAL_SPAN> feedSelection = [
    HISTORICAL_SPAN.DAY,
    HISTORICAL_SPAN.WEEK,
    HISTORICAL_SPAN.THREE_MONTH,
    HISTORICAL_SPAN.YEAR,
  ];

  LeaderboardController({
    required this.repository,
    required this.portfoliosLeaderboardController,
    required this.irisEvent,
  });

  Future<void> changeCategory(String? index) async {
    final newCategory = feedSelection
        .firstWhere((value) => feedSelectionToString(value) == index);
    currentPortfolioSelection = newCategory;
    portfoliosLeaderboardController.currentPortfolioSelection = newCategory;
    if (isLocalLeadeboard.value) {
      portfoliosLeaderboardController.offset = 0;
      await portfoliosLeaderboardController.fetchLocalPortfolios(
          queryType: QueryType.loadCache);
    } else {
      await portfoliosLeaderboardController.fetchGlobalPortfolios(
          queryType: QueryType.loadCache);
    }
  }

  String feedSelectionToString(HISTORICAL_SPAN selection) {
    switch (selection) {
      case HISTORICAL_SPAN.DAY:
        return 'Day';
      case HISTORICAL_SPAN.WEEK:
        return 'Week';
      case HISTORICAL_SPAN.THREE_MONTH:
        return '3M';
      case HISTORICAL_SPAN.YEAR:
        return 'Year';
      default:
        return 'Day';
    }
  }

  HISTORICAL_SPAN getCurrentCategory() {
    return currentPortfolioSelection;
  }

  int getCurrentCategoryIndex() {
    return feedSelection.indexOf(currentPortfolioSelection);
  }

  String getCurrentSelectionString() {
    return feedSelectionToString(currentPortfolioSelection);
  }

  @override
  void onInit() {
    irisEvent.add(eventType: EVENT_TYPE.VIEW_SCREEN_LEADERBOARD);
    super.onInit();
  }

  void scrollToTop() {}

  Future<void> toggleType() async {
    isLocalLeadeboard.value = !isLocalLeadeboard.value;
    portfoliosLeaderboardController.isLocalLeadeboard.value =
        isLocalLeadeboard.value;
    if (isLocalLeadeboard.value) {
      portfoliosLeaderboardController.offset = 0;
      await portfoliosLeaderboardController.fetchLocalPortfolios(
          queryType: QueryType.loadCache);
    } else {
      await portfoliosLeaderboardController.fetchGlobalPortfolios(
          queryType: QueryType.loadCache);
    }
  }
}
