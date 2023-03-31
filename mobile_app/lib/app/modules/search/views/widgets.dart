import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/widgets/iris_buttons.dart';
import 'package:iris_mobile/app/modules/search/controllers/search_controller.dart';

import '../../../../widgets_v2/material_floating_search_app_bar/material_floating_search_bar.dart';

class SearchInput extends GetView<SearchController> {
  final String? hintText;
  const SearchInput({Key? key, this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 15.0, left: 15, right: 15),
        child: Column(children: [
          FloatingSearchAppBar(
            height: 50,
            transitionDuration: const Duration(milliseconds: 100),
            color: context.theme.scaffoldBackgroundColor,
            shadowColor: Colors.white,
            iconColor: context.theme.backgroundColor,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
            hint: hintText ?? 'Search ...',
            automaticallyImplyDrawerHamburger: false,
            automaticallyImplyBackButton: false,
            showBack: false,
            hideKeyboardOnDownScroll: true,
            padding: const EdgeInsets.only(right: 4, bottom: 0, top: 0),
            titleStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
            clearQueryOnClose: false,
            onQueryChanged: (value) {
              controller.query.value = value;
            },
            onTapInput: () {},
            onTapCancel: () {
              controller.query.value = '';
            },
            body: Container(),
          ),
        ]));
  }
}

class UserListTile extends StatelessWidget {
  final User user;
  final Function(User user) onSave;
  const UserListTile({Key? key, required this.user, required this.onSave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final connectedBrokers = user.connectedBrokerNames;
    return Builder(builder: (context) {
      final id = uuid.v4();
      return Container(
        // padding: EdgeInsets.only(top: index! == 0 ? 5.0 : 0.0),
        color: context.theme.scaffoldBackgroundColor,
        child: Column(
          children: [
            ListTile(
                onTap: () {
                  onSave(user);
                  user.routeToProfile();
                },
                leading: ProfileImage(
                  radius: 30,
                  url: user.profilePictureUrl,
                  uuid: id,
                  onTap: () {
                    onSave(user);
                    user.routeToProfile();
                  },
                ),
                title: UserName(
                  user: user,
                  fontSize: 16,
                  route: false,
                ),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (user.username != null) Text(user.username!),
                      if (connectedBrokers != null &&
                          connectedBrokers.isNotEmpty)
                        Container(
                            height: 30,
                            padding:
                                const EdgeInsets.only(top: 3.0, bottom: 3.0),
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
                trailing: IrisFollowButton(
                  user$: Rx(user),
                  customAction: () {
                    onSave(user);
                  },
                )),
            const SizedBox(height: 10)
          ],
        ),
      );
    });
  }
}
