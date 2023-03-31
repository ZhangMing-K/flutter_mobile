import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class RecentOrdersController extends GetxController {
  final IChatRepository chatRepository;
  final int collectionKey;
  final Function(TextModel order)? setSharingOrder;
  Rx<Collection?> currentCollection$ = Rx<Collection?>(null);

  RxList<User> selectedUsers$ = <User>[].obs;
  RxList<User> currentUsers$ = <User>[].obs;
  RxList<CommonAssets?> currentAssets$ = <CommonAssets?>[].obs;
  RxList<CommonAssets?> selectedAssets$ = <CommonAssets?>[].obs;
  String? cursor = '';
  RxList<TextModel> recentOrders$ = <TextModel>[].obs;
  // RxList<Rx<TextModel>> recentOrders$ = <User>[].obs;
  Rx<TextModel?> sharedOrder = Rx<TextModel?>(null);
  RxBool showUsersList = false.obs;

  RxBool showAssetsList = false.obs;
  IAuthUserService authUserStore = Get.find();

  // int messages
  RecentOrdersController({
    required this.chatRepository,
    required this.collectionKey,
    this.setSharingOrder,
  }) {
    loadData();
  }

  Future<void> getSelectedUserOrders(
      {QueryType queryType = QueryType.loadCache}) {
    List<int> userKeys = [];
    if (selectedUsers$.isNotEmpty) {
      userKeys = selectedUsers$.map((element) => element.userKey!).toList();
    }

    final List<int> assetKeys =
        selectedAssets$.map((element) => element!.asset!.assetKey!).toList();
    return chatRepository.getCollectionOrders(
        collectionKey: collectionKey,
        cursor: cursor,
        userKeys: userKeys,
        assetKeys: assetKeys,
        onError: onError,
        callback: queryType == QueryType.loadMore ? onLoadMore : onSuccess,
        queryType: queryType);
  }

  isSelectedAsset(CommonAssets asset) {
    if (selectedAssets$.contains(asset)) {
      return true;
    } else {
      return false;
    }
  }

  isSelectedUser(User user) {
    if (selectedUsers$.contains(user)) {
      return true;
    } else {
      return false;
    }
  }

  ///TODO: Why call this on constructor?
  loadData() async {
    showOrders();
    await chatRepository.getCollectionUsers(
      collectionKeys: [collectionKey],
      callback: onGetUsersSuccess,
      queryType: QueryType.loadCache,
      onError: onError,
    );
  }

  Future<void> loadMoreOrders() async {
    await getSelectedUserOrders(queryType: QueryType.loadMore);
  }

  onClickAsset(CommonAssets asset) {
    if (selectedAssets$.contains(asset)) {
      selectedAssets$.remove(asset);
    } else {
      selectedAssets$.clear();
      selectedAssets$.add(asset);
    }

    showOrders();
  }

  onClickUser(User user) {
    if (selectedUsers$.contains(user)) {
      selectedUsers$.remove(user);
    } else {
      selectedUsers$.clear();
      selectedUsers$.add(user);
    }
    showOrders();
  }

  void onError(err) {
    IrisExceptionHandler.show(RecentOrdersException());
  }

  void onGetUsersSuccess(Collection collectionInfo) {
    currentCollection$.value = collectionInfo;
    currentUsers$.clear();
    currentAssets$.clear();
    currentAssets$.addAll(collectionInfo.authUserSimilarity!.commonAssets!);
    currentUsers$.add(authUserStore.loggedUser!);
    currentUsers$.addAll(collectionInfo.currentUsers!);
  }

  void onLoadMore(DataList<TextModel> data) {
    final List<TextModel> list = data.list;
    if (data.cursor != '') {
      cursor = data.cursor;
    }
    recentOrders$.addAll(list.map((item) => item).toList());
  }

  onShowAssetsList() {
    showAssetsList.value = true;
  }

  void onSuccess(DataList<TextModel> data) {
    final List<TextModel> list = data.list;
    if (data.cursor != '') {
      cursor = data.cursor;
    }
    recentOrders$.assignAll(list);
  }

  showOrders() {
    cursor = '';
    getSelectedUserOrders();
  }
}
