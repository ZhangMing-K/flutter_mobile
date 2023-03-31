import 'package:flutter/foundation.dart';

import '../../secure_storage/secure_storage_interface.dart';
import '../interface/storage_interface.dart';

@visibleForTesting
class StorageMock implements IStorage {
  @override
  final ISecureStorage secure;
  late final Map _cache;

  StorageMock({required this.secure});

  @override
  bool containsKey(String key) {
    return _cache.containsKey(key);
  }

  @override
  Future<void> delete(String dataId) async {
    _cache.remove(dataId);
    return;
  }

  @override
  Future<void> init() async {
    _cache = {};
  }

  void put(String dataId, dynamic value) {
    _cache[dataId] = value;
  }

  @override
  void putAll(Map data) {
    _cache.addAll(data);
  }

  @override
  T? read<T>(String key) {
    return _cache[key];
  }

  @override
  Future<void> reset() async {
    _cache.clear();
    return;
  }

  Map<String, Map<String, dynamic>> toMap() {
    return Map.from(_cache);
  }

  void Function() watch(String key, Function(dynamic) callback) {
    return () {};
  }

  @override
  Future<void> write({String? key, Object? value}) async {
    _cache[key] = value;
    return;
  }
}
