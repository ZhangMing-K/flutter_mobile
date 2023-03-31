import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/instance_manager.dart';

class IrisImageCacheManager extends CacheManager
    with ImageCacheManager, GetxServiceMixin {
  static const key = 'irisLibCachedImageData';

  IrisImageCacheManager()
      : super(Config(key,
            maxNrOfCacheObjects: 50, stalePeriod: const Duration(days: 1)));
}
