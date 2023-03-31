import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/shared/widgets/iris_buttons.dart';

import '../../../../widgets_v2/following_options/following_options.dart';
import '../../../routes/pages.dart';

class ProfileSearchPortfolioList extends StatelessWidget {
  final Portfolio portfolio;
  final bool editFunctionality;
  final User? user;
  final User? profileUser;
  final Function? removeAction;
  const ProfileSearchPortfolioList(
      {Key? key,
      required this.portfolio,
      this.editFunctionality = false,
      this.user,
      this.removeAction,
      this.profileUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: context.theme.backgroundColor,
        // margin: EdgeInsets.only(top: 5),
        child: Column(children: [
          ListTile(
              tileColor: context.theme.backgroundColor,
              onTap: () {
                Get.toNamed(
                  Paths.Portfolio.createPath([portfolio.portfolioKey]),
                  id: 1,
                );
              },
              leading: BrokerIcon(
                brokerName: portfolio.brokerName,
                height: 50,
              ),
              title: Text(portfolio.portfolioName!),
              subtitle: UserName(user: portfolio.user),
              trailing: SizedBox(
                  width: 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FollowButtonV2(
                        followStatus:
                            portfolio.authUserFollowInfo?.followStatus,
                        entityKey: portfolio.portfolioKey,
                        entityType: FOLLOW_REQUEST_ENTITY_TYPE.PORTFOLIO,
                      ),
                      if (profileUser?.authUserFollowInfo?.followStatus ==
                          FOLLOW_STATUS.ME)
                        FollowingOptions(
                            user: user,
                            portfolioKey: portfolio.portfolioKey,
                            refreshParent: refreshEntities)
                    ],
                  ))),
          const Divider(),
        ]));
  }

  refreshEntities(
      {int? userKey,
      FOLLOW_ACTION actionType = FOLLOW_ACTION.REMOVE,
      UserRelation? authUserRelation,
      int? portfolioKey}) {
    if (actionType == FOLLOW_ACTION.REMOVE) {
      if (removeAction != null) {
        debugPrint('portfolioKey on remove portfolio: $portfolioKey');
        removeAction!(portfolioKey);
      }
    }
  }
}

class ProfileSearchUserTile extends StatelessWidget {
  final User user;
  final bool removeFunctionality;
  final bool editFunctionality;
  final Function? removeAction;
  final User? profileUser;
  const ProfileSearchUserTile(
      {Key? key,
      required this.user,
      this.removeFunctionality = false,
      this.editFunctionality = false,
      this.removeAction,
      this.profileUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = uuid.v4();
    return Column(
      children: [
        ListTile(
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
            url: user.profilePictureUrl,
            uuid: id,
          ),
          title: UserName(
            user: user,
            fontSize: 16,
          ),
          trailing: removeFunctionality == true
              ? UnfollowButton(
                  userKey: user.userKey,
                  refreshParent: refreshEntities,
                  followStatus: user.authUserFollowInfo?.followStatus,
                )
              : SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IrisFollowButton(user$: Rx(user)),
                      if (profileUser?.authUserFollowInfo?.followStatus ==
                          FOLLOW_STATUS.ME)
                        FollowingOptions(
                            user: user, refreshParent: refreshEntities)
                    ],
                  ),
                ),
        ),
        Divider(color: Colors.grey.withOpacity(.3)),
      ],
    );
  }

  refreshEntities({
    int? userKey,
    FOLLOW_ACTION actionType = FOLLOW_ACTION.REMOVE,
    int? portfolioKey,
    UserRelation? authUserRelation,
  }) {
    if (actionType == FOLLOW_ACTION.REMOVE) {
      if (removeAction != null) {
        removeAction!(userKey);
      }
    }
  }
}
