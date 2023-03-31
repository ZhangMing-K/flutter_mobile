import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/text_card/text_card.dart';

import '../controllers/focused_feed_controller.dart';

class FocusedFeedMobile extends GetWidget<FocusedFeedController> {
  const FocusedFeedMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        title: 'Orders',
      ),
      body: controller.obx(
        (state) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              IrisListView(
                key: controller.listviewController,
                onRefresh: controller.pullRefresh,
                itemCount: state!.length,
                widgetLoader: const IrisLoading(),
                loadMore: controller.loadMore,
                builder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      TextCard(
                        text: state[index],
                      ),
                      Divider(
                        color: context.theme.backgroundColor,
                        thickness: 4,
                        height: 4,
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        },
        onEmpty: empty(context),
        onLoading: const IrisLoading(),
      ),
    );
  }

  empty(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 20, right: 12, left: 12),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              IrisEmpty(emptyText: 'Orders not found'),
            ]));
  }

  snoozeButton(BuildContext context) {
    return StatefulBuilder(builder: (_, update) {
      return IrisBounceButton(
          duration: const Duration(milliseconds: 100),
          onPressed: () {
            HapticFeedback.lightImpact();
            controller.setSnooze(update);
          },
          child: (!controller.hasTradeNotifications)
              ? AbsorbPointer(
                  absorbing: true,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          IrisColor.imessagePurple),
                    ),
                    onPressed: () => debugPrint('dsfsf'),
                    child: Row(children: [
                      SvgPicture.asset(
                        IconPath.snooze,
                        height: 12,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Snoozed all trades',
                        style: TextStyle(
                            fontSize: 12,
                            color: context.theme.colorScheme.secondary),
                      )
                    ]),
                  ))
              : AbsorbPointer(
                  child: ElevatedButton(
                      onPressed: () => debugPrint('dsfsf'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            context.theme.backgroundColor),
                      ),
                      child: Row(children: [
                        SvgPicture.asset(
                          IconPath.snooze,
                          height: 12,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Snooze all trades',
                          style: TextStyle(
                              fontSize: 12,
                              color: context.theme.colorScheme.secondary),
                        )
                      ]))));
    });
  }
}
