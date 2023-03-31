import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'change_group_info_controller.dart';

class ChangeGroupInfo extends StatelessWidget {
  ChangeGroupInfo({Key? key, this.controller}) : super(key: key);
  final BaseController baseController = Get.find();
  final GroupChangeInfoController? controller;

  Widget nameAndPhotoView() {
    final TextEditingController textEditingController =
        TextEditingController(text: controller!.collection!.name);
    CachedNetworkImageProvider? imageProvider;
    if (controller!.collection!.pictureUrl != null) {
      imageProvider = CachedNetworkImageProvider(
        controller!.collection!.pictureUrl!,
        //cache: true,
      );
    }

    return Builder(builder: (context) {
      return Container(
          padding: const EdgeInsets.all(20),
          child: Obx(() => controller!.isSaving.value
              ? const Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.blueAccent)))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          child: controller!.groupAvatar$.value != null
                              ? CircleAvatar(
                                  radius: 35.0,
                                  backgroundColor:
                                      const Color.fromRGBO(242, 244, 246, 1.0),
                                  backgroundImage: MemoryImage(
                                      controller!.groupAvatar$.value!),
                                )
                              : imageProvider != null
                                  ? CircleAvatar(
                                      radius: 35.0,
                                      backgroundColor: const Color.fromRGBO(
                                          242, 244, 246, 1.0),
                                      backgroundImage: ResizeImage(
                                          imageProvider,
                                          height: 35,
                                          width: 35))
                                  : CircleAvatar(
                                      radius: 35.0,
                                      backgroundColor: const Color.fromRGBO(
                                          242, 244, 246, 1.0),
                                      child: Icon(Icons.camera_alt_outlined,
                                          color: context.theme.primaryColor,
                                          size: 35),
                                    ),
                          onTap: () {
                            controller!.pickImage();
                          },
                        ),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Container(
                                margin: const EdgeInsets.only(left: 12, top: 5),
                                child: Text(
                                  'Group Name',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          context.theme.colorScheme.secondary,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 12, top: 12, bottom: 12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            context.theme.colorScheme.secondary,
                                        width: 0.33),
                                    color: context.theme.backgroundColor,
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextField(
                                  autofocus: false,
                                  textAlignVertical: TextAlignVertical.center,
                                  onChanged: (value) {
                                    // controller.groupName = value;
                                  },
                                  controller: textEditingController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 20, top: 12, bottom: 12),
                                      isDense: true,
                                      hintText: 'Please provide a group name.',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400)),
                                ),
                              ),
                            ]))
                      ],
                    ),
                    InkWell(
                      child: Text('Change',
                          style: TextStyle(color: context.theme.primaryColor)),
                      onTap: () async {
                        final newGroupName = textEditingController.value.text;
                        // ??
                        //     controller!.collection!.name!;
                        await controller!.onTapUpdateInfo(newGroupName);
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                )));
    });
  }

  Widget usersList() {
    final List<User> users = controller!.collection!.currentUsers!;
    final List<Widget> widgets = [];
    for (var user in users) {
      widgets.add(Stack(
        children: <Widget>[
          Container(
              width: ScreenUtil().setWidth(50),
              margin: const EdgeInsets.all(6.0),
              child: Column(
                children: [
                  ProfileImage(
                    url: user.profilePictureUrl,
                    uuid: uuid.v4(),
                  ),
                ],
              )),
        ],
      ));
    }
    return Wrap(children: widgets);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        usersList(),
        const SizedBox(
          height: 15,
        ),
        Text(controller!.collection!.name!,
            style: const TextStyle(fontSize: 20)),
        const SizedBox(
          height: 8,
        ),
        InkWell(
          child: Text(
            'Change Name and Photo',
            style: TextStyle(color: context.theme.primaryColor),
          ),
          onTap: () {
            Get.bottomSheet(
                CustomBottomSheet(
                  child: nameAndPhotoView(),
                  maxHeight: 0.4,
                  overflow: false,
                ),
                isScrollControlled: false);
          },
        )
      ],
    );
  }
}
