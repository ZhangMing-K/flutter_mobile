import 'secure_storage_interface.dart';

class SecureStorageMock extends ISecureStorage {
  final Map<String, String?> data = <String, String?>{};
  @override
  Future<void> delete({required String key}) async {
    data.remove(key);
  }

  @override
  Future<String?> read({required String? key}) async {
    return Future.value(data[key]);
  }

  @override
  Future<void> write({required String key, required String? value}) async {
    data[key] = value;
  }

  @override
  Future<void> upsert({required String key, required String? value}) async {
    final bool containsKey = await this.containsKey(key: key);

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
  Future<bool> containsKey({required String key}) async {
    return Future.value(data.containsKey(key));
  }
}
