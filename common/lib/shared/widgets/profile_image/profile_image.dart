import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/consts/images.dart';
import '../../../data/providers/local/storage/iris_image_cache_manager.dart';
import 'profile_full_screen.dart';

class ProfileImage extends StatefulWidget {
  final String? url;
  final double radius;
  final VoidCallback? onTap;
  final bool showFullScreen;
  final String uuid;
  // final bool hasHero;
  final bool networkImage;
  const ProfileImage({
    Key? key,
    required this.url,
    this.radius = 20,
    this.onTap,
    this.showFullScreen = false,
    required this.uuid,
    // this.hasHero = true,
    this.networkImage = true,
  }) : super(key: key);

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  // ImageProvider? imageProvider;

  bool get isInvalidUrl =>
      widget.url == null ||
      widget.url ==
          'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y';

  @override
  Widget build(BuildContext context) {
    // if (imageProvider != null) {
    //   imageProvider!.evict();
    // }

    Widget avatar = Visibility(
      visible: isInvalidUrl,
      replacement: CircleAvatar(
        backgroundImage: isInvalidUrl
            ? const AssetImage(
                Images.defaultProfileImage,
                // cacheRawData: true,
              )
            : widget.networkImage
                ? CachedNetworkImageProvider(
                    widget.url!,
                    cacheManager: Get.find<IrisImageCacheManager>(),
                  )
                : Image.asset(
                    widget.url!,
                    height: 300,
                    width: 300,
                  ).image,
        radius: widget.radius,
        backgroundColor: Colors.transparent,
      ),
      child: CircleAvatar(
        radius: widget.radius,
        backgroundColor: Colors.transparent,
        child: Image.asset(
          Images.defaultProfileImage,
          height: 300,
          width: 300,
        ),
      ),
    );
    if (widget.showFullScreen) {
      return ProfileFullScreenWidget(
        imageProvider: getImageProvider(),
        tag: widget.uuid,
        child: Center(
          child: avatar,
        ),
      );
    }
    return Material(
      child: InkWell(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap?.call();
          }
        },
        child: avatar,
      ),
    );
  }

  @override
  dispose() {
    super.dispose();
  }

  // BoxDecoration get decoration {
  //   if (widget.hasUnSeenStories)
  //     return BoxDecoration(
  //       shape: BoxShape.circle,
  //       border: Border.all(
  //         color: IrisColor.primaryColor,
  //         width: 3.0,
  //       ),
  //     );
  //   return BoxDecoration();
  // }

  ImageProvider getImageProvider() {
    if (isInvalidUrl) {
      return const AssetImage(
        Images.defaultProfileImage,
        // cacheRawData: true,
      );
    } else {
      return CachedNetworkImageProvider(
        widget.url!,
        cacheManager: Get.find<IrisImageCacheManager>(),
      );
    }
  }
}
