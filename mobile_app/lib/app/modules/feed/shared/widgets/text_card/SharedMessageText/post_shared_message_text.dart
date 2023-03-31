import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/widgets/app_easy_rich_text/index.dart';

import '../text_card_controller.dart';
import '../video_controller.dart';

class SharedTextPost extends StatelessWidget {
  final TextModel? text;
  final String showMoreTag =
      ' ... <C {"type":"showMore","value":"see"}>SEE</C>';
  final maxLength = 200;
  final TextCardController controller;

  SharedTextPost({
    Key? key,
    required this.text,
  })  : controller = TextCardController(text.obs),
        super(key: key);

  String? get cutText => RichEditTextUtils.getCutText(text!.value!, maxLength);

  bool get hasUser {
    if (text!.user != null) {
      return true;
    }
    return false;
  }

  bool get hasValue {
    if (text!.value != null) {
      return true;
    }
    return false;
  }

  bool get isShowMore =>
      RichEditTextUtils.needShowMore(text!.value, maxLength) ?? false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        toTextScreen();
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: hasUser && hasValue
                ? Theme.of(context).backgroundColor
                : Colors.transparent,
          ),
          child: hasUser
              ? hasValue
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [firstRow(), gestureArea()],
                    )
                  : const Text('Post has been deleted ...')
              : const Text('User not found ...')),
    );
  }

  Widget content() {
    final TextModel post = text!;
    if (post.value == null) {
      return Container();
    }
    double fontSize = 15;
    if (post.value!.length < 80) {
      fontSize = 20;
    }
    return StatefulBuilder(
        builder: (context, update) => Container(
            margin: const EdgeInsets.only(left: 10, right: 5, bottom: 10),
            child: RichTextEditor(
              originalText: post.value,
              text: isShowMore ? cutText! + showMoreTag : post.value,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w300,
                color: context.theme.colorScheme.secondary,
              ),
            )));
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

  Widget fileCard({required FileModel file}) {
    if (file.fileType == FILE_TYPE.IMAGE) {
      return image(file.url!);
    } else if (file.fileType == FILE_TYPE.VIDEO && file.url != null) {
      return ChewiePlayer(
        url: file.url!,
        showBottom: false,
        text: text,
        textCardController: controller,
      );
    } else {
      return Container();
    }
  }

  Widget firstRow({showTrailing = true}) {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 0, top: 10, bottom: 10),
        child: Row(
          children: [
            ProfileImage(
              onTap: () {
                toTextScreen();
              },
              radius: 25,
              url: text!.user?.profilePictureUrl,
              uuid: uuid.v4(),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  toTextScreen();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserName(
                          user: text!.user,
                          fontWeight: FontWeight.w500,
                          route: false,
                          fontSize: 15),
                      Row(
                        children: [
                          featured(),
                          Builder(builder: (context) {
                            return Text(
                              text!.dateFrom,
                              style: TextStyle(
                                fontSize: 12,
                                color: showTrailing
                                    ? context.theme.colorScheme.secondary
                                    : context.theme.backgroundColor,
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (showTrailing) trailing(),
          ],
        ));
  }

  int generateTag() {
    final rnd = Random();
    var next = rnd.nextDouble() * 1000000;
    while (next < 100000) {
      next *= 10;
    }
    return next.toInt();
  }

  Widget gestureArea() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // onDoubleTap: onDoubleTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          content(),
          taggedFiles(),
          taggedGiffs(),
        ],
      ),
    );
  }

  Widget giffCard({required Giff giff}) {
    return image(giff.url!);
  }

  Widget image(String url) {
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
    final tag = generateTag().toString();
    return Column(children: [
      FullScreenWidget(
        url: url,
        tag: tag,
        child: Center(
          child: Hero(
              tag: tag,
              child: CachedNetworkImage(
                  imageUrl: url,
                  cacheManager: Get.find<IrisImageCacheManager>())),
        ),
      ),
      if (isGiphy) giphyBranding,
      const SizedBox(
        height: 10,
      ),
    ]);
  }

  Widget taggedFiles() {
    if (text?.taggedFiles == null || text!.taggedFiles!.isEmpty) {
      return Container();
    }

    return fileCard(file: text!.taggedFiles![0]);
  }

  Widget taggedGiffs() {
    if (text?.taggedGiffs == null || text!.taggedGiffs!.isEmpty) {
      return Container();
    }
    return giffCard(giff: text!.taggedGiffs![0]);
  }

  void toTextScreen() {
    Get.toNamed(Paths.Text.createPath([text!.textKey]),
        arguments: TextScreenArgs(text: text!.obs), id: 1);
  }

  Widget trailing() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            toTextScreen();
          },
          child: SizedBox(
              height: 30,
              width: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                ],
              )),
        )
      ],
    );
  }
}
