import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../../../../../widgets_v2/position_card/position_card_v2.dart';

import '../controllers/position_controller.dart';

class PositionView extends GetView<PositionController> {
  const PositionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final portfolio = controller.portfolio$.value;
      final List<PositionModel>? positions =
          portfolio?.brokerConnection?.positions;
      final List<Widget> list = [];
      if (portfolio?.connectionStatus != CONNECTION_STATUS.CONNECTED &&
          portfolio!.isAuthUser) {
        list.add(Container(
          margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            children: [
              const Text('Portfolio is disconnected'),
              const SizedBox(
                height: 10,
              ),
              reconnectButton()
            ],
          ),
        ));
        return Column(
          children: list,
        );
      }

      if (positions == null) {
        return Container();
      }

      return Column(
        children: [
          Expanded(
              child: IrisListView(
                  itemCount: positions.length,
                  shrinkWrap: true,
                  loadMore: null,
                  onRefresh: () async {},
                  builder: (context, index) {
                    return Column(
                      children: [
                        PositionCardV2(position: positions[index]),
                        const Divider()
                      ],
                    );
                  })),
        ],
      );
    });
  }

  reconnectButton() {
    return AppButtonV2(
      height: 45,
      width: double.maxFinite,
      child: const Text('Reconnect portfolio', style: TextStyle(fontSize: 20)),
      buttonType: APP_BUTTON_TYPE.SOLID,
      onPressed: controller.reconnect,
    );
  }
}
