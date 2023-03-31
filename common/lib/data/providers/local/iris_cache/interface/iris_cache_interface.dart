import '../iris_cache.dart';

abstract class IrisCacheInterface {
  bool reachedMaxEntriesLimit(CacheResult result);
  //bool isExpired(CacheEntry element, CacheResult result);
  // void removeExpiredEntrys(String key);
  CacheResult? getCacheResult(String key);
  void putOnCache(String key, CacheEntry cacheEntry);
  T? getFromCache<T>(String key, String id);
  Future<void> downloadImagesToCache({required List<String> listOfImageUrls});
}
