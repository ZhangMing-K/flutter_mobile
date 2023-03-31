import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/feed/modules/posts/controllers/posts_controller.dart';

class FilterButton extends GetView<PostsController> {
  const FilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaleFactor = context.textScaleFactor;
    return Obx(
      () {
        return Container(
            height: 40 * scaleFactor,
            margin: const EdgeInsets.only(top: 0),
            child: ListView(
                shrinkWrap: true,
                primary: false,
                addAutomaticKeepAlives: false,
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 9),
                  FilterButtonItem(
                    onTap: () {
                      controller
                          .onClickFilterButton(PUBLIC_FEED_CATEGORY.INVESTORS);
                    },
                    isSelected: controller.currentFilter.value ==
                        PUBLIC_FEED_CATEGORY.INVESTORS,
                    title: 'Investors',
                  ),
                  FilterButtonItem(
                    onTap: () {
                      controller
                          .onClickFilterButton(PUBLIC_FEED_CATEGORY.TOP_TRADES);
                    },
                    isSelected: controller.currentFilter.value ==
                        PUBLIC_FEED_CATEGORY.TOP_TRADES,
                    title: 'Top Trades',
                  ),
                  FilterButtonItem(
                    onTap: () {
                      controller
                          .onClickFilterButton(PUBLIC_FEED_CATEGORY.TRENDING);
                    },
                    isSelected: controller.currentFilter.value ==
                        PUBLIC_FEED_CATEGORY.TRENDING,
                    title: 'Trending',
                  ),
                  // FilterButtonItem(
                  //   onTap: () {
                  //     controller.onClickFilterButton(
                  //         PUBLIC_FEED_CATEGORY.DUE_DILIGENCE);
                  //   },
                  //   isSelected: !controller.isOrderFlow.value &&
                  //       controller.currentFilter.value ==
                  //           PUBLIC_FEED_CATEGORY.DUE_DILIGENCE,
                  //   title: 'Trade Ideas',
                  // ),
                  FilterButtonItem(
                    onTap: () {
                      controller
                          .onClickFilterButton(PUBLIC_FEED_CATEGORY.ORDER_FLOW);
                    },
                    isSelected: controller.currentFilter.value ==
                        PUBLIC_FEED_CATEGORY.ORDER_FLOW,
                    title: 'Order Flow',
                  ),
                  const SizedBox(width: 8),
                ]));
      },
    );
  }
}

class FilterButtonItem extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final String title;

  const FilterButtonItem(
      {Key? key,
      required this.onTap,
      required this.isSelected,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
              color: isSelected
                  ? context.theme.backgroundColor
                  : context.theme.scaffoldBackgroundColor,
              border: Border.all(
                color: isSelected
                    ? context.theme.backgroundColor
                    : context.theme.colorScheme.secondary.withOpacity(0.5),
                width: 1,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(100))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: IrisScreenUtil.dFontSize(16),
                      fontWeight: FontWeight.w400))
            ],
          )),
    );
  }
}
