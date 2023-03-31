import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../controllers/inbox_controller.dart';

class NoMessagesInbox extends GetView<InboxController> {
  const NoMessagesInbox({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          images(),
          const SizedBox(
            height: 22,
          ),
          const Text(
            // 'iMessage but better',
            'Can iMessage do this?',
            style: TextStyle(fontSize: 28),
            textAlign: TextAlign.center,
          ),
          Text(
            'Talk stocks with magic',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 60,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              child: const Text(
                'Start a chat',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: controller.openPannel,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          InviteLinkButton(),
        ],
      ),
    );
  }

  Widget image(String url) {
    return CircleAvatar(radius: 40, backgroundImage: Image.asset(url).image);
  }

  Widget images() {
    return SizedBox(
      width: 230,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(right: 20, child: image(Images.guy1)),
          image(Images.defaultProfileImage),
          Positioned(left: 20, child: image(Images.girl2)),
        ],
      ),
    );
  }
}
