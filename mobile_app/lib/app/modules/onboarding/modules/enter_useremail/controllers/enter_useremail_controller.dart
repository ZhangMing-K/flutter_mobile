import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:gql_exec/src/error.dart';

import '../../../../../routes/pages.dart';

class EnterUseremailController extends GetxController {
  EnterUseremailController({
    required this.authUserStore,
    required this.storageService,
    required this.userService,
    required this.authService,
  });

  final IAuthUserService authUserStore;
  final StorageService storageService;
  final UserService userService;
  final AuthService authService;

  final GlobalKey<FormBuilderState> emailFormKey =
      GlobalKey<FormBuilderState>();
  final RxnString email = RxnString('');

  bool get canGoNext {
    return email.value != null && emailFormKey.currentState!.validate();
  }

  Future createOrEditUser() async {
    if (email.value != null && emailFormKey.currentState!.validate()) {
      await overlayLoader(
        context: Get.overlayContext!,
        asyncFunction: () async {
          try {
            await editUserFullName();
            goToEnterUsername();
          } catch (err) {
            String errorText = 'Something went wrong, please try again';
            if (err is List) {
              final GraphQLError error = err[0];
              final extensions = error.extensions;
              if (extensions != null &&
                  extensions['exception']['errors'] is List) {
                errorText = extensions['exception']['errors'][0]['message'];
              }
            }
            emailFormKey.currentState
                ?.invalidateField(name: 'email', errorText: errorText);
            rethrow;
          }
        },
        opacity: .7,
        loaderColor: Get.context!.theme.primaryColor,
      );
    }
  }

  Future<void> editUserFullName() async {
    final User? authUser = authUserStore.loggedUser;

    final result = await userService.userEdit(email: email.value);
    if (result != null) {
      authUserStore.editUserData(authUserStore.loggedUser!.copyWith(
        email: result.email,
      ));
    }
  }

  void onEmailChanged(String? value) {
    email.value = value;
  }

  void onError(err) {
    debugPrint(err.toString());
    Get.snackbar('Error', 'Cannot load recommended users');
  }

  int offset = 0;

  void goToEnterUsername() {
    Get.toNamed(Paths.EnterUsername);
  }
}
