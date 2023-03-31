import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class DecryptData {
  const DecryptData({required this.message, required this.encryptionCode});
  final String message;
  final String encryptionCode;
}

class DecryptMessages {
  DecryptMessages._();

  static Future<List<Rx<TextModel>>> decryptMessageList(
      List<Rx<TextModel>> messages) async {
    final tempList = <Rx<TextModel>>[];
    for (Rx<TextModel> message in messages) {
      if (message.value.isEncrypted ?? false) {
        final decryptedMessage = await decrypt(DecryptData(
            encryptionCode: message
                .value.collection!.collectionGuardedInfo!.encryptionCode!,
            message: message.value.value!));
        message.value =
            message.value.copyWith(value: decryptedMessage, isEncrypted: false);
        tempList.add(message);
      } else {
        tempList.add(message);
      }
    }

    return tempList;
  }

  static Future<String> decrypt(DecryptData data) async {
    final decryptedData =
        await IrisCryptr(secret: data.encryptionCode).decrypt(data.message);
    return decryptedData;
  }
}
