import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../contact_model.dart';
import '../groupchat_controller.dart';

class ContactsListView extends StatelessWidget {
  final GroupChatController controller;
  final double susItemHeight = 40;

  const ContactsListView({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: LayoutBuilder(
        // use layoutbuilder to hide indexBarData since it causes keyboard overlap issue
        builder: (BuildContext context, BoxConstraints constraints) {
      return Obx(() => AzListView(
            data: controller.contacts$,
            itemCount: controller.contacts$.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) return Obx(() => _buildHeader(context));
              return Obx(() {
                if (index >= controller.contacts$.length) return Container();
                final ContactInfo model = controller.contacts$[index];
                final susTag = model.getSuspensionTag();
                final isShowSuspension = model.isShowSuspension;
                if (isShowSuspension) {
                  final contacts = controller.groupedContacts$
                      .where((gc) => gc[0].tagIndex == susTag)
                      .toList();
                  final elements = contacts[0];
                  final List<Widget> widgets = [];
                  for (var element in elements) {
                    widgets.add(_buildListItem(element, context));
                  }
                  return StickyHeaderBuilder(
                      builder: (BuildContext context, double stuckAmount) {
                        stuckAmount = 1.0 - stuckAmount.clamp(0.0, 1.0);
                        return header(stuckAmount, context,
                            model.getSuspensionTag(), model.isShowSuspension);
                      },
                      content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widgets));
                } else {
                  return Container();
                }
              });
            },
            physics: const BouncingScrollPhysics(),
            indexBarData: constraints.maxHeight > 300
                ? SuspensionUtil.getTagIndexList(controller.contacts$)
                : [],
            indexHintBuilder: (context, hint) {
              return Container(
                alignment: Alignment.center,
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: Colors.blue[700]!.withAlpha(200),
                  shape: BoxShape.circle,
                ),
                child: Text(hint,
                    style:
                        const TextStyle(color: Colors.white, fontSize: 30.0)),
              );
            },
            indexBarMargin: const EdgeInsets.only(left: 10, right: 0),
            indexBarOptions: const IndexBarOptions(
                needRebuild: false,
                textStyle: TextStyle(color: IrisColor.irisBlueLight)),
          ));
    }));
  }

  Widget header(double stuckAmount, BuildContext context, String susTag,
      bool isShowSuspension) {
    return Container(
      height: isShowSuspension ? 50.0 : 0.0,
      color: context.theme.backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          if (isShowSuspension)
            Expanded(
              child: Text(
                susTag,
                style: TextStyle(color: context.theme.colorScheme.secondary),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return controller.status$.value == NEW_GROUP_CHAT_STATUS.NEW
        ? Container(
            padding: const EdgeInsets.all(6),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.group_add),
                  title: Text('New Group',
                      style: TextStyle(
                          color: context.theme.colorScheme.secondary)),
                  onTap: () {
                    controller.onClickNewGroup();
                  },
                ),
              ],
            ),
          )
        : Container();
  }

  Widget _buildListItem(ContactInfo model, BuildContext context) {
    bool isSelected = false;
    final lists =
        controller.selectedContacts$.where((c) => c == model).toList();
    if (lists.isNotEmpty && lists[0] == model) {
      isSelected = true;
    }
    return Column(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.only(right: 10),
            child: Column(children: [
              ListTile(
                leading: ProfileImage(
                  url: model.user!.profilePictureUrl,
                  uuid: uuid.v4(),
                  onTap: () {
                    if (controller.status$.value ==
                        NEW_GROUP_CHAT_STATUS.PARTICIPANTS) {
                      controller.clickContact(model);
                    }
                    if (controller.status$.value == NEW_GROUP_CHAT_STATUS.NEW) {
                      controller.toPrivateChat(model);
                    }
                  },
                ),
                title: Text(model.user!.fullName,
                    style:
                        TextStyle(color: context.theme.colorScheme.secondary)),
                trailing: controller.status$.value ==
                        NEW_GROUP_CHAT_STATUS.PARTICIPANTS
                    ? Icon(
                        isSelected
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: context.theme.primaryColor)
                    : null,
                subtitle: Container(
                    height: 30,
                    padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
                    margin: const EdgeInsets.only(top: 3.0),
                    child: Text(model.user!.displayName)),
                onTap: () {
                  if (controller.status$.value ==
                      NEW_GROUP_CHAT_STATUS.PARTICIPANTS) {
                    controller.clickContact(model);
                  }
                  if (controller.status$.value == NEW_GROUP_CHAT_STATUS.NEW) {
                    controller.toPrivateChat(model);
                  }
                },
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: const Divider(),
              )
            ]))
      ],
    );
  }
}
