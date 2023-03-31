import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'invite_chat_controller.dart';

class InviteSelectedContactsList extends StatelessWidget {
  final InviteChatController controller;
  const InviteSelectedContactsList({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _selectedContactsBuild());
  }

  Widget _selectedContactsBuild() {
    final List<Widget> widgets = [];
    for (var contact in controller.selectedContacts$) {
      widgets.add(Stack(
        children: <Widget>[
          Container(
              width: ScreenUtil().setWidth(50),
              margin: const EdgeInsets.all(6.0),
              child: InkWell(
                child: Column(
                  children: [
                    ProfileImage(
                      url: contact.user!.profilePictureUrl,
                      uuid: uuid.v4(),
                      onTap: () {
                        controller.clickContact(contact);
                      },
                    ),
                    Text(contact.user!.firstName!,
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                  ],
                ),
                onTap: () {
                  controller.clickContact(contact);
                },
              )),
          Positioned(
            right: 3.0,
            top: 3.0,
            child: GestureDetector(
              onTap: () {
                controller.clickContact(contact);
              },
              child: const Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 8.0,
                  backgroundColor: Colors.red,
                  child: Icon(Icons.close, color: Colors.white, size: 12.0),
                ),
              ),
            ),
          ),
        ],
      ));
    }

    return Container(
      child: Wrap(children: widgets),
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
    );
  }
}
