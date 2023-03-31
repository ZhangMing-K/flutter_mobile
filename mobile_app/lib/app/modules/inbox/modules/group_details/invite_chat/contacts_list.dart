import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../groupchat/contact_model.dart';
import 'invite_chat_controller.dart';

class InviteContactsListView extends StatelessWidget {
  final InviteChatController controller;
  final double susItemHeight = 40;

  const InviteContactsListView({Key? key, required this.controller})
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
              if (index == 0) return _buildHeader();
              return Obx(() {
                if (controller.contacts$.length <= index) return Container();
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
            indexBarOptions: IndexBarOptions(
                needRebuild: false,
                textStyle: TextStyle(color: context.theme.primaryColor)),
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
                style: const TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container();
  }

  Widget _buildListItem(ContactInfo model, BuildContext context) {
    bool isSelected = false;
    final lists = controller.getSelectedList(model);
    if (lists.isNotEmpty && lists[0] == model) {
      isSelected = true;
    }
    final connectedBrokers = model.user!.connectedBrokerNames;
    final brokerView = [];
    connectedBrokers?.forEach((element) {
      brokerView.add(BrokerIcon(
        brokerName: element,
        height: 25,
      ));
      brokerView.add(const SizedBox(width: 8.0));
    });
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(right: 10),
          child: ListTile(
            leading: ProfileImage(
              url: model.user!.profilePictureUrl,
              uuid: uuid.v4(),
              onTap: () {
                controller.clickContact(model);
              },
            ),
            title: Text(
              model.user!.fullName,
              style: TextStyle(color: context.theme.colorScheme.secondary),
            ),
            trailing: Icon(
                isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                color: context.theme.primaryColor),
            subtitle: connectedBrokers!.isNotEmpty
                ? Container(
                    height: 30,
                    padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
                    margin: const EdgeInsets.only(top: 3.0),
                    child: Row(
                      children: [...brokerView],
                    ))
                : const Text('Not connected'),
            onTap: () {
              controller.clickContact(model);
            },
          ),
        )
      ],
    );
  }
}
