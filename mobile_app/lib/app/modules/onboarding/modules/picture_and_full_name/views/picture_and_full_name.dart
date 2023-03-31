import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iris_common/iris_common.dart';

import '../../../components/onboarding_wrapper.dart';
import '../controllers/picture_and_full_name_controller.dart';

class PictureAndFullNameScreen extends GetView<PictureAndFullNameController> {
  const PictureAndFullNameScreen({Key? key}) : super(key: key);

  Widget actionButton() {
    return ActionButton(
      padding: EdgeInsets.zero,
      height: ScreenUtil().setHeight(60),
      disabled: false,
      text: 'Next',
      textColor: Colors.white,
      onPressed: controller.createOrEditUser,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IrisAutoScrollContent(
      child: OnboardingWrapper(
          resizeToAvoidBottomInset: false,
          child: IrisInstructionForm(
            fontSize: IrisScreenUtil.dFontSize(28),
            actionButton: actionButton(),
            title: 'What\'s your full name?',
            content: content(),
            subtitle: '',
            excludeKeyboard: false,
          )),
    );
  }

  Widget content() {
    return Column(
      children: [
        uploadPictureForm(),
        SizedBox(height: IrisScreenUtil.dHeight(32)),
        inputForm(),
      ],
    );
  }

  Widget inputForm() {
    return FormBuilder(
      key: controller.fullNameFormKey,
      initialValue: {
        'fullName': controller.fullName.value,
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: IrisScreenUtil.dWidth(24)),
                child: NameInputForm(
                  name: 'fullName',
                  hint: 'Elon Musk',
                  onChanged: (val) => controller.onFullNameChanged(val),
                )),
          ),
        ],
      ),
    );
  }

  Widget uploadPictureForm() {
    return SizedBox(
      height: IrisScreenUtil.dWidth(160),
      width: IrisScreenUtil.dWidth(160),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Obx(() => SizedBox(
              width: IrisScreenUtil.dWidth(160),
              height: IrisScreenUtil.dWidth(160),
              child: GestureDetector(
                onTap: () {
                  controller.uploadFile();
                },
                child: controller.userProfileImage$.value != null
                    ? CircleAvatar(
                        radius: IrisScreenUtil.dWidth(35.0),
                        backgroundColor: Colors.black,
                        backgroundImage:
                            MemoryImage(controller.userProfileImage$.value!),
                      )
                    : CircleAvatar(
                        radius: IrisScreenUtil.dWidth(35.0),
                        backgroundColor: Colors.black,
                        child: Image.asset(
                          Images.defaultProfileImage,
                          fit: BoxFit.cover,
                        ),
                      ),
              ))),
          Padding(
            padding: const EdgeInsets.all(
              0.0,
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: IrisColor.primaryColor,
                onPressed: () {
                  controller.uploadFile();
                },
                mini: true,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: IrisScreenUtil.dWidth(40),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
