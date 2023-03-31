import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/search/controllers/search_controller.dart';
import 'package:iris_mobile/app/modules/search/views/widgets.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Search people',
          style: TextStyle(color: context.theme.colorScheme.secondary),
        ),
      ),
      body: Container(
          color: context.theme.scaffoldBackgroundColor,
          child: Obx(
            () {
              final showRecent = controller.isQueryEmpty.value &&
                  !controller.isRecentPeopleEmpty;
              final users = showRecent
                  ? controller.searchPeopleController.recentList
                  : controller.searchUserList;
              return IrisListView(
                itemCount: users.length,
                widgetLoader: const ShimmerScroll(),
                header: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SearchInput(hintText: 'Type a name or username'),
                    if (showRecent)
                      Container(
                          margin: const EdgeInsets.only(
                              left: 15, top: 10, bottom: 15),
                          child: Text(
                            'Recent',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: context.theme.colorScheme.secondary
                                    .withOpacity(0.5)),
                          ))
                  ],
                ),
                emptyWidget: NoData(
                  text: '',
                  backgroundColor: null,
                  type: NO_DATA_TYPE.FIT,
                  image: Image.asset(Images.noItemsInFeed,
                      width: 300, height: 300),
                ),
                loadMore: showRecent ? null : controller.loadMoreUsers,
                onRefresh: controller.refreshUsers,
                builder: (BuildContext context, int index) {
                  return UserListTile(
                    user: users[index],
                    onSave: controller.searchPeopleController.saveUserToRecent,
                  );
                },
              );
            },
          )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.grey.shade900, width: 0.0))),
        child: BottomNavbar(
          isGoldMode: false,
          onActiveMenuItemPressed: (_) {
            // return controller.scrollToTop();
          },
        ),
      ),
    );
  }
}
