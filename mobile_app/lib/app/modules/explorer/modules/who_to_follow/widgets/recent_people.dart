import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/who_to_follow_controller.dart';

Widget _userListTile({required User user}) {
  final connectedBrokers = user.connectedBrokerNames;

  return Builder(builder: (context) {
    // final id = uuid.v4();
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      child: ListTile(
        visualDensity: VisualDensity.standard,
        onTap: () {
          user.routeToProfile();
        },
        leading: AbsorbPointer(
          child: UserImage(
            radius: 25,
            user: user,
          ),
        ),
        title: AbsorbPointer(
          child: UserName(
            user: user,
            fontSize: 16,
          ),
        ),
        minVerticalPadding: 0,
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (user.username != null) Text(user.username!),
              if (connectedBrokers != null && connectedBrokers.isNotEmpty)
                SizedBox(
                    height: 30,
                    child: Row(
                      children: connectedBrokers
                          .map((element) => Container(
                                margin: const EdgeInsets.only(right: 3.0),
                                child: BrokerIcon(
                                  brokerName: element,
                                  height: 25,
                                ),
                              ))
                          .toList(),
                    ))
            ]),
        // trailing: IrisFollowButton(user$: Rx(user)),
      ),
    );
  });
}

class RecentPeople extends GetView<WhoToFollowController> {
  final Widget? header;
  const RecentPeople({Key? key, this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return IrisListView(
          itemCount: controller.recentList.length,
          widgetLoader: const ShimmerScroll(),
          emptyWidget: NoData(
            text: 'No recent searches',
            backgroundColor: null,
            type: NO_DATA_TYPE.FIT,
            image: Image.asset(Images.noItemsInFeed, width: 300, height: 300),
          ),
          header: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.only(left: 16, top: 10, bottom: 20),
                  child: const Text(
                    'Recent',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
          builder: (BuildContext context, int index) {
            return Column(
              children: [
                Container(
                    child: _userListTile(user: controller.recentList[index])),
                const Divider()
              ],
            );
          },
        );
      },
    );
    // );
  }
}
