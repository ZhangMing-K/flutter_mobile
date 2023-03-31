import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class SearchAssetController extends GetxController {
  final IStorage storage = Get.find();
  final recentList = <Asset>[].obs;

  @override
  void onInit() {
    loadRecentList();
    super.onInit();
  }

  void loadRecentList() {
    final assetsFromStorage = storage.read('savedAssets');
    if (assetsFromStorage != null) {
      final List<Asset> userList = List<Asset>.from(assetsFromStorage.map((i) {
        if (i is Asset) return i;
        return Asset.fromJson(i);
      }));
      recentList.assignAll(userList);
    }
  }

  void saveAssetToRecent(Asset asset) {
    final assetKey = asset.assetKey;
    recentList.removeWhere((element) => element.assetKey == assetKey);
    recentList.insert(0, asset);
    storage.write(
      key: 'savedAssets',
      value: recentList.map((element) => element.toJson()).toList(),
    );
  }
}
