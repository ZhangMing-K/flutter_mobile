import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/widgets/app_easy_rich_text/index.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/text_card/shared_text_header.dart';

import 'text_card.dart';
import 'text_card_controller.dart';
import 'video_controller.dart';

class PostText extends StatelessWidget {
  final TextModel? text;
  final TextCardController controller;
  final String showMoreTag =
      ' ... <C {"type":"showMore","value":"see"}>SEE</C>';
  final Widget? statRow;
  final VoidCallback onDoubleTap;
  final VoidCallback showMore;
  final TEXT_CARD_DISPLAY_TYPE textCardDisplayType;
  final VoidCallback? onFollowTapped;

  const PostText(
      {Key? key,
      required this.text,
      required this.controller,
      required this.showMore,
      this.statRow,
      required this.onDoubleTap,
      required this.onFollowTapped,
      this.textCardDisplayType = TEXT_CARD_DISPLAY_TYPE.SUMMARY})
      : super(key: key);

  bool get hasMedia {
    if (text?.taggedFiles != null && text!.taggedFiles!.isNotEmpty) {
      return true;
    } else if (text?.taggedGiffs != null && text!.taggedGiffs!.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final id = uuid.v4();
    if (textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.IMAGE_SHARE) {
      return FittedBox(
        fit: BoxFit.contain,
        alignment: Alignment.center,
        child: SizedBox.square(
          dimension: 414,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SharedTextHeader(text: text!),
              content(),
              if (text?.taggedFiles != null && text!.taggedFiles!.isNotEmpty)
                Flexible(child: Center(child: taggedFiles(id: id))),
              if (text?.taggedGiffs != null && text!.taggedGiffs!.isNotEmpty)
                Flexible(child: Center(child: taggedGiffs(id: id))),
            ],
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        firstRow(),
        gestureArea(id: id),
      ],
    );
  }

  Widget content() {
    final TextModel post = controller.text$!.value!;
    double fontSize = 15;
    if (post.value == null) {
      fontSize = 20;
    } else {
      if (post.value!.length < 50) {
        fontSize = 20;
      }
    }
    double bottomMargin = 10;
    double topMargin = 0;

    if (!hasMedia) {
      bottomMargin = 10;
      topMargin = 10;
    } else {
      fontSize = 15;
    }
    return Builder(
      builder: (context) => Container(
        margin: EdgeInsets.only(
            left: 16, right: 16, bottom: bottomMargin, top: topMargin),
        child: RichTextEditor(
          originalText: post.value,
          text: controller.isShowMore
              ? controller.cutText! + showMoreTag
              : post.value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w300,
            color: context.theme.colorScheme.secondary,
          ),
          showMore: showMore,
        ),
      ),
    );
  }

  Widget featured() {
    if (text!.featuredAt == null) {
      return Container();
    }
    return Row(
      children: const [
        Icon(
          Icons.star,
          size: 15,
          color: IrisColor.gold,
        ),
        SizedBox(
          width: 3,
        ),
      ],
    );
  }

  Widget fileCard({required FileModel file, required String id}) {
    if (file.fileType == FILE_TYPE.IMAGE) {
      return image(url: file.url!, id: id);
    } else if (file.fileType == FILE_TYPE.VIDEO && file.url != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: ChewiePlayer(
          url: file.url!,
          showBottom: false,
          text: text,
          textCardController: controller,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget firstRow() {
    final avatarHeroId = uuid.v4();
    return Builder(builder: (context) {
      return Container(
          margin: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 24,
          ),
          child: Row(
            children: [
              UserImage(
                id: avatarHeroId,
                radius: 25,
                user: text!.user!,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: UserName(
                                shrinkText: false,
                                heroTag: avatarHeroId,
                                user: text!.user,
                                fontWeight: FontWeight.w500,
                                maxLength:
                                    (18 / context.textScaleFactor).round(),
                                fontSize: 15),
                          ),
                          followText(),
                        ],
                      ),
                      Row(
                        children: [
                          featured(),
                          Text(
                            text!.dateFromAbb,
                            style: const TextStyle(
                                fontSize: 12, color: IrisColor.dateFromColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              trailing(),
            ],
          ));
    });
  }

  followText() {
    if (text!.user?.authUserFollowInfo?.followStatus ==
        FOLLOW_STATUS.NOT_FOLLOWING) {
      return Row(
        children: [
          const Text('   •'),
          TextButton(
            style: ButtonStyle(
              //reduce padding and minimum size to prevent larger than intended size
              padding: MaterialStateProperty.resolveWith(
                (states) => const EdgeInsets.only(left: 12),
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize:
                  MaterialStateProperty.resolveWith((states) => Size.zero),
            ),
            child: const Text('Follow'),
            onPressed: () {
              controller.followUser();
              onFollowTapped?.call();
            },
          ),
        ],
      );
    }
    return Container();
  }

  Widget gestureArea({required String id}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onDoubleTap: onDoubleTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
            // vertical: 2,
            ),
        // color: Colors.red,R
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            content(),
            taggedFiles(id: id),
            taggedGiffs(id: id),
          ],
        ),
      ),
    );
  }

  Widget image({required String url, required String id}) {
    Widget giphyBranding = const SizedBox.shrink();
    var isGiphy = false;
    if (url.contains('giphy.com/media/')) {
      isGiphy = true;
      giphyBranding = Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 2),
            child: Image.asset(
              Images.giphyBranding,
              height: 10,
            ),
          )
        ])
      ]);
    }

    return Column(children: [
      Builder(builder: (context) {
        final screenWidth = context.width;
        return FullScreenWidget(
          tag: id,
          url: url,
          child: Hero(
            tag: id,
            flightShuttleBuilder: (flightContext, animation, flightDirection,
                fromHeroContext, toHeroContext) {
              return CachedNetworkImage(
                imageUrl: url,
                cacheManager: Get.find<IrisImageCacheManager>(),
                imageBuilder: (context, imageProvider) => Image(
                  image: imageProvider,
                  fit: BoxFit.fitWidth,
                ),
              );
            },
            child: CachedNetworkImage(
              imageUrl: url,
              cacheManager: Get.find<IrisImageCacheManager>(),
              imageBuilder: (_, imageProvider) {
                var isTall = false;
                double height = 500;
                imageProvider.resolve(const ImageConfiguration()).addListener(
                  ImageStreamListener(
                    (ImageInfo imageInfo, bool synchronousCall) {
                      final myImage = imageInfo.image;
                      height = screenWidth;
                      Size size = Size(
                          myImage.width.toDouble(), myImage.height.toDouble());
                      if (size.aspectRatio < 1) {
                        isTall = true;
                      }
                    },
                  ),
                );

                return Image(
                  image: imageProvider,
                  height: isTall ? height : null,
                  width: isTall ? double.infinity : null,
                  fit: BoxFit.fitWidth,
                );
              },
            ),
          ),
        );
      }),
      if (isGiphy) giphyBranding,
    ]);
  }

  Widget taggedFiles({required String id}) {
    if (text?.taggedFiles == null || text!.taggedFiles!.isEmpty) {
      return Container();
    } else if (textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.IMAGE_SHARE) {
      return CachedNetworkImage(
        imageUrl: text!.taggedFiles![0].url!,
        cacheManager: Get.find<IrisImageCacheManager>(),
        imageBuilder: (context, imageProvider) => Image(
          image: imageProvider,
          fit: BoxFit.fitWidth,
        ),
      );
    }
    return fileCard(file: text!.taggedFiles![0], id: id);
  }

  Widget taggedGiffs({required String id}) {
    if (text?.taggedGiffs == null || text!.taggedGiffs!.isEmpty) {
      return Container();
    }
    return image(url: text!.taggedGiffs![0].url!, id: id);
  }

  trailing() {
    if (textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.STORY) {
      return Container();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: controller.tapTrailing,
          child: SizedBox(
              height: 30,
              width: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.more_horiz,
                    color: Colors.grey,
                  ),
                ],
              )),
        )
      ],
    );
  }
}
