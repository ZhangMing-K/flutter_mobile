import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../groupchat_controller.dart';

class SelectedContactsList extends StatelessWidget {
  final GroupChatController controller;
  final bool isCancellable;
  const SelectedContactsList({
    Key? key,
    required this.controller,
    this.isCancellable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          width: double.infinity,
          child: Wrap(
            children: controller.selectedContacts$.map((contact) {
              return Stack(
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
                                if (isCancellable) {
                                  if (controller.status$.value ==
                                      NEW_GROUP_CHAT_STATUS.PARTICIPANTS) {
                                    controller.clickContact(contact);
                                  }
                                }
                              },
                            ),
                            Text(contact.user!.firstName!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        onTap: () {
                          if (isCancellable) {
                            controller.clickContact(contact);
                          }
                        },
                      )),
                  if (isCancellable)
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
                            child: Icon(Icons.close,
                                color: Colors.white, size: 12.0),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }).toList(),
          ),
        ));
  }
}
