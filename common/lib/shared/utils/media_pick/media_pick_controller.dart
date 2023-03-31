import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../iris_common.dart';

class MediaPickController extends GetxController {
  Rx<TextModel?>? text;

  final picker = ImagePicker();
  RxList<AppMedia> mediaList$ = <AppMedia>[].obs;

  RxBool isEdited$ = false.obs;
  Rx<AppMedia?> deletedMedia$ = Rx(null);

  MediaPickController({this.text}) {
    if (text?.value?.taggedGiffs != null &&
        text!.value!.taggedGiffs!.isNotEmpty) {
      final giffs = text!.value!.taggedGiffs!;
      AppMedia appMedia;
      for (var gif in giffs) {
        appMedia = AppMedia(
            appMediaType: APP_MEDIA_TYPE.GIFF,
            url: gif.url,
            giffId: gif.remoteId,
            isEditing: true,
            entityKey: gif.giffKey);
        mediaList$.assignAll([appMedia]);
      }
    }

    if (text?.value?.taggedFiles != null &&
        text!.value!.taggedFiles!.isNotEmpty) {
      final files = text!.value!.taggedFiles!;
      AppMedia appMedia;
      APP_MEDIA_TYPE mediaType;
      for (var file in files) {
        mediaType = APP_MEDIA_TYPE.PHOTO;
        if (file.fileType == FILE_TYPE.VIDEO) {
          mediaType = APP_MEDIA_TYPE.VIDEO;
        }
        appMedia = AppMedia(
            appMediaType: mediaType,
            url: file.url,
            isEditing: true,
            entityKey: file.fileKey);
        mediaList$.assignAll([appMedia]);
      }
    }
  }

  void addMedia(AppMedia appMedia) {
    if (mediaList$.isEmpty) {
      if (!isEdited$.value) {
        isEdited$.value = true;
        deletedMedia$.value = null;
      }
      mediaList$.assignAll([appMedia]);
      return;
    } else {
      final AppMedia originMedia = mediaList$[0];

      if (originMedia.isEditing) {
        isEdited$.value = true;
        deletedMedia$.value = originMedia;
      } else {
        isEdited$.value = false;
        deletedMedia$.value = null;
      }
      mediaList$.assignAll([appMedia]);
    }
  }

  Future<CroppedFile?> cropImage({required XFile imageFile}) async {
    return ImageCropper().cropImage(
      sourcePath: imageFile.path,
      // aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      compressFormat: ImageCompressFormat.jpg,
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: IrisColor.primaryColor,
          activeControlsWidgetColor: IrisColor.primaryColor,
          toolbarWidgetColor: Colors.white,
          statusBarColor: IrisColor.primaryColor,
          backgroundColor: Colors.white,
        ),
        IOSUiSettings(),
      ],
    );
  }

  Future<XFile?> getImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<PermissionStatus> getPermissions(Function func) async {
    final permission = GetPlatform.isAndroid
        ? await Permission.storage.request()
        : await Permission.photos.request();

    if (permission == PermissionStatus.granted ||
        permission == PermissionStatus.limited) {
      await func();
    }
    return permission;
  }

  Future<void> handleImage() async {
    try {
      final image = await getImage();
      if (image == null) {
        return;
      }
      final CroppedFile? croppedImage = await cropImage(imageFile: image);
      final Uint8List bytes = croppedImage != null
          ? await croppedImage.readAsBytes()
          : await image.readAsBytes();
      addMedia(AppMedia(
          appMediaType: APP_MEDIA_TYPE.PHOTO,
          path: croppedImage?.path,
          bytes: bytes));
    } catch (err) {
      debugPrint('err: $err');
    }
  }

  Future<void> handleVideo() async {
    final video = await picker.pickVideo(
        source: ImageSource.gallery, maxDuration: const Duration(minutes: 2));
    if (video == null) {
      return;
    }

    final bytes = await video.readAsBytes();
    addMedia(AppMedia(
        appMediaType: APP_MEDIA_TYPE.VIDEO, path: video.path, bytes: bytes));
  }

  Future<void> pickGiff() async {
    final gif = await GiphyPicker.pickGif(
      context: Get.context!,
      apiKey: ENV.GIPHY_API_KEY!,
      showPreviewPage: false,
      fullScreenDialog: true,
      decorator: GiphyDecorator(
        showAppBar: true,
        giphyTheme: ThemeData(
            primaryColor: IrisColor.primaryColor,
            backgroundColor: Get.theme.backgroundColor,
            scaffoldBackgroundColor: Get.theme.scaffoldBackgroundColor,
            inputDecorationTheme: InputDecorationTheme(
                fillColor: Get.context!.theme.backgroundColor,
                filled: true,
                hintStyle: TextStyle(color: Colors.grey.shade500),
                border: const OutlineInputBorder(borderRadius: kBorderRadius)),
            textTheme: TextTheme(
                subtitle1: TextStyle(
                    color: Get.context!.theme.colorScheme.secondary))),
      ),
      rating: GiphyRating.r,
    );
    if (gif != null) {
      addMedia(AppMedia(
          appMediaType: APP_MEDIA_TYPE.GIFF,
          url: gif.images.original!.url,
          giffId: gif.id));
    }
  }

  Future<void> pickMedia(Function func) async {
    final permission = await getPermissions(func);
    if (permission == PermissionStatus.granted) {
      return;
    } else if (permission == PermissionStatus.denied) {
      await Get.dialog(
        IrisDialog(
          title: 'Permission Required',
          subtitle:
              'Iris will need your permission to access photos and media on your device.',
          cancelButtonText: 'Deny',
          onCancel: () => Get.back(),
          confirmButtonText: 'Grant',
          onConfirm: () async {
            await getPermissions(func);
            Get.back();
          },
        ),
        barrierDismissible: true,
      );
    } else {
      await Get.dialog(
        IrisDialog(
          title: 'Permission Required',
          subtitle:
              'You have denied access to photos and media, you can go to settings and grant permission again.',
          onCancel: () => Get.back(),
          confirmButtonText: 'Settings',
          onConfirm: () {
            openAppSettings();
            Get.back();
          },
        ),
        barrierDismissible: true,
      );
    }
  }

  void removeMedia(AppMedia appMedia) {
    if (appMedia.isEditing) {
      isEdited$.value = true;
      deletedMedia$.value = appMedia;
    } else {
      isEdited$.value = false;
      deletedMedia$.value = null;
    }
    mediaList$.clear();
  }
}
