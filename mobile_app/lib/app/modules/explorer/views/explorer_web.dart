import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_common/shared/widgets/iris_buttons.dart';

import '../../../routes/pages.dart';
import '../../feed/shared/widgets/rails/nav_rails.dart';
import '../controllers/explorer_controller.dart';
import '../modules/stocks/views/stocks_view.dart';
import '../modules/who_to_follow/widgets/recent_people.dart';

class ExplorerScreenWeb extends GetView<ExplorerController> {
  const ExplorerScreenWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavRail(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      body: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Visibility(
          visible: false,
          replacement: const Center(
            child: Text('Coming soon'),
          ),
          child: SizedBox(
            width: 600,
            height: context.height,
            child: IrisTabView.expanded(
              keyboardHidesTabbar: false,
              backgroundColor: context.theme.scaffoldBackgroundColor,
              actions: [
                Row(
                  children: const [
                    NotificationBell(
                      nbrUnseenNotifications: null,
                      //  onTap: () {},
                      isActive: false,
                    )
                  ],
                )
              ],
              onTabChange: (index) {
                controller.changePage(index == 0
                    ? ExplorerPageType.EXPLORER
                    : ExplorerPageType.LEADERBOARD);
              },
              tabController: controller.tabController,
              header: Container(
                margin:
                    const EdgeInsets.only(bottom: 15.0, left: 15, right: 15),
                child: CupertinoSearchTextField(
                  onChanged: (value) {
                    controller.query.value = value;
                  },
                  onSubmitted: (value) {
                    controller.query.value = value;
                  },
                  controller: controller.textEditingController,
                  backgroundColor: context.theme.backgroundColor,
                  prefixInsets: const EdgeInsets.all(10),
                  placeholder: 'Search people or assets',
                  placeholderStyle: TextStyle(
                      color:
                          context.theme.colorScheme.secondary.withOpacity(0.6)),
                  style: TextStyle(color: context.theme.colorScheme.secondary),
                ),
              ),
              tabs: [
                // IrisTab(
                //   text: 'People',
                //   body: Obx(() => Padding(
                //         padding: const EdgeInsets.only(left: 10.0),
                //         child: Visibility(
                //           visible: controller.isQueryEmpty.isTrue,
                //           replacement: const SearchPeople(),
                //           child: const SizedBox(
                //             height: 100,
                //             child: WhoFollowView(),
                //           ),
                //           // child: Container(),
                //         ),
                //       )),
                // ),
                IrisTab(
                  text: 'Assets',
                  body: Obx(() => Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: SingleChildScrollView(
                          child: Visibility(
                            visible: controller.isQueryEmpty.isTrue,
                            replacement: const RecentPeople(),
                            child: const StocksView(),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IrisChoiceButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isSelected;
  const IrisChoiceButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: context.theme.backgroundColor,
          width: 2,
        ),
        borderRadius: kBorderRadius,
      ),
      label: Text(text),
      backgroundColor: Colors.black,
      elevation: 0,
      selectedColor: context.theme.backgroundColor,
      labelStyle: const TextStyle(color: Colors.white),
      onSelected: (bool selected) {
        if (selected) {
          HapticFeedback.lightImpact();
          onTap();
        }
      },
      selected: isSelected,
    );
  }
}

class UserListTile extends StatelessWidget {
  final User user;
  const UserListTile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final connectedBrokers = user.connectedBrokerNames;
    final brokerView = [];
    connectedBrokers?.forEach((element) {
      brokerView.add(BrokerIcon(
        brokerName: element,
        height: 25,
      ));
      brokerView.add(const SizedBox(width: 8.0));
    });
    return Builder(builder: (context) {
      final id = uuid.v4();
      return Container(
        // padding: EdgeInsets.only(top: index! == 0 ? 5.0 : 0.0),
        color: context.theme.backgroundColor,
        child: Column(
          children: [
            ListTile(
                tileColor: context.theme.backgroundColor,
                onTap: () {
                  debugPrint('tap on list tile');
                  final profileArgs = ProfileArgs(
                    user: user,
                    heroTag: id,
                  );
                  Get.toNamed(
                    Paths.Feed + Paths.Home + Paths.Profile,
                    parameters: {'profileUserKey': user.userKey.toString()},
                    arguments: profileArgs,
                    id: 1,
                  );
                },
                leading: ProfileImage(
                  radius: 30,
                  url: user.profilePictureUrl,
                  uuid: id,
                ),
                title: UserName(
                  user: user,
                  fontSize: 16,
                ),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (user.username != null) Text(user.username!),
                      if (connectedBrokers!.isNotEmpty)
                        Container(
                            height: 30,
                            padding:
                                const EdgeInsets.only(top: 3.0, bottom: 3.0),
                            margin: const EdgeInsets.only(top: 3.0),
                            child: Row(
                              children: [...brokerView],
                            ))
                    ]),
                trailing: IrisFollowButton(
                  user$: Rx(user),
                )),
            const Divider(),
          ],
        ),
      );
    });
  }
}
