import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../routes/pages.dart';
import '../../contacts_permission/controllers/contacts_permission_controller.dart';
import '../../picture_and_full_name/controllers/picture_and_full_name_controller.dart';

class BuildYourCommunityController extends GetxController {
  final UserContactService userContactService;
  final ContactsPermissionController permissionController;
  final PictureAndFullNameController pictureAndFullNameController;
  final Rx<API_STATUS> apiStatus$ = API_STATUS.NOT_STARTED.obs;

  BuildYourCommunityController({
    required this.userContactService,
    required this.permissionController,
    required this.pictureAndFullNameController,
  });

  void goToOnboadingFinal() {
    Get.toNamed(Paths.OnboardingFinal);
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
    permissionController.contactsSynced.value = true;
    apiStatus$.value = API_STATUS.FINISHED;
  }
}
