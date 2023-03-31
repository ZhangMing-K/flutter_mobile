import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../text_card_controller.dart';

class SharedTextArticle extends StatelessWidget {
  final TextModel? text;
  final TextCardController? c;
  final double pictureWidth = Get.width * .35;

  SharedTextArticle({
    Key? key,
    this.text,
  })  : c = TextCardController(text.obs),
        super(key: key);

  assetRow() {
    final asset = text!.article!.asset;
    if (asset == null) {
      return Container();
    }
    final String symbol = asset.symbol ?? '';
    // final String priceChange =
    //     asset.quote?.changePercent.formatPercentage() ?? '';
    return Builder(
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.only(
            bottom: 10,
          ),
          child: Row(
            children: [
              AppAssetImage(asset: asset),
              const SizedBox(
                width: 10,
              ),
              Text(
                symbol,
                style: TextStyle(
                    color: context.theme.colorScheme.secondary,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              DisplayPercent(
                percent: asset.quote!.changePercent,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
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
        padding: const EdgeInsets.only(left: 10, right: 0, top: 10, bottom: 0),
        // color: Colors.red,
        width: (Get.width * .60) - 25,
        height: pictureWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              child: assetRow(),
            ),
            AutoSizeText(
              text!.article!.headline!
                  .shortenLong(max: 180, trailingDots: true),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              minFontSize: 14,
              maxLines: 3,
            ),
            Flexible(
              child: Text(
                text!.article!.dateFrom,
                style: TextStyle(color: Colors.grey.shade400),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).backgroundColor,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onDoubleTap: () {},
        child: main(),
      ),
    );
  }

  Widget main() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: body(),
        ),
        picture(),
      ],
    );
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
                    image: CachedNetworkImageProvider(text!.article!.imageUrl!,
                        cacheManager: Get.find<IrisImageCacheManager>()),
                  )),
            ),
          )),
    );
  }

  route() async {
    final url = text!.article!.url!;

    UrlUtils.open(url);
  }
}
