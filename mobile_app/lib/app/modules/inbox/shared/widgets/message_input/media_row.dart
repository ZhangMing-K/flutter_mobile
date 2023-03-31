import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'message_input_controller.dart';
import 'thumbnail_image.dart';

//TODO: refactor c to controller
class PostInputMediaRow extends StatelessWidget {
  const PostInputMediaRow({Key? key, required this.c}) : super(key: key);
  final MessageInputController c;

  Widget media(AppMedia appMedia) {
    Widget? mediaW;
    if (appMedia.appMediaType == APP_MEDIA_TYPE.PHOTO) {
      if (!appMedia.isEditing) {
        mediaW = AspectRatio(
          aspectRatio: 1,
          // child: Image.file(File(appMedia.path))
          child: Image.memory(
            appMedia.bytes!,
            height: 100,
            fit: BoxFit.cover,
          ),
        );
      } else {
        mediaW = AspectRatio(
          aspectRatio: 1,
          // child: Image.file(File(appMedia.path))
          child: CachedNetworkImage(
              imageUrl: appMedia.url!,
              height: 100,
              cacheManager: Get.find<IrisImageCacheManager>()),
        );
      }
    } else if (appMedia.appMediaType == APP_MEDIA_TYPE.GIFF) {
      mediaW = AspectRatio(
        aspectRatio: 1,
        child: Image.network(
          appMedia.url!,
          height: 100,
          fit: BoxFit.fill,
        ),
      );
    } else if (appMedia.appMediaType == APP_MEDIA_TYPE.VIDEO) {
      final videoPath = appMedia.isEditing ? appMedia.url : appMedia.path;
      final GenThumbnailImage thumbnail = GenThumbnailImage(
          thumbnailRequest: ThumbnailRequest(
              video: videoPath,
              thumbnailPath: null,
              maxHeight: 64,
              maxWidth: 128,
              timeMs: 0,
              quality: 100));
      mediaW = AspectRatio(aspectRatio: 1, child: thumbnail);
    }

    return Stack(children: [
      SizedBox(
        height: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: mediaW,
        ),
      ),
      Positioned(
        right: -10,
        top: -10,
        child: IconButton(
            icon: const Icon(Icons.cancel),
            color: Colors.red,
            onPressed: () {
              c.mediaPickController.removeMedia(appMedia);
            }),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (c.mediaPickController.mediaList$.isEmpty) {
        return Container();
      }
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: c.mediaPickController.mediaList$.map(media).toList(),
          ));
    });
  }
}
