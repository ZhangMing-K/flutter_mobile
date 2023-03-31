import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:unicons/unicons.dart';

import 'components/name_input.dart';
import 'components/selected_contacts_list_view.dart';
import 'groupchat_controller.dart';

class GroupChatCreateInfo extends StatelessWidget {
  final GroupChatController controller;
  const GroupChatCreateInfo({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      child: Obx(
        () {
          final listUsers = controller.listUsers;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Avatar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: context.theme.primaryColor, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            child: ClipOval(
                              child: GroupCircleAvatar(
                                width: 70,
                                height: 70,
                                users: listUsers,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text('Members')
                        ],
                      )),
                  const SizedBox(width: 30),
                  InkWell(
                    child: controller.groupAvatar$.value != null
                        ? Column(children: [
                            CircleAvatar(
                              radius: 35.0,
                              backgroundColor: Colors.black,
                              backgroundImage:
                                  MemoryImage(controller.groupAvatar$.value!),
                            ),
                            const SizedBox(height: 4),
                            const Text('Upload')
                          ])
                        : Column(
                            children: [
                              CircleAvatar(
                                radius: 35.0,
                                backgroundColor: Colors.black,
                                child: Icon(Icons.camera_alt_outlined,
                                    color: context.theme.primaryColor,
                                    size: 35),
                              ),
                              const SizedBox(height: 4),
                              const Text('Upload')
                            ],
                          ),
                    onTap: () {
                      controller.pickImage();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              GroupChatNameInput(
                controller: controller,
              ),
              const SizedBox(height: 24),
              Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 24),
                  child: Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(UniconsLine.lock),
                              SizedBox(width: 12),
                              Text('Require approval to join'),
                            ],
                          ),
                          CupertinoSwitch(
                              value: controller.isPublic.value,
                              onChanged: (bool value) {
                                controller.isPublic.value = value;
                              })
                        ],
                      ))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Members ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(
                          ' ${controller.selectedContacts$.length} / ${controller.contacts$.length - 1} ',
                          style: TextStyle(
                              fontSize: 15,
                              color: context.theme.colorScheme.secondary
                                  .withOpacity(0.4),
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 12, left: 0),
                      child: SelectedContactsList(
                          controller: controller, isCancellable: true))
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
