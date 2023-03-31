import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenViewWrapper extends StatelessWidget {
  const FullScreenViewWrapper({Key? key, this.imageUrl}) : super(key: key);

  final String? imageUrl;
  back() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails data) {
        final d = data.delta;
        if (d.dy > 2.8 || d.dy < -2.8) {
          back();
        }
      },
      child: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Center(
          child: CachedNetworkImage(
            imageUrl: imageUrl!,
            cacheManager: Get.find<IrisImageCacheManager>(),
            imageBuilder: (context, imageProvider) => PhotoView(
              imageProvider: imageProvider,
              initialScale: PhotoViewComputedScale.contained,
              backgroundDecoration:
                  const BoxDecoration(color: Colors.transparent),
              heroAttributes: const PhotoViewHeroAttributes(tag: 'hero'),
            ),
          ),
        ),
      ),
    );
  }
}
