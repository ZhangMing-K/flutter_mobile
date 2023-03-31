import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:iris_common/iris_common.dart';

class GroupChangeInfoController extends GetxController {
  Collection? collection;

  ///TODO: MOVE TO BINDINGS
  final AuthService authService = Get.find();

  final CollectionService collectionService = Get.find();
  MediaPickController mediaPickController = MediaPickController();
  RxBool isSaving = false.obs;

  String groupName = '';

  Rx<http.MultipartFile?> fileUpload$ = Rx(null); // image picker
  Rx<Uint8List?> groupAvatar$ = Rx(null); // group chat picture
  GroupChangeInfoController({required this.collection}); // image widget to show

  onTapUpdateInfo(String groupName) async {
    final int? collectionKey = collection!.collectionKey;
    isSaving.value = true;
    await collectionService.updateGroupInfo(
        collectionKey, groupName, fileUpload$.value);
    isSaving.value = false;
  }

  pickImage() async {
    mediaPickController.pickMedia(() async {
      final image = await mediaPickController.getImage();
      if (image == null) {
        return;
      }
      final croppedImage =
          await mediaPickController.cropImage(imageFile: image);

      final Uint8List bytes = croppedImage != null
          ? await croppedImage.readAsBytes()
          : await image.readAsBytes();

      final http.MultipartFile multiPartFile = http.MultipartFile.fromBytes(
        'photo',
        bytes,
        filename: '${DateTime.now().second}.jpg',
        contentType: MediaType('image', 'jpg'),
      );
      groupAvatar$.value = bytes;
      fileUpload$.value = multiPartFile;
    });
  }
}
