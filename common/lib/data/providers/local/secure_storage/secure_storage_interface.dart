import 'package:flutter/foundation.dart';

abstract class ISecureStorage {
  @mustCallSuper
  Future<void> delete({required String key});

  Future<String?> read({required String? key});

  Future<void> write({required String key, required String? value});

  Future<void> upsert({required String key, required String? value});

  Future<bool> containsKey({required String key});
}
