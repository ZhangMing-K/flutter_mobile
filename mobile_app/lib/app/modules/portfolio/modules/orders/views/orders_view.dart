import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/text_card/text_card.dart';
import '../controllers/orders_controller.dart';

class OrdersView extends GetView<PortfolioOrdersController> {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            IrisListView(
              onRefresh: controller.pullRefresh,
              itemCount: state!.length,
              widgetLoader: Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: const TextCardShimmer()),
              loadMore: controller.loadMore,
              builder: (BuildContext context, int index) {
                return Column(
                  children: [
                    TextCard(
                      text: state[index].obs,
                    ),
                    const Divider()
                  ],
                );
              },
            ),
          ],
        );
      },
      onEmpty: NoData(
        text: 'No orders made.',
        type: NO_DATA_TYPE.FIT,
        image: Image.asset(Images.noItemsInFeed, width: 300, height: 300),
      ),
      onLoading: Container(
          margin: const EdgeInsets.only(top: 8),
          child: const TextCardShimmer()),
    );
  }
}
