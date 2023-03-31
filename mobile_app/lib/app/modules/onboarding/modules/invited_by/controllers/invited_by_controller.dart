import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../routes/pages.dart' hide Share;

class InvitedByController extends GetxController {
  final Rx<User?> invitedBy = Rx<User?>(null);
  final UserContactService userContactService;
  final contactsSynced = false.obs;
  final Rx<API_STATUS> apiStatus$ = API_STATUS.NOT_STARTED.obs;
  final IAuthUserService authUserStore = Get.find();

  InvitedByController({required this.userContactService});

  void goToBuildYourCommunity() {
    Get.toNamed(Paths.BuildYourCommunity);
  }

  Future<void> syncContacts() async {
    try {
      apiStatus$.value = API_STATUS.PENDING;
      final data = await Permission.contacts.request();
      if (data.isGranted) {
        // Either the permission was already granted before or the user just granted it.
        final Iterable<Contact> contacts = await ContactsService.getContacts();
        final List<Contact> contactsList = contacts.toList();

        if (contactsList.isNotEmpty) {
          final List<UserContactInput> args =
              userContactService.transformContacts(contacts: contactsList);
          await userContactService.userContactSync(userContacts: args);
        }
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    contactsSynced.value = true;
    apiStatus$.value = API_STATUS.FINISHED;
  }

  void shareInviteLink() {
    Share.share(
        'Follow my trades on Iris!\n${authUserStore.loggedUser!.inviteLink!}');
  }
}
