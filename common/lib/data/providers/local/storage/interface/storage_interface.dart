import '../../secure_storage/secure_storage_interface.dart';

abstract class IStorage {
  ISecureStorage get secure;

  Future<void> init();

  bool containsKey(String key);

  Future<void> delete(String key);

  T? read<T>(String key);

  Future<void> write({String? key, Object? value});

  void putAll(Map data);

  //void put(String dataId, Map<String, dynamic>? value);

  // Map<String, Map<String, dynamic>> toMap();

  // void Function() watch(String key, Function(dynamic) callback);

  Future<void> reset();
}

const String SECURE_BOX = 'secure2';
