import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../iris_common.dart';

class MfaContactPermissionsController extends GetxController {
  UserContactService userContactService = Get.find();
  Rx<API_STATUS?> apiStatus$ = Rx<API_STATUS?>(null);

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

          //final bool? success =
          await userContactService.userContactSync(userContacts: args);
        }
      }
    } catch (err) {
      debugPrint(err.toString());
    }

    apiStatus$.value = API_STATUS.FINISHED;
  }
}
