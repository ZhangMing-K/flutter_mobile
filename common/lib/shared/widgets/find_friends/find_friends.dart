import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../iris_common.dart';

//TODO: Refactor this class
class FindFriends extends StatelessWidget {
  late FindFriendsController controller;

  FindFriends({Key? key, Function? onNextCallback}) : super(key: key) {
    controller = Get.put(FindFriendsController(
        onNextCallBack: onNextCallback, recomended: true));
  }

  about({BuildContext? context, required User user}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        portfoliosRow(name: user.connectedBrokerNames!),
        if (user.description != null)
          Container(
              padding: const EdgeInsets.only(top: 4),
              child: DefaultTextTitle(
                textTitle: user.description,
                color: context!.theme.colorScheme.secondary,
                fontWeight: FontWeight.w300,
                textOverflow: TextOverflow.ellipsis,
              ))
      ],
    );
  }

  actionButton(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 30, right: 12, left: 12),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: AppButtonV2(
          borderRadius: 8,
          height: 50,
          onPressed: () async {
            await controller.submit();
          },
          width: double.maxFinite,
          child: const DefaultTextTitle(
            textTitle: 'Next',
            fontSize: TextUnit.large,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          buttonType: APP_BUTTON_TYPE.SOLID,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: main(context),
    );
  }

  Widget listView() {
    return IrisListView(
      shrinkWrap: true,
      onRefresh: () async => debugPrint('refreshed'),
      itemCount: controller.userContacts$.length,
      widgetLoader: const ShimmerScroll(),
      loadMore: controller.loadMore,
      builder: (BuildContext context, int index) {
        final data = controller.userContacts$[index];
        return Column(
          children: [
            userPannel(user: data, context: context),
            if (index != controller.userContacts$.length - 1) const Divider()
          ],
        );
      },
    );
  }

  main(BuildContext context) {
    return Obx(() {
      return IrisInstructionForm(
        actionButton: actionButton(context),
        buttonOnButtom: true,
        title: 'We found some friends for you',
        content: controller.isEmpty$.value
            ? const IrisEmpty(
                emptyText:
                    'Sorry :( none of your friends are part of our community')
            : controller.apiStatus$.value != API_STATUS.PENDING
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Flexible(
                        child: listView(),
                      )
                    ]))
                : const IrisLoading(loadingText: 'Finding your contacts :)'),
      );
    });
  }

  portfoliosRow({required List<BROKER_NAME> name}) {
    final List<Widget> images = [];
    for (var name in name) {
      images.add(BrokerIcon(height: 20, brokerName: name));
      images.add(const SizedBox(width: 6));
    }
    return Row(
      children: [...images],
    );
  }

  userPannel({User? user, BuildContext? context}) {
    return Obx(() {
      final bool isSelected =
          controller.selectedUserKeys$.contains(user!.userKey);
      return ListTile(
          onTap: () => {
                HapticFeedback.lightImpact(),
                controller.addOrRemovePortfolio(user.userKey)
              },
          leading: Container(
              alignment: Alignment.centerLeft,
              width: 50,
              child: ProfileImage(
                  url: user.profilePictureUrl, radius: 30, uuid: uuid.v4())),
          subtitle:
              user.description != null || user.connectedBrokerNames!.isNotEmpty
                  ? about(context: context, user: user)
                  : null,
          title: UserName(
              user: user,
              route: false,
              fontSize: TextUnit.small,
              color: context!.theme.colorScheme.secondary,
              fontWeight: FontWeight.w500),
          trailing: Icon(
              isSelected
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank,
              color: IrisColor.primaryColor));
    });
  }
}
