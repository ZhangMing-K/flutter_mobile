import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../routes/pages.dart';
import '../../../who_to_follow/widgets/explorer_header.dart';
import '../../controllers/stocks_controller.dart';

class TopMentionsView extends GetView<StocksController> {
  const TopMentionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        height: 270,
        child: Column(
          children: [
            const ExplorerHeader(text: 'Most Mentions'),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                addAutomaticKeepAlives: false,
                itemCount: controller.topMentions$.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return MostMentionCard(
                    tag: controller.topMentions$[index],
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}

class MostMentionCard extends StatelessWidget {
  const MostMentionCard({Key? key, required this.tag}) : super(key: key);
  final TagAnalysis tag;

  getColor(bool positive) {
    if (positive) {
      return IrisColor.positiveChange;
    } else {
      return IrisColor.negativeChange;
    }
  }

  Widget valueCell(String value,
      {required bool positive, double fontSize = 12}) {
    return Text(value,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: fontSize,
            color: getColor(positive),
            fontWeight: FontWeight.bold));
  }

  Widget cell(
      {Widget? contents,
      double? width,
      Alignment alignment = Alignment.centerLeft}) {
    return Container(
      width: width,
      alignment: alignment,
      child: contents,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Paths.Trending);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: kBorderRadius,
          color: context.theme.backgroundColor,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(10),
        width: ScreenUtil().setWidth(120),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppAssetImage(asset: tag.asset!, height: 50),
            const SizedBox(
              height: 4,
            ),
            Text(
              tag.symbol!,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            if (tag.asset?.historical?.returnPercentage != null)
              cell(
                  contents: valueCell(
                      '${tag.asset!.historical!.returnPercentage! >= 0 ? '+' : '-'}${tag.asset!.historical!.returnPercentage!.abs().formatPercentage()}',
                      positive: tag.asset!.historical!.returnPercentage! >= 0,
                      fontSize: 20),
                  width: Get.width / 5,
                  alignment: Alignment.centerLeft)
            else
              cell(
                  contents: const Text('-'),
                  width: Get.width / 5,
                  alignment: Alignment.centerLeft)
          ],
        ),
      ),
    );
  }
}
