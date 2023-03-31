import 'package:get/get.dart';

import '../../../iris_common.dart';

class KeyChainAuthCredKeyNames {
  static const usernameKey =
      'email'; //kept at email because this was the original value.
  static const passwordKey = 'password';
}

class KeyChainInstitutionCredKeyNames {
  static const usernameKey =
      'email'; //kept at email because this was the original value.
}

class KeyChainAuthCreds {
  KeyChainAuthCreds({this.username, this.password});
  String? username;
  String? password;
}

class KeyChainService extends GetxService {
  KeyChainService({required this.secureStorage});
  final ISecureStorage secureStorage;

  Future<void> upsert({required String key, required String? value}) async {
    final bool containsKey = await secureStorage.containsKey(key: key);

    if (containsKey) {
      final String? keyChainValue = await secureStorage.read(key: key);
      if (keyChainValue != value) {
        await secureStorage.delete(key: key);
        await secureStorage.write(key: key, value: value);
      }
    } else {
      await secureStorage.write(key: key, value: value);
    }
  }

  Future<String?> read({required String key}) {
    return secureStorage.read(key: key);
  }

  Future<KeyChainAuthCreds> getAuthCreds() async {
    return KeyChainAuthCreds(
        username: await read(key: KeyChainAuthCredKeyNames.usernameKey),
        password: await read(key: KeyChainAuthCredKeyNames.passwordKey));
  }

  Future<KeyChainAuthCreds> getInstituionCreds(
      INSTITUTION_NAME institution) async {
    return KeyChainAuthCreds(
        username: await read(key: KeyChainAuthCredKeyNames.usernameKey),
        password: await read(key: KeyChainAuthCredKeyNames.passwordKey));
  }
}
