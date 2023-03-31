import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/pages.dart';
import '../controllers/users_controller.dart';

class ShimmerScroll extends StatelessWidget {
  const ShimmerScroll({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      child: const ListTileShimmer(),
    );
  }
}

class UsersView extends GetView<PortfolioUsersController> {
  const UsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: IrisListView(
                    onRefresh: controller.pullRefresh,
                    itemCount: state!.length,
                    widgetLoader: const ShimmerScroll(),
                    loadMore: controller.loadMore,
                    header: Container(height: 5),
                    builder: (BuildContext context, int index) {
                      return userListTile(user: state[index], index: index);
                    },
                  ),
                ),
              ],
            ),
        onLoading: const ShimmerScroll(),
        onEmpty: NoData(
          text: 'No users match your search',
          backgroundColor: null,
          type: NO_DATA_TYPE.FIT,
          image: Image.asset(Images.noItemsInFeed, width: 300, height: 300),
        ));
  }

  Widget userListTile({required User user, int? index}) {
    return Builder(builder: (context) {
      final id = uuid.v4();
      return Container(
        padding: EdgeInsets.only(top: index! == 0 ? 5.0 : 0.0),
        color: context.theme.backgroundColor,
        child: Column(
          children: [
            ListTile(
              tileColor: context.theme.backgroundColor,
              onTap: () {
                final profileArgs = ProfileArgs(
                  user: user,
                  heroTag: id,
                );
                Get.toNamed(
                  Paths.Feed + Paths.Home + Paths.Profile,
                  parameters: {
                    'profileUserKey': user.userKey.toString(),
                  },
                  arguments: profileArgs,
                  id: 1,
                );
              },
              leading: ProfileImage(
                url: user.profilePictureUrl,
                uuid: id,
              ),
              title: UserName(
                user: user,
                fontSize: 16,
              ),
              subtitle: (user.username == null) ? null : Text(user.username!),
              trailing: FollowButtonV2(
                followStatus: user.authUserFollowInfo!.followStatus,
                entityKey: user.userKey,
                entityType: FOLLOW_REQUEST_ENTITY_TYPE.USER,
                // refreshParent: c.refreshEntities),
              ),
            ),
            const Divider(),
          ],
        ),
      );
    });
  }
}
