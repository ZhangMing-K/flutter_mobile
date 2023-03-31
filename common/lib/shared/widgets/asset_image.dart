import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class AppAssetImage extends StatelessWidget {
  const AppAssetImage({
    Key? key,
    required this.asset,
    this.height = 40,
    this.onTap,
    this.showStories = true,
    this.afterStories, // function to be called after watching stories
    this.onTapIfNoStories, // custom function to be called for asset image
    this.symbol,
    this.shouldResize = true,
    this.shouldAnimate = true,
  }) : super(key: key);
  final Asset? asset;
  final double height;
  final String? symbol;
  final VoidCallback? onTap;
  final VoidCallback? afterStories;
  final VoidCallback? onTapIfNoStories;
  final bool? showStories;
  final bool? shouldResize;
  final bool? shouldAnimate;

  double get baseRingNumber {
    return height / 20;
  }

  Color get gradientColor {
    if (hasStories && hasUnseenStories) {
      // return const Color(0xffFF01FF);
      return const Color(0xffFFAF44);
    } else {
      return lightenColor(Colors.grey.shade900, .3);
    }
  }

  Color get ringColor {
    if (hasStories && hasUnseenStories) {
      // return const Color(0xff00CDFD);
      return const Color(0xffE60066);
    } else {
      return Colors.grey;
    }
  }

  EdgeInsets get innerPadding {
    return EdgeInsets.zero;
    // Uncomment to bring stories back
    // final double padding = getInnerPadding(height,
    //     isAsset: true, hasUnseenStories: hasUnseenStories);
    // return EdgeInsets.all(padding);
  }

  EdgeInsets get outerPadding {
    return EdgeInsets.zero;
    // Uncomment to bring stories back
    // final double padding = getOuterPadding(height,
    //     isAsset: true, hasUnseenStories: hasUnseenStories);
    // return EdgeInsets.all(padding);
  }

  // ignore: non_constant_identifier_names
  bool get hasStories {
    final storyConnection = asset?.storiesConnection;
    if (storyConnection == null) return false;
    final metadata = storyConnection.metaData?.areStories;
    if (metadata == null) return false;
    return metadata;
  }

  bool get hasUnseenStories {
    final storyConnection = asset?.storiesConnection;
    if (storyConnection == null) return false;
    final metadata = storyConnection.metaData?.areUnseenStories;
    if (metadata == null) return false;
    return metadata;
  }

  BoxDecoration kGradientBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          gradientColor,
          ringColor,
        ],
        stops: const [0.0, .7],
      ),
      color: Colors.black,
      shape: BoxShape.rectangle,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    );
  }

  BoxDecoration kInnerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.isDarkMode ? Colors.black : Colors.white,
      shape: BoxShape.rectangle,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    );
  }

  Widget image(double radius, BuildContext context) {
    String? url = asset?.pictureUrl;
    if (asset?.pictureUrl == null) {
      url = 'http://via.placeholder.com/150?text=$symbol';
    }
    const BoxFit fit = BoxFit.fill;
    return Material(
      child: InkWell(
          onTap: () {
            if (onTap != null) {
              onTap!();
            } else {
              if (hasStories == false && onTapIfNoStories != null) {
                onTapIfNoStories!();
              } else {
                //  asset!.routeToFromAssetImage(showStories!, afterStories);
              }
            }
          },
          child: CachedNetworkImage(
            imageUrl: url!,
            fit: fit,
            height: shouldResize! ? radius * context.textScaleFactor : radius,
            width: shouldResize! ? radius * context.textScaleFactor : radius,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                shape: BoxShape.rectangle,
              ),
            ),
            cacheManager: Get.find<IrisImageCacheManager>(),
            placeholder: (context, url) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300)),
            errorWidget: (context, url, error) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300)),
          )),
    );
  }

  Widget storyAsset() {
    return Builder(builder: (context) {
      return Container(
        child: Padding(
          padding: outerPadding,
          child: Container(
            child: image(height - baseRingNumber, context),
            padding: innerPadding,
            decoration: kInnerDecoration(context),
          ),
        ),
        decoration: kGradientBoxDecoration(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (hasStories && showStories!) {
      return storyAsset();
    } else {
      return Container(
        padding: outerPadding,
        decoration: BoxDecoration(
          color: Colors.grey.shade700,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Container(
          child: image(height - baseRingNumber, context),
          padding: innerPadding,
          decoration: BoxDecoration(
            color: context.isDarkMode ? Colors.grey.shade700 : Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      );
    }
  }
}
