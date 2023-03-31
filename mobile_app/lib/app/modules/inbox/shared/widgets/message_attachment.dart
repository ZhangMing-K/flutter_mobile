import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/text_card/video_controller.dart';

class MessageAttachment extends StatelessWidget {
  final TextModel text;
  final Widget? statRow;
  final bool isSender;
  const MessageAttachment(
      {Key? key, required this.text, this.statRow, required this.isSender})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [taggedFiles(), taggedGiffs()],
      ),
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
        topContainer: Container(),
        statContainer: statRow,
      );
    } else {
      return Container();
    }
  }

  int generateTag() {
    final rnd = Random();
    var next = rnd.nextDouble() * 1000000;
    while (next < 100000) {
      next *= 10;
    }
    return next.toInt();
  }

  Widget giffCard({required Giff giff}) {
    return image(giff.url!);
  }

  Widget image(String url) {
    Widget giphyBranding = const SizedBox.shrink();
    var isGiphy = false;
    if (url.contains('giphy.com/media/')) {
      isGiphy = true;
      giphyBranding = Builder(builder: (context) {
        return Container(
            decoration: BoxDecoration(
                color: !isSender
                    ? context.isDarkMode
                        ? Colors.grey[900]!
                        : const Color(0xffdfdfdf)
                    : IrisColor.primaryColor,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Image.asset(
                    Images.giphyBranding,
                    height: 10,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
              ])
            ]));
      });
    }
    final tag = generateTag().toString();
    return Column(children: [
      FullScreenWidget(
        url: url,
        tag: tag,
        child: Hero(
            tag: tag,
            child: Builder(builder: (context) {
              return Container(
                  padding: const EdgeInsets.all(1),
                  constraints: BoxConstraints(
                      maxHeight:
                          isGiphy ? double.infinity : context.height / 2 - 50),
                  decoration: BoxDecoration(
                      // color: Colors.grey[500]!,
                      borderRadius: isGiphy
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))
                          : BorderRadius.circular(10)),
                  child: ClipRRect(
                      borderRadius: isGiphy
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))
                          : BorderRadius.circular(10),
                      child: CachedNetworkImage(
                          imageUrl: url,
                          cacheManager: Get.find<IrisImageCacheManager>())));
            })),
      ),
      if (isGiphy) giphyBranding,
    ]);
  }

  taggedFiles() {
    if (text.taggedFiles == null || text.taggedFiles!.isEmpty) {
      return Container();
    }

    return fileCard(file: text.taggedFiles![0]);
  }

  taggedGiffs() {
    if (text.taggedGiffs == null || text.taggedGiffs!.isEmpty) {
      return Container();
    }
    return giffCard(giff: text.taggedGiffs![0]);
  }
}
