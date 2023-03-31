import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../../routes/pages.dart';
import '../../../../institution/classes/connect_institution_arts.dart';
import '../../picture_and_full_name/controllers/picture_and_full_name_controller.dart';

class EnterUsernameController extends GetxController {
  EnterUsernameController({
    required this.authUserStore,
    required this.pictureAndFullNameController,
  });

  final IAuthUserService authUserStore;
  final PictureAndFullNameController pictureAndFullNameController;
  final userNameFormKey = GlobalKey<FormBuilderState>();
  final RxnString usernameTakenError$ = RxnString();
  final RxnString userName = RxnString('');

  void onUserNameChanged(String? value) {
    userName.value = value;
    usernameTakenError$.value = null;
  }

  void _goToConnectPortfolio() {
    var args =
        ConnectInstitutionArgs(from: INSTITUTION_CONNECTED_FROM.ONBOARDING);
    Get.toNamed(Paths.InstitutionConnectLanding, arguments: args);
  }

  Future<void> onUserNameSubmitted() async {
    if (userName.value!.contains(' ')) {
      usernameTakenError$.value = 'must not contain spaces';
      return;
    }

    if (userNameFormKey.currentState!.validate()) {
      await overlayLoader(
        context: Get.overlayContext!,
        asyncFunction: () async {
          try {
            final User? authUser = authUserStore.loggedUser;

            final result =
                await pictureAndFullNameController.userService.userEdit(
              firstName: pictureAndFullNameController.firstName.value ??
                  authUser!.firstName,
              lastName: pictureAndFullNameController.lastName.value ??
                  authUser!.lastName,
              username: userName.value ?? authUser!.username,
            );

            if (result != null) {
              authUserStore.editUserData(authUserStore.loggedUser!.copyWith(
                firstName: result.firstName,
                lastName: result.lastName,
                username: result.username ?? userName.value,
                userKey: result.userKey,
                invitedByUser: result.invitedByUser,
              ));
              Get.focusScope!.unfocus();
              _goToConnectPortfolio();
            } else {}
          } catch (err) {
            if (err.toString().contains('username must be unique')) {
              usernameTakenError$.value =
                  'Sorry, it looks like that name is taken';
            } else {
              if (err is List && err.isEmpty) {
                Get.find<IrisErrorReport>()
                    .send(UsernameException(err.toString()));
                usernameTakenError$.value =
                    'Unable to connect to server, check your internet connection';
              } else {
                Get.find<IrisErrorReport>()
                    .send(UsernameException(err.toString()));
                usernameTakenError$.value =
                    'You cannot use this username, contact our support';
              }
            }
          }
        },
        opacity: .7,
        loaderColor: Get.context!.theme.primaryColor,
      );
    }
  }
}
