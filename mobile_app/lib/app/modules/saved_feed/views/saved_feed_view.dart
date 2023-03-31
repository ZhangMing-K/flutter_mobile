import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/text_card/text_card.dart';

import '../../../routes/pages.dart';
import '../controllers/saved_feed_controller.dart';

class SavedFeedMobile extends GetWidget<SavedFeedController> {
  const SavedFeedMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        title: 'Saved Posts',
      ),
      body: Container(child: main(context)),
    );
  }

  Widget empty(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
                child: Text('Oops, Nothing to see here.',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            const SizedBox(height: 10),
            Text(
              'Looks like you haven\'t saved any posts yet. Click the bookmark on the bottom right of any post, order or article to save it here.',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: context.theme.colorScheme.secondary.withOpacity(0.8)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                    side: MaterialStateProperty.all(BorderSide(
                        width: 2.0, color: context.theme.backgroundColor)),
                    backgroundColor: MaterialStateProperty.all(
                        context.theme.scaffoldBackgroundColor)),
                child: Text(
                  'Home feed',
                  style: TextStyle(
                      fontSize: 19, color: context.theme.colorScheme.secondary),
                ),
                onPressed: () {
                  Get.until((route) => route.settings.name == Paths.Feed);
                },
              ),
            )
          ],
        ));
  }

  Widget main(BuildContext context) {
    return controller.obx(
      (state) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            IrisListView(
              onRefresh: controller.pullRefresh,
              itemCount: state!.length,
              widgetLoader: const ShimmerScroll(),
              loadMore: controller.loadMore,
              builder: (BuildContext context, int index) {
                return Column(
                  children: [
                    TextCard(
                      text: state[index],
                      showHint: true,
                    ),
                    Divider(
                      color: context.theme.backgroundColor,
                      thickness: 4,
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
      onEmpty: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [empty(context)]),
      onLoading: const ShimmerScroll(),
    );
  }
}
