import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:gql_exec/src/error.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:iris_common/iris_common.dart';

class EditProfileController extends GetxController {
  final IAuthUserService authUserStore;
  final PushNotificationService pushNotificationService;
  final StorageService storageService;
  final UserService userService;
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  MediaPickController mediaPickController = MediaPickController();

  EditProfileController({
    required this.authUserStore,
    required this.pushNotificationService,
    required this.storageService,
    required this.userService,
  });

  @override
  void onReady() async {
    final authNotifications =
        await pushNotificationService.getAuthUserNotifications();
    if (authNotifications != null) {
      authUserStore.editUserData(authNotifications);
    }

    super.onReady();
  }

  void snackbar({required String title, required String message, Icon? icon}) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        icon: icon,
        borderRadius: 9,
        isDismissible: true,
        dismissDirection: DismissDirection.vertical,
        snackStyle: SnackStyle.FLOATING,
        animationDuration: const Duration(milliseconds: 500),
        barBlur: 10);
  }

  Future<void> uploadFile() async {
    mediaPickController.pickMedia(() async {
      final imageFile = await mediaPickController.getImage();
      if (imageFile == null) {
        return;
      }
      final croppedImage =
          await mediaPickController.cropImage(imageFile: imageFile);
      final Uint8List byteData = croppedImage != null
          ? await croppedImage.readAsBytes()
          : await imageFile.readAsBytes();
      final multiPartFile = http.MultipartFile.fromBytes(
        'photo',
        byteData,
        filename: '${DateTime.now().second}.jpg',
        contentType: MediaType('image', 'jpg'),
      );
      await overlayLoader(
        context: Get.overlayContext!,
        asyncFunction: () async {
          try {
            final String? url =
                await storageService.fileUpload(file: multiPartFile);
            authUserStore.editUserData(
                authUserStore.loggedUser!.copyWith(profilePictureUrl: url));
          } catch (err) {
            debugPrint(err.toString());
            return;
          }
        },
        opacity: .8,
        loaderColor: IrisColor.primaryColor,
      );
    });
  }

  Future<User?> userEdit() async {
    final User? authUser = authUserStore.loggedUser;

    if (fbKey.currentState!.saveAndValidate()) {
      final mapValues = fbKey.currentState!.value;

      try {
        final result = await userService.userEdit(
            firstName: mapValues['firstName'] ?? authUser!.firstName,
            lastName: mapValues['lastName'] ?? authUser!.lastName,
            username: mapValues['username'] ?? authUser!.username,
            description: mapValues['bio'] ?? authUser!.description,
            userPrivacyType: mapValues['userPrivacyType']);

        if (result == null) return null;
        authUserStore.editUserData(authUserStore.loggedUser!.copyWith(
          firstName: result.firstName,
          lastName: result.lastName,
          description: result.description,
          userPrivacyType: result.userPrivacyType,
          username: result.username ?? '',
        ));
        return authUserStore.loggedUser;
      } catch (err) {
        if (err is List) {
          final GraphQLError error = err[0];
          String errorMessage = error.message;
          final extensions = error.extensions;
          if (extensions != null && extensions['exception']['errors'] is List) {
            errorMessage = extensions['exception']['errors'][0]['message'];
          }
          snackbar(
              title: 'Error',
              message: errorMessage.capitalizeFirst!,
              icon: const Icon(Icons.error_outline_outlined));
        }
        return null;
      }
    }
    return null;
  }
}
