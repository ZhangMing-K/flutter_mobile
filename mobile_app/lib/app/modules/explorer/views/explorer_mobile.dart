import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/shared/widgets/iris_buttons.dart';

import '../../../../widgets_v2/material_floating_search_app_bar/material_floating_search_bar.dart';
import '../../../routes/pages.dart';
import '../../feed/modules/posts/views/posts_new.dart';
import '../../feed/shared/widgets/filter_button/filter_button.dart';
import '../controllers/explorer_controller.dart';
import '../modules/who_to_follow/widgets/recent_people.dart';
import '../modules/who_to_follow/widgets/search_people.dart';

class ExplorerScreenMobile extends GetView<ExplorerController> {
  const ExplorerScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IrisTabView.expanded(
        keyboardHidesTabbar: false,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        actions: const [],
        onTabChange: (index) {
          controller.changePage(index == 0
              ? ExplorerPageType.EXPLORER
              : ExplorerPageType.LEADERBOARD);
          if (index == 0) {
            controller.query.value = '';
          }
        },
        tabController: controller.tabController,
        // showBackButton: true,
        horizontalPadding: 0,
        header: Container(
          margin: const EdgeInsets.only(left: 12, top: 12, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                'Discover',
                maxFontSize: 28,
                maxLines: 1,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                width: double.infinity,
                child: SearchInput(
                  showBack: false,
                  onFocusChange: (v) {
                    controller.showRecentSearch(v);
                  },
                ),
              ),
            ],
          ),
        ),
        hideTab: true,
        tabs: [
          IrisTab(
            text: '',
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Obx(() {
                    final isQueryEmpty = controller.isQueryEmpty.isTrue;
                    final isRecentSearchEmpty = controller.isRecentPeopleEmpty;
                    final showRecentSearch = controller.showRecentSearch.isTrue;
                    return isQueryEmpty
                        ? Visibility(
                            visible: !isRecentSearchEmpty && showRecentSearch,
                            child: const RecentPeople(),
                            replacement: PostsNewView(
                              header: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    FilterButton(),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SearchPeople();
                  }),
                ),
                // )
                //  )
              ],
            ),
          ),
        ],
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
      selectedColor: !context.isDarkMode
          ? IrisColor.irisBlue
          : context.theme.backgroundColor,
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

class SearchInput extends GetView<ExplorerController> {
  const SearchInput(
      {Key? key, required this.onFocusChange, this.showBack = true})
      : super(key: key);
  final ValueSetter<bool> onFocusChange;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 0, bottom: 12.0),
        child: Column(children: [
          FloatingSearchAppBar(
            height: 45,

            //  onTapInput: ,
            transitionDuration: const Duration(milliseconds: 100),
            color: context.theme.scaffoldBackgroundColor,
            shadowColor: Colors.white,
            onFocusChanged: onFocusChange,
            iconColor: context.theme.backgroundColor,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
            hint: 'Search',
            automaticallyImplyDrawerHamburger: false,
            automaticallyImplyBackButton: false,
            showBack: showBack,
            hideKeyboardOnDownScroll: true,
            padding: const EdgeInsets.only(right: 4, bottom: 0, top: 0),
            titleStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
            clearQueryOnClose: false,
            onQueryChanged: controller.query,
            // onTapInput: () {
            //   controller.setShowSearchType();
            // },
            onTapCancel: () {
              // controller.setHideSearchType();
              controller.query.value = '';
            },
            body: Container(),
          )
        ]));
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
