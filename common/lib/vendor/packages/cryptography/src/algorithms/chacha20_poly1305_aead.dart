import 'dart:typed_data';


import '../../cryptography.dart';
import '../utils.dart';

// Copyright 2019-2020 Gohilla Ltd.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// _AEAD_CHACHA20_POLY1305_ ([https://tools.ietf.org/html/rfc7539](RFC 7539)) cipher.
///
/// ## Things to know
///   * See [chacha20] for information about the cipher.
///   * This cipher is authenticated and decrypting will throw
///     [MacValidationException] if the cipherText contains an invalid MAC.
///   * `aad` (Associated Authenticated Data) is supported.
///
/// ## Example
/// ```dart
/// import 'package:cryptography/cryptography.dart';
///
/// Future<void> main() async {
///   // Generate a random 256-bit secret key
///   final secretKey = SecretKey.randomBytes(32);
///
///   // Generate a random 96-bit nonce.
///   final nonce = Nonce.randomBytes(12);
///
///   // Encrypt
///   final plainText = <int>[1, 2, 3];
///   final encrypted = await chacha20Poly1305Aead.encrypt(
///     plainText,
///     secretKey: secretKey,
///     nonce: nonce,
///   );
///
///   debugPrint('Bytes: ${chacha20Poly1305Aead.getDataInCipherText(encrypted)}');
///   debugPrint('MAC: ${chacha20Poly1305Aead.getMacInCipherText(encrypted)}');
///
///   // Decrypt.
///   //
///   // If the message authentication code is incorrect,
///   // the method will throw MacValidationException.
///   //
///   final decrypted = await algorithm.decrypt(
///     cipherText,
///     secretKey: secretKey,
///     nonce: nonce,
///   );
/// }
/// ```
const CipherWithAppendedMac chacha20Poly1305Aead = Chacha20Poly1305Aead(
  name: 'chacha20Poly1305Aead',
  cipher: chacha20,
);

/// _XAEAD_CHACHA20_POLY1305_ ([draft-irtf-cfrg-xchacha](https://tools.ietf.org/html/draft-arciszewski-xchacha-03)) cipher.
///
/// XChaCha20 uses 192-bit nonces whereas ChaCha20 uses 96-bit nonces.
///
/// ## Things to know
///   * See [xchacha20] for information about the cipher.
///   * This cipher is authenticated and decrypting will throw
///     [MacValidationException] if the cipherText contains an invalid MAC.
///   * `aad` (Associated Authenticated Data) is supported.
const CipherWithAppendedMac xchacha20Poly1305Aead = Chacha20Poly1305Aead(
  name: 'xchacha20Poly1305Aead',
  cipher: xchacha20,
);

/// _AEAD_CHACHA20_POLY1305_ implementation for subclassing.
/// For documentation, see [chacha20Poly1305Aead].
///
/// This is used by [chacha20Poly1305Aead] and [xchacha20Poly1305Aead].
class Chacha20Poly1305Aead extends CipherWithAppendedMac {
  static final _tmpByteData = ByteData(16);
  static final _tmpUint8List = Uint8List.view(_tmpByteData.buffer);

  @override
  final String name;

  const Chacha20Poly1305Aead({
    required this.name,
    required Cipher cipher,
  })  : super(cipher, poly1305);

  @override
  bool get supportsAad => true;

  @override
  Future<Mac> calculateMac(
    List<int> cipherText, {
    required SecretKey? secretKey,
    required Nonce? nonce,
    required List<int>? aad,
  }) {
    return Future<Mac>.value(calculateMacSync(
      cipherText,
      secretKey: secretKey,
      nonce: nonce,
      aad: aad,
    ));
  }

  @override
  Mac? calculateMacSync(
    List<int> cipherText, {
    required SecretKey? secretKey,
    required Nonce? nonce,
    required List<int>? aad,
  }) {
    final secretKeyForPoly1305 = poly1305SecretKeyFromChacha20(
      secretKey,
      nonce: nonce,
    );
    final sink = poly1305.newSink(secretKey: secretKeyForPoly1305);

    var length = 0;

    final tmpByteData = _tmpByteData;
    tmpByteData.setUint32(0, 0);
    tmpByteData.setUint32(4, 0);
    tmpByteData.setUint32(8, 0);
    tmpByteData.setUint32(12, 0);

    // Add Additional Authenticated Data (AAD)
    final aadLength = aad == null ? 0 : aad.length;
    if (aadLength != 0) {
      sink.add(aad!);
      length += aad.length;

      final rem = length % 16;
      if (rem != 0) {
        // Add padding
        final paddingLength = 16 - rem;
        sink.add(_tmpUint8List.sublist(0, paddingLength));
        length += paddingLength;
      }
    }

    // Add cipherText
    sink.add(cipherText);
    length += cipherText.length;
    final rem = length % 16;
    if (rem != 0) {
      // Add padding
      final paddingLength = 16 - rem;
      sink.add(_tmpUint8List.sublist(0, paddingLength));
      length += paddingLength;
    }

    // Add 16-byte footer.
    // We can't use setUint64() because it's not supported in the browsers.
    tmpByteData.setUint32(
      0,
      uint32mask & aadLength,
      Endian.little,
    );
    tmpByteData.setUint32(
      4,
      aadLength ~/ (uint32mask + 1),
      Endian.little,
    );
    tmpByteData.setUint32(
      8,
      uint32mask & cipherText.length,
      Endian.little,
    );
    tmpByteData.setUint32(
      12,
      cipherText.length ~/ (uint32mask + 1),
      Endian.little,
    );
    sink.add(_tmpUint8List);

    // Reset the static buffer.
    tmpByteData.setUint32(0, 0);
    tmpByteData.setUint32(4, 0);
    tmpByteData.setUint32(8, 0);
    tmpByteData.setUint32(12, 0);

    // Return MAC
    sink.close();

    return sink.mac;
  }

  @override
  Future<Uint8List> decrypt(
    List<int> cipherText, {
    required SecretKey? secretKey,
    required Nonce? nonce,
    List<int>? aad,
    int keyStreamIndex = 0,
  }) async {
    final dataInCipherText = getDataInCipherText(cipherText);
    final calculatedMac = await calculateMac(
      dataInCipherText,
      secretKey: secretKey,
      nonce: nonce,
      aad: aad,
    );
    final macInCipherText = getMacInCipherText(cipherText);
    if (macInCipherText != calculatedMac) {
      throw MacValidationException();
    }
    return cipher.decrypt(
      dataInCipherText,
      secretKey: secretKey,
      nonce: nonce,
      aad: null,
      // Block counter 0 is used for Poly1305 key generation
      keyStreamIndex: 64 + keyStreamIndex,
    );
  }

  @override
  Uint8List decryptSync(
    List<int> cipherText, {
    required SecretKey? secretKey,
    required Nonce? nonce,
    List<int>? aad,
    int keyStreamIndex = 0,
  }) {
    final dataInCipherText = getDataInCipherText(cipherText);
    final calculatedMac = calculateMacSync(
      dataInCipherText,
      secretKey: secretKey,
      nonce: nonce,
      aad: aad,
    );
    final macInCipherText = getMacInCipherText(cipherText);
    if (macInCipherText != calculatedMac) {
      throw MacValidationException();
    }
    return cipher.decryptSync(
      dataInCipherText,
      secretKey: secretKey,
      nonce: nonce,
      aad: null,
      // Block counter 0 is used for Poly1305 key generation
      keyStreamIndex: 64 + keyStreamIndex,
    );
  }

  @override
  Future<Uint8List> encrypt(
    List<int> plainText, {
    required SecretKey? secretKey,
    required Nonce? nonce,
    List<int>? aad,
    int keyStreamIndex = 0,
  }) async {
    final cipherTextWithoutMac = await cipher.encrypt(
      plainText,
      secretKey: secretKey,
      nonce: nonce,
      aad: null,
      // Block counter 0 is used for Poly1305 key generation
      keyStreamIndex: 64 + keyStreamIndex,
    );
    final mac = await calculateMac(
      cipherTextWithoutMac,
      secretKey: secretKey,
      nonce: nonce,
      aad: aad,
    );
    final result = Uint8List(cipherTextWithoutMac.length + 16);
    result.setAll(0, cipherTextWithoutMac);
    result.setAll(cipherTextWithoutMac.length, mac.bytes);
    return result;
  }

  @override
  Uint8List encryptSync(
    List<int> plainText, {
    required SecretKey? secretKey,
    required Nonce? nonce,
    List<int>? aad,
    int keyStreamIndex = 0,
  }) {
    final cipherTextWithoutMac = cipher.encryptSync(
      plainText,
      secretKey: secretKey,
      nonce: nonce,
      aad: null,
      // Block counter 0 is used for Poly1305 key generation
      keyStreamIndex: 64 + keyStreamIndex,
    );
    final mac = calculateMacSync(
      cipherTextWithoutMac,
      secretKey: secretKey,
      nonce: nonce,
      aad: aad,
    )!;
    final result = Uint8List(cipherTextWithoutMac.length + 16);
    result.setAll(0, cipherTextWithoutMac);
    result.setAll(cipherTextWithoutMac.length, mac.bytes);
    return result;
  }
}
