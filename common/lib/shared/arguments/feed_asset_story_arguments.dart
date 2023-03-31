import '../../iris_common.dart';

class FeedAssetStoryArgs {
  final List<Asset>? assetList;
  final int? initialPage;
  final int assetKey;
  FeedAssetStoryArgs({
    this.assetList,
    this.initialPage,
    required this.assetKey,
  });
}
