import 'dart:async';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'post_input_controller.dart';

//TODO: Refactor this
// Change c to controller
class PostInputMediaRow extends StatelessWidget {
  const PostInputMediaRow({Key? key, required this.c, required this.isFullPage})
      : super(key: key);
  final PostInputController c;
  final bool isFullPage;

  Widget media(AppMedia appMedia) {
    Widget? mediaW;
    if (appMedia.appMediaType == APP_MEDIA_TYPE.PHOTO) {
      if (!appMedia.isEditing) {
        mediaW = AspectRatio(
          aspectRatio: 1,
          // child: Image.file(File(appMedia.path))
          child: Image.memory(appMedia.bytes!),
        );
      } else {
        mediaW = AspectRatio(
          aspectRatio: 1,
          // child: Image.file(File(appMedia.path))
          child: CachedNetworkImage(
              imageUrl: appMedia.url!,
              cacheManager: Get.find<IrisImageCacheManager>()),
        );
      }
    } else if (appMedia.appMediaType == APP_MEDIA_TYPE.GIFF) {
      mediaW = AspectRatio(
        aspectRatio: 4 / 3,
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
        height: isFullPage ? 250 : 80,
        child: mediaW,
      ),
      Positioned(
        right: 0,
        child: IconButton(
            icon: const Icon(Icons.cancel),
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

      final List<Widget> list = [];
      for (var pickedFile in c.mediaPickController.mediaList$) {
        list.add(media(pickedFile));
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: list,
      );
    });
  }
}

class ThumbnailRequest {
  final String? video;
  final String? thumbnailPath;
  final ImageFormat? imageFormat;
  final int? maxHeight;
  final int? maxWidth;
  final int? timeMs;
  final int? quality;

  const ThumbnailRequest(
      {this.video,
      this.thumbnailPath,
      this.imageFormat,
      this.maxHeight,
      this.maxWidth,
      this.timeMs,
      this.quality});
}

class ThumbnailResult {
  final Image? image;
  final int? dataSize;
  final int? height;
  final int? width;
  const ThumbnailResult({this.image, this.dataSize, this.height, this.width});
}

class GenThumbnailImage extends StatefulWidget {
  final ThumbnailRequest? thumbnailRequest;

  const GenThumbnailImage({Key? key, this.thumbnailRequest}) : super(key: key);

  @override
  _GenThumbnailImageState createState() => _GenThumbnailImageState();
}

Future<ThumbnailResult> genThumbnail(ThumbnailRequest r) async {
  //WidgetsFlutterBinding.ensureInitialized();
  Uint8List? bytes;
  final Completer<ThumbnailResult> completer = Completer();

  bytes = await VideoThumbnail.thumbnailData(
      video: r.video!,
      imageFormat: ImageFormat.JPEG,
      maxHeight: r.maxHeight!,
      maxWidth: r.maxWidth!,
      timeMs: r.timeMs!,
      quality: r.quality!);
  final image = Image.memory(bytes!);
  image.image
      .resolve(const ImageConfiguration())
      .addListener(ImageStreamListener((ImageInfo info, bool _) {
    completer.complete(ThumbnailResult(
      image: image,
    ));
  }));
  return completer.future;
}

class _GenThumbnailImageState extends State<GenThumbnailImage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThumbnailResult>(
      future: genThumbnail(widget.thumbnailRequest!),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final image = snapshot.data.image;
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                image,
              ]);
        } else if (snapshot.hasError) {
          return Container(
            color: Colors.red,
            child: Text(
              'Error:\n${snapshot.error.toString()}',
            ),
          );
        } else {
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                CircularProgressIndicator(),
              ]);
        }
      },
    );
  }
}
