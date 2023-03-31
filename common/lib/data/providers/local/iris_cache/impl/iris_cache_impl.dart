import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

import '../../storage/storage.dart';
import '../iris_cache.dart';

class IrisCache implements IrisCacheInterface {
  final IStorage storage;

  IrisCache({required this.storage});

  @override
  bool reachedMaxEntriesLimit(CacheResult result) {
    return result.entry.length < result.config.maxEntries;
  }

  // bool isExpired(CacheEntry element, CacheResult result) {
  //   final invalidateDate = element.dateTime.add(result.config.maxDuration);
  //   return invalidateDate.isAfter(DateTime.now());
  // }

  // void removeExpiredEntrys(String key) {
  //   final result = getCacheResult(key);
  //   if (result == null) return;

  //   final newEntry =
  //       result.entry.where((element) => !isExpired(element, result));
  //   storage.put(key, result.copyWith(entry: newEntry.toList()).toMap());
  // }

  @override
  CacheResult? getCacheResult(String key) {
    final result = storage.read(key);
    if (result == null) {
      return null;
    }
    return CacheResult.fromMap(result);
  }

  @override
  void putOnCache(String key, CacheEntry cacheEntry) {
    final localResult = getCacheResult(key);
    if (localResult == null) {
      writeToStorage(
          key: key,
          value: CacheResult(
            entry: [cacheEntry],
            config: CacheConfig.standard(),
          ));
    } else {
      final localEntry = localResult.entry;
      localEntry.removeWhere((element) => element.id == cacheEntry.id);
      while (localEntry.length >= localResult.config.maxEntries) {
        localResult.entry.removeAt(0);
      }

      localEntry.add(cacheEntry);
      writeToStorage(key: key, value: localResult.copyWith(entry: localEntry));
    }
  }

  void writeToStorage({required String key, required CacheResult value}) {
    storage.write(key: key, value: value.toMap());
  }

  void setConfig(String key, CacheConfig config) {
    final result = getCacheResult(key);
    if (result == null) {
      writeToStorage(key: key, value: CacheResult(config: config, entry: []));
    } else {
      writeToStorage(key: key, value: result.copyWith(config: config));
    }
  }

  @override
  T? getFromCache<T>(String key, String id) {
    final localResult = getCacheResult(key);
    if (localResult == null) {
      return null;
    }
    final entry =
        localResult.entry.firstWhereOrNull((element) => element.id == id);
    if (entry != null) {
      /// Schedule a cleaning in two minutes
      // Future.delayed(Duration(seconds: 2), () => removeExpiredEntrys(key));
      return entry.data as T;
    } else {
      return null;
    }
  }

  @override
  Future<void> downloadImagesToCache(
      {required List<String> listOfImageUrls}) async {
    /// We iterate the list for downloading each image from the image url
    await Future.forEach(listOfImageUrls, (String item) async {
      /// We first have to check if the file is already present in the cache or not
      FileInfo? fileInfo =
          await Get.find<IrisImageCacheManager>().getFileFromCache(item);
      bool fileExists = false;

      /// if file exists then var fileExists is set to true , else false
      if (fileInfo != null) {
        fileExists = await fileInfo.file.exists();
      }

      /// if the file does not exists , then we download it in the cache
      if (!fileExists) {
        try {
          await Get.find<IrisImageCacheManager>().downloadFile(item);
        } catch (e) {
          /// if file url is incorrect or corrupted then we move on to next url
          debugPrint('Error in downloading image $e');
        }
      }
    }).timeout(const Duration(seconds: 10));
  }
}
