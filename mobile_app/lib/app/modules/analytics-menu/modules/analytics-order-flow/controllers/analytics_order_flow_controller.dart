import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-order-flow/views/table/constants.dart';
import 'package:iris_mobile/app/routes/pages.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class AnalyticsOrderFlowController extends GetxController {
  final IAnalyticsOrderFlowRepository repository;
  final ISearchRepository searchRepository;
  final Rx<OVERVIEW_ORDER_BY> selectedOrderBy$ = Rx(OVERVIEW_ORDER_BY.ALL);
  final IAuthUserService authUserStore;
  final RxList<OrderFlow> dataSource$ = <OrderFlow>[].obs;

  final Rx<SortColumns> sortColumns$ =
      Rx(SortColumns(sortBy: SORT_BY.TICKER, orderByAsc: false));

  final Rx<API_STATUS> apiStatus$ = Rx<API_STATUS>(API_STATUS.PENDING);
  final Rx<POSITION_TYPE> currentPositionType$ =
      Rx<POSITION_TYPE>(POSITION_TYPE.OPTION);
  final Rx<bool> appliedIsGold = false.obs;
  final Rx<double> appliedMinPortfolio = 0.0.obs;

  final Rx<double> appliedMinTradeAmount = 0.0.obs;

  final LinkedScrollControllerGroup linkedScrollControllerGroup =
      LinkedScrollControllerGroup();

  final Rx<bool> isLoadingMoreFinished = false.obs;

  final selectedAssetList = <Asset>{}.obs;

  int offset = 0;

  String cursor = '';

  bool canLoadMore = false;

  bool isLoadingMore = false;

  ScrollController scrollController = ScrollController();

  late ScrollController headController;
  late ScrollController bodyController;

  int offsetAssets = 0;

  final searchAssetList = <Asset>[].obs;

  final query = ''.obs;

  final searchNode = FocusNode();

  late Worker _worker;

  Function eq = const ListEquality().equals;

  AnalyticsOrderFlowController({
    required this.repository,
    required this.authUserStore,
    required this.searchRepository,
  });

  bool get getIsGoldApplied {
    return appliedIsGold.value == true;
  }

  bool get getIsMinPortfolioApplied {
    return appliedMinPortfolio.value != 0.0;
  }

  bool get getIsMinTradeApplied {
    return appliedMinTradeAmount.value != 0.0;
  }

  bool get isCrown {
    return selectedOrderBy$.value == OVERVIEW_ORDER_BY.TOP;
  }

  // bool get isGoldMember =>
  //     authUserStore.loggedUser?.goldConnection?.isGoldMember == true;

  bool get isIrisGold {
    return true;
  }

  changeToTopView() async {
    if (selectedOrderBy$.value == OVERVIEW_ORDER_BY.ALL) {
      selectedOrderBy$.value = OVERVIEW_ORDER_BY.TOP;
    } else {
      selectedOrderBy$.value = OVERVIEW_ORDER_BY.ALL;
    }
    apiStatus$.value = API_STATUS.PENDING;
    getOrderFlows();
  }

  String formatDateTime(DateTime time) {
    return DateFormat('yyyy-MM-dd').format(time);
  }

  Future<void> getOrderFlows() async {
    await repository.getOrderFlows(
        assetKeys: selectedAssetList.map((asset) => asset.assetKey!).toList(),
        cursor: cursor,
        positionType: currentPositionType$.value,
        onlyTopTraders: appliedIsGold.value,
        callback: onSuccessGetOrderFlows,
        minPortfolioAllocation: appliedMinPortfolio.value / 100,
        minCost: appliedMinTradeAmount.value,
        onError: onError);
  }

  Future<void> loadAssets(QueryType type, String searchQuery) {
    return searchRepository.loadAssets(
      queryType: type,
      searchValue: searchQuery,
      offset: offsetAssets,
      callback: (data) {
        if (type == QueryType.loadMore) {
          searchAssetList.addAll(data);
        } else {
          searchAssetList.assignAll(data);
        }
      },
      onError: (err) {},
    );
  }

  Future<void> loadMore() async {
    if (canLoadMore && !isLoadingMore) {
      isLoadingMore = true;
      await repository.getOrderFlows(
          assetKeys: selectedAssetList.map((asset) => asset.assetKey!).toList(),
          cursor: cursor,
          positionType: currentPositionType$.value,
          onlyTopTraders: appliedIsGold.value,
          callback: onSuccessGetOrderFlowsMore,
          minPortfolioAllocation: appliedMinPortfolio.value / 100,
          minCost: appliedMinTradeAmount.value,
          queryType: QueryType.loadMore,
          onError: onError);
      isLoadingMore = false;
    }
  }

  Future<void> loadMoreAssets() async {
    offsetAssets += 10;
    await loadAssets(QueryType.loadMore, query.value);
  }

  void onAssetSelected(Asset? asset) {
    if (asset == null) return;
    HapticFeedback.lightImpact();
    if (selectedAssetList.contains(asset)) {
      selectedAssetList.remove(asset);
      searchAssetList.add(asset);
    } else {
      if (selectedAssetList.length >= 5) {
        IrisSnackbar.trigger(
            title: 'Error', body: 'The maximum assets you can add is 5.');
        return;
      }
      selectedAssetList.add(asset);
      searchAssetList.remove(asset);
    }
  }

  @override
  void onClose() {
    _worker.dispose();
    super.onClose();
  }

  void onDone() {
    query('');
    searchNode.unfocus();
  }

  void onError(err) {
    isLoadingMoreFinished.value = true;
  }

  void onFilterApplied(bool isGold, double minPortfolio, double minTrade) {
    Get.back();
    // if (isGoldMember) {
    offset = 0;
    cursor = '';
    appliedIsGold.value = isGold;
    appliedMinPortfolio.value = minPortfolio;
    appliedMinTradeAmount.value = minTrade;
    canLoadMore = false;
    isLoadingMore = false;
    isLoadingMoreFinished.value = false;
    apiStatus$.value = API_STATUS.PENDING;
    dataSource$.value = <OrderFlow>[];
    getOrderFlows();
    // } else {
    //   HapticFeedback.heavyImpact();
    //   routeToGoldSignUp();
    // }
  }

  @override
  void onInit() {
    headController = linkedScrollControllerGroup.addAndGet();
    bodyController = linkedScrollControllerGroup.addAndGet();
    getOrderFlows();
    loadAssets(QueryType.loadCache, '');
    _worker = debounce(query, onQueryChangeDebounced,
        time: const Duration(milliseconds: 150));
    super.onInit();
  }

  Future<void> onPressSelector(POSITION_TYPE positionType) async {
    cursor = '';
    offset = 0;
    apiStatus$.value = API_STATUS.PENDING;
    dataSource$.value = <OrderFlow>[];
    currentPositionType$.value = positionType;
    await getOrderFlows();
  }

  void onQueryChangeDebounced(String value) {
    offsetAssets = 0;
    loadAssets(QueryType.loadCache, value);
  }

  Future<void> onRefresh() async {
    offset = 0;
    cursor = '';
    await getOrderFlows();
  }

  void onSuccessGetOrderFlows(AnalyticsOrderFlowData<OrderFlow> data) {
    final AnalyticsOrderFlowFilterFields filterFields = data.filterFields;
    if (shouldShowResult(filterFields)) {
      final String nextCursor = data.cursor;
      dataSource$.value = data.list;
      if (data.list.length == 20) {
        canLoadMore = true;
        offset += 20;
        cursor = nextCursor;
      } else {
        canLoadMore = false;
        isLoadingMoreFinished.value = true;
      }
      if (data.list.isNotEmpty) {
        apiStatus$.value = API_STATUS.FINISHED;
      } else {
        apiStatus$.value = API_STATUS.EMPTY;
      }
    }
  }

  void onSuccessGetOrderFlowsMore(AnalyticsOrderFlowData<OrderFlow> data) {
    final AnalyticsOrderFlowFilterFields filterFields = data.filterFields;
    if (shouldShowResult(filterFields)) {
      final String nextCursor = data.cursor;
      if (data.list.length == 20) {
        cursor = nextCursor;
        offset += 20;
        canLoadMore = true;
      } else {
        canLoadMore = false;
        isLoadingMoreFinished.value = true;
      }
      dataSource$.addAll(data.list);
      apiStatus$.value = API_STATUS.FINISHED;
    }
  }

  // routeToGoldSignUp() async {
  //   await Get.toNamed(Paths.IrisGoldSettingsPreview);
  // }

  bool shouldShowResult(AnalyticsOrderFlowFilterFields filterFields) {
    if (filterFields.positionType != currentPositionType$.value) return false;
    if (filterFields.onlyTopTraders != appliedIsGold.value) return false;
    if (filterFields.minPortfolioAllocation !=
        (appliedMinPortfolio.value > 0
            ? appliedMinPortfolio.value / 100
            : appliedMinPortfolio.value)) {
      return false;
    }
    if (filterFields.minCost != appliedMinTradeAmount.value) return false;
    final List<int> appliedAssetKeys =
        selectedAssetList.map((asset) => asset.assetKey!).toList();
    if (!eq(filterFields.assetKeys, appliedAssetKeys)) {
      return false;
    }
    return true;
  }

  Future<void> sortTradeAnalysisData({SORT_BY? sortBy}) async {
    sortColumns$.value.sortBy = sortBy;
    sortColumns$.value.orderByAsc = !sortColumns$.value.orderByAsc!;
    final tempData = dataSource$.value;
    dataSource$.value = [];
    final bool? asc = sortColumns$.value.orderByAsc;
    switch (sortBy) {
      case SORT_BY.TICKER:
        tempData.sort((a, b) {
          final String val1 = a.order!.symbol!;
          final String val2 = b.order!.symbol!;
          if (asc!) {
            return val1.compareTo(val2);
          } else {
            return val2.compareTo(val1);
          }
        });
        break;
      default:
        tempData.sort((a, b) {
          final String val1 = a.order!.symbol!;
          final String val2 = b.order!.symbol!;
          if (asc!) {
            return val1.compareTo(val2);
          } else {
            return val2.compareTo(val1);
          }
        });
        break;
    }
    dataSource$.value = tempData;
  }
}
