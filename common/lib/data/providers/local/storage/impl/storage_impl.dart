import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';

//import 'package:shared_preferences/shared_preferences.dart';

import '../../secure_storage/secure_storage_interface.dart';
import '../interface/storage_interface.dart';

class Storage extends IStorage {
  static const String boxKey = 'hiveBox';

  static const String _version = 'VERSION';

  @override
  final ISecureStorage secure;
  late final Box box;

  Storage({required this.secure});

  @override
  bool containsKey(String key) {
    return box.containsKey(key);
  }

  @override
  Future<void> delete(String key) {
    return box.delete(key);
  }

  dynamic dynamicToMap(dynamic data) {
    return jsonDecode(jsonEncode(data));
  }

  @override
  Future<void> init() async {
    box = await Hive.openBox(boxKey);
    await _clearStorageOnUpdate();
  }

  @override
  void putAll(Map data) {
    data.forEach((key, value) {
      write(key: key, value: value);
    });
  }

  @override
  T? read<T>(String key) {
    final value = box.get(key);
    if (value == null) {
      return null;
    }
    return dynamicToMap(value);
  }

  @override
  Future<void> reset() => box.clear();

  @override
  Future<void> write({String? key, dynamic value}) {
    return box.put(key, value);
  }

  Future<void> _clearStorageOnUpdate() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final id = packageInfo.version;
    var hasKey = await secure.containsKey(key: _version);
    final idFromStorage = await secure.read(key: _version);
    if (hasKey && idFromStorage != null) {
      if (idFromStorage != id) {
        await box.clear();
        await secure.write(key: _version, value: id);
      }
    } else {
      await box.clear();
      await secure.write(key: _version, value: id);
    }
  }
}
