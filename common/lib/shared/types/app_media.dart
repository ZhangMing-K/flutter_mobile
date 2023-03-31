import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../iris_common.dart';

enum APP_MEDIA_TYPE {
  GIFF,
  PHOTO,
  VIDEO,
}

class AppMedia {
  APP_MEDIA_TYPE appMediaType;
  String? path;
  String? url;
  String? giffId;
  Uint8List? bytes;
  bool isEditing;
  int? entityKey;
  AppMedia(
      {required this.appMediaType,
      this.path,
      this.url,
      this.giffId,
      this.bytes,
      this.entityKey,
      this.isEditing = false});
}

class CreateTextType {
  TEXT_TYPE? textType;
  int? parentKey;
  int? collectionKey;
  CreateTextType({
    this.textType,
    this.parentKey,
    this.collectionKey,
  });
}

class PostInputInfo {
  final RxList<AppMedia> mediaList;
  final TextEditingController? textEditingController;
  final Rx<TextModel?>? textModel;
  final bool isEdited;
  final AppMedia? deletedMedia;
  final CreateTextType? createTextType;
  final TEXT_TYPE textType;
  final Rx<TextModel?>? sharedText;
  PostInputInfo({
    required this.mediaList,
    required this.textEditingController,
    required this.textModel,
    required this.isEdited,
    required this.deletedMedia,
    required this.createTextType,
    required this.textType,
    this.sharedText,
  });
}

class ReturnTextInfo {
  TextModel? text;
  API_STATUS apiStatus;
  ReturnTextInfo({this.text, this.apiStatus = API_STATUS.NOT_STARTED});
}
