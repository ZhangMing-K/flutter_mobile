import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/widgets/iris_buttons.dart';

import '../../../controllers/explorer_controller.dart';

class SearchPeople extends GetView<ExplorerController> {
  const SearchPeople({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return IrisListView(
          // onRefresh: controller.pullRefresh,
          itemCount: controller.searchUserList.length,
          widgetLoader: const ShimmerScroll(),
          emptyWidget: NoData(
            text: 'No users match your search',
            backgroundColor: null,
            type: NO_DATA_TYPE.FIT,
            image: Image.asset(Images.noItemsInFeed, width: 300, height: 300),
          ),
          loadMore: controller.loadMoreUsers,
          header: Container(height: 5),
          builder: (BuildContext context, int index) {
            return userListTile(
                user: controller.searchUserList[index], index: index);
          },
        );
      },
    );
    // );
  }

  userListTile({required User user, required int index}) {
    final connectedBrokers = user.connectedBrokerNames;

    return Builder(builder: (context) {
      return Container(
        color: context.theme.scaffoldBackgroundColor,
        child: ListTile(
          onTap: () {
            user.routeToProfile();
            controller.whoToFollowController.saveUserToRecent(user);
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
              route: false,
            ),
          ),
          subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (user.username != null) Text(user.username!),
                if (connectedBrokers != null && connectedBrokers.isNotEmpty)
                  Container(
                      height: 30,
                      padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
                      margin: const EdgeInsets.only(top: 3.0),
                      child: Row(
                        children: connectedBrokers
                            .map((element) => BrokerIcon(
                                  brokerName: element,
                                  height: 25,
                                ))
                            .toList(),
                      ))
              ]),
          trailing: SizedBox(
            width: IrisScreenUtil.dWidth(100, scale: context.textScaleFactor),
            child: IrisFollowButton(
              user$: Rx(user),
              customAction: () {
                controller.whoToFollowController.saveUserToRecent(user);
              },
            ),
          ),
        ),
      );
    });
  }
}
