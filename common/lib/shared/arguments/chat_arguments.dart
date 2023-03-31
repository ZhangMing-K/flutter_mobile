import 'package:get/get.dart';

import '../../iris_common.dart';

class ChatArgs {
  final String encryptionCode;
  final String avatarUrl;
  final String chatname;
  final String id;
  final Rx<TextModel>? message;
  const ChatArgs({
    required this.encryptionCode,
    required this.avatarUrl,
    required this.chatname,
    required this.id,
    required this.message,
  });
}
