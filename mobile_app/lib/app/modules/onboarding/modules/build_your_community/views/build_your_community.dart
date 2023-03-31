import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../../components/onboarding_wrapper.dart';
import '../controllers/build_your_community_controller.dart';

class BuildYourCommunityScreen extends GetView<BuildYourCommunityController> {
  const BuildYourCommunityScreen({Key? key}) : super(key: key);

  Widget about({BuildContext? context, required User user}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: IrisScreenUtil.dWidth(8)),
        portfoliosRow(connectedBrokerNames: user.connectedBrokerNames!),
        Container(
          padding: EdgeInsets.only(top: IrisScreenUtil.dWidth(4)),
          child: DefaultTextTitle(
            textTitle: user.descriptionPreview,
            fontSize: IrisScreenUtil.dFontSize(13),
            textOverflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingWrapper(
      horizontalPadding: 0,
      child: main(),
      onNext: () {
        controller.goToOnboadingFinal();
      },
    );
  }

  Widget buildContent() {
    return GetX<FindFriendsController>(builder: (friendsController) {
      if (friendsController.apiStatus$.value == API_STATUS.PENDING) {
        return const IrisLoading(
          loadingText: 'Finding your contacts :)',
        );
      }

      return Column(
        children: [
          if (controller.permissionController.contactsSynced.value != true)
            syncContacts()
          else
            friendsPanel(friendsController),
          recommendedList()
        ],
      );
    });
  }

  Widget divider() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: const Divider(),
    );
  }

  Widget follow(User user, BuildContext context) {
    return FollowButtonV2(
      height: IrisScreenUtil.dWidth(35),
      width: IrisScreenUtil.dWidth(95),
      followStatus: user.authUserFollowInfo!.followStatus,
      entityKey: user.userKey,
      entityType: FOLLOW_REQUEST_ENTITY_TYPE.USER,
      textStyle: TextStyle(
          color: context.theme.colorScheme.secondary,
          fontSize: IrisScreenUtil.dFontSize(13)),
    );
  }

  Widget following() {
    return SizedBox(
        height: IrisScreenUtil.dWidth(35),
        child: AbsorbPointer(
            child: OutlinedButton(
                onPressed: () => debugPrint('I do nothing'),
                child: Builder(builder: (context) {
                  return Text(
                    'Following',
                    style:
                        TextStyle(color: context.theme.colorScheme.secondary),
                  );
                }))));
  }

  Widget friendsBottomSheet(FindFriendsController friendsController) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      maxChildSize: 1,
      builder: (context, scrollController) => CustomBottomSheet(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(
              () => IrisListView(
                controller: scrollController,
                shrinkWrap: true,
                loadMore: friendsController.loadMore,
                itemCount: friendsController.userContacts$.length,
                builder: (BuildContext context, int index) {
                  final data = friendsController.userContacts$[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0)
                        DefaultTextTitle(
                          textTitle: 'Friends on Iris',
                          fontSize: ScreenUtil().setSp(22),
                        ),
                      userPannel(user: data, context: context),
                      if (index != friendsController.userContacts$.length - 1)
                        divider()
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget friendsPanel(FindFriendsController friendsController) {
    return Builder(
        builder: (context) => Obx(() {
              var top6List = [];
              var selectedTopItems = [];

              if (friendsController.userContacts$.length > 5) {
                top6List =
                    friendsController.userContacts$.getRange(0, 6).toList();
                selectedTopItems = top6List
                    .where((user) => friendsController.selectedUserKeys$
                        .contains(user.userKey))
                    .toList();
              }
              final int count = top6List.isEmpty
                  ? friendsController.userContacts$.length
                  : top6List.length;

              if (friendsController.isEmpty$.value == true) {
                return Text(
                  'You currently do not have any contacts on Iris',
                  style: TextStyle(color: context.theme.hintColor),
                );
              }

              final tileHeight = context.height * .11;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: count == 0
                        ? 0
                        : count > 2
                            ? tileHeight * 3
                            : tileHeight * count,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                'Friends on Iris',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(15)),
                              )),
                          for (int i = 0; i < count; i++)
                            Column(
                              children: [
                                userPannel(
                                  user: friendsController.userContacts$[i],
                                  context: context,
                                ),
                                if (i !=
                                    friendsController.userContacts$.length - 1)
                                  divider()
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (friendsController.userContacts$.length > 3)
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextButton(
                        onPressed: () {
                          Get.bottomSheet(
                            friendsBottomSheet(friendsController),
                            isScrollControlled: true,
                            enableDrag: true,
                          );
                        },
                        child: Text(
                          'Following ${friendsController.nbrUsersFromContacts$ - selectedTopItems.length} more...',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: IrisColor.primaryColor,
                            fontSize: ScreenUtil().setSp(14),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }));
    //which of the top are selected
  }

  Widget main() {
    return IrisInstructionForm(
      scrollPhysics: const AlwaysScrollableScrollPhysics(),
      title: 'Finish building your community!',
      buttonOnButtom: true,
      content: buildContent(),
      excludeKeyboard: false,
      fontSize: 24,
    );
  }

  Widget portfoliosRow({required List<BROKER_NAME> connectedBrokerNames}) {
    final List<Widget> images = [];
    for (var name in connectedBrokerNames) {
      images.add(
        BrokerIcon(height: ScreenUtil().setHeight(16), brokerName: name),
      );
      images.add(const SizedBox(width: 6));
    }
    return Row(
      children: [...images],
    );
  }

  Widget recommendedList() {
    return Obx(() {
      return Container(
          padding: EdgeInsets.only(top: IrisScreenUtil.dWidth(20)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            IrisListView(
              shrinkWrap: true,
              header: Container(
                  padding: EdgeInsets.only(left: IrisScreenUtil.dWidth(20)),
                  child: Text(
                    'Recommended',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: IrisScreenUtil.dFontSize(17)),
                  )),
              itemCount: controller
                  .pictureAndFullNameController.recommendedList.length,
              builder: (BuildContext context, int index) {
                final data = controller
                    .pictureAndFullNameController.recommendedList[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    userPannel(user: data, context: context, featured: true),
                    if (index !=
                        controller.pictureAndFullNameController.recommendedList
                                .length -
                            1)
                      divider()
                  ],
                );
              },
            )
          ]));
    });
  }

  Widget syncContacts() {
    return Builder(builder: (context) {
      return ListTile(
        leading: Container(
          width: 45,
          decoration: ShapeDecoration(
            color: context.theme.primaryColor,
            shape: const CircleBorder(),
          ),
          child: Center(
              child: Image.asset(
            IconPath.people_plus,
          )),
        ),
        trailing: ElevatedButton(
          child: const Text(
            'Connect',
          ),
          onPressed: () async => await controller.syncContacts(),
        ),
        title: Text(
          'Connect Contacts',
          style: TextStyle(
              color: context.theme.colorScheme.secondary,
              fontWeight: FontWeight.w500),
        ),
      );
    });
  }

  Widget userPannel(
      {required User user, BuildContext? context, bool? featured}) {
    return ListTile(
      leading: Container(
          alignment: Alignment.topLeft,
          width: IrisScreenUtil.dWidth(50),
          child: ProfileImage(
            url: user.profilePictureUrl,
            radius: IrisScreenUtil.dWidth(25),
            uuid: uuid.v4(),
          )),
      subtitle: about(context: context, user: user),
      title: UserName(
          user: user,
          route: false,
          fontSize: IrisScreenUtil.dFontSize(15),
          color: context!.theme.colorScheme.secondary,
          fontWeight: FontWeight.w700),
      trailing: featured == true ? follow(user, context) : following(),
    );
  }
}
