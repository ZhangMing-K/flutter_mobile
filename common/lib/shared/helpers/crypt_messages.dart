import 'dart:convert';
import 'dart:typed_data';

import '../../vendor/packages/cryptography/cryptography.dart';

class IrisCryptr {
  //this encryption is just for messaging iterations are low for performance but this still provides extreme secruity for our users
  static const _algorithm = AesGcm();
  static const _macAlgo = Hmac(sha256);
  String secret;
  late List<int> secretBytes;
  int ivLength = 16;
  int saltLength = 64;
  int iterations;

  IrisCryptr({required this.secret, this.iterations = 2}) {
    secretBytes = utf8.encode(secret);
  }

  Future<String> decrypt(String message) async {
    // return message;
    try {
      final int encryptedPosition = saltLength + ivLength;

      const BASE64 = Base64Codec();
      final List<int> messageBytes = BASE64.decode(message);
      final List<int> salt = messageBytes.sublist(0, saltLength);
      final List<int> iv = messageBytes.sublist(saltLength, encryptedPosition);
      // List<int> tag;
      final List<int> encrypted = messageBytes.sublist(encryptedPosition);

      final Nonce saltNonce = Nonce(salt);
      final Nonce ivNonce = Nonce(iv);
      final secretKey = getKey(saltNonce);

      final decoded = await _algorithm.decrypt(encrypted,
          secretKey: secretKey, nonce: ivNonce, keyStreamIndex: 32);
      final Uint8List decodedBytes = Uint8List.fromList(decoded);
      return utf8.decode(decodedBytes);
    } catch (err) {
      return '[[**encrypted message**]]';
    }
  }

  Future<String> encrypt(String message) async {
    final iv = Nonce.randomBytes(ivLength);
    final saltNonce = Nonce.randomBytes(saltLength);
    final secretKey = getKey(saltNonce);

    final List<int> messageBytes = utf8.encode(message);
    final t = await _algorithm.encrypt(messageBytes,
        secretKey: secretKey, nonce: iv, keyStreamIndex: 32);

    final l = [...saltNonce.bytes, ...iv.bytes, ...Uint8List.fromList(t)];
    final Uint8List bytes = Uint8List.fromList(l);
    const BASE64 = Base64Codec();
    final String string = BASE64.encode(bytes);
    return string;
  }

  SecretKey getKey(Nonce saltNonce) {
    final pbkdf2 = Pbkdf2(
      macAlgorithm: _macAlgo,
      iterations: iterations,
      bits: 256,
    );
    final newSecretKey = pbkdf2.deriveBitsSync(secretBytes, nonce: saltNonce);
    return SecretKey(newSecretKey);
  }
}
