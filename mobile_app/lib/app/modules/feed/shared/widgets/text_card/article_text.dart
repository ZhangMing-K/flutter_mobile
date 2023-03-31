import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class ArticleText extends StatelessWidget {
  ArticleText({
    Key? key,
    this.text,
    this.assetFromArg,
    required this.onDoubleTap,
  }) : super(key: key);
  final TextModel? text;
  final Asset? assetFromArg;

  final double pictureWidth = Get.width * .35;
  final Function() onDoubleTap;

  route() async {
    final url = text!.article!.url!;

    UrlUtils.open(url);
  }

  picture() {
    return InkWell(
      onTap: route,
      child: Container(
          height: pictureWidth,
          width: pictureWidth,
          // padding: EdgeInsets.only(top:10),
          margin: const EdgeInsets.only(top: 12, bottom: 12, right: 15),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    onError: (err, stack) {},
                    fit: BoxFit.cover,
                    alignment: FractionalOffset.topCenter,
                    image: CachedNetworkImageProvider(
                        text!.article!.thumbnailImageUrl ??
                            text!.article!.imageUrl!,
                        cacheManager: Get.find<IrisImageCacheManager>()),
                  )),
            ),
          )),
    );
  }

  assetRow() {
    final asset = assetFromArg ?? text!.article!.asset;
    if (asset == null || asset.assetKey == null) {
      return Container();
    }
    return Builder(
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.only(
            left: 16,
            right: 8,
            top: 16,
            bottom: 16,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppAssetImage(
                    asset: asset,
                    height: 40,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(asset.symbol!,
                          style: const TextStyle(
                            fontSize: 16,
                          )),
                      Text(asset.name!,
                          style: TextStyle(
                              fontSize: 14,
                              color: context.theme.colorScheme.secondary
                                  .withOpacity(0.5))),
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        asset.quote!.latestPrice.formatCurrency(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      DisplayPercent(
                        percent: asset.quote!.changePercent,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget body() {
    return InkWell(
      onTap: route,
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 0, top: 10, bottom: 0),
        width: (Get.width * .60) - 25,
        height: pictureWidth + 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text!.article!.headline!
                  .shortenLong(max: 200, trailingDots: true),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              maxLines: 3,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Text(source),
            )
          ],
        ),
      ),
    );
  }

  String get source {
    final source = text!.article?.source ?? '';
    final dateFrom = text!.article?.dateFrom ?? '';
    return source + ' - ' + dateFrom;
  }

  Widget main() {
    return Column(
      children: [
        assetRow(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: body(),
            ),
            picture(),
          ],
        ),
      ],
    );
  }

  @override
  build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onDoubleTap: onDoubleTap,
        child: main(),
      ),
    ]);
  }
}
