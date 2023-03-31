import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../routes/pages.dart';

class ContactsPermissionController extends GetxController {
  UserContactService userContactService = Get.find();
  final apiStatus$ = Rx<API_STATUS?>(null);
  final contactsSynced = false.obs;

  void completeCallback() {
    goToBuildYourCommunity();
    contactsSynced.value = true;
  }

  void goToBuildYourCommunity() {
    Get.toNamed(Paths.BuildYourCommunity);
  }

  void onNext() {
    Get.toNamed(Paths.OnboardingFinal);
  }

  Future<void> syncContacts() async {
    try {
      apiStatus$.value = API_STATUS.PENDING;
      if (await Permission.contacts.request().isGranted) {
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

    apiStatus$.value = API_STATUS.FINISHED;
  }
}
