import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'secure_storage_interface.dart';

class SecureStorage extends ISecureStorage {
  static final iosOptions = IOSOptions.defaultOptions.copyWith(
    accessibility: IOSAccessibility.first_unlock,
  );

  static final androidOptions = AndroidOptions.defaultOptions.copyWith(
    encryptedSharedPreferences: true,
  );

  final _keyChainStorage = const FlutterSecureStorage();

  @override
  Future<bool> containsKey({required String key}) async {
    return Future.value(_keyChainStorage.containsKey(
      key: key,
      iOptions: iosOptions,
      aOptions: androidOptions,
    ));
  }

  @override
  Future<void> delete({required String key}) {
    return _keyChainStorage.delete(
      key: key,
      iOptions: iosOptions,
      aOptions: androidOptions,
    );
  }

  @override
  Future<String?> read({required String? key}) {
    if (key == null) {
      return Future.value(null);
    }
    return _keyChainStorage.read(
      key: key,
      iOptions: iosOptions,
      aOptions: androidOptions,
    );
  }

  @override
  Future<void> upsert({required String key, required String? value}) async {
    final bool containsKey = await this.containsKey(
      key: key,
    );

    if (containsKey) {
      final String? keyChainValue = await read(key: key);
      if (keyChainValue != value) {
        await delete(key: key);
        await write(key: key, value: value);
      }
    } else {
      await write(key: key, value: value);
    }
  }

  @override
  Future<void> write({required String key, required String? value}) {
    return _keyChainStorage.write(
      key: key,
      value: value,
      iOptions: iosOptions,
      aOptions: androidOptions,
    );
  }
}
