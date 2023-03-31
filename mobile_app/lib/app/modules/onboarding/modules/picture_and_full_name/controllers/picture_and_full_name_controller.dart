import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../../../routes/pages.dart';

class PictureAndFullNameController extends GetxController {
  PictureAndFullNameController({
    required this.authUserStore,
    required this.searchRepository,
    required this.storageService,
    required this.userService,
    required this.authService,
  });

  @override
  void onInit() {
    final args = Get.arguments;
    if (args is MFAContact) {
      mfaContact$.value = args;
    }
    super.onInit();
  }

  final IAuthUserService authUserStore;
  final ISearchRepository searchRepository;
  final StorageService storageService;
  final UserService userService;
  final AuthService authService;

  final RxnString firstName = RxnString('');
  final RxnString lastName = RxnString('');
  final Rx<MFAContact?> mfaContact$ = Rx<MFAContact?>(null);
  final GlobalKey<FormBuilderState> fullNameFormKey =
      GlobalKey<FormBuilderState>();
  final Rx<Uint8List?> userProfileImage$ = Rx<Uint8List?>(null);
  final MediaPickController mediaPickController = MediaPickController();
  final Rx<http.MultipartFile?> fileUpload$ = Rx<http.MultipartFile?>(null);
  final RxnString fullName = RxnString('');
  final recommendedList = <User>[].obs;

  bool get alreadyCreatedUser => authUserStore.loggedUser != null;

  Future createOrEditUser() async {
    if (firstName.value != null &&
        // lastName.value != null &&
        fullNameFormKey.currentState!.validate()) {
      await overlayLoader(
        context: Get.overlayContext!,
        asyncFunction: () async {
          try {
            if (alreadyCreatedUser) {
              await editUserFullName();
            } else {
              await createUser();
            }
            goToEnterUsername();
            loadRecommended();
          } catch (e) {
            rethrow;
          }
        },
        opacity: .7,
        loaderColor: Get.context!.theme.primaryColor,
      );
    }
  }

  Future<void> updateProfilePicture() async {
    if (userProfileImage$.value != null) {
      // upload user profile
      final String? url =
          await storageService.fileUpload(file: fileUpload$.value!);

      authUserStore.editUserData(
          authUserStore.loggedUser!.copyWith(profilePictureUrl: url));
    }
  }

  Future<void> editUserFullName() async {
    final User? authUser = authUserStore.loggedUser;

    final result = await userService.userEdit(
      firstName: firstName.value ?? authUser!.firstName,
      lastName: lastName.value ?? authUser!.lastName,
    );

    if (result != null) {
      await updateProfilePicture();
      authUserStore.editUserData(authUserStore.loggedUser!.copyWith(
        firstName: result.firstName,
        lastName: result.lastName,
        userKey: result.userKey,
      ));
    }
  }

  Future<void> createUser() async {
    final res = await authService.registerUserMfa(
      phoneNumber: mfaContact$.value!.contactValue,
      challengeId: mfaContact$.value!.challengeId,
      firstName: firstName.value,
      lastName: lastName.value,
    );

    // userName.value =
    //     authUserStore.loggedUser!.username!.replaceAll(' ', '');

    final authUser = res.user;
    final token = res.auth?.token;
    if (authUser == null || token == null) {
      return;
    }

    authUserStore.loginPhone(user: authUser, token: token);
    await updateProfilePicture();
  }

  void extractFirstAndLastName() {
    final String? value = fullName.value;
    if (value == null || value.isEmpty) {
      // nameSubmitDisabled.value = true;
    }
    final names = value!.split(' ').toList();

    if (names.isNotEmpty) {
      firstName.value = names[0];
      names.removeAt(0);
      lastName.value = names.join(' ').trim();
    }
  }

  void onFullNameChanged(String? value) {
    fullName.value = value;
    extractFirstAndLastName();
  }

  void loadRecommended() {
    _onLoadUsers(FOLLOW_SUGGESTION_TYPE.FEATURED);
  }

  String recommendedCursor = '';

  Future<void> _onLoadUsers(FOLLOW_SUGGESTION_TYPE suggestionType,
      {QueryType queryType = QueryType.loadRemote}) async {
    await searchRepository.followSuggestions(
      suggestionType: suggestionType,
      cursor: recommendedCursor,
      queryType: queryType,
      callback: (data) => onSuccess(data, type: suggestionType),
      onError: onError,
    );
  }

  void onError(err) {
    debugPrint(err.toString());
    Get.snackbar('Error', 'Cannot load recommended users');
  }

  void onSuccess(dynamic data, {required FOLLOW_SUGGESTION_TYPE type}) {
    if (type == FOLLOW_SUGGESTION_TYPE.FEATURED) {
      recommendedList.assignAll(data);
    }
  }

  int offset = 0;

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
      userProfileImage$.value = byteData;
      fileUpload$.value = multiPartFile;
    });
  }

  void goToEnterUsername() {
    Get.toNamed(Paths.EnterUseremail);
  }
}
