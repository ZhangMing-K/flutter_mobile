import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'share_inbox_item.dart';

class ShareInboxItemController extends GetxController {
  final IChatRepository chatRepository = Get.find();

  Rx<TextModel>? text;
  Rx<User>? user;
  final SHARE_INBOX_TYPE inboxType;
  IAuthUserService authUserStore = Get.find();

  final lastSeen = Rx<DateTime?>(null);
  String url = '';

  String avatarCode = '';
  int? id;
  ShareInboxItemController({
    this.text,
    this.user,
    required this.inboxType,
  });

  Collection get collection {
    return text!.value.collection!;
  }

  List<User>? get currentUsers {
    if (inboxType == SHARE_INBOX_TYPE.INBOX) {
      return collection.currentUsers;
    } else {
      return [user!.value];
    }
  }

  User? get getUser {
    if (collection.currentUsers != null &&
        collection.currentUsers!.isNotEmpty) {
      return collection.currentUsers![0];
    } else {
      return text!.value.user;
    }
  }

  User get receiverUser {
    if (currentUsers == null || currentUsers!.isEmpty) {
      return Fallback.user;
    } else {
      return currentUsers!.first;
    }
  }

  String get userStatus {
    if (receiverUser != Fallback.user) {
      final seenAt = receiverUser.lastOnlineAt;
      if (inboxType == SHARE_INBOX_TYPE.INBOX &&
          collection.collectionType == COLLECTION_TYPE.GROUP_MESSAGE) {
        final numberOfCurrentUsers = collection.numberOfCurrentUsers;
        return '$numberOfCurrentUsers members';
      } else {
        if (seenAt != null) {
          return DateTime.now().difference(seenAt) < const Duration(minutes: 10)
              ? 'Active now'
              : 'Active ${timeago.format(seenAt)}';
        } else {
          return '';
        }
      }
    }
    return '';
  }
}
